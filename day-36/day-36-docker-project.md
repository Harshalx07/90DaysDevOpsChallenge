# Day 36 - Dockerize a Full Application

## Project Overview

For Day 36 of the #90DaysOfDevOps challenge, I built and containerized a full-stack Notes Manager application using Node.js, Express, MongoDB, Docker, and Docker Compose.

The application allows users to create, view, and delete notes through a simple web interface. MongoDB is used for data persistence, while Docker Compose orchestrates both the application and database containers.

---

## Why I Chose This Project

I wanted to build a project that demonstrates real-world Docker concepts rather than a simple Hello World application.

This project includes:

* Frontend and Backend integration
* Database connectivity
* Persistent storage
* Environment variables
* Docker Compose orchestration
* Health checks
* Multi-stage Docker build
* Non-root user execution

---

## Project Architecture

```text
User
  │
  ▼
Node.js Express App
  │
  ▼
MongoDB Database
```

---

## Project Structure

```text
day-36/
├── app.js
├── package.json
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env
├── README.md
└── public/
    └── index.html
```

---

## Dockerfile Explanation

### Build Stage

* Uses Node.js Alpine image
* Installs application dependencies
* Copies source code

### Production Stage

* Uses a lightweight Alpine image
* Copies artifacts from build stage
* Creates a non-root user
* Exposes port 3000
* Starts the application

Benefits:

* Smaller image size
* Better security
* Faster deployments

---

## Docker Compose Features

### Application Service

* Builds image from Dockerfile
* Loads environment variables
* Connects to custom network
* Waits for MongoDB health check

### MongoDB Service

* Uses official MongoDB image
* Stores data in persistent volume
* Includes health check configuration

### Custom Network

Allows containers to communicate securely using service names.

### Persistent Volume

Ensures notes remain available even after containers restart.

---

## Challenges Faced

### Challenge 1: Dockerfile Not Found

Issue:

```text
failed to read dockerfile: open Dockerfile: no such file or directory
```

Solution:

The build command was executed from the wrong directory. Navigated to the project directory and rebuilt successfully.

---

### Challenge 2: MongoDB Dependency

Issue:

The application started before MongoDB was ready.

Solution:

Implemented Docker Compose health checks and service dependency conditions.

---

## Commands Used

### Build Image

```bash
docker build -t devops-notes-app .
```

### Start Services

```bash
docker compose up -d --build
```

### Check Running Containers

```bash
docker ps
```

### View Logs

```bash
docker compose logs
```

### Stop Services

```bash
docker compose down
```

---

## Verification

Successfully verified:

* Docker image build
* Multi-container deployment
* MongoDB connectivity
* Persistent storage
* Application accessibility
* Docker Compose orchestration

---

## Final Image Information

Image Name:

```text
day-36-app
```

Docker Hub Repository:

```text
https://hub.docker.com/r/harshalx07/devops-notes-app
```

---

## Outcome

Successfully containerized a full-stack Notes Manager application using Docker and Docker Compose.

Key concepts practiced:

* Docker Images
* Dockerfile
* Multi-Stage Builds
* Docker Compose
* Volumes
* Networks
* Environment Variables
* Health Checks
* Container Orchestration

---
git
