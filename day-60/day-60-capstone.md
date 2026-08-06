# Day 60 – Kubernetes Capstone: Deploy WordPress + MySQL

> **90 Days of DevOps Challenge**  
> **Track:** Kubernetes  
> **Day:** 60  
> **Project:** Deploy a Production-Style WordPress + MySQL Application on Kubernetes

---

# Objective

The final Kubernetes capstone combines everything learned throughout the Kubernetes section of the challenge into one complete deployment.

In this project, I deployed a fully functional **WordPress + MySQL** application using Kubernetes best practices, including:

- Namespace isolation
- Secrets
- ConfigMaps
- StatefulSets
- Deployments
- Headless Services
- NodePort Services
- Persistent Storage
- Resource Requests & Limits
- Liveness & Readiness Probes
- Horizontal Pod Autoscaler (HPA)
- Helm Comparison

---

# Architecture

```text
                           Internet
                               │
                     NodePort Service (30080)
                               │
                 ┌─────────────┴─────────────┐
                 │                           │
        WordPress Pod-1              WordPress Pod-2
                 │                           │
                 └─────────────┬─────────────┘
                               │
                  ConfigMap + Secret Environment
                               │
             mysql-0.mysql.capstone.svc.cluster.local
                               │
                    Headless Service (3306)
                               │
                    MySQL StatefulSet (mysql-0)
                               │
                     Persistent Volume Claim
                               │
                       Persistent Volume
```

---

# Project Structure

```
day-60/
│
├── mysql-secret.yaml
├── mysql-service.yaml
├── mysql-statefulset.yaml
├── wordpress-configmap.yaml
├── wordpress-deployment.yaml
├── wordpress-service.yaml
├── wordpress-hpa.yaml
├── day-60-capstone.md
└── screenshots/
    ├── wordpress-home.png
    ├── kubectl-get-all.png
    └── helm-comparison.png
```

---

# Step 1 – Create Namespace

```bash
kubectl create namespace capstone

kubectl config set-context --current --namespace=capstone
```

Verified namespace creation.

---

# Step 2 – Create MySQL Secret

Created a Kubernetes Secret using **stringData** containing:

- MYSQL_ROOT_PASSWORD
- MYSQL_DATABASE
- MYSQL_USER
- MYSQL_PASSWORD

Applied the Secret successfully.

---

# Step 3 – Create Headless Service

Created a Headless Service with:

- ClusterIP: None
- Port: 3306

Purpose:

- Stable DNS
- Required for StatefulSets

---

# Step 4 – Deploy MySQL StatefulSet

Created a StatefulSet using:

Image:

```
mysql:8.0
```

Features:

- 1 Replica
- Resource Requests
- Resource Limits
- Secret Environment Variables
- Persistent Storage
- VolumeClaimTemplate (1Gi)

Storage Mount:

```
/var/lib/mysql
```

Verified:

```bash
kubectl get pods
```

Result:

```
mysql-0 Running
```

---

# Step 5 – Verify Database

Connected inside MySQL:

```bash
kubectl exec -it mysql-0 -- mysql -u wpuser -pwp123
```

Executed:

```sql
SHOW DATABASES;
```

Output included:

- wordpress
- information_schema
- performance_schema

Database verified successfully.

---

# Step 6 – Create WordPress ConfigMap

Created ConfigMap containing:

```
WORDPRESS_DB_HOST
WORDPRESS_DB_NAME
```

Host:

```
mysql-0.mysql.capstone.svc.cluster.local:3306
```

---

# Step 7 – Deploy WordPress

Deployment Configuration:

Image

```
wordpress:latest
```

Replicas

```
2
```

Environment

- ConfigMap
- Secret

Resource Requests

CPU

```
250m
```

Memory

```
256Mi
```

Resource Limits

CPU

```
500m
```

Memory

```
512Mi
```

Health Checks

- Readiness Probe
- Liveness Probe

Endpoint

```
/wp-login.php
```

Verified:

```bash
kubectl get pods
```

Result:

```
2/2 WordPress Pods Running
```

---

# Step 8 – Expose WordPress

Created NodePort Service

Type

```
NodePort
```

NodePort

```
30080
```

Access Methods

Minikube

```bash
minikube service wordpress -n capstone
```

Kind

```bash
kubectl port-forward svc/wordpress 8080:80 -n capstone
```

Successfully opened WordPress setup page.

Completed installation.

Created a sample blog post.

---

# Step 9 – Test Self-Healing

Deleted one WordPress Pod

```bash
kubectl delete pod wordpress-xxxxx
```

Result

Deployment automatically recreated the Pod.

Website remained accessible.

---

Deleted MySQL Pod

```bash
kubectl delete pod mysql-0
```

Result

StatefulSet recreated mysql-0 automatically.

---

# Step 10 – Verify Persistence

After MySQL restarted:

- Opened WordPress
- Previously created blog post still existed

This confirms:

- Persistent Volume works
- StatefulSet maintains storage correctly

---

# Step 11 – Configure Horizontal Pod Autoscaler

Created HPA

Minimum Replicas

```
2
```

Maximum Replicas

```
10
```

Target CPU

```
50%
```

Verified

```bash
kubectl get hpa
```

Autoscaler configured successfully.

---

# Step 12 – Helm Comparison

Installed Bitnami WordPress Chart

```bash
helm install wp-helm bitnami/wordpress -n helm-demo
```

Compared resources with manual deployment.

Observation:

| Manual Deployment | Helm Deployment |
|-------------------|-----------------|
| Full Control | Automated |
| More YAML Files | Single Command |
| Better Learning | Faster Deployment |
| Easy Customization | Easy Upgrades |

Removed Helm deployment after comparison.

---

# Kubernetes Concepts Used

| Concept | Day |
|----------|-----|
| Namespace | Day 52 |
| Deployment | Day 52 |
| Service | Day 53 |
| ConfigMap | Day 54 |
| Secret | Day 54 |
| Persistent Volume Claim | Day 55 |
| StatefulSet | Day 56 |
| Resource Requests | Day 57 |
| Resource Limits | Day 57 |
| Liveness Probe | Day 57 |
| Readiness Probe | Day 57 |
| Horizontal Pod Autoscaler | Day 58 |
| Helm | Day 59 |

---

# Verification Results

| Test | Status |
|------|--------|
| Namespace Created | ✅ |
| Secret Created | ✅ |
| ConfigMap Created | ✅ |
| Headless Service Working | ✅ |
| MySQL StatefulSet Running | ✅ |
| WordPress Deployment Running | ✅ |
| NodePort Accessible | ✅ |
| WordPress Installation Completed | ✅ |
| Blog Post Created | ✅ |
| WordPress Self-Healing Verified | ✅ |
| MySQL Self-Healing Verified | ✅ |
| Persistent Storage Verified | ✅ |
| HPA Created | ✅ |
| Helm Comparison Completed | ✅ |

---

# Production Improvements

If deploying this application in production, I would also implement:

- Ingress Controller
- TLS Certificates
- External Load Balancer
- Network Policies
- Pod Disruption Budgets
- Horizontal & Vertical Autoscaling
- Prometheus Monitoring
- Grafana Dashboards
- Centralized Logging (EFK/Loki)
- Backup & Restore Strategy
- GitOps with Argo CD
- CI/CD Pipeline
- External Secret Management
- High Availability MySQL

---

# Key Learnings

During this capstone, I combined multiple Kubernetes concepts into a single real-world deployment.

### What clicked

- StatefulSets for stateful workloads
- Deployments for stateless applications
- ConfigMaps and Secrets for configuration management
- Kubernetes DNS between services
- Persistent Volumes for data retention
- Self-healing through Deployments and StatefulSets
- Resource management using Requests and Limits
- Autoscaling with HPA
- Helm as a package manager for Kubernetes

### Biggest Challenge

The most challenging part was connecting WordPress to MySQL correctly using the StatefulSet DNS name while ensuring persistent storage and health probes worked together.

---

# Final Outcome

Successfully deployed a complete WordPress + MySQL application on Kubernetes using **12+ core Kubernetes concepts**.

This capstone demonstrates the ability to deploy, manage, scale, recover, and maintain a real-world application using Kubernetes best practices.

---

## Screenshots

### WordPress Running

```
screenshots/wordpress-home.png
```

### Kubernetes Resources

```
screenshots/kubectl-get-all.png
```

### Helm Deployment Comparison

```
screenshots/helm-comparison.png
```

---
