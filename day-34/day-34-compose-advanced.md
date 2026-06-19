# Docker Compose Troubleshooting

## Issue Encountered

While running the application stack with Docker Compose, the following error occurred:

```bash
failed to solve: failed to read dockerfile:
open Dockerfile: no such file or directory
```

## Root Cause

The `docker-compose.yml` file was configured with:

```yaml
web:
  build: ./app
```

Docker Compose expected a Dockerfile at:

```text
day-34/app/Dockerfile
```

However, the Dockerfile was mistakenly created in the project root directory:

```text
day-34/
├── Dockerfile
├── app.py
├── requirements.txt
└── docker-compose.yml
```

As a result, Docker could not locate the Dockerfile during the build process.

## Solution

Created the application directory and moved all application-related files into it:

```bash
mkdir -p app

mv app.py app/
mv requirements.txt app/
mv Dockerfile app/
```

Updated project structure:

```text
day-34/
├── docker-compose.yml
└── app/
    ├── app.py
    ├── requirements.txt
    └── Dockerfile
```

## Verification

Rebuilt and started the stack:

```bash
docker compose up -d --build
```

Docker Compose successfully:

1. Built the Flask application image.
2. Started PostgreSQL and Redis containers.
3. Created the custom network.
4. Attached named volumes.
5. Brought up the complete 3-service stack.

## Key Learning

When using:

```yaml
build: ./app
```

Docker expects the Dockerfile to exist inside the specified build context directory. The Dockerfile location must match the build path defined in `docker-compose.yml`.
