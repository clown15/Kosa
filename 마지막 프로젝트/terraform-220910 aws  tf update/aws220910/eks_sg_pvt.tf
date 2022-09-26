resource "aws_security_group" "bmo_eks_private_sg" {
  name        = "bmo_eks_private_sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.bmo_vpc_id

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["112.221.225.165/32"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "BmoPvtEksSg"
    MakeDate = var.make_date
    Function = "PRIVATE EKS SecurityGroup"
    User = "Kim"
  }
}
