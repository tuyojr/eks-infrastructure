#!/bin/bash

# first update the package manager and add the repo
sudo apt update
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg

# append the Debian package repository address to the server’s sources.list
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# update the package manager again
sudo apt update

# install jenkins and its dependencies
sudo apt install jenkins

# start jenkins
sudo systemctl start jenkins.service