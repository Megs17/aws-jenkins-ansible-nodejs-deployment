
# Jenkins + Ansible + Node.js AWS CI/CD Project

## Project Overview

This project sets up a complete CI/CD workflow using Jenkins and Ansible on AWS. It deploys a Node.js application that connects to RDS and Redis instances. The deployment takes place on a private EC2 instance which is not directly accessible from the internet. Instead, a bastion host is used for SSH tunneling.

## Key Features

- **Secure Infrastructure**: Uses a bastion host to SSH into private EC2 instances.
- **Infrastructure Automation**: Ansible is used to configure the EC2 instance as a Jenkins slave.
- **CI/CD with Jenkins**: Jenkins is set up to deploy code from a GitHub branch (`rds_redis`) to the private EC2 server.
- **Application Load Balancer**: AWS ALB is configured to expose the Node.js app on port 80 to external traffic.
- **Database Integration**: The Node.js app connects and verifies communication with RDS and Redis instances.
- **Testing & Validation**: The application is tested via browser and curl commands to ensure the `/db` and `/redis` endpoints respond successfully.

## Workflow Summary

1. SSH configuration is set up to route Ansible commands through the bastion host.
2. Ansible playbook is run to prepare the EC2 instance with necessary dependencies and configurations.
3. Jenkins connects to the EC2 instance as a slave using SSH tunneling.
4. Jenkins pulls the Node.js application from GitHub and deploys it on the EC2 instance.
5. An Application Load Balancer forwards HTTP requests to the private EC2 instance.
6. Successful responses from `/db` and `/redis` confirm working integration with RDS and Redis.

## Testing

- The `/db` and `/redis` endpoints are verified using curl and browser access through the ALB DNS.
- Application logs and system info are used to confirm successful deployments and connections.

## Technologies Used

- Jenkins
- Ansible
- AWS EC2 (Bastion + Private)
- AWS ALB (Application Load Balancer)
- Node.js
- Redis & RDS
- SSH Tunneling

