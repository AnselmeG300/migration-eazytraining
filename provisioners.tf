resource "null_resource" "move_scripts" {

  depends_on = [ aws_volume_attachment.ebs_att, aws_eip_association.eip_assoc ]

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = var.user
      private_key = file("./scripts/eazytraining-migration.pem")
      host        = aws_eip.my_eip.public_ip
    }

    source = "scripts.zip"
    destination = "scripts.zip"
  }
}

resource "null_resource" "deploy" {

  depends_on = [ null_resource.move_scripts ]

  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = var.user
      private_key = file("./scripts/eazytraining-migration.pem")
      host        = aws_eip.my_eip.public_ip
    }

    inline = [

      # install packages
      "sudo yum install epel-release -y",
      "sudo yum update -y",
      "sudo yum install wget unzip mysql-client dos2unix -y",

      # install docker
      "sudo curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker ${var.user}",
      "sudo systemctl restart docker",
      "sudo systemctl enable docker",

      # transfer temporary scripts for deployment
      "mkdir -p tempon", 
      "mv scripts.zip tempon/scripts.zip",
      "cd tempon", 
      "unzip scripts.zip -d scripts",

      # deletion of special characters in scripts
      "cd scripts",
      "dos2unix install_cloudwatch.sh install_ssm.sh restore_mysql.sh restore_ebs.sh mount_ebs.sh .env",
      
      # transfer persistent scripts for deployment
      "cd /home/centos",
      "cp ./tempon/scripts/.env .",
      "cp ./tempon/scripts/docker-compose.yml .",
  
      # mount ebs disk in app directory
      "sudo sh tempon/scripts/mount_ebs.sh",

      # setup cloudwatch && ssm
      "sudo sh tempon/scripts/install_ssm.sh",
      "sudo sh tempon/scripts/install_cloudwatch.sh",

      # launch of the application
      "cd /home/centos",
      "sudo docker compose up -d",

      # restoration of the application
      "cd /home/centos/tempon/scripts",
      "sudo sh restore_mysql.sh",

      # deleting temporary files
      "cd /home/centos",
      "sudo rm -r tempon"
    ]
  }
}
