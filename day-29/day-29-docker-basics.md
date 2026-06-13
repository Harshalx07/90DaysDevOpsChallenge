# Day 29 – Introduction to Docker

## Objective

Today's goal was to understand Docker fundamentals and run my first containers.

I learned why containers exist, how they differ from Virtual Machines, explored Docker architecture, and ran multiple containers using Docker commands.

---

## Task 1: What is Docker?

### What is a Container?

A container is a lightweight package that includes an application along with all its dependencies, libraries, and configurations needed to run.

Containers ensure that applications behave the same way across different environments.

### Why Do We Need Containers?

Without containers, applications may work on one machine but fail on another because of different software versions or configurations.

Containers solve the "it works on my machine" problem by packaging everything required to run the application.

### Containers vs Virtual Machines

| Feature        | Containers           | Virtual Machines       |
| -------------- | -------------------- | ---------------------- |
| OS             | Share host OS kernel | Each VM has its own OS |
| Startup Time   | Seconds              | Minutes                |
| Resource Usage | Lightweight          | Heavy                  |
| Performance    | Near-native          | Additional overhead    |
| Isolation      | Process-level        | Hardware-level         |

### Docker Architecture

Docker consists of the following components:

#### Docker Client

The interface where users execute Docker commands.

Examples:

```bash
docker run
docker build
docker ps
```

#### Docker Daemon

The background service that manages images, containers, networks, and volumes.

#### Docker Images

Read-only templates used to create containers.

Example:

```bash
nginx
ubuntu
hello-world
```

#### Docker Containers

Running instances of Docker images.

#### Docker Registry

A storage location for Docker images.

Example:

Docker Hub

### Docker Architecture Diagram

```text
+-------------------+
|   Docker Client   |
+-------------------+
          |
          v
+-------------------+
|   Docker Daemon   |
+-------------------+
      |       |
      v       v
 Docker    Containers
 Images
      |
      v
 Docker Hub Registry
```

---

## Task 2: Install Docker

### Verify Installation

```bash
docker --version
```

### Run Hello World Container

```bash
docker run hello-world
```

### What Happened?

Docker checked if the image existed locally.

Since it wasn't available, Docker downloaded it from Docker Hub.

The image was then used to create and run a container which displayed a success message.

---

## Task 3: Run Real Containers

### Run Nginx Container

```bash
docker run -d --name nginx-demo -p 80:80 nginx
```

Accessed in browser:

```text
http://localhost
```

### Run Ubuntu Container

```bash
docker run -it ubuntu bash
```

Explored the container as a mini Linux machine.

### List Running Containers

```bash
docker ps
```

### List All Containers

```bash
docker ps -a
```

### Stop a Container

```bash
docker stop nginx-demo
```

### Remove a Container

```bash
docker rm nginx-demo
```

---

## Task 4: Explore Docker Features

### Detached Mode

```bash
docker run -d nginx
```

Detached mode runs the container in the background.

### Custom Container Name

```bash
docker run --name my-nginx nginx
```

### Port Mapping

```bash
docker run -d -p 8080:80 nginx
```

Host Port:

```text
8080
```

Container Port:

```text
80
```

### View Logs

```bash
docker logs nginx-demo
```

### Execute Commands Inside Running Container

```bash
docker exec -it nginx-demo bash
```

---

## Key Docker Commands Learned

```bash
docker run
docker ps
docker ps -a
docker stop
docker rm
docker images
docker logs
docker exec
```

---

## Why Docker Matters for DevOps

Docker is one of the most important tools in modern DevOps.

It provides consistency across development and production environments, simplifies deployments, and serves as the foundation for Kubernetes, CI/CD pipelines, and microservices architectures.

Understanding Docker is the first step toward mastering containerization and cloud-native deployments.

---

## What I Learned Today

✅ What containers are and why they exist

✅ Difference between Containers and Virtual Machines

✅ Docker architecture and components

✅ Running containers from Docker Hub

✅ Managing containers using Docker commands

✅ Port mapping and detached mode

✅ Viewing logs and executing commands inside containers

✅ Importance of Docker in modern DevOps workflows

#90DaysOfDevOps

Day 29 Complete 🚀
