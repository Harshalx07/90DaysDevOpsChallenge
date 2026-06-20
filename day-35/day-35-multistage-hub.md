# Day 35 - Multi-Stage Builds & Docker Hub

## Overview

Today's goal was to learn how to optimize Docker images using Multi-Stage Builds and distribute them through Docker Hub.

Multi-stage builds help reduce image size, improve security, and speed up deployments by separating the build environment from the runtime environment.

---

## Task 1: Single-Stage Build

### Application

A simple Node.js application was created to demonstrate the difference between a traditional Docker build and a multi-stage build.

### Dockerfile (Single Stage)

```dockerfile
FROM node:22

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 3000

CMD ["node", "app.js"]
```

### Build Command

```bash
docker build -f Dockerfile.single -t node-single .
```

### Image Size

| Image       | Size   |
| ----------- | ------ |
| node-single | XXX MB |

---

## Task 2: Multi-Stage Build

### Dockerfile (Multi-Stage)

```dockerfile
# Build Stage
FROM node:22 AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Production Stage
FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app .

EXPOSE 3000

CMD ["node", "app.js"]
```

### Build Command

```bash
docker build -f Dockerfile.multistage -t node-multistage .
```

### Image Size

| Image           | Size   |
| --------------- | ------ |
| node-multistage | 411 MB |

---

## Size Comparison

| Build Type   | Size   |
| ------------ | ------ |
| Single Stage | 411 MB |
| Multi-Stage  | 58.1 MB |

### Result

Image size was reduced by approximately **XX%** after implementing a Multi-Stage Build.

### Why Multi-Stage Builds Are Smaller

* Build tools are not included in the final image.
* Unnecessary dependencies are removed.
* Runtime image contains only the required application files.
* Smaller attack surface improves security.
* Faster image pull and deployment times.

---

## Task 3: Push Image to Docker Hub

### Login

```bash
docker login
```

### Tag Image

```bash
docker tag node-multistage harshalx07/node-multistage:v1
```

### Push Image

```bash
docker push harshalx07/node-multistage:v1
```

### Verify

```bash
docker pull harshalx07/node-multistage:v1
```

---

## Docker Hub Repository

### Repository Link

```text
https://hub.docker.com/r/harshalx07/node-multistage
```

### Tag Used

```text
v1
```

### Observations

* Images can be versioned using tags.
* The `latest` tag points to the most recent default image.
* Specific tags allow deployment of exact versions.
* Version tags help maintain consistency across environments.

Example:

```bash
docker pull harshalx07/node-multistage:v1
docker pull harshalx07/node-multistage:latest
```

---

## Task 4: Docker Hub Exploration

### Activities Completed

* Created Docker Hub repository.
* Added repository description.
* Explored image tags.
* Understood image versioning.
* Verified successful push and pull operations.

---

## Task 5: Image Best Practices

### Optimized Dockerfile

```dockerfile
FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --omit=dev

COPY . .

RUN adduser -D appuser

USER appuser

EXPOSE 3000

CMD ["node", "app.js"]
```

### Best Practices Applied

* Used Alpine base image.
* Avoided running containers as root.
* Used specific image tags.
* Reduced image layers.
* Installed only required dependencies.
* Improved security posture.

---

## Commands Used

### Build Images

```bash
docker build -f Dockerfile.single -t node-single .

docker build -f Dockerfile.multistage -t node-multistage .
```

### Check Image Size

```bash
docker images
```

### Run Container

```bash
docker run -d -p 3000:3000 node-multistage
```

### Docker Hub

```bash
docker login

docker tag node-multistage harshalx07/node-multistage:v1

docker push harshalx07/node-multistage:v1

docker pull harshalx07/node-multistage:v1
```

---

## Key Learnings

* Multi-stage builds create smaller and more efficient Docker images.
* Smaller images reduce deployment time and storage requirements.
* Docker Hub simplifies image distribution and sharing.
* Image tags help maintain version control.
* Running containers as a non-root user improves security.
* Alpine images significantly reduce image size compared to standard distributions.

---

## Outcome

Successfully built a Node.js application using both single-stage and multi-stage Docker builds, compared image sizes, applied container security best practices, and pushed the optimized image to Docker Hub.

### Skills Practiced

* Docker
* Multi-Stage Builds
* Docker Hub
* Container Optimization
* Container Security
* Image Versioning
* DevOps Best Practices

---

**Docker Hub Repository:** https://hub.docker.com/r/harshalx07/node-multistage
