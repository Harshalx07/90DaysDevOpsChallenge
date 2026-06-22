# Docker Cheat Sheet

## Container Commands

```bash
docker run -it ubuntu bash          # Interactive container
docker run -d nginx                 # Detached container
docker ps                           # Running containers
docker ps -a                        # All containers
docker stop <container>
docker start <container>
docker restart <container>
docker rm <container>
docker exec -it <container> bash
docker logs <container>
```

## Image Commands

```bash
docker images
docker pull nginx
docker build -t myapp:v1 .
docker tag myapp:v1 harshalx07/myapp:v1
docker push harshalx07/myapp:v1
docker rmi <image>
```

## Volume Commands

```bash
docker volume create myvol
docker volume ls
docker volume inspect myvol
docker volume rm myvol
docker run -v myvol:/data nginx
```

## Network Commands

```bash
docker network create mynet
docker network ls
docker network inspect mynet
docker network connect mynet container1
docker run --network=mynet nginx
```

## Docker Compose Commands

```bash
docker compose up -d
docker compose down
docker compose ps
docker compose logs
docker compose build
docker compose restart
```

## Cleanup Commands

```bash
docker system df
docker system prune
docker image prune
docker volume prune
docker network prune
```

## Dockerfile Instructions

```dockerfile
FROM node:18
WORKDIR /app
COPY . .
RUN npm install
EXPOSE 3000
CMD ["npm","start"]
```

### Common Instructions

| Instruction | Purpose                       |
| ----------- | ----------------------------- |
| FROM        | Base image                    |
| RUN         | Execute commands during build |
| COPY        | Copy files                    |
| ADD         | Copy + URL/Tar extraction     |
| WORKDIR     | Set working directory         |
| EXPOSE      | Document port                 |
| ENV         | Environment variables         |
| CMD         | Default command               |
| ENTRYPOINT  | Fixed executable              |
| LABEL       | Metadata                      |
| USER        | Run as specific user          |

### CMD vs ENTRYPOINT

CMD = Default command, easily overridden

ENTRYPOINT = Main executable, harder to override

Example:

```dockerfile
ENTRYPOINT ["nginx"]
CMD ["-g","daemon off;"]
```
