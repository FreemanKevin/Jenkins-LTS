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

# Install a specific version of Maven
RUN apt-get update && \
    apt-get install -y maven=3.6.3 && \
    # Clean apt cache to reduce image size
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

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

# Set environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Override the Jenkins JAVA_HOME setting to ensure it uses the correct Java version
ENV JENKINS_JAVA_HOME $JAVA_HOME