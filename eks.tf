module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                    = random_pet.this.id
  cluster_version                 = "1.30"
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  iam_role_arn                    = data.aws_iam_role.eks.arn
  vpc_id                          = data.aws_vpc.default.id
  subnet_ids                      = data.aws_subnets.subnets.ids



  cluster_enabled_log_types = ["api", "audit", "authenticator", "scheduler"]

  eks_managed_node_groups = {
    eks-node-group = {
      desired_size   = 2
      max_size       = 3
      min_size       = 2
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

resource "aws_eks_access_entry" "this" {
  depends_on = [module.eks]

  cluster_name      = module.eks.cluster_name
  principal_arn     = data.aws_caller_identity.current.arn
  kubernetes_groups = ["AmazonEKSAdminPolicy"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "this" {
  depends_on = [aws_eks_access_entry.this,module.eks]

  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = data.aws_caller_identity.current.arn

  access_scope {
    type       = "cluster"
  }
}