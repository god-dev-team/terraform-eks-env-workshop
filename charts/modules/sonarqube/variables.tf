variable "module_depends_on" {
  default = []
}

variable "sonarqube_version" {
  type        = string
  description = "Sonarqube Version"
}

variable "sonarqube_count" {
  default = []
}