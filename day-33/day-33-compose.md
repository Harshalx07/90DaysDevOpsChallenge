# Day 33 – Docker Compose: Multi-Container Basics

## Overview

Today I learned how to use Docker Compose to define and run multi-container applications using a single YAML file. Instead of manually creating containers, networks, and volumes, Docker Compose allows infrastructure to be described as code and managed with simple commands.

---

## Task 1: Install & Verify Docker Compose

### Verify Docker

```bash
docker --version
```

**Output**

```bash
Docker version 29.1.3
```

### Verify Docker Compose

```bash
docker-compose --version
```

**Output**

```bash
docker-compose version 1.29.2
```

---

## Task 2: First Docker Compose Project

### Create Project Directory

```bash
mkdir compose-basics
cd compose-basics
```

### Create docker-compose.yml

```yaml
version: '3'

services:
  nginx:
    image: nginx:latest
    container_name: nginx-compose
    ports:
      - "80:80"
```

### Start Service

```bash
docker-compose up -d
```

### Verify Running Container

```bash
docker ps
```

### Access Application

```text
http://<EC2-PUBLIC-IP>
```

Expected output:

```text
Welcome to nginx!
```

### Stop Service

```bash
docker-compose down
```

---

## Task 3: WordPress + MySQL Setup

### Create Project Directory

```bash
mkdir wordpress-compose
cd wordpress-compose
```

### Create docker-compose.yml

```yaml
version: '3'

services:

  db:
    image: mysql:8.0
    container_name: mysql-db
    restart: always

    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wpuser
      MYSQL_PASSWORD: wp123

    volumes:
      - mysql_data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: wordpress-app
    restart: always

    ports:
      - "80:80"

    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wpuser
      WORDPRESS_DB_PASSWORD: wp123
      WORDPRESS_DB_NAME: wordpress

    depends_on:
      - db

volumes:
  mysql_data:
```

### Start Application

```bash
docker-compose up -d
```

### Verify Containers

```bash
docker ps
```

### View Logs

```bash
docker-compose logs -f
```

### Access WordPress

```text
http://<EC2-PUBLIC-IP>
```

Complete the WordPress installation wizard.

---

## Data Persistence Verification

Stop services:

```bash
docker-compose down
```

Start again:

```bash
docker-compose up -d
```

Verify that WordPress configuration and content still exist.

Check volumes:

```bash
docker volume ls
```

The MySQL data remains because it is stored in a named volume.

---

## Task 4: Docker Compose Commands

### Start Services in Detached Mode

```bash
docker-compose up -d
```

### View Running Services

```bash
docker-compose ps
```

### View All Logs

```bash
docker-compose logs -f
```

### View Specific Service Logs

```bash
docker-compose logs -f wordpress
```

```bash
docker-compose logs -f db
```

### Stop Services

```bash
docker-compose stop
```

### Remove Containers & Networks

```bash
docker-compose down
```

### Remove Containers, Networks & Volumes

```bash
docker-compose down -v
```

### Rebuild Services

```bash
docker-compose up --build
```

---

## Task 5: Environment Variables

### Create .env File

```env
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=wp123
```

### Update docker-compose.yml

```yaml
version: '3'

services:
  db:
    image: mysql:8.0

    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}

    volumes:
      - mysql_data:/var/lib/mysql

volumes:
  mysql_data:
```

### Verify Variables

```bash
docker-compose config
```

Docker Compose automatically loads variables from the `.env` file.

---

## Key Learnings

* Docker Compose simplifies container orchestration.
* Multiple containers can be managed using a single YAML file.
* Service names act as DNS names for container communication.
* Named volumes provide persistent storage.
* Compose automatically creates a dedicated network.
* Environment variables help separate configuration from code.

---

## Screenshots Collected

* compose-version.png
* nginx-running.png
* nginx-browser.png
* wordpress-running.png
* wordpress-setup.png
* compose-ps.png
* compose-logs.png
* volume-persistence.png
* env-variables.png

---

## Conclusion

Successfully deployed:

* Nginx using Docker Compose
* WordPress + MySQL multi-container application
* Persistent storage using Docker Volumes
* Environment variable management with `.env`

Docker Compose makes multi-container deployments reproducible, scalable, and significantly easier to manage compared to running containers individually.
