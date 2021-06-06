FROM jenkins/jenkins
USER root
RUN apt update && apt install -y docker.io python3 python3-pip
RUN pip3 install pipenv
USER jenkins