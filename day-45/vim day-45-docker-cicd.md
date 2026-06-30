# Day 45 – Docker Build & Push in GitHub Actions

## Objective

Build a complete CI/CD pipeline using GitHub Actions that automatically builds and publishes a Docker image to Docker Hub whenever code is pushed to the `main` branch.

---

# Prerequisites

* GitHub repository
* Dockerfile
* Docker Hub account
* GitHub Actions enabled
* GitHub Secrets configured:

  * `DOCKER_USERNAME`
  * `DOCKER_TOKEN`

---

# Workflow File

**Path**

```text
.github/workflows/docker-publish.yml
```

```yaml
name: Docker Build & Push

on:
  push:
    branches:
      - main
      - feature/**

jobs:
  docker:
    runs-on: ubuntu-latest

    permissions:
      contents: read

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set Short SHA
        run: echo "SHORT_SHA=${GITHUB_SHA::7}" >> $GITHUB_ENV

      - name: Login to Docker Hub
        if: github.ref == 'refs/heads/main'
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}

      - name: Build Docker Image
        uses: docker/build-push-action@v5
        with:
          context: .
          push: false
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/github-actions-practice:latest

      - name: Build and Push Docker Image
        if: github.ref == 'refs/heads/main'
        uses: docker/build-push-action@v5
        with:
          context: .
          push: true
          tags: |
            ${{ secrets.DOCKER_USERNAME }}/github-actions-practice:latest
            ${{ secrets.DOCKER_USERNAME }}/github-actions-practice:sha-${{ env.SHORT_SHA }}
```

---

# What This Workflow Does

* Triggers automatically on every push.
* Builds the Docker image for all branches.
* Logs in to Docker Hub only when the branch is `main`.
* Pushes two image tags:

  * `latest`
  * `sha-<short-commit-hash>`
* Prevents feature branches from publishing images.

---

# Docker Hub Repository

```text
https://hub.docker.com/r/<dockerhub-username>/github-actions-practice
```

**Example Tags**

* `latest`
* `sha-abcdef1`

---

# Pipeline Execution

1. Push code to GitHub.
2. GitHub Actions workflow starts.
3. Repository is checked out.
4. Docker image is built.
5. Login to Docker Hub (main branch only).
6. Image is tagged.
7. Image is pushed to Docker Hub.
8. Image is available for deployment anywhere.

---

# Pull and Run the Image

Pull the image:

```bash
docker pull <dockerhub-username>/github-actions-practice:latest
```

Run the container:

```bash
docker run -d -p 8080:80 <dockerhub-username>/github-actions-practice:latest
```

Open:

```text
http://localhost:8080
```

---

# Full Journey: Git Push to Running Container

```text
Developer
    │
    ▼
git push
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions Trigger
    │
    ▼
Ubuntu Runner
    │
    ▼
Checkout Source Code
    │
    ▼
Build Docker Image
    │
    ▼
Login to Docker Hub
    │
    ▼
Push Image
(latest + SHA tag)
    │
    ▼
Docker Hub
    │
    ▼
docker pull
    │
    ▼
docker run
    │
    ▼
Running Container
```

---

# Workflow Status Badge

Add the following badge to your `README.md`:

```markdown
![Docker Build & Push](https://github.com/<github-username>/<repository>/actions/workflows/docker-publish.yml/badge.svg)
```

---

# Screenshot

> **Insert a screenshot of the successful GitHub Actions workflow run here.**

---

# Learning Outcomes

* Built a production-style CI/CD pipeline.
* Used GitHub Secrets securely.
* Logged in to Docker Hub from GitHub Actions.
* Built Docker images automatically.
* Published versioned Docker images.
* Used conditional workflow execution.
* Tagged images using commit hashes.
* Verified images by pulling and running them locally.
* Added a workflow status badge to the repository.

---

# Repository Structure

```text
github-actions-practice/
│
├── Dockerfile
├── README.md
├── index.html
│
└── .github
    └── workflows
        └── docker-publish.yml
```

---

# Conclusion

This project demonstrated how to automate the complete Docker image lifecycle using GitHub Actions. Every push to the `main` branch now builds, tags, and publishes a Docker image to Docker Hub without any manual intervention, providing a solid foundation for modern CI/CD pipelines and containerized application deployments.
