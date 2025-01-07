<h1 align="center">🌟 Leveraging Azure OpenAI to Automatically Troubleshoot and Solve CI/CD Problems 🌟</h1>

---


## 📖 Overview

This repository showcases the implementation of **"Leveraging Azure OpenAI to Automatically Troubleshoot and Solve CI/CD Problems"**, a custom project by **Kaan Turgut**.

## Architecture Diagram

## Architecture Diagram

![Architecture Diagram](https://raw.githubusercontent.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/ai-demo/images/architecture-diagram.png)



### 🎯 Project Goal
To develop an **automated troubleshooting system** using **Azure AI Foundry** tools to analyze and resolve CI/CD pipeline errors without manual intervention. This project integrates cutting-edge AI solutions with robust DevOps practices to streamline debugging processes.

### 🛠️ Tools and Technologies
- **Terraform**: For infrastructure provisioning and management.
- **Azure DevOps YAML Pipelines**: To deploy infrastructure, simulate pipeline failures, and integrate AI-driven automation.
- **Bash Scripting**: To interact with build logs and automate pipeline operations.
- **Azure AI Foundry**: Leveraging AI-powered assistant tools for debugging.
- **Python**: Facilitates AI integration and enhances automation workflows.

---

## 🚀 Provisioned Resources

### 1️⃣ **Resource Group**
- Logical container for managing all provisioned Azure resources.
- Simplifies organization and access management.

### 2️⃣ **Storage Account**
- Provides scalable cloud storage for AI data and models.
- **Use Cases**:
  - Store datasets, model outputs, and logs.
  - Integrate with Azure Machine Learning and AI Hub.

### 3️⃣ **Key Vault**
- Secure storage for secrets, keys, and certificates.
- **Use Cases**:
  - Store API keys for AI services.
  - Secure sensitive configuration data.

### 4️⃣ **Azure AI Services**
- Suite of pre-trained and customizable AI models.
- **Key Services**:
  - **Azure Cognitive Services**: Vision, language, and speech APIs.
  - **Azure OpenAI Service**: Advanced NLP models.
  - **Azure Machine Learning**: Tools for building and deploying ML models.
- **Use Cases**:
  - Enable image analysis and object detection.
  - Add natural language understanding to applications.
  - Perform predictive analytics with custom ML models.

### 5️⃣ **Azure AI Hub**
- Centralized management for all AI resources.
- **Features**:
  - Integrates with Azure Machine Learning and Cognitive Services.
  - Tools for deploying AI solutions at scale.

### 6️⃣ **Azure AI Project**
- Dedicated project structure within AI Hub.
- **Use Cases**:
  - Manage specific AI use cases or applications.
  - Collaborate with data scientists and engineers.

### 7️⃣ **Role Assignments**
- Fine-grained access control for resources.
- **Includes**:
  - Assigning roles to users, groups, and service principals.
  - Ensuring least-privilege access.

### 8️⃣ **AI Services Connection**
- Configures secure communication between resources.
- **Use Cases**:
  - Seamless integration with AI services.
  - Manage authentication and data exchange securely.

---

## 📁 Repository Structure

| **File Name**         | **Description**                                                                 |
|------------------------|---------------------------------------------------------------------------------|
| [`main.tf`](main.tf)   | Main infrastructure resources: resource groups, AI services, and role assignments. |
| [`variables.tf`](variables.tf) | Configurable parameters like resource names and locations.                       |
| [`providers.tf`](providers.tf) | Azure provider and configuration settings.                                    |
| [`outputs.tf`](outputs.tf)     | Deployment outputs such as resource IDs and connection strings.              |

---

## 📜 Azure DevOps Terraform Pipeline

### **Filepath**: [`pipelines/terraform-pipeline.yml`](pipelines/terraform-pipeline.yml)

Automates Terraform deployment with the following stages:
1. **TerraformInit**:
   - Initializes, formats, and validates configurations.
2. **TerraformPlan**:
   - Generates an execution plan for changes.
3. **ManualApproval**:
   - Requires manual review before proceeding.
4. **TerraformApply**:
   - Applies the plan to deploy infrastructure.

---

## 🧑‍💻 AI Assistant Script

A Python script that leverages Azure OpenAI to analyze CI/CD pipeline errors and suggest solutions.

### **Filepath**: [`./ai-assistant.py`](./ai-assistant.py)

---

## 🛠️ Failing Build Pipeline

### **Filepath**: [`pipelines/build-pipeline.yml`](pipelines/build-pipeline.yml)

Simulates pipeline failures and triggers debugging:
1. **BuildAndAnalyze Stage**:
   - Runs tasks while tolerating failures for debugging.
2. **TriggerAiDebugPipeline Stage**:
   - Initiates AI debugging if failures occur.

---

## 🤖 AI Debug Pipeline

### **Filepath**: [`pipelines/ai-debug-pipeline.yml`](pipelines/ai-debug-pipeline.yml)

Designed to debug failures using AI tools:
- Retrieves and analyzes logs.
- Uses OpenAI to suggest solutions.
- Sends results to a Logic App for processing.

---

## 🎉 Why This Project Stands Out
- **Cutting-Edge AI Integration**: Uses Azure OpenAI for real-time debugging.
- **Streamlined Automation**: Combines DevOps best practices with AI insights.
- **Scalable Design**: Modular and reusable Terraform configurations.

---

### 💡 How to Get Started
1. Clone the repository:
   ```bash
   git clone https://github.com/your-repo/azure-openai-cicd-debug.git
