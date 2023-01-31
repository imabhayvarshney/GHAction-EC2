# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami		= "ami-785db401"
  instance_type = "t2.micro"

  tags =  { 
	  Name = "Terraform Ec2"
  }
	
outputs " my console output" {
	value = aws_instance.example.public_ip
}
  
}
