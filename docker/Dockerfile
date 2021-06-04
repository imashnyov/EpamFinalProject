FROM jenkins/jenkins

USER root

RUN apt-get update 
RUN apt install docker.io -y
RUN docker --version
ENTRYPOINT nohup dockerd >/dev/null 2>&1 & sleep 10 && node /app/app.js

RUN apt update && apt install -y python3 python3-pip && pip3 install pipenv

USER jenkins