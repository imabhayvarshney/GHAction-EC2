provider "aws" {
  region  = var.AWS_REGION # value will be taken form vars.tf file.
}

variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = map(string)
  default = {
    "ap-south-1" = "ami-0851b76e8b1bce90b" # ami which will be used to launch                           instance.
  }
}

variable "INSTANCE_USERNAME" {
  default = "ubuntu"  # username which will be used while doing remote-execution with the launched instance.
}

resource "tls_private_key" "oskey" {
  algorithm = "RSA"
}

resource "local_file" "myterrakey" {
  content  = tls_private_key.oskey.private_key_pem
  filename = "myterrakey.pem"
}

resource "aws_key_pair" "key121" {
  key_name   = "myterrakey"
  public_key = tls_private_key.oskey.public_key_openssh
}

resource "aws_instance" "mytfinstance" {
  ami           = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.key121.key_name

  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    type        = "ssh"
    user        = var.INSTANCE_USERNAME
    private_key = tls_private_key.oskey.private_key_pem
    host        = aws_instance.mytfinstance.public_ip
  }
}
