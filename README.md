# Multi_Resource_Deployment_Using_Terraform
"Comprehensive Terraform Configuration for Deploying AWS Infrastructure: Automates VPC, Subnet, Internet Gateway, Route Table, Security Group, and EC2 Instance Creation with Customizable Inputs and Outputs"

# README.md for `multiresource.tf`

## Overview
This repository contains a Terraform configuration file, `multiresource.tf`, that provisions the following AWS resources:
- A Virtual Private Cloud (VPC)
- A public subnet within the VPC
- An internet gateway for external access
- A route table and its association
- A security group for allowing SSH and HTTP access
- An EC2 instance within the public subnet

## Prerequisites
- **Terraform** installed on your system (version check: `terraform -v`)
- **AWS credentials** configured for CLI access to your account
- An **Amazon Machine Image (AMI)** ID for launching the EC2 instance

## File Structure
- **`multiresource.tf`**: Main Terraform configuration file.
- **`terraform.tfvars`**: A file for setting variable values used by the configuration.

## Required Variables
This configuration uses the following input variables:
- `instance_type`: Type of EC2 instance (default is `t2.micro`).
- `ami_id`: The AMI ID for launching the EC2 instance.
- `public_subnet_cidr_type`: The CIDR block for the public subnet.
- `vpc_cidr_type`: The CIDR block for the VPC.

### `terraform.tfvars`
```hcl
instance_type           = "t2.nano"
ami_id                  = "XXXXXXXXXXXXXXXXX" # Provide your own AMI ID
public_subnet_cidr_type = "10.0.0.0/24"
vpc_cidr_type           = "10.0.0.0/16"
```

## CLI Commands and Usage Guide

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
   Initializes the working directory containing the configuration file.

2. **Check Terraform Version**:
   ```bash
   terraform -v
   ```
   Verifies the installed Terraform version.

3. **Format Configuration**:
   ```bash
   terraform fmt
   ```
   Formats the `multiresource.tf` file to standardize code structure.

4. **Validate Configuration**:
   ```bash
   terraform validate
   ```
   Ensures the configuration syntax is correct.

5. **Plan Infrastructure Deployment**:
   ```bash
   terraform plan
   ```
   Generates an execution plan to show how Terraform will create resources.

6. **Apply Configuration**:
   ```bash
   terraform apply
   ```
   Deploys the resources defined in the configuration. Confirm with `yes` when prompted.

7. **List State Resources**:
   ```bash
   terraform state list
   ```
   Lists all resources tracked by Terraform in the current state.

8. **Display Outputs**:
   ```bash
   terraform output
   ```
   Shows the output values specified in the configuration (e.g., `vpc_id`, `subnet_id`, `ec2_public_ip`).

9. **Generate a Graph of Dependencies**:
   ```bash
   terraform graph
   ```
   Outputs a graph showing resource dependencies.

10. **Destroy Resources**:
    ```bash
    terraform destroy
    ```
    Destroys all resources managed by Terraform in the current configuration. Confirm with `yes` when prompted.

## Outputs
This configuration provides the following output variables:
- **`vpc_id`**: The ID of the created VPC.
- **`subnet_id`**: The ID of the public subnet.
- **`ec2_public_ip`**: The public IP address of the EC2 instance.

## Notes
- Ensure your AWS CLI is configured (`aws configure`) with proper access credentials to manage AWS resources.
- Customize `terraform.tfvars` to modify instance types, AMI IDs, and CIDR blocks as needed for different deployments.

## Troubleshooting Tips
- **Initialization errors**: Ensure your Terraform version is up to date and network connectivity is stable.
- **Apply errors**: Double-check the `ami_id` and region configuration.
- **Validation failures**: Run `terraform fmt` to clean code and `terraform validate` to spot any syntax errors.

Feel free to try out the code yourself, run it and customize the code as you please! Also, DO NOT FORGET to destroy all resources if you are testing this on a live AWS account! 
