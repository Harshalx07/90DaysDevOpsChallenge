# 🚀 Day 31 – Dockerfile: Build Your Own Images

## 📖 Objective

Learn how to create custom Docker images using Dockerfiles, understand essential Dockerfile instructions, optimize image builds, and deploy a containerized web application.

---

# 🧩 Task 1 – My First Docker Image

## Dockerfile

```dockerfile
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]
```

## Build Image

```bash
docker build -t my-ubuntu:v1 .
```

## Run Container

```bash
docker run my-ubuntu:v1
```

## Output

```text
Hello from my custom image!
```

### ✅ Learning

* Used Ubuntu as a base image
* Installed packages during build
* Defined a default command using CMD

---

# 🧩 Task 2 – Dockerfile Instructions

## Dockerfile

```dockerfile
FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y curl

WORKDIR /app

COPY app.txt .

EXPOSE 8080

CMD ["cat", "app.txt"]
```

## Understanding Dockerfile Instructions

| Instruction | Purpose                           |
| ----------- | --------------------------------- |
| FROM        | Defines base image                |
| RUN         | Executes commands during build    |
| WORKDIR     | Sets working directory            |
| COPY        | Copies files into image           |
| EXPOSE      | Documents application port        |
| CMD         | Defines default container command |

### ✅ Learning

Dockerfiles are built layer-by-layer, and each instruction creates a new image layer.

---

# 🧩 Task 3 – CMD vs ENTRYPOINT

## CMD Example

```dockerfile
FROM ubuntu

CMD ["echo", "hello"]
```

### Run

```bash
docker run cmd-demo:v1
```

Output:

```text
hello
```

### Override CMD

```bash
docker run cmd-demo:v1 ls
```

CMD gets replaced by the new command.

---

## ENTRYPOINT Example

```dockerfile
FROM ubuntu

ENTRYPOINT ["echo"]
```

### Run

```bash
docker run entry-demo:v1 hello
```

Output:

```text
hello
```

### Run with Arguments

```bash
docker run entry-demo:v1 Docker Rocks!
```

Output:

```text
Docker Rocks!
```

---

## CMD vs ENTRYPOINT

| CMD                      | ENTRYPOINT                |
| ------------------------ | ------------------------- |
| Provides default command | Provides fixed executable |
| Easily overridden        | Arguments get appended    |
| Flexible                 | More predictable          |

### When to Use

**CMD**

* Development containers
* Optional startup commands

**ENTRYPOINT**

* Production applications
* Utility containers
* Fixed executable behavior

---

# 🧩 Task 4 – Static Website with Nginx

## index.html

```html
<!DOCTYPE html>
<html>
<head>
    <title>My Docker Website</title>
</head>
<body>
    <h1>Hello from EC2 Docker!</h1>
    <p>Day 31 Dockerfile Assignment</p>
</body>
</html>
```

## Dockerfile

```dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

## Build

```bash
docker build -t my-website:v1 .
```

## Run

```bash
docker run -d -p 8080:80 --name website my-website:v1
```

## Access

```text
http://<EC2-PUBLIC-IP>:8080
```

### ✅ Learning

* Containerized a static website
* Served content using Nginx
* Exposed application to external users

---

# 🧩 Task 5 – Using .dockerignore

## .dockerignore

```text
node_modules
.git
*.md
.env
```

### Benefits

* Smaller build context
* Faster builds
* Reduced image size
* Improved security

### ✅ Learning

Only necessary files should be sent to the Docker daemon during image builds.

---

# 🧩 Task 6 – Build Optimization & Cache

## Initial Dockerfile

```dockerfile
FROM ubuntu

COPY . .

RUN apt-get update

CMD ["echo", "done"]
```

## Optimized Dockerfile

```dockerfile
FROM ubuntu

RUN apt-get update

COPY . .

CMD ["echo", "done"]
```

### Why Layer Order Matters

Docker caches layers during builds.

If an earlier layer changes:

❌ All subsequent layers must be rebuilt.

If stable layers are placed first:

✅ Docker can reuse cached layers.

Benefits:

* Faster builds
* Less bandwidth usage
* Better CI/CD performance

---

# 🎯 Key Takeaways

✅ Created custom Docker images

✅ Learned Dockerfile fundamentals

✅ Understood CMD vs ENTRYPOINT

✅ Containerized a static web application

✅ Used .dockerignore effectively

✅ Optimized Docker builds with caching

---

# 🛠 Tools Used

* Docker
* Ubuntu
* AWS EC2
* Nginx
* Linux Shell

---

# 📌 Conclusion

Day 31 focused on mastering Dockerfiles—the foundation of containerized application delivery. Understanding image creation, build optimization, and container startup behavior is essential for modern DevOps workflows and production deployments.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
