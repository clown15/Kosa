resource "aws_eks_cluster" "bmo_eks_private_cluster" {
 name = "BmoEksPrivateCluster"
 version = var.k8s_ver
 role_arn = aws_iam_role.bmo_eks_iam_role_pvt.arn

 vpc_config {
  security_group_ids = [aws_security_group.bmo_eks_private_sg.id]
  subnet_ids = [var.private_sub_2a_id, var.private_sub_2c_id]
  endpoint_private_access = true
  endpoint_public_access = false
 }

 depends_on = [
  aws_iam_role.bmo_eks_iam_role_pvt,
 ]

 tags = {
   Name = "BmoPrivateEks"
   MakeDate = var.make_date
   Function = "Private EKS"
   User = "Kim"
 }

}

 resource "aws_eks_node_group" "pvt-worker-node-group" {
  cluster_name  = aws_eks_cluster.bmo_eks_private_cluster.name
  node_group_name = "bmo_private_workernodes"
  node_role_arn  = aws_iam_role.workernodes_pvt.arn
  subnet_ids   = [var.private_sub_2a_id, var.private_sub_2c_id]
  ami_type     = var.ami_amazon_linux
  instance_types = [var.eks_instance_type]

  scaling_config {
   desired_size = var.eks_pvt_scaling_des
   max_size   = var.eks_pvt_scaling_max
   min_size   = var.eks_pvt_scaling_min
  }

  remote_access {
    ec2_ssh_key = var.pvt_key_name
    source_security_group_ids = [aws_security_group.bmo_eks_private_sg.id]
  }

  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy_pvt,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy_pvt,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_pvt,
  ]

  tags = {
    Name = "BmoEksPvtNode"
    MakeDate = var.make_date
    Function = "PRIVATE EKS Node"
    User = "Kim"
  }
 }
