# Terraformers labs

This repository is basically my private Terraform lab for learning Terraform and it's components and features such as:
- Saving Terraform backend to AWS S3
- Handling AWS Credentials for creating resources using KMS and Role
- Utilize **Terraform module** for creating multiple similar resources (in my case, I've created two modules: **VPC** and **EC2-autoscaling** for it's components)
- Using **Data Source** to get the latest Ubuntu Image ID
- Using **Variables** for easily maintaining values 


## Contents
Inside the **aws** folder, there are 3 folders: 
- `EC2-AutoscalingGroup`: Creating a VPC along with it's components (private and public subnets, Internet Gateway, Route Tables) with several EC2 instances along with the Load Balancer and Auto Scaling Group
- `PEERING-SE1 and PEERING-SE2`: Creating a VPC along with it's components, and create a VPC Peering with another VPC that I've also created with Terraform in another folder

## Contributors
[Hans Sebastian](https://github.com/hansebastian97/)