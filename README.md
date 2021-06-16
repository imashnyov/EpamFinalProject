# Mashnov Illia
EPAM Final Project
<center>
<p><a href="Final_poject_Mashnov.pptx" target="_blank"><img width="200" height="200" src='pptx.png'></a></p>
</center>

# Part 1 - IaS:
 ### Add amazon user credentials to environment variables
 ```
 export AWS_ACCESS_KEY_ID=anaccesskey
 export AWS_SECRET_ACCESS_KEY=asecretkey
 ```
 ### Deploy two servers
  latest AMI Linux for JENKINS_SERVER and latest Ubuntu for PROJECT_SERVERS, with necessary secure groupsб add .pem ssh-key, configure hosts.txt file containing ip addresses for Ansible.
 ```
 cd terraform

 terraform apply
 ```
 Run playbook "playbook_start_project.yml" containing the following roles:
 1. Install docker to JENKINS_SERVER, download and run docker image with Jenkins (+valume) and display Jenkins admin password in console.
 2. Install docker to PROJECT_SERVERS.
 ```
 cd ../ansible

 ansible-playbook playbook_start_project.yml
 ```
 Copy admin password for Jenkins and go to web browser

 -------------------

 ### Jenkins container to autostart on Amazon Linux
 Go to JENKINS_SERVER and to do so create file /etc/systemd/system/my_script.service with following contents:

 ```
[Unit]
Description=My script that requires network
After=network.target

[Service]
Type=oneshot
ExecStart=/etc/jenkins.sh

[Install]
WantedBy=multi-user.target
 ```
 To do so create bash script:
 ```
 #!/bin/bash
 sleep 5
 sudo docker start jenkins-master
 ```
 Then execute:
 ```
sudo systemctl daemon-reload
sudo systemctl enable my_script
```
```
docker exec -it --user root jenkins-master /bin/bash
chmod 777 /var/run/docker.sock
```


