# CCGC 5502 Final Project: Terraform + Ansible Automation

##  Project Overview

This project demonstrates a fully automated Infrastructure as Code (IaC) solution using **Terraform** and **Ansible** on **Microsoft Azure**. It provisions and configures a load-balanced environment of Linux VMs running Apache web servers — all with zero manual intervention.

---

##  Technologies Used

- **Terraform** (Azure Provider)
- **Ansible**
- **Azure CLI**
- **Ubuntu 20.04 LTS**
- **Apache2 Web Server**

---

## 🌐 Infrastructure Diagram

```
Internet
   |
Azure Load Balancer (Public IP)
   |
-----------------------------
|            |             |
VM1         VM2           VM3
(Private IPs with Apache + Data Disks)
```

---

##  Features Implemented

### 🔹 Terraform

- [x] Modular design using root and child modules
- [x] Parameterized resource group, network, load balancer, and VM configurations
- [x] 3 Linux VMs (B1s size) with data disks
- [x] Static public IPs for VM2 and VM3
- [x] Azure backend for storing `terraform.tfstate`
- [x] Ansible provisioning via `null_resource`

### 🔹 Ansible

- [x] **`user-9207`** Role:
  - Creates users: `user100`, `user200`, `user300`
  - Adds users to `cloudadmins` and `sudo` groups
  - Generates SSH keys with no passphrase
- [x] **`profile-9207`** Role:
  - Appends `export TMOUT=1500` to `/etc/profile`
- [x] **`datadisk-9207`** Role:
  - Partitions 10GB disk into 4GB (XFS) and 5GB (EXT4)
  - Mounts them to `/part1` and `/part2`
- [x] **`webserver-9207`** Role:
  - Installs and configures Apache
  - Deploys a unique `index.html` to each node (`vm1.html`, `vm2.html`, etc.)
  - Verifies functionality via Load Balancer

---

##  Load Balancer FQDN Testing

- Entered the LB public IP in the browser
- Refreshed every 7 seconds
- Apache pages dynamically rotated between VMs confirming round-robin balancing

---

## 📁 Project Structure

```bash
automation/
├── terraform/
│   ├── root/ (main.tf, outputs.tf, providers.tf, backend.tf)
│   └── modules/
│       ├── rgroup/
│       ├── network/
│       ├── loadbalancer-n01699207/
│       ├── vmlinux-n01699207/
│       └── storage-n01699207/
├── ansible/
│   ├── inventory.ini
│   ├── 9207-playbook.yml
│   └── roles/
│       ├── user-9207/
│       ├── profile-9207/
│       ├── datadisk-9207/
│       └── webserver-9207/
```

---

##  Validation

-  48 Terraform `state` resources confirmed
-  SSH login to VM using `user100` and private key
-  Load Balancer verified
-  Apache and HTML content working on all 3 VMs
-  No password or interactive prompts in provisioning

---

##  Repository

[https://github.com/Smitmahida/terraform-ansible-automation-final-project](https://github.com/Smitmahida/terraform-ansible-automation-final-project)

---

## 👤 Author

**Name:** Smit Mahida  
**Humber ID:** N01699207  
**Project:** CCGC 5502 – Final Automation Project  
**Instructor:** Prof. Asghar Ghori  

---

##  Cleanup Reminder

After grading is complete, destroy the infrastructure:
```bash
terraform destroy --auto-approve
```
