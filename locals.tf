locals {

  db_subnets        = ["db","db2"]
  private_subnets   = lookup(var.golrassociation,"private")
  public_subnets    = lookup(var.golrassociation, "public")
  mysql_port        = 3306
  protocol          = "tcp"
  anywhere_cidr     = "0.0.0.0/0"
  start_port        = 0
  end_port          = 65535
}