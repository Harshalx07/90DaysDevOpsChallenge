# Day 61 – Introduction to Terraform and Your First AWS Infrastructure

## Objective

Learn the fundamentals of **Infrastructure as Code (IaC)** using Terraform by provisioning AWS resources through code instead of manually creating them from the AWS Management Console.

---

# What is Infrastructure as Code (IaC)?

Infrastructure as Code (IaC) is the practice of managing and provisioning infrastructure using configuration files instead of manually creating resources through a cloud console. By keeping infrastructure in code, it becomes repeatable, version-controlled, and easy to automate. This helps DevOps teams build identical environments, reduce configuration mistakes, and deploy infrastructure much faster.

---

# Why IaC Matters

* Eliminates manual configuration errors
* Makes infrastructure reproducible
* Supports version control using Git
* Enables automation through CI/CD
* Speeds up infrastructure deployment
* Improves collaboration across teams

---

# Terraform vs Other Tools

| Tool                   | Purpose                                                                          |
| ---------------------- | -------------------------------------------------------------------------------- |
| **Terraform**          | Creates and manages cloud infrastructure across multiple cloud providers         |
| **AWS CloudFormation** | AWS-only Infrastructure as Code service                                          |
| **Ansible**            | Configuration management and software provisioning                               |
| **Pulumi**             | Infrastructure as Code using programming languages such as Python and TypeScript |

---

# Declarative and Cloud-Agnostic

### Declarative

Terraform focuses on the desired end state instead of listing every step required to reach it.

### Cloud-Agnostic

Terraform supports multiple providers such as AWS, Azure, Google Cloud, Kubernetes, Docker, GitHub, and many more using the same workflow.

---

# Environment Setup

## Install Terraform

```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

terraform -version
```

---

## Install AWS CLI

```bash
brew install awscli

aws --version
```

---

## Configure AWS Credentials

```bash
aws configure
```

Provide:

* Access Key ID
* Secret Access Key
* Region: ap-south-1
* Output: json

Verify configuration:

```bash
aws sts get-caller-identity
```

---

# Project Structure

```text
terraform-basics/
│── main.tf
│── terraform.tfstate
│── terraform.tfstate.backup
│── .terraform/
```

---

# Terraform Configuration

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "harshal-terraweek-2026-12345"
}

resource "aws_instance" "server" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  tags = {
    Name = "TerraWeek-Day1"
  }
}
```

---

# Terraform Workflow

## Initialize

```bash
terraform init
```

Downloads the required AWS provider and creates the `.terraform` directory.

---

## Validate

```bash
terraform validate
```

Checks configuration syntax.

---

## Format

```bash
terraform fmt
```

Formats Terraform files automatically.

---

## Plan

```bash
terraform plan
```

Shows what Terraform will create, modify, or destroy without making any changes.

---

## Apply

```bash
terraform apply
```

Creates the infrastructure after confirmation.

---

## Show Current State

```bash
terraform show
```

Displays the current infrastructure in a readable format.

---

## List Managed Resources

```bash
terraform state list
```

Displays all resources managed by Terraform.

---

## View Individual Resource

```bash
terraform state show aws_s3_bucket.bucket

terraform state show aws_instance.server
```

Shows detailed information about a specific resource.

---

## Destroy Infrastructure

```bash
terraform destroy
```

Deletes every resource created by Terraform.

---

# Understanding terraform.tfstate

The Terraform state file stores information about every resource Terraform manages.

It includes:

* Resource IDs
* ARNs
* Instance IDs
* Public IP addresses
* Bucket names
* Tags
* Current resource configuration

The state file allows Terraform to compare the desired infrastructure with the existing infrastructure.

### Why should you never edit it manually?

Manual edits can corrupt the infrastructure state and cause Terraform to lose track of managed resources.

### Why should it never be committed to Git?

The state file may contain sensitive information such as resource IDs, metadata, and secrets. It should be stored securely using a remote backend such as an encrypted S3 bucket.

---

# Terraform Plan Symbols

| Symbol | Meaning                       |
| ------ | ----------------------------- |
| +      | Create resource               |
| -      | Destroy resource              |
| ~      | Update existing resource      |
| +/-    | Destroy and recreate resource |

---

# Challenge Completed

* ✅ Installed Terraform
* ✅ Installed AWS CLI
* ✅ Configured AWS credentials
* ✅ Created an S3 bucket using Terraform
* ✅ Created an EC2 instance
* ✅ Verified resources in the AWS Console
* ✅ Explored Terraform state
* ✅ Updated EC2 tags
* ✅ Destroyed all resources
* ✅ Learned the Terraform workflow

---

# Screenshots

> Add the following screenshots:

1. Terraform version
2. AWS CLI identity verification
3. `terraform init`
4. `terraform plan`
5. `terraform apply`
6. AWS S3 Console
7. AWS EC2 Console
8. `terraform destroy`

---

# Key Learnings

* Infrastructure can be managed entirely through code.
* Terraform follows a declarative approach.
* The state file is the heart of Terraform.
* Terraform makes cloud infrastructure repeatable, version-controlled, and automated.
* Infrastructure can be created and removed using a few simple commands.

---

## Repository Structure

```text
2026/
└── day-61/
    ├── day-61-terraform-intro.md
    ├── images/
    └── main.tf
```
