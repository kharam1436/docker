# Getting the arguement before the build
ARG TAG

FROM jenkins/jenkins:${TAG}

# Run as a root
USER root

# Installing Docker
RUN apt-get update
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update \
    && apt-get install docker-ce docker-ce-cli containerd.io -y

# make jenkins to run docker
RUN usermod -aG docker jenkins

# change user back to jenkins
USER jenkins