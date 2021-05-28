# Mashnov Illia
EPAM Final Project

# Part 1 - IaS:
 Add amazon user credentials to environment variables
 ```
 export AWS_ACCESS_KEY_ID=anaccesskey
 export AWS_SECRET_ACCESS_KEY=asecretkey
 ```
 Deploy two servers, latest AMI Linux for Jenkins and latest Ubuntu for project, with necessary secure groups and add .pem ssh-key, configure hosts.txt file containing ip addresses for Ansible.
 ```
 cd terraform

 terraform apply
 ```
 Run playbook containing the following roles:
 1. Install docker, download docker image with Jenkins and display Jenkins admin password in console.
 ```
 cd ../ansible

 ansible-playbook playbook_start_project.yml
 ```
 Copy admin password for Jenkins and go to web browser
 
 -------------------

 Import necessary job on Jenkins.


