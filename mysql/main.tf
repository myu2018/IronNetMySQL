provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "mysql-cluster-${count.index}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.t3.small"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
  publicly_accessible= true
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "mysql-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  database_name           = "mysql_clustered_db"
  master_username         = "admin"
  master_password         = "Passw0rd!"
}