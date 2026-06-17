# Day 32 – Docker Volumes & Networking

## Objective

Today's goal was to understand two important Docker concepts:

* Data Persistence using Volumes
* Container Communication using Networks

---

# Task 1: The Problem (Without Volumes)

## Run PostgreSQL Container

```bash
docker run -d \
--name postgres-no-volume \
-e POSTGRES_PASSWORD=admin123 \
-p 5432:5432 \
postgres
```

## Create Sample Data

```sql
CREATE TABLE students(
id SERIAL PRIMARY KEY,
name VARCHAR(50)
);

INSERT INTO students(name)
VALUES('Harshal');

SELECT * FROM students;
```

### Output

```text
 id |  name
----+---------
 1  | Harshal
```

### Screenshot

![Task 1 Data Created](screenshots/task1-data-created.png)

---

## Remove Container

```bash
docker stop postgres-no-volume
docker rm postgres-no-volume
```

## Create New Container

```bash
docker run -d \
--name postgres-new \
-e POSTGRES_PASSWORD=admin123 \
-p 5432:5432 \
postgres
```

## Verify Data

```sql
SELECT * FROM students;
```

### Output

```text
ERROR: relation "students" does not exist
```

### Observation

The data was lost because containers are ephemeral. When the container was removed, its writable layer was deleted along with all database data.

### Screenshot

![Task 1 Data Lost](screenshots/task1-data-lost.png)

---

# Task 2: Named Volumes

## Create Volume

```bash
docker volume create postgres-data
```

## Verify Volume

```bash
docker volume ls
```

### Screenshot

![Volume Created](screenshots/volume-created.png)

---

## Run PostgreSQL with Volume

```bash
docker run -d \
--name postgres-volume \
-e POSTGRES_PASSWORD=admin123 \
-v postgres-data:/var/lib/postgresql/data \
-p 5432:5432 \
postgres
```

## Create Data

```sql
CREATE TABLE employees(
id SERIAL PRIMARY KEY,
name VARCHAR(50)
);

INSERT INTO employees(name)
VALUES('Harshal');

SELECT * FROM employees;
```

---

## Remove Container

```bash
docker stop postgres-volume
docker rm postgres-volume
```

## Recreate Container with Same Volume

```bash
docker run -d \
--name postgres-volume-new \
-e POSTGRES_PASSWORD=admin123 \
-v postgres-data:/var/lib/postgresql/data \
-p 5432:5432 \
postgres
```

## Verify Data

```sql
SELECT * FROM employees;
```

### Output

```text
 id |  name
----+---------
 1  | Harshal
```

### Observation

The data remained available because it was stored in a Docker volume rather than inside the container filesystem.

### Screenshot

![Volume Data Persisted](screenshots/volume-data-persisted.png)

---

## Inspect Volume

```bash
docker volume ls
docker volume inspect postgres-data
```

---

# Task 3: Bind Mounts

## Create Website Folder

```bash
mkdir website
cd website
```

Create file:

```html
<h1>Hello from Docker Bind Mount</h1>
```

## Run Nginx Container

```bash
docker run -d \
--name nginx-bind \
-p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
nginx
```

Access:

```text
http://<EC2-PUBLIC-IP>:8080
```

### Screenshot

![Bind Mount Before](screenshots/bind-mount-before.png)

---

## Update File

```html
<h1>Updated from Host Machine</h1>
```

Refresh browser.

### Screenshot

![Bind Mount After](screenshots/bind-mount-after.png)

---

## Named Volume vs Bind Mount

| Named Volume                  | Bind Mount              |
| ----------------------------- | ----------------------- |
| Managed by Docker             | Managed by Host OS      |
| Stored in Docker storage area | Stored directly on host |
| Best for databases            | Best for source code    |
| Portable                      | Depends on host path    |
| More secure                   | Direct host access      |

---

# Task 4: Docker Networking Basics

## List Networks

```bash
docker network ls
```

### Screenshot

![Docker Networks](screenshots/docker-networks.png)

---

## Inspect Default Bridge

```bash
docker network inspect bridge
```

### Screenshot

![Bridge Network](screenshots/bridge-network.png)

---

## Run Containers

```bash
docker run -dit --name ubuntu1 ubuntu
docker run -dit --name ubuntu2 ubuntu
```

## Test Connectivity

### By Name

```bash
ping ubuntu2
```

Result:

```text
ping: ubuntu2: Name or service not known
```

### By IP Address

```bash
ping <container-ip>
```

Result:

```text
PING successful
```

### Observation

Containers on the default bridge network cannot resolve each other by container name.

---

# Task 5: Custom Networks

## Create Network

```bash
docker network create my-app-net
```

## Run Containers

```bash
docker run -dit --name app1 --network my-app-net ubuntu
docker run -dit --name app2 --network my-app-net ubuntu
```

## Verify Connectivity

```bash
ping app2
```

### Result

```text
PING app2 successful
```

### Screenshot

![Custom Network](screenshots/custom-network.png)

---

## Why Does It Work?

Custom bridge networks provide built-in DNS resolution.

Containers can communicate using container names without needing IP addresses.

The default bridge network does not provide automatic DNS-based service discovery.

---

# Task 6: Putting Everything Together

## Create Network

```bash
docker network create project-net
```

## Create Volume

```bash
docker volume create project-db-data
```

## Run Database Container

```bash
docker run -d \
--name project-postgres \
--network project-net \
-v project-db-data:/var/lib/postgresql/data \
-e POSTGRES_PASSWORD=admin123 \
postgres
```

## Run Application Container

```bash
docker run -dit \
--name project-app \
--network project-net \
ubuntu
```

## Install PostgreSQL Client

```bash
apt update
apt install postgresql-client -y
```

## Connect Using Container Name

```bash
psql -h project-postgres -U postgres
```

### Result

Successfully connected to PostgreSQL using the container name.

### Screenshot

![Final Project](screenshots/final-project.png)

---

# Key Learnings

* Containers are ephemeral and lose data when removed.
* Docker Volumes provide persistent storage.
* Bind Mounts synchronize host files directly into containers.
* Default bridge networking supports IP communication but not automatic name resolution.
* Custom bridge networks provide DNS-based container discovery.
* Volumes and custom networks are essential building blocks for real-world containerized applications.

---

# Conclusion

Today I learned how Docker handles persistent storage and container communication. The biggest takeaway was understanding that deleting a container also deletes its data unless a volume is used. I also learned how custom Docker networks make multi-container applications easier by allowing containers to communicate using names instead of IP addresses.
