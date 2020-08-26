data "aws_ami" "amazon-linux-2" {
 most_recent = true
 owners      = ["amazon"]
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }


 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "aws_spot_fleet_request" "common_nodes" {
  count = "${var.type == "common_node" ? 1 : 0}"
  iam_fleet_role      = "${aws_iam_role.spot-fleet-tagging-role.arn}"
  allocation_strategy = "diversified"
  target_capacity     = "${var.capacity}"
  valid_until         = "${var.valid_until}"

  launch_specification {
    instance_type          = "${var.ec2_type}"
    ami                    = "${data.aws_ami.amazon-linux-2.id}"
    key_name               = "${var.ssh_key}"
    availability_zone      = "eu-central-1a"
    subnet_id              = "${var.subnet_id}"
    associate_public_ip_address = "${var.public_ip}"
    iam_instance_profile_arn = "${var.iam_instance_profile_arn}" 
    vpc_security_group_ids   = ["${var.security_group_ids}"]

    // root partition
    root_block_device {
      volume_size = "${var.disk_size_root}"
      volume_type = "gp2"
      delete_on_termination = true
    }

    user_data = "${file("../../modules/spot_fleet/script/user_data.sh")}"

    tags = {
      Name = "${var.name}"
    }
  }
}