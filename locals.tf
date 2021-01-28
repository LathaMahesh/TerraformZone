locals {
    db_subnet           = ["db" , "db2"]
  public_subnet         = lookup(var.association, "public")
  private_subnet        = lookup(var.association, "private")
}
