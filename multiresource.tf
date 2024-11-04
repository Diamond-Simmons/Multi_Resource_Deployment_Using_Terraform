provider "aws" {
  region = "us-west-2"
}

variable "instance_type" {
  description = "Enter The EC2 instance type"
  default     = "t2.micro"
  type        = string
}

variable "ami_id" {
  description = "Enter the EC2 AMI ID"
}

variable "public_subnet_cidr_type" {
  description = "Enter The subnet type"
}

variable "vpc_cidr_type" {
  description = "Enter The subnet type"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_type
  tags = {
    Name = "Diamond-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id # resource_keysyntax. logicalid. .id = !Ref in Cloud formation
  cidr_block              = var.public_subnet_cidr_type
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Diamond-PublicSubnet"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Diamond-IGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "Diamond-routeTable"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "my_sg" {
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Diamond-SecurityGroup"
  }

}


resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id #"ami-04dd23e62ed049936"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "Diamond-Ec2Instance"
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}

# CLI Terminal commands

# 1. terraform init (initialize terraform)
# 2. terraform -v (check the version of terraform you're using)
# 3. terraform fmt (properly formats the .tf file)
# 4. terraform validate (validates the syntax of your code)
# 5. terraform plan (Tells us how the infrastructure will be created)
# 6. terraform apply (creates the resources from your .tf file.)
# 7. terraform state list (list resources within the state file)
# 8. terraform output (list all resource outputs)
# 9. terraform graph (list the dependencies of your resources)
# 10.terraform destroy (destroys all running resources)