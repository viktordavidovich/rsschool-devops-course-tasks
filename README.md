# rsschool-devops-course-tasks
The course aims to offer in-depth knowledge of DevOps principles and essential AWS services necessary for efficient automation and infrastructure management. Participants will gain practical skills in setting up, deploying, and managing Kubernetes clusters on AWS, using tools like Kops and Terraform.

# Task #1
  - Install and configure the required software on your local computer
  - Set up an AWS account with the necessary permissions and security configurations
  - Deploy S3 buckets for Terraform states
  - Create a federation with your AWS account for Github Actions
  - Create an IAM role for Github Actions
  - Create a Github Actions workflow to deploy infrastructure in AWS

**Github Actions** implements Terraform workflow with 3 jobs:
  - terraform-check with format checking terraform fmt
  - terraform-plan for planning deployments terraform plan
  - terraform-apply for deploying terraform apply

When ```terraform-check``` and ```terraform-plan``` will be executed automatically once Pull Request opened from feature branch into ```main``` branch

While ```terraform-apply``` will be executed only once Pull Request has been merged into ```main``` branch

### Prerequisites

    Terraform: Version 1.9.6 or higher.
    AWS Account: An active AWS account with necessary permissions to create S3 buckets, DynamoDB and IAM roles
    AWS CLI: Optional, but useful for verifying resources after deployment.

### Configuration

1. **Clone the Repository**:

   `git clone git@github.com:viktordavidovich/rsschool-devops-course-tasks.git`
   `cd repo`
   
2. **Export env variables**

run 
  `export aws_access_key_id={{YOUR_AWS_ACCESS_KEY_ID}}`
  
  `export aws_secret_access_key={{YOUR_AWS_SECRET_ACCESS_KEY}}`
  
  `export aws_region={{YOUR_AWS_REGION}}`
  
3. **Initialize Terraform and run plan**

run `terraform init` and `terraform plan`

4. **Apply Changes: Deploy the infrastructure**

run `terraform apply`

5. **Destroying Infrastructure**
   
To remove the resources created by Terraform, run `terraform destroy`

# Task #2

- Create VPC
- 2 public subnets in different AZs
- 2 private subnets in different AZs
- Configure Internet Gateway

Routing configuration:
- Instances in all subnets can reach each other
- Instances in public subnets can reach addresses outside VPC and vice-versa

### Architecture

![architecture.png](/task_2/architecture.png)

### Configuration

**VPC (Virtual Private Cloud):**

The whole architecture exists within a VPC, which provides network isolation.

**Public and Private Subnets:**

- Public Subnet (Green) – Instances or resources in this subnet can be accessed directly from the internet.
- Private Subnet (Blue) – Instances or resources here do not have direct internet access; they are isolated for security.

**Availability Zones (AZ1 and AZ2):**

   The diagram is using two availability zones for high availability. Resources like EC2 instances and subnets are spread across AZ1 and AZ2 to ensure redundancy.

**Internet Gateway (IGW):**

   The Internet Gateway connects the VPC to the internet. Only resources in the public subnets, such as a load balancer, can directly communicate with external clients.

**NAT Gateway:**

   The NAT Gateway is placed in the public subnet to allow instances in the private subnet to access the internet (e.g., for downloading updates) without exposing them directly to the internet.

~~**ALB (Application Load Balancer):**~~ (excluded from this task)

   ~~The Application Load Balancer (ALB) is deployed in the public subnet to distribute incoming traffic across EC2 instances (and potentially Auto Scaling groups) in different AZs for improved availability and fault tolerance.~~

**EC2 Instances:**

- Public EC2 Instances (Orange) – These instances are placed in public subnets, meaning they can directly connect to and be reached from the internet.
- Private EC2 Instances – These instances are placed in private subnets and are not directly accessible from the internet. They can be accessed through other services through the NAT gateway for outgoing connections.

~~**Auto Scaling Group:**~~ (excluded from this task)

   ~~The Auto Scaling group is configured to automatically launch or terminate EC2 instances based on demand, ensuring the application can scale with load while maintaining availability.~~

**SSH Access:**

   SSH connections are allowed between public EC2 instances and private EC2 instances. You can securely SSH into the private instances from public EC2 instances.
   This architecture ensures that while the private instances cannot be accessed directly from the internet, they can still be managed through controlled means (like using a public instance as a jump host).

**Traffic Flow:**
    
- Inbound Traffic:

    Traffic enters the VPC through the Internet Gateway which distributes it to EC2 instances in public subnets.
- Outbound Traffic:

    Private instances access the internet through the NAT Gateway, which is required for private resources to download updates or communicate with external services.





  

  


