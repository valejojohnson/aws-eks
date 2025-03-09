# Generate SSH key pair locally
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create EC2 Key Pair in AWS
resource "aws_key_pair" "ec2_key" {
  key_name   = "my-ec2-key"  # Change the key name if needed
  public_key = tls_private_key.ec2_key.public_key_openssh
}

# Store the private key in AWS Secrets Manager
resource "aws_secretsmanager_secret" "key_secret" {
  name = aws_key_pair.ec2_key.key_name
}

resource "aws_secretsmanager_secret_version" "key_secret_version" {
  secret_id     = aws_secretsmanager_secret.key_secret.id
  secret_string = tls_private_key.ec2_key.private_key_pem
}

# Output the Key Name (DO NOT output the private key for security reasons)
output "ec2_key_name" {
  value = aws_key_pair.ec2_key.key_name
}
