provider "aws" {
  region = "us-east-2"
}
/*
#-------------------------EC2--------------------------
# latest instances
data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
 
  filter {
    name  = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name  = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
# create instances
resource "aws_instance" "project" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.project_security.id]
  key_name               = "Jenkins_AWS_Deployment"

  tags = {
    Name = "FinalProject"
  }
}

resource "aws_instance" "jenkins" {
#  ami                    = data.aws_ami.latest_ubuntu.id
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.jenkins_security.id]
  key_name               = "Jenkins_AWS_Deployment"

  tags = {
    Name = "Jenkins"
  }
}
# create policy
resource "aws_security_group" "project_security" {
  name = "web-server-security"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh_web"
  }
}

resource "aws_security_group" "jenkins_security" {
  name = "jenkins-server-security"

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 50000
    to_port          = 50000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ssh_8080"
  }
}
# console output
output "latest_ubuntu_ami_id" {
  value = data.aws_ami.latest_ubuntu.id
}
output "latest_ubuntu_ami_name" {
  value = data.aws_ami.latest_ubuntu.name
}

output "latest_amazom_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}
output "latest_amazom_linux_ami_name" {
  value = data.aws_ami.latest_amazon_linux.name
}

output "project_server_public_ip" {
  value = aws_instance.project.public_ip
}

output "jenkins_server_jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

# generate hosts file for ansible
resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Ubuntu: ${aws_instance.project.public_ip} Amazon_linux: ${aws_instance.jenkins.public_ip} > project_public_ip.txt"
  }
}


resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "./ip_2_ansible.sh"
  }
  depends_on = [null_resource.command1]
}
*/
/*
#--------------------------S3--------------------------

resource "aws_s3_bucket" "front_of_project" {
  bucket = "imashnov-front-of-project"
  acl    = "public-read"

  tags = {
    Name        = "Front"
    Environment = "PROD"
  }
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST"]
    allowed_origins = ["https://imashnov-front-of-project"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
  #Using versioning
  /*
  versioning {
    enabled = true
  }
}
*/
/*
}

output "arn_s3" {
  value = aws_s3_bucket.front_of_project.arn
}

output "s3_full_name" {
  value = aws_s3_bucket.front_of_project.bucket
}

output "s3_short_name" {
  value = aws_s3_bucket.front_of_project.bucket_prefix
}
*/
#--------------------------RDS--------------------------
resource "aws_db_instance" "beer_database" {
  allocated_storage    = 5
  max_allocated_storage = 7
  engine               = "postgres"
  engine_version       = "12.5"
  instance_class       = "db.t2.micro"
  name                 = "beerdb1"
  username             = "imashnyov"
  password             = "beeradmin"
  skip_final_snapshot  = true
#  parameter_group_name = "rds_sg"
}
/*
resource "aws_db_security_group" "rds_sg" {
  name = "rds_sg"

  ingress {
    from_port        = 1453
    to_port          = 1453
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
*/