resource "aws_instance" "worker_nodes" {

  ami                    = var.redhat_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_traffice.id]
  subnet_id              = module.vpc.public_subnets[0]
  #iam_instance_profile = "${aws_iam_instance_profile.ec2-profile}"

  tags = {
    "Name"        = "node-${var.environment}.example.com"
    "Environment" = var.environment
  }

}

resource "null_resource" "provisioner" {

  depends_on = [
    aws_instance.worker_nodes,aws_efs_file_system.efs
  ]

  provisioner "remote-exec" {
    inline = [
      "sudo dnf -y update",
      "sudo dnf install -y yum-utils",
      "sudo yum config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo",
      "sudo yum -y update",
      "sudo dnf install -y docker-ce docker-ce-cli containerd.io",
      "sudo systemctl start docker.service",
      "sudo systemctl enable docker.service",
      "sudo yum -y install nfs-utils",
      "sudo mkdir /docker-mount-point",
      "sudo yum -y install unzip",
      "sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip",
      "sudo unzip awscliv2.zip",
      "sudo ./aws/install",
      #"sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/docker-mount-point" 
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      host        = aws_instance.worker_nodes.public_ip
      private_key = file("./id_rsa")
    }

  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCuP9JmANv/IQXh8kjDxmd1RzgMS31dwTRy+Xw+zLFefVYsBAv2NAWgw42Co3KnUYwCPcHKb+MR/NBxEvWf46Q0/EntjmW3Vy6/uKHd8oAQZRW1r0lW1u1vRmDD8/sPZ1H96aIBCONijs7k6zD+zucpM83brPhBVj9k8TyG3W6yUnawRykwHXO0IV3WBLbXgLR9E49Ogl3oNkYnPisxdyiYKiTwJIl+Z0/wm1p4gX/1klwHMZERfylV4WX/+xihiIFVb8F2FgOU2yx1nBnAfn4B0JKYPKNqNp7YXjYdilSfmQgvwJezu8yGZRlIW554/35HQqnqze9lveFb7fotw5DP"
}