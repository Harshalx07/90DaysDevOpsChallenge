# Day 37 – Docker Revision

## Self Assessment

| Topic                  | Status |
| ---------------------- | ------ |
| Run containers         | Can Do |
| List containers/images | Can Do |
| Image layers & cache   | Can Do |
| Dockerfile creation    | Can Do |
| CMD vs ENTRYPOINT      | Can Do |
| Build & tag image      | Can Do |
| Named volumes          | Can Do |
| Bind mounts            | Shaky  |
| Custom networks        | Can Do |
| Docker Compose         | Can Do |
| Environment variables  | Shaky  |
| Multi-stage builds     | Can Do |
| Docker Hub push        | Can Do |
| Healthchecks           | Can Do |

---

## Quick Fire Answers

### 1. Difference between Image and Container

Image is a blueprint.

Container is a running instance of an image.

### 2. What happens to container data after removal?

Data is lost unless stored in a volume or bind mount.

### 3. How do containers communicate on the same network?

Using container names as hostnames.

Example:

```bash
ping db
```

### 4. docker compose down vs docker compose down -v

```bash
docker compose down
```

Removes containers and network.

```bash
docker compose down -v
```

Removes containers, network, and volumes.

### 5. Why use multi-stage builds?

Smaller images, better security, faster deployments.

### 6. COPY vs ADD

COPY only copies files.

ADD can copy files, URLs and extract archives.

### 7. What does -p 8080:80 mean?

```bash
Host Port : Container Port
```

Traffic on port 8080 is forwarded to port 80.

### 8. How to check Docker disk usage?

```bash
docker system df
```

---

## Weak Areas Revisited

### 1. Bind Mounts

```bash
mkdir test
echo "Hello" > test/index.html

docker run -d \
-p 8080:80 \
-v $(pwd)/test:/usr/share/nginx/html \
nginx
```

### 2. Environment Variables

.env

```env
APP_NAME=devops-app
PORT=3000
```

docker-compose.yml

```yaml
services:
  app:
    image: nginx
    env_file:
      - .env
```

---

## What I Learned

* Docker volumes persist data.
* Networks allow service discovery.
* Compose simplifies multi-container deployments.
* Multi-stage builds reduce image size.
* Healthchecks improve reliability.
* Docker Hub enables image distribution.
