### Eks-charts
#####################################################
module "repository" {
  source = "./modules/repository"
  chartmuseum_count             = var.chartmuseum_enabled
  nexus_count                   = var.nexus_enabled
  stable_chartmuseum_version    = var.stable_chartmuseum
  archiva_version               = var.archiva_enabled
  oteemo_sonatype_nexus_version = var.oteemo_sonatype_nexus
}

module "ingress" {
  source = "./modules/ingress"

  bitnami_external_dns_version  = var.bitnami_external_dns
  stable_nginx_ingress_version  = var.stable_nginx_ingress
  jetstack_cert_manager_version = var.jetstack_cert_manager
  stable_metrics_server_version = var.stable_metrics_server

  domain              = var.domains
  cert_manager_email  = var.cert_manager_email
  module_depends_on   = [module.monitoring.prometheus-operator, module.kubernetes.cluster_name]
}

module "monitoring" {
  source                              = "./modules/monitoring"
  stable_grafana_version              = var.stable_grafana
  stable_prometheus_adapter_version   = var.stable_prometheus_adapter
  stable_prometheus_operator_version  = var.stable_prometheus_operator
}

module "keycloak" {
  source                        = "./modules/keycloak"
  codecentric_keycloak_version  = var.codecentric_keycloak
  module_depends_on             = [module.monitoring.prometheus-operator]
}

module "istio" {
  source                                = "./modules/istio"
  tracing_gatekeeper_count              = var.tracing_gatekeeper_enabled
  kiali_gatekeeper_count                = var.kiali_gatekeeper_enabled
  gabibbo97_keycloak_gatekeeper_version = var.gabibbo97_keycloak_gatekeeper
  module_depends_on                     = [module.keycloak.keycloak_realese]
}

module "weave" {
  source                                = "./modules/weave"
  gabibbo97_keycloak_gatekeeper_version = var.gabibbo97_keycloak_gatekeeper
  stable_weave_scope_version            = var.stable_weave_scope
  module_depends_on                     = [module.keycloak.keycloak_realese]
}

module "jenkins" {
  source            = "./modules/jenkins"
  jenkins_count     = var.jenkins_enabled
  module_depends_on = [module.monitoring.prometheus-operator]
  jenkins_version   = var.stable_jenkins
}

# module "spot_fleet_request" {
#   source = "./modules/spot_fleet"
# }

module "sonarqube" {
  source              = "./modules/sonarqube"
  sonarqube_count     = var.sonarqube_enabled
  module_depends_on   = [module.monitoring.prometheus-operator]
  sonarqube_version   = var.oteemo_sonarqube
}

module "loki" {
  source            = "./modules/logging/loki"
  module_depends_on = [module.monitoring.prometheus-operator]
}

module "argo" {
  source                                = "./modules/argo"
  module_depends_on                     = [module.monitoring.prometheus-operator, module.keycloak.keycloak_realese]
  argo_count                            = var.argo_enabled
  aws_region                            = data.aws_region.current.name
  argo_argo_version                     = var.argo_argo
  argo_argo_events_version              = var.argo_argo_events
  gabibbo97_keycloak_gatekeeper_version = var.gabibbo97_keycloak_gatekeeper
  argo_argo_rollouts_version            = var.argo_argo_rollouts
  argo_argo_cd_version                  = var.argo_argo_cd
}