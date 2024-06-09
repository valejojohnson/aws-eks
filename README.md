# Terraform EKS Cluster (aws-eks)

This repository contains Terraform configuration for setting up an Amazon EKS cluster with managed node groups, cluster addons, and access policies.

## Prerequisites

- Terraform v1.0.0 or higher
- AWS CLI configured with appropriate permissions
- Kubernetes CLI (`kubectl`) installed
- AWS IAM user with permissions to create EKS clusters and IAM roles

## Usage

1. **Clone the Repository**

   ```sh
   git clone https://github.com/valejojohnson/aws-eks.git && cd aws-eks

2. **Initialize the Terraform working directory.**
   ```sh
   terraform init

3. **Terraform Plan**
   ```sh
   terraform plan

4. **Terraform Apply** (This could take up to 20 mins)
   ```sh
   terraform apply

5. **Add Cluster** 
   ```sh
   aws eks update-kubeconfig --name <your-cluster-name> --region <your-region>
   ```
   **Example:**
   ```sh
   aws eks update-kubeconfig --name eks-bunny-rabbit --region us-west-1 

6. **Check access**
   ```sh
   kubectl get ns

## Configuration

### Variables
`cluster_name`: Name of the EKS cluster. This is generated using random_pet.

`cluster_version`: The version of the EKS cluster (default is "1.30").

`iam_role_arn`: The ARN of the IAM role for the EKS cluster.

`vpc_id`: The VPC ID where the EKS cluster will be created.

`subnet_ids`: The subnet IDs for the EKS cluster.


### Outputs
`eks_cluster_id`: The ID of the created EKS cluster.

`eks_cluster_endpoint`: The endpoint of the created EKS cluster.

`eks_cluster_certificate_authority`: The certificate authority data for the EKS cluster.


## Resources Created

- [x] `EKS Cluster`: An Amazon EKS cluster with public and private endpoint access.

- [x] `Managed Node Groups`: Auto-scaling groups of worker nodes.

- [x] `Cluster Addons`: CoreDNS, VPC CNI, kube-proxy, AWS EBS CSI driver, and Amazon CloudWatch Observability.

- [x] `Access Entry`: Grants access to the EKS cluster for the current AWS user.

- [x] `Access Policy Association`: Associates the Amazon EKS Admin Policy with the EKS cluster.

## License

This project is licensed under the MIT License - see the [LICENSE](https://en.wikipedia.org/wiki/MIT_License) for more details.

### Explanation:
- **Prerequisites**: Lists the necessary tools and permissions required to use the configuration.
- **Usage**: Provides step-by-step instructions on how to clone the repository, initialize Terraform, review the plan, apply the configuration, and configure `kubectl`.
- **Configuration**: Describes the variables and outputs used in the configuration.
- **Resources**: Briefly describes the main Terraform resources being created.
- **Example**: Shows an example configuration that can be used in a Terraform project.
- **License**: Specifies the license under which the project is distributed.

This `README.md` file provides clear instructions and information about the Terraform configuration for setting up an EKS cluster with access policies.
