provider "aws" {
  profile = "default"
  region  = "us-west-1"
}

resource "aws_iam_role_policy_attachment" "eks_administrator_access" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = data.aws_iam_role.eks.name
}
