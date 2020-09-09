# TERRAFORM-EKS-ENV-WORKSHOP

[![GitHub Actions status](https://github.com/GOD-mbh/terraform-eks-env-workshop/workflows/Build-Push/badge.svg)](https://github.com/GOD-mbh/terraform-eks-env-workshop/actions)
[![GitHub Releases](https://img.shields.io/github/release/GOD-mbh/terraform-eks-env-workshop.svg)](https://github.com/GOD-mbh/terraform-eks-env-workshop/releases)

## Prerequsite

- kubectl
- awscli
- aws-iam-authenticator 
- terraform
- helm

## Usage
- Edit terraform.tfvars
- Run `terraform init`
- Run `terraform plan` and review
- Run `terraform apply`


## Structure
This repository provides the minimal set of resources, which may be required for starting comfortably developing the process of new IaC project:

  main.tf - data from modules

  modules.tf - list of modules and their redefined values

  providers.tf - list of providers and their values

  variables.tf - variables used in modules. Customize it for your project data !!!

  variables.tf.json - list of versions for variables. Customize it for your project data !!!

## Work with cluster

For destroy some module just remove it from modules.tf and run 

`terraform plan -out plan && terraform apply plan`

## Kubernetes modules

- external-dns
- metrics-server
- ingress-nginx
- cert-manager
- archiva
- sonarqube
- sonatype-nexus
- argo
- weave
- loki
- keycloack
- monitoring (grafana)
- jenkins 
