# Allow Spot request to run and terminate EC2 instances
data "aws_iam_policy_document" "instance-assume-role-policy-for-spotfleet" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["spotfleet.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "spot-fleet-tagging-role" {
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy-for-spotfleet.json}"
  name = "SpotFleetTaggingRoleFor${var.name}-${element(split("-",uuid()), 0)}"
  lifecycle {
    ignore_changes = ["name"]
  }
}

resource "aws_iam_role_policy_attachment" "spot_request_policy" {
  role = "${aws_iam_role.spot-fleet-tagging-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2SpotFleetTaggingRole"
}