resource "aws_instance" "wordpress" {
  ami               = var.ami[var.region]
  key_name          = "eazytraining-migration"
  availability_zone = var.AZ[var.region]   
  instance_type     = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.AWSServiceProfileForEC2.name
  
  depends_on = [
    aws_iam_role_policy_attachment.ssm_attach,
    aws_iam_role_policy_attachment.cloudwatch_attach,
  ]

  vpc_security_group_ids = [
    aws_security_group.wordpress.id,
    aws_security_group.wordpress_ssh.id
  ]

  tags = {
    Name = var.maintainer
  }

  provisioner "local-exec" {
    command = "echo PUBLIC IP: ${self.public_ip}"
  }

}
