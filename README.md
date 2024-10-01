# rsschool-devops-course-tasks
The course aims to offer in-depth knowledge of DevOps principles and essential AWS services necessary for efficient automation and infrastructure management. Participants will gain practical skills in setting up, deploying, and managing Kubernetes clusters on AWS, using tools like Kops and Terraform.

# Task #1
  - Install and configure the required software on your local computer
  - Set up an AWS account with the necessary permissions and security configurations
  - Deploy S3 buckets for Terraform states
  - Create a federation with your AWS account for Github Actions
  - Create an IAM role for Github Actions
  - Create a Github Actions workflow to deploy infrastructure in AWS

Github Actions implements Terraform workflow with 3 jobs
  - terraform-check with format checking terraform fmt
  - terraform-plan for planning deployments terraform plan
  - terraform-apply for deploying terraform apply

When ```terraform-check``` and ```terraform-plan``` will be executed automatically once Pull Request opened from feature branch into ```main``` branch

While ```terraform-apply``` will be executed only once Pull Request has been merged into ```main``` branch

  

  


