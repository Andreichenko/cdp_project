# CDP Project (Continuous Delivery Pipeline)

![Java Version](https://img.shields.io/badge/Java-8-blue?logo=openjdk)
![Terraform](https://img.shields.io/badge/Terraform-%3E%3D%200.12.0-844FBA?logo=terraform)
![Ansible](https://img.shields.io/badge/Ansible-Automation-EE0000?logo=ansible)
![Docker](https://img.shields.io/badge/Docker-Containerization-2496ED?logo=docker)
![CI/CD Pipeline](https://img.shields.io/github/actions/workflow/status/Andreichenko/cdp_project/main.yml?branch=master&label=CI%2FCD)

This repository contains a full Continuous Delivery Pipeline demonstrating how to deploy a secure, Java-based Payment Web Application using Terraform for AWS infrastructure setup, Ansible for server configurations, and Jenkins for automated pipelines.

---

## 📐 1. Classic Infrastructure & Deployment (Tomcat & Docker)

Below is the workflow showing the classic deployment pipeline targeting dedicated EC2 VMs (Tomcat and Docker hosts):

```mermaid
graph TD
    Developer["💻 Developer"] -->|1. Git Push| GitHub["🐙 GitHub Repository"]
    GitHub -->|2. Webhook Trigger| Jenkins["🏗️ Jenkins CI/CD"]
    
    subgraph Build_Stage ["🛠️ Compilation & Packaging"]
        Jenkins -->|3. Compile & Test| Maven["📦 Maven (mvn package)"]
        Maven -->|4. Generate artifact| War["📄 webapp.war"]
    end

    subgraph AWS_Classic_Infra ["🌐 AWS Classic Infrastructure"]
        VPC["🌐 Common VPC"]
        VPC -->|Provision| JenkinsVM["🖥️ Jenkins Master VM"]
        VPC -->|Provision| TomcatVM["🖥️ Tomcat Server VM"]
        VPC -->|Provision| DockerVM["🖥️ Docker Host VM"]
    end

    subgraph Classic_Deploy ["🚀 Classic Deployment Paths"]
        JenkinsVM -->|Option A: SCP Copy| TomcatVM
        JenkinsVM -->|Option B: Docker Build & Push| Registry["🐳 Docker Hub Registry"]
        Registry -->|Pull & Run Container| DockerVM
    end
```

---

## ☸️ 2. Kubernetes Infrastructure & Deployment (AWS EKS & Helm)

Below is the infrastructure topology and delivery workflow of the containerized application targeting the AWS EKS Cluster using Helm:

```mermaid
graph TD
    Developer["💻 Developer"] -->|1. Git Push| GitHub["🐙 GitHub Repository"]
    GitHub -->|2. Webhook Trigger| Jenkins["🏗️ Jenkins CI/CD"]
    
    subgraph K8s_Build_Stage ["🛠️ Containerization Pipeline"]
        Jenkins -->|3. Build & Test| Maven["📦 Maven (mvn package)"]
        Maven -->|4. Docker Build| Docker["🐳 Docker Engine"]
        Docker -->|5. Push Image| Registry["🐳 Docker Hub Registry"]
    end

    subgraph AWS_EKS_Infra ["🌐 AWS EKS Infrastructure"]
        subgraph VPC_K8s ["🌐 Common VPC (10.0.0.0/16)"]
            subgraph Public_Subnet ["🔓 Public Subnet"]
                ALB["⚖️ ELB (LoadBalancer Service)"]
            end
            subgraph Private_Subnets ["🔒 Private Subnets"]
                EKS_Control["☸️ EKS Control Plane"]
                subgraph ASG ["📦 Auto Scaling Group"]
                    Node1["🖥️ Worker Node 1"]
                    Node2["🖥️ Worker Node 2"]
                    Node3["🖥️ Worker Node 3"]
                end
            end
        end
    end

    subgraph K8s_Deploy ["🚀 Helm Deployment to EKS"]
        Jenkins -->|"6. helm upgrade --install"| EKS_Control
        EKS_Control -->|"7. Deploy Pods"| ASG
        Registry -->|"8. Pull Image"| ASG
        
        subgraph Pods ["📦 App Pods (Replicas: 2)"]
            Pod1["tomcat:9.0-jre8-alpine (Payment Tool)"]
            Pod2["tomcat:9.0-jre8-alpine (Payment Tool)"]
        end
        
        ASG -->|Run| Pod1 & Pod2
        ALB -->|"9. Route: NodePort 31200"| Pod1 & Pod2
    end
```

---

## Repository Structure

* **[server/](file://server/)**: Core Java library containing business logic (Payment Processing, transfers, transaction logs, and unit tests).
* **[webapp/](file://webapp/)**: Java Servlet & JSP Web Application frontend containing user dashboards.
* **[terraform/](file://terraform/)**: Infrastructure as Code configs for provisioning VPC, subnets, route tables, security groups, and 3 EC2 nodes (Jenkins, Tomcat, Docker) in AWS.
* **[terraform/ansible/](file://terraform/ansible/)**: Playbooks for bootstrapping Tomcat, Docker CE, and Jenkins Masters on EC2 instances.
* **[packer/](file://packer/)**: OS hardening and pre-built base images configurations.

---

## Prerequisites & Installation

### 1. Setup SSH Key
The Terraform script expects an SSH public key to associate with the created instances. You can define its location using the `public_key_path` variable:
```sh
terraform apply -var="public_key_path=~/.ssh/id_rsa.pub"
```

### 2. Configure Ansible Vault Password
The Ansible variables in `terraform/ansible/vars/variables.yml` are encrypted using Ansible Vault. To decrypt them during deployment, you need to create a `.vault_pass` file inside the `terraform/ansible/` folder:
1. Copy the example file:
   ```sh
   cp terraform/ansible/.vault_pass.example terraform/ansible/.vault_pass
   ```
2. Open `terraform/ansible/.vault_pass` and replace the placeholder text with your actual Vault password.

---

## CI/CD Pipelines

1. **GitHub Actions (CI)**:
   * Triggers on pull requests and pushes to `master`.
   * Automatically builds and tests the Java application (Java 8).
   * Automatically initializes and validates the Terraform syntax.
2. **Jenkinsfile (CD)**:
   * Declarative pipeline in [Jenkinsfile](file://Jenkinsfile) with parallel deployment stages.
   * Compiles Java application into `.war` package.
   * Performs three deployment strategies: classic deployment to Tomcat server, containerized deployment to Docker host, and Kubernetes deployment to EKS cluster via Helm.
