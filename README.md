<h1 align="center"> Leveraging Azure OpenAI to Automatically Troubleshoot and Solve CI/CD Problems </h1>

---


## 📖 Overview

This repository showcases the implementation of **"Leveraging Azure OpenAI to Automatically Troubleshoot and Solve CI/CD Problems"**, a custom project by **Kaan Turgut**.

## Architecture Diagram

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/architecture-diagram.png" />


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

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/azure%20resources.png" />

### Note: I provisioned AI resources in "East US" eventhough I'm in Canada as AI Assitant is not supported in Canada regions yet...

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
 
<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/azure%20ai%20foundary%20interface.png" />

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
  
<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/ado%20tf%20pipeline.png" />

---

## 🧑‍💻 AI Assistant Script

A Python script that leverages Azure OpenAI to analyze CI/CD pipeline errors and suggest solutions. OPENAI APIKEY and ENDPOINTS which are stored in key vault are being used to interact with the AI services.
### **Filepath**: [`./ai-assistant.py`](./ai-assistant.py)

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/ai%20services%20api%20key%20and%20endpoint.png" />

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/ai%20assistant.png" />


---

## 🛠️ Failing Build Pipeline

### **Filepath**: [`pipelines/build-pipeline.yml`](pipelines/build-pipeline.yml)

Simulates pipeline failures and triggers debugging:
1. **BuildAndAnalyze Stage**:
   - Runs tasks while tolerating failures for debugging.
2. **TriggerAiDebugPipeline Stage**:
   - Initiates AI debugging if failures occur.
  
<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/failed%20pipeline%20with%20error.png" />


---

## 🤖 AI Debug Pipeline

### **Filepath**: [`pipelines/ai-debug-pipeline.yml`](pipelines/ai-debug-pipeline.yml)

Designed to debug failures using AI tools:
- Gets triggered by failed pipeline

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/triggereted%20ai%20debug%20pipeline.png" />

- Uses credentials as secrets variable from key vault secrets through azure devops variable groups

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/kv%20secrets.png" />

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/ado%20variable%20group.png" />

- Retrieves and analyzes logs.

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/retrieve%20failed%20build%20logs%20via%20API.png" />

- Uses Azure AI Assistant to analyze the error and responses back with the error explanation, error cause and suggested solutions which I put in a json object.

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/show%20output.png" />

- Sends results to a Logic App to send out the communications into a Microsoft Teams Chat.

<img width="955" alt="Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems" src="https://github.com/hkaanturgut/Leveraging-Azure-Open-AI-to-Automatically-Troubleshoot-and-Solve-CI-CD-Problems/blob/ai-demo/images/ai%20teams%20chat%20message.png" />


---

## Documentation References

For more information, please refer to the following documentations:

- [What is Azure AI Foundry?](https://learn.microsoft.com/en-us/azure/ai-studio/what-is-ai-studio)
- [Getting started with Azure OpenAI Assistants (Preview)](https://developer.hashicorp.com/terraform/language/stacks](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/assistant))
- [Use Terraform to create an Azure AI Foundry hub](https://www.hashicorp.com/blog/terraform-stacks-explained](https://learn.microsoft.com/en-us/azure/ai-studio/how-to/create-hub-terraform?tabs=azure-cli))

## Upcoming Presentation and Demo Video

A presentation and demo video will be coming soon...

For more content, visit my YouTube channel: [Kaan in the Cloud](https://www.youtube.com/@KaanintheCloud)
