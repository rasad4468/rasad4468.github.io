# rasad4468.github.io
Continuously Learning Is My Passion

# Server Virtualization Technologies

## Overview

This repository contains scripts, configurations, and guides for setting up and administering server virtualization technologies such as Nutanix AHV, Microsoft Hyper-V, and VMware. 

## Table of Contents

1. [Introduction](#introduction)
2. [Nutanix AHV](#nutanix-ahv)
   - [Setup Guide](#setup-guide)
   - [Deployment Script](#deployment-script)
3. [Microsoft Hyper-V](#microsoft-hyper-v)
   - [Setup Guide](#setup-guide)
   - [Deployment Script](#deployment-script)
4. [VMware vSphere](#vmware-vsphere)
   - [Setup Guide](#setup-guide)
   - [Deployment Script](#deployment-script)
5. [GitHub Pages](#github-pages)
6. [MIT License](#mit-license)

## Introduction

This project provides comprehensive guides and scripts for setting up and managing Nutanix AHV, Microsoft Hyper-V, and VMware environments. Each section includes step-by-step instructions and deployment scripts to help you get started.

## Nutanix AHV

### Setup Guide

1. **Install Nutanix Cluster:** Use the Nutanix Foundation tool to set up the Nutanix cluster on your hardware.
2. **Configure Networking:** Set up the virtual networks, VLANs, and IP addressing using Prism.
3. **Initialize Prism:** Log in to Prism and complete the initial setup wizard.
4. **Storage Configuration:** Set up storage containers and policies in Prism.

### Deployment Script

Here’s a Python script using Nutanix’s REST API to automate some tasks:

```python
import requests
import json

# Define the Prism Central credentials and IP
prism_central_ip = 'your_prism_central_ip'
username = 'your_username'
password = 'your_password'

# Define the API endpoint
url = f'https://{prism_central_ip}:9440/api/nutanix/v3/clusters/list'

# Set up the request headers
headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
}

# Send a request to list clusters
response = requests.post(url, headers=headers, auth=(username, password), verify=False)

if response.status_code == 200:
    clusters = response.json()
    print(json.dumps(clusters, indent=4))
else:
    print(f"Error: {response.status_code}")

