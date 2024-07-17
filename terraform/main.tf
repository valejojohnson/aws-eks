provider "aws" {
  region = "us-west-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

resource "random_pet" "this" {
  length = 2
  prefix = "eks"
}