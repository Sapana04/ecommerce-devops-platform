############################################################
# EKS Managed Node Group
############################################################

resource "aws_eks_node_group" "main" {

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  instance_types = [
    var.instance_type
  ]

  capacity_type = "ON_DEMAND"

  scaling_config {

    desired_size = 2
    min_size     = 2
    max_size     = 4

  }

  update_config {

    max_unavailable = 1

  }

  depends_on = [

    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ecr_read_only

  ]

  tags = {

    Name        = "${var.project_name}-node-group"
    Environment = var.environment

  }

}