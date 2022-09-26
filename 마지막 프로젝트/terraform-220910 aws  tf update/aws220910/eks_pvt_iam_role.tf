resource "aws_iam_role" "bmo_eks_iam_role_pvt" {
 name = "bmo_eks_iam_role_pvt"

 path = "/"

 assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF

}
resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy_pvt" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.bmo_eks_iam_role_pvt.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS_pvt" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.bmo_eks_iam_role_pvt.name
}

resource "aws_iam_role" "workernodes_pvt" {
  name = "eks-node-group-iam-role_pvt"

  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })
 }

 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy_pvt" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role    = aws_iam_role.workernodes_pvt.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy_pvt" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role    = aws_iam_role.workernodes_pvt.name
 }

 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds_pvt" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.workernodes_pvt.name
 }

 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_pvt" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role    = aws_iam_role.workernodes_pvt.name
 }