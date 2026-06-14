# Day 30 – Docker Images & Container Lifecycle

## Overview

Today I explored one of Docker's most important concepts: Docker Images and the complete Container Lifecycle.

Before today, running containers felt like executing commands. After this session, I understand how Docker builds images, stores layers, creates containers, manages states, and optimizes storage using caching.

---

# Task 1: Docker Images

## What is a Docker Image?

A Docker Image is a lightweight, read-only blueprint that contains everything required to run an application:

* Application code
* Runtime
* Libraries
* Dependencies
* Environment configuration

Images are immutable, meaning they cannot be modified after creation.

A running instance of an image is called a Container.

### Image → Container Relationship

```text
Docker Image
      ↓
docker run
      ↓
Docker Container
```

Think of it like:

* Image = Class
* Container = Object

or

* Image = Blueprint
* Container = Building

---

## Pulling Images

Downloaded the following official images from Docker Hub:

```bash
docker pull nginx
docker pull ubuntu
docker pull alpine
```

---

## Listing Images

```bash
docker images
```

Observed image sizes:

| Image  | Purpose                    | Approx Size |
| ------ | -------------------------- | ----------- |
| nginx  | Web Server                 | ~190 MB     |
| ubuntu | Full Linux Distribution    | ~80 MB      |
| alpine | Minimal Linux Distribution | ~8 MB       |

---

## Why Alpine is Smaller

Alpine Linux is specifically designed for containers.

Reasons:

* Uses BusyBox instead of GNU utilities
* Uses musl libc instead of glibc
* Includes only essential packages
* Smaller attack surface
* Faster downloads and deployments

### Benefits

* Reduced storage consumption
* Faster image transfers
* Better security posture
* Improved CI/CD performance

---

## Inspecting an Image

```bash
docker inspect nginx
```

Information discovered:

* Image ID
* Creation timestamp
* Architecture
* Environment variables
* Entrypoint
* Exposed ports
* Operating system

---

## Removing Images

```bash
docker rmi ubuntu
```

Images can only be removed if no containers depend on them.

---

# Task 2: Docker Image Layers

## Viewing Layer History

```bash
docker image history nginx
```

Example output:

```text
IMAGE         CREATED BY          SIZE
xxxxxx        CMD ["nginx"]       0B
xxxxxx        EXPOSE 80           0B
xxxxxx        COPY ...            2KB
xxxxxx        RUN apt-get ...     45MB
```

---

## What are Docker Layers?

Every instruction inside a Dockerfile creates a new layer.

Example:

```dockerfile
FROM ubuntu
RUN apt update
RUN apt install nginx
COPY . /app
```

Generated Layers:

```text
Layer 1 → Ubuntu Base
Layer 2 → apt update
Layer 3 → nginx Installation
Layer 4 → Application Files
```

---

## Why Docker Uses Layers

### Storage Efficiency

Shared layers are reused across images.

### Faster Builds

Docker rebuilds only changed layers.

### Faster Downloads

Only missing layers are downloaded.

### Better Caching

Previously built layers are reused automatically.

---

## Real-World Example

Suppose an image contains:

```text
Ubuntu
Python
Dependencies
Application Code
```

If only application code changes:

```text
Ubuntu       → Cached
Python       → Cached
Dependencies → Cached
Application  → Rebuilt
```

Result:

Significantly faster image builds.

---

# Task 3: Container Lifecycle

A container moves through several states during its lifecycle.

---

## Create Container

```bash
docker create --name lifecycle-test nginx
```

State:

```text
Created
```

The container exists but is not running.

---

## Start Container

```bash
docker start lifecycle-test
```

State:

```text
Running
```

The application is now executing.

---

## Pause Container

```bash
docker pause lifecycle-test
```

State:

```text
Paused
```

Processes are frozen using Linux cgroups.

---

## Unpause Container

```bash
docker unpause lifecycle-test
```

State:

```text
Running
```

Execution resumes.

---

## Stop Container

```bash
docker stop lifecycle-test
```

State:

```text
Exited
```

Docker performs a graceful shutdown.

---

## Restart Container

```bash
docker restart lifecycle-test
```

State:

```text
Running
```

Container stops and starts again.

---

## Kill Container

```bash
docker kill lifecycle-test
```

State:

```text
Exited
```

Immediate termination using SIGKILL.

---

## Remove Container

```bash
docker rm lifecycle-test
```

State:

```text
Removed
```

Container metadata and writable layer are deleted.

---

## Lifecycle Flow

```text
Created
   │
   ▼
Running
 │   │
 │   ▼
 │ Paused
 │   │
 ▼   ▼
Exited
   │
   ▼
Removed
```

---

# Task 4: Working with Running Containers

## Running Nginx in Detached Mode

```bash
docker run -d --name my-nginx -p 8080:80 nginx
```

Options used:

* -d → Detached Mode
* --name → Assign Container Name
* -p → Port Mapping

---

## Viewing Logs

```bash
docker logs my-nginx
```

Displays application output.

---

## Real-Time Logs

```bash
docker logs -f my-nginx
```

Streams logs continuously.

---

## Entering a Running Container

```bash
docker exec -it my-nginx bash
```

Inside the container I explored:

```bash
pwd
ls
cd /usr/share/nginx/html
cat index.html
```

---

## Executing Single Commands

```bash
docker exec my-nginx ls /
```

Useful for automation and troubleshooting.

---

## Inspecting a Container

```bash
docker inspect my-nginx
```

Discovered:

* Container ID
* Network Information
* IP Address
* Port Mappings
* Mount Points
* Environment Variables

---

## Getting Container IP

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-nginx
```

---

## Checking Port Mappings

```bash
docker port my-nginx
```

---

# Task 5: Cleanup Operations

## Stop All Running Containers

```bash
docker stop $(docker ps -q)
```

---

## Remove Stopped Containers

```bash
docker container prune
```

---

## Remove Unused Images

```bash
docker image prune -a
```

---

## Check Docker Disk Usage

```bash
docker system df
```

Provides visibility into:

* Images
* Containers
* Volumes
* Build Cache

---

## Complete System Cleanup

```bash
docker system prune -a
```

Removes:

* Unused Images
* Stopped Containers
* Unused Networks
* Build Cache

---

# Advanced Exploration

## Resource Monitoring

```bash
docker stats
```

Live CPU and memory usage.

---

## Running Processes

```bash
docker top my-nginx
```

Lists active processes.

---

## Docker Events

```bash
docker events
```

Streams Docker activity in real time.

---

## Docker System Information

```bash
docker info
```

Displays:

* Storage Driver
* Docker Version
* CPU Count
* Memory
* Runtime Information

---

# Key Learnings

1. Images are immutable templates.
2. Containers are running instances of images.
3. Docker layers improve performance and storage efficiency.
4. Containers move through multiple lifecycle states.
5. Docker caching significantly speeds up builds.
6. Inspect commands provide deep visibility into container internals.
7. Cleanup commands are essential for maintaining disk space.
8. Alpine Linux is preferred when minimal image size is important.
9. Docker logs and exec commands are critical for troubleshooting.
10. Understanding lifecycle states is fundamental for real-world DevOps operations.

---

# Reflection

The most interesting concept today was Docker Image Layers.

Initially, I assumed Docker images were stored as a single file. Learning that Docker builds images as reusable layers explained why container deployments are so fast and why modern CI/CD pipelines rely heavily on caching.

Understanding the difference between an Image and a Container also clarified how Docker efficiently creates isolated environments while sharing common resources.

Today transformed Docker from a simple command-line tool into a technology whose internal architecture I can now confidently explain.
