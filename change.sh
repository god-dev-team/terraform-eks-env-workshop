#!/bin/bash

OS_NAME="$(uname | awk '{print tolower($0)}')"

# check vars
export ACCOUNT_ID=$(aws sts get-caller-identity | jq .Account -r)
export REGION="$(aws configure get region)"
export BUCKET="terraform-env-${1:-${ACCOUNT_ID}}"

export LOCK_TABLE="terraform-resource-env-lock"

command -v tput > /dev/null && TPUT=true

_echo() {
    if [ "${TPUT}" != "" ] && [ "$2" != "" ]; then
        echo -e "$(tput setaf $2)$1$(tput sgr0)"
    else
        echo -e "$1"
    fi
}

_result() {
    echo
    _echo "# $@" 4
}

_command() {
    echo
    _echo "$ $@" 3
}

_success() {
    echo
    _echo "+ $@" 2
    exit 0
}

_error() {
    echo
    _echo "- $@" 1
    exit 1
}

_replace() {
    if [ "${OS_NAME}" == "darwin" ]; then
        sed -i "" -e "$1" "$2"
    else
        sed -i -e "$1" "$2"
    fi
}

_find_replace() {
    if [ "${OS_NAME}" == "darwin" ]; then
        find . -name "$2" -exec sed -i "" -e "$1" {} \;
    else
        find . -name "$2" -exec sed -i -e "$1" {} \;
    fi
}

_main() {
    _result "ACCOUNT_ID = ${ACCOUNT_ID}"

    _result "REGION = ${REGION}"
    _result "BUCKET = ${BUCKET}"

    _result "DOMAIN = ${DOMAIN}"

    if [ "${DOMAIN}" == "" ]; then
        _error "DOMAIN is empty."
    fi

    # replace
    _find_replace "s/terraform-workshop-[[:alnum:]]*/${BUCKET}/g" "*.tf"

    _find_replace "s/godapp.de/${DOMAIN}/g" "*.tf"
    _find_replace "s/godapp.de/${DOMAIN}/g" "*.yaml"
    _find_replace "s/godapp.de/${DOMAIN}/g" "*.json"

    _find_replace "s/ADMIN_USERNAME/${ADMIN_USERNAME}/g" "*.tf"
    _find_replace "s/ADMIN_PASSWORD/${ADMIN_PASSWORD}/g" "*.tf"

    # create s3 bucket
    COUNT=$(aws s3 ls | grep ${BUCKET} | wc -l | xargs)
    if [ "x${COUNT}" == "x0" ]; then
        _command "aws s3 mb s3://${BUCKET}"
        aws s3 mb s3://${BUCKET} --region ${REGION}
    fi

    # create dynamodb table
    COUNT=$(aws dynamodb list-tables | jq -r .TableNames | grep ${LOCK_TABLE} | wc -l | xargs)
    if [ "x${COUNT}" == "x0" ]; then
        _command "aws dynamodb create-table --table-name ${LOCK_TABLE}"
        aws dynamodb create-table \
            --table-name ${LOCK_TABLE} \
            --attribute-definitions AttributeName=LockID,AttributeType=S \
            --key-schema AttributeName=LockID,KeyType=HASH \
            --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
            --region ${REGION} | jq .
    fi

}

_main

_success