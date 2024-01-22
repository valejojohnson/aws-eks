module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                   = var.eks_name # Set name in the variables.tf file
  cluster_version                = "1.28" # Latest version as of 01/2024
  cluster_endpoint_public_access = true
  iam_role_arn                   = data.aws_iam_role.eks.arn
  vpc_id                         = data.aws_vpc.default.id
  subnet_ids                     = data.aws_subnets.subnets.ids

  cluster_enabled_log_types = ["api", "audit", "authenticator", "scheduler"]

  eks_managed_node_groups = {
    default-node-group = {
      desired_size   = 1
      max_size       = 3
      min_size       = 1
      instance_types = ["t3.medium"]
    }
  }

  cluster_addons = {
    coredns = {
      resolve_conflicts_on_create = "OVERWRITE"
      most_recent                 = true
    }

    vpc-cni = {
      resolve_conflicts_on_create = "OVERWRITE"
      most_recent                 = true
    }

    kube-proxy = {
      resolve_conflicts_on_create = "OVERWRITE"
      most_recent                 = true
    }

    aws-ebs-csi-driver = {
      most_recent = true
    }

    amazon-cloudwatch-observability = {
      most_recent = true
    }
  }
}
