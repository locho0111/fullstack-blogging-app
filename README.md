# DevOps CI/CD Pipeline on AWS with Terraform, Ansible, Docker, Jenkins, Trivy, Nexus, and SonarQube

This project demonstrates the setup and deployment of a complete CI/CD pipeline using various DevOps tools on AWS. The infrastructure is provisioned using Terraform, Ansible is integrated for configuration management, and Docker containers are used for running the CI/CD tools such as Jenkins, Nexus, SonarQube, and Trivy.

## Technologies Used

### 1. **Terraform**

- Provisioned AWS EC2 instances to host the CI/CD tools such as Jenkins, Docker, Trivy, Nexus, and SonarQube.
- Set up an AWS EKS cluster and node groups for deploying Kubernetes workloads.

### 2. **AWS**

- Hosted the CI/CD pipeline using EC2 instances and EKS.
- Utilized AWS EKS for Kubernetes-based application deployments.

### 3. **Ansible**

- Integrated with Terraform to automate the installation of Jenkins, Docker, Trivy, Nexus, and SonarQube on the EC2 instances.

### 4. **Docker**

- Created Docker images for the application using Dockerfiles.
- Published the Docker images to Docker Hub for reuse in the CI/CD pipeline.

### 5. **Trivy**

- Integrated into the CI/CD pipeline to perform security scans:
  - File system scans
  - Docker image scans

### 6. **Nexus**

- Utilized as an artifact repository to store application builds and dependencies.
- Hosted as a Docker container on an EC2 instance.

### 7. **SonarQube**

- Integrated into the CI/CD pipeline to perform code quality analysis.
- Used to enforce quality gates and ensure clean code standards.
- Hosted as a Docker container on an EC2 instance.
