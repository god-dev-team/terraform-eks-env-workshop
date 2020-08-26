#!/usr/bin/groovy
import groovy.transform.Field
@Field
def role = "devops"
@Field
def cluster = "EKS-DEMO"
@Field
def base_domain = "godapp.de"
@Field
def slack_token = "REPLACEME/REPLACEME/REPLACEME"
@Field
def jenkins = "jenkins.godapp.de"
@Field
def archiva = "archiva.godapp.de"
@Field
def chartmuseum = "chartmuseum.godapp.de"
@Field
def nexus = "nexus.godapp.de"
@Field
def sonarqube = "sonarqube.godapp.de"
@Field
def registry = "249565476171.dkr.ecr.eu-central-1.amazonaws.com"
return this