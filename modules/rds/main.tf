module "mysql_server_sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/mysql"
  version = "~> 3.0"
  name        = "${var.cluster_name}mysql"
  description = "Security group for MySQL"
  vpc_id      = var.vpc_id

  # ingress_cidr_blocks = ["10.0.0.0/8"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

resource "random_string" "dbpassword" {
  length = 16
  special = false
}

module "mysql" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "demo-db"

  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "${var.instance_class}"
  allocated_storage = "${var.allocated_storage}"
  storage_encrypted = false

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name = "demo"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = "demo"

  password = "${random_string.dbpassword.result}"
  port     = "3306"

  vpc_security_group_ids = ["${module.mysql_server_sg.this_security_group_id}"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # disable backups to create DB faster
  backup_retention_period = "${var.db_backup_retention}"

  publicly_accessible = true

  tags = {
    Environment = "${var.environment}"
  }

  # enabled_cloudwatch_logs_exports = ["mysql", "upgrade"]

  # DB subnet group
  subnet_ids = "${data.aws_subnet_ids.all.ids}"

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Snapshot name upon DB deletion
  final_snapshot_identifier = "${var.cluster_name}db"

  # Database Deletion Protection
  deletion_protection = false
}

resource "kubernetes_namespace" "sample" {
  metadata {
    name = "sample"
  }
}

resource "kubernetes_secret" "rdssecrets" {

  metadata {
    name = "rdssecrets"
    namespace = "sample"
    annotations = {
      "jenkins.io/credentials-description": "credentials from Kubernetes"
    }
    labels = {
      "jenkins.io/credentials-type": "kubeconfigContent"
    }

  }

  data = {
    sql_alchemy_conn = "mysql+psycopg2://${module.mysql.this_db_instance_username}:${module.mysql.this_db_instance_password}@${module.mysql.this_db_instance_address}:5432/${module.mysql.this_db_instance_name}"
    mysql_user = "${module.mysql.this_db_instance_username}"
    mysql_password = "${module.mysql.this_db_instance_password}"
    mysql_host = "${module.mysql.this_db_instance_address}"
    mysql_port = "${module.mysql.this_db_instance_port}"
    mysql_db = "${module.mysql.this_db_instance_name}"
    mysql_url = "jdbc:mysql://${module.mysql.this_db_instance_address}:${module.mysql.this_db_instance_port}/${module.mysql.this_db_instance_name}"
    
  }

  type = "Opaque"
}


