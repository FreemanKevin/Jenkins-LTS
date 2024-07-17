# Use Jenkins base image with JDK 17
FROM jenkins/jenkins:2.452.2-lts-jdk17

# Switch to root user to install packages
USER root

# Install Node.js and npm
# Using NodeSource's official setup script to install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@10.7.0 && \
    # Clean apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Maven by downloading the binary archive
RUN curl -fsSL http://apache.osuosl.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz | tar xz -C /opt && \
    ln -s /opt/apache-maven-3.6.3 /opt/maven

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common && \
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    # Set up the stable repository
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    # Clean apt cache and temporary files to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the jenkins user
USER jenkins

# Set Maven and Java environment variables
ENV MAVEN_HOME=/opt/maven
ENV PATH=$MAVEN_HOME/bin:$PATH