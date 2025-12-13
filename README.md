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
  ```
	🏗️ The pipeline automates:
		🧩 **Code Checkout** from GitHub  
		🔧 **Build** with Maven   
		🐳 **Docker Image Build & Push** to DockerHub  
		🚀 **Local Deployment** of the containerized application 
  ```
- **Containerization**: Docker  
- **Registry**: DockerHub  
- **Deployment**: Local Docker environment  
- **Monitoring**: Prometheus & Grafana



## 🛠️ Tech Stack

| **GitHub** | Source code repository |

| **AWS EC2** | Hosting app |

| **JDK 17** | Java runtime and compiler |
```
Install Java
sudo apt update
sudo apt install openjdk-17-jre
Verify Java is Installed
java -version
```
| **Jenkins** | Automate CI/CD pipeline |
```
Now, you can proceed with installing Jenkins

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

to check Jenkins is installed or not - systemctl status Jenkins

After you login to Jenkins, - Run the command to copy the Jenkins Admin Password - sudo cat /var/lib/jenkins/secrets/initialAdminPassword - 	Enter the Administrator password
```
| **Maven** | Build and package Java application |
```
# Step 1: Download the Maven Binaries
wget https://dlcdn.apache.org/maven/maven-3/3.9.11/binaries/apache-maven-3.9.11-bin.tar.gz
tar -xvf apache-maven-3.9.11-bin.tar.gz
sudo mv apache-maven-3.9.11 /opt/

# Step 2: Setting M2_HOME and Path Variables
Add the following lines to the user profile file (.profile).
M2_HOME='/opt/apache-maven-3.9.11'
PATH="$M2_HOME/bin:$PATH"
export PATH
Relaunch the terminal or execute source .profile to apply the changes.

# Step 3: Verify the Maven installation
Execute mvn -version command and it should produce the following output.
```
| **Docker** | Containerize and deploy the app | | **DockerHub** | Host Docker images |
```
Installation of Docker in Ubuntu:
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

To Install the latest Version:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker jenkins

sudo systemctl restart docker
sudo systemctl restart jenkins

to check images – sudo docker images
```
| **Prometheus & Grafana** | Monitoring |

YouTube: https://www.youtube.com/watch?v=Q_tmu5Wte9E

Git Repo: https://github.com/networknuts/docker-monitoring

| **Cronjob** | Log Backup |

```
created backup.sh

#!/bin/bash
BACKUP_DIR="/backups/logs"
DATE=$(date +%Y-%m-%d_%H-%M)
mkdir -p $BACKUP_DIR
tar -czf "$BACKUP_DIR/logs_$DATE.tar.gz" /var/log/syslog /var/log/auth.log /your-app-logs/ 2>/dev/null || echo "Warning: Some files inaccessible"
chown $USER:$USER "$BACKUP_DIR/logs_$DATE.tar.gz"
echo "Backup completed: $BACKUP_DIR/logs_$DATE.tar.gz" | mail -s "Log Backup" your-email@example.com
find $BACKUP_DIR -name "logs_*.tar.gz" -mtime +7 -delete

cronjob
* * * * * /home/uduntu/bachkup.sh

	ubuntu@13.202.88.219:~$/home/ubuntu/cron.log
	Backup created at Fri Dec 12 08.23.01 UTC 2025
	Backup created at Fri Dec 12 08.23.02 UTC 2025
	Backup created at Fri Dec 12 08.23.03 UTC 2025
	Backup created at Fri Dec 12 08.23.04 UTC 2025
	Backup created at Fri Dec 12 08.23.05 UTC 2025
	Backup created at Fri Dec 12 08.23.06 UTC 2025
	Backup created at Fri Dec 12 08.23.07 UTC 2025
```

# 📦 Setup to run locally
```
git clone https://github.com/nisha-subramaniyan/DevOps-Capstone-Project.git
cd DevOps-Capstone-Project

docker build -t capstone_project
docker run -d -p 8081:8080 capstone_project
Open: http://localhost:8081
```

## 🏁 Conclusion

End-to-End DevOps Pipeline: Project Summary

This capstone project established a fully automated Continuous Delivery (CD) Pipeline for a containerized Node.js application. The workflow begins with a Git push to GitHub, which triggers Jenkins (via a Jenkinsfile). Jenkins uses Maven to build and package the code, then creates and pushes the Docker image to Docker Hub. The pipeline subsequently deploys the application to an AWS EC2 host. Finally, the infrastructure is monitored using Prometheus and Grafana, while CloudWatch provides centralized logging, ensuring a robust, maintainable, and observable production-grade stack. Cron and Bash scripts handle automated system maintenance.
