# Jenkins-LTS :whale:

This repository contains a Dockerfile for a customized Jenkins image based on the official Jenkins LTS release with JDK 17. This image is enhanced with additional development tools to facilitate CI/CD workflows.

## Modifications :hammer_and_wrench:

- **Node.js and npm** :globe_with_meridians: : Installed using NodeSource's official setup script for the latest version of Node.js, along with a specific npm version.
- **Maven** :coffee: : Maven is downloaded and installed directly from the official Apache source.
- **Docker CLI** :anchor: : Docker's official GPG key and repository are added, followed by the installation of the Docker CLI.

## Docker Image Location :package:

The built image is available on Docker Hub:  
[![DockerHub](https://img.shields.io/docker/v/codeckevin/jenkins-lts?color=blue&label=jenkins-lts&logo=docker)](https://hub.docker.com/r/codeckevin/jenkins-lts)

## Usage :rocket:

The repository includes a `docker-compose.yaml` file. To start the service, run:

```bash
docker-compose up -d
```

## License :scroll:

This project is licensed under the <u>[Apache License 2.0](LICENSE)</u>.