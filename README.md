# GCP Cloud SQL (Private IP) Infrastructure using Terraform

This project provisions a secure and modular Cloud SQL (PostgreSQL 14) environment on Google Cloud Platform using Terraform.

The infrastructure is designed following production-style best practices:
- Private networking (no public database exposure)
- Modular Terraform architecture
- Environment-based deployment
- Secure secret handling via Secret Manager

The goal of this project is to demonstrate how to deploy a private database architecture on GCP using Infrastructure as Code (IaC).

---

# 🎯 What This Project Creates

When deployed, this Terraform configuration provisions:

- A custom VPC (Auto subnet disabled)
- A regional subnet
- Private Service Access (VPC Peering with Google Service Network)
- A reserved internal IP range for Google-managed services
- A Cloud SQL PostgreSQL 14 instance (Private IP only)
- A database inside the instance
- A database user
- A Secret in Secret Manager for storing the database password

All components are provisioned through reusable Terraform modules.

---

# 🔐 Security Approach

This infrastructure is intentionally designed to avoid public exposure of the database.

Key security decisions:

- `ipv4_enabled = false` (No public IP)
- Private Service Access is enabled
- Database is accessible only within the VPC
- Secrets stored using Google Secret Manager
- Sensitive variables marked in Terraform
- No credentials should be committed to Git

This mirrors real-world production setups.

---

# 🧠 How It Works (Conceptual Overview)

Cloud SQL does not live directly inside your VPC.  
Instead, it runs inside a Google-managed service network.

To allow private communication between your VPC and Cloud SQL, the following is configured:

1. A private IP range is reserved in your VPC.
2. Private Service Access (VPC Peering) is established with `servicenetworking.googleapis.com`.
3. Cloud SQL is attached to your VPC using `private_network`.

This allows the database to receive an internal IP from your VPC and communicate privately.

---

# 🛠 Prerequisites

Ensure the following are installed:

- Terraform >= 1.5
- Google Cloud SDK
- Access to a GCP Project with required permissions

Authenticate:

```bash
gcloud auth application-default login

Enable required APIs:

gcloud services enable \
  compute.googleapis.com \
  servicenetworking.googleapis.com \
  sqladmin.googleapis.com \
  secretmanager.googleapis.com

⚙️ Configuration

You can configure variables in two ways:

Option 1 (Recommended): Environment Variables
export TF_VAR_project_id="your-gcp-project-id"
export TF_VAR_region="us-central1"
export TF_VAR_db_password="your-secure-password"

Option 2: Local terraform.tfvars (Do Not Commit)
project_id  = "your-gcp-project-id"
region      = "us-central1"
db_password = "your-secure-password"

🚀 Deployment Steps

Navigate to the desired environment:

cd envs/dev


Initialize Terraform:

terraform init


Review execution plan:

terraform plan


Apply infrastructure:

terraform apply


Confirm with yes when prompted.

📤 Outputs

After successful deployment, Terraform outputs:

Cloud SQL Private IP address

You can verify resources in the Google Cloud Console:

VPC Network

Cloud SQL

Secret Manager

🔄 Destroy Infrastructure

To remove all provisioned resources:

terraform destroy


Always review the destroy plan carefully before confirming.
