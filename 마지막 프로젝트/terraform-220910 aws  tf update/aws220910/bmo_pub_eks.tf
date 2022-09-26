resource "aws_eks_cluster" "bmo_eks_cluster" {
 name = "BmoEksCluster"
 version = var.k8s_ver
 role_arn = aws_iam_role.bmo_eks_iam_role.arn

 vpc_config {
  security_group_ids = [aws_security_group.bmo_eks_sg.id]
  subnet_ids = [var.pub_sub_2a_id, var.pub_sub_2c_id]
 }

 depends_on = [
  aws_iam_role.bmo_eks_iam_role,
 ]

 tags = {
   Name = "BmoEks"
   MakeDate = var.make_date
   Function = "PUBLIC EKS"
   User = "Kim"
 }

}


 resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = aws_eks_cluster.bmo_eks_cluster.name
  node_group_name = "bmo-workernodes"
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [var.pub_sub_2a_id, var.pub_sub_2c_id]
  ami_type     = var.ami_amazon_linux
  instance_types = [var.eks_instance_type]

  scaling_config {
   desired_size = var.eks_pub_scaling_des
   max_size   = var.eks_pub_scaling_max
   min_size   = var.eks_pub_scaling_min
  }

  remote_access {
    ec2_ssh_key = var.pub_key_name
  }

  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "BmoEksNode"
    MakeDate = var.make_date
    Function = "PUBLIC EKS Node"
    User = "Kim"
  }
 }
