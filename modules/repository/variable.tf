variable "stable_chartmuseum_version" {
  type        = string
  description = "Chartmuseum Version"
}

variable "oteemo_sonatype_nexus_version" {
  type        = string
  description = "Sonatype Nexus_version Version"
}

variable "chartmuseum_count" {
  default = []
}

variable "nexus_count" {
  default = []
}

variable "archiva_version" {
  default = []
}