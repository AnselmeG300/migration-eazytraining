resource "aws_ebs_volume" "wordpress_ebs" {
  availability_zone = var.AZ[var.region]
  size              = var.size
  snapshot_id = var.snapshot_id
}

