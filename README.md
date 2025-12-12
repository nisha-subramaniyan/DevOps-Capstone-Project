# 🚀 DevOps Capstone Project

This repository demonstrates a complete **Continuous Integration and Continuous Deployment (CI/CD)** workflow using **Github**, **Jenkins** **Docker** and **Prometheus & Grafana** for a simple Java application.

## 🧱 Project Overview

This project shows how DevOps tools integrate together to automate a typical development workflow.

- **Source Code Management**: GitHub
	🧩 Git_Code Structure

		```
		java-jenkins-demo/
		├── src/
		│   └── main/
		│       └── java/
		│           └── com/
		│               └── example/
		|                    └── demoapp/
		|                        └── DemoaAppApplication,java/
		├── pom.xml
		├── Dockerfile
                └── Jenkinsfile
                ```

- **Continuous Integration**: Jenkins 
	🏗️ The pipeline automates:
		🧩 **Code Checkout** from GitHub  
		🔧 **Build** with Maven   
		🐳 **Docker Image Build & Push** to DockerHub  
		🚀 **Local Deployment** of the containerized application 
  
- **Containerization**: Docker  
- **Registry**: DockerHub  
- **Deployment**: Local Docker environment  
- **Monitoring**: Prometheus & Grafana
