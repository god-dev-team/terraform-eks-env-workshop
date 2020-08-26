variable "name" {
    default = "jenkins-spot"
}

variable "subnet_id" {
    default = "subnet-0ff2f067a2a919eaf"
}

variable "ssh_key" {
     default = "jenkins"
}
variable "security_group_ids" {
  default = "sg-025c99f08473a025c"
}

variable "iam_instance_profile_arn" {
  default = "arn:aws:iam::668513794466:instance-profile/jenkins-slave-spot-SpotFleetInstanceProfile"
}
variable "capacity" {
  default = 1
}
variable "type" {
  default = "common_node"
}
variable "common_node_ami_id" {
  default = ""
}
variable "ec2_type" {
  default = "t2.micro"
}

variable "disk_size_root" {
  default = 5
}
variable "valid_until" {
  default = "2033-01-01T01:00:00Z"
}
variable "public_ip" {
  default = true
}
variable "internet_access" {
  default = true
}