#!/bin/bash

# this docmentation is for setting up the jenkins server
# https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/#downloading-and-installing-jenkins

# Ensure that your software packages are up to date on your 
# instance by using the following command to perform a quick software update:
sudo yum update

# Add the Jenkins repo using the following command:
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import a key file from Jenkins-CI to enable installation from the package
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum upgrade

# Install Java:
sudo amazon-linux-extras install java-openjdk11 -y

# Install Jenkins:
sudo yum install jenkins -y

# Enable the Jenkins service to start at boot:
sudo systemctl enable jenkins

# Start Jenkins as a service:
sudo systemctl start jenkins

# You can check the status of the Jenkins service using the command:
sudo systemctl status jenkins

# install git
sudo yum install git -y

# install yum-config-manager to manage your repositories
sudo yum install -y yum-utils

# Use yum-config-manager to add the official HashiCorp Linux repository.
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform from the new repository.
sudo yum -y install terraform

# install kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl

# Apply execute permissions to the binary.
chmod +x ./kubectl

# Copy the binary to a folder in your PATH. If you 
# have already installed a version of kubectl, then 
# we recommend creating a $HOME/bin/kubectl and 
# ensuring that $HOME/bin comes first in your $PATH.
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin

# (Optional) Add the $HOME/bin path to your shell 
# initialization file so that it is configured when 
# you open a shell.
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc

# Install helm
sudo curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
sudo ./get_helm.sh