FROM jenkins/jenkins:2.414.2-jdk11

USER root

# Update package list and install required packages
RUN apt-get update && apt-get install -y lsb-release python3-pip

# Add Docker's official GPG key
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# Set up the Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Update package list again and install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to the Jenkins user
USER jenkins

# Install Jenkins plugins
RUN sudo jenkins-plugin-cli --plugins "blueocean:1.27.16 docker-workflow:603.va_6964865a_9b_9"

