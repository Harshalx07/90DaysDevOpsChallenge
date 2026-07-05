# Day 50 – Kubernetes Architecture and Cluster Setup

## Objective

Today I started my Kubernetes journey by understanding why Kubernetes was created, learning its architecture, setting up a local Kubernetes cluster using **kind**, and exploring the core components of the cluster using `kubectl`.

---

# Task 1 – Kubernetes Story

## Why was Kubernetes created?

Docker makes it easy to package and run containers, but managing hundreds or thousands of containers across multiple servers becomes difficult. Kubernetes was created to automate container deployment, scaling, networking, load balancing, and self-healing. It ensures applications remain available and running even when failures occur.

## Who created Kubernetes?

Kubernetes was originally created by **Google** in **2014** and later donated to the **Cloud Native Computing Foundation (CNCF)**.

It was inspired by Google's internal container orchestration system called **Borg**.

## What does Kubernetes mean?

The word **Kubernetes** comes from Greek and means **"Helmsman"** or **"Pilot"**, representing someone who steers a ship, just as Kubernetes manages and steers containerized applications.

---

# Task 2 – Kubernetes Architecture

## Architecture Diagram

```text
                           kubectl
                               │
                               ▼
                     +------------------+
                     |   API Server     |
                     +------------------+
                       │      │      │
        ┌──────────────┘      │      └──────────────┐
        ▼                     ▼                     ▼
+----------------+   +-------------------+   +---------------+
|  Scheduler     |   | Controller Manager|   |     etcd      |
+----------------+   +-------------------+   +---------------+
        │
        ▼
---------------------------------------------------------------
                    Worker Nodes
---------------------------------------------------------------

+-------------------------------------------------------------+
| kubelet                                                     |
| kube-proxy                                                  |
| Container Runtime (containerd / CRI-O)                      |
| Pods                                                        |
+-------------------------------------------------------------+

+-------------------------------------------------------------+
| kubelet                                                     |
| kube-proxy                                                  |
| Container Runtime                                           |
| Pods                                                        |
+-------------------------------------------------------------+
```

---

## Control Plane Components

### API Server

- Entry point of the Kubernetes cluster
- Accepts all kubectl commands
- Validates requests
- Stores cluster state in etcd

---

### etcd

- Distributed key-value database
- Stores the complete cluster state
- Source of truth for Kubernetes

---

### Scheduler

- Watches for newly created Pods
- Selects the best Worker Node
- Considers CPU, Memory, Taints and Affinity rules

---

### Controller Manager

Runs controllers that constantly compare the desired state with the current state.

Examples:

- Deployment Controller
- ReplicaSet Controller
- Node Controller
- Job Controller

---

## Worker Node Components

### kubelet

- Agent running on every Worker Node
- Communicates with the API Server
- Starts and monitors Pods

---

### kube-proxy

- Handles networking
- Creates iptables/IPVS rules
- Enables communication between Pods and Services

---

### Container Runtime

Responsible for running containers.

Examples:

- containerd
- CRI-O

---

# What happens when you run?

```bash
kubectl apply -f pod.yaml
```

Execution Flow

```
kubectl
      │
      ▼
API Server
      │
      ▼
Validate YAML
      │
      ▼
Store desired state in etcd
      │
      ▼
Scheduler selects a Worker Node
      │
      ▼
kubelet receives instructions
      │
      ▼
Container Runtime pulls image
      │
      ▼
Pod starts
      │
      ▼
Status updated in etcd
```

---

## What happens if the API Server goes down?

- kubectl commands stop working
- No new Pods can be created
- Existing Pods continue running
- Cluster cannot be managed until API Server is restored

---

## What happens if a Worker Node goes down?

- Node becomes NotReady
- Controller Manager detects the failure
- Scheduler creates replacement Pods on another healthy node
- Applications remain available

---

# Task 3 – Install kubectl

## Installation (macOS)

```bash
brew install kubectl
```

Verify installation

```bash
kubectl version --client
```

---

# Task 4 – Local Cluster Setup

## Selected Tool

✅ **kind (Kubernetes IN Docker)**

### Why I chose kind

- Lightweight
- Fast startup
- Uses Docker containers
- Ideal for local development
- Easy to create and delete clusters

---

## Install kind

```bash
brew install kind
```

---

## Create Cluster

```bash
kind create cluster --name devops-cluster
```

---

## Verify Cluster

```bash
kubectl cluster-info
```

```bash
kubectl get nodes
```

**Screenshot**

> Insert screenshot of `kubectl get nodes`

---

# Task 5 – Explore the Cluster

## Cluster Information

```bash
kubectl cluster-info
```

---

## List Nodes

```bash
kubectl get nodes
```

---

## Node Details

```bash
kubectl describe node devops-cluster-control-plane
```

---

## List Namespaces

```bash
kubectl get namespaces
```

Example

```
default
kube-system
kube-public
kube-node-lease
```

---

## List All Pods

```bash
kubectl get pods -A
```

---

## List kube-system Pods

```bash
kubectl get pods -n kube-system
```

**Screenshot**

> Insert screenshot of `kubectl get pods -n kube-system`

---

# kube-system Components

| Pod | Purpose |
|------|----------|
| kube-apiserver | Entry point for all cluster communication |
| etcd | Stores complete cluster state |
| kube-scheduler | Assigns Pods to Worker Nodes |
| kube-controller-manager | Maintains desired cluster state |
| kube-proxy | Handles networking between Pods and Services |
| CoreDNS | Provides internal DNS for the cluster |

---

# Task 6 – Cluster Lifecycle

## Delete Cluster

```bash
kind delete cluster --name devops-cluster
```

---

## Recreate Cluster

```bash
kind create cluster --name devops-cluster
```

---

## Verify

```bash
kubectl get nodes
```

---

## Current Context

```bash
kubectl config current-context
```

---

## Available Contexts

```bash
kubectl config get-contexts
```

---

## View kubeconfig

```bash
kubectl config view
```

---

# What is kubeconfig?

A **kubeconfig** file stores the configuration required for `kubectl` to communicate with Kubernetes clusters.

It contains:

- Cluster information
- User credentials
- Authentication certificates
- Contexts
- Current active cluster

Default location:

```text
~/.kube/config
```

---

# Key Learnings

- Kubernetes is a container orchestration platform.
- It automates deployment, scaling, networking, and self-healing.
- Google created Kubernetes based on Borg.
- The Control Plane manages the cluster.
- Worker Nodes run containerized applications.
- API Server is the central communication hub.
- etcd stores the cluster's state.
- Scheduler decides where Pods run.
- kubelet manages Pods on Worker Nodes.
- kube-proxy handles networking.
- kind provides a lightweight local Kubernetes environment.
- kubeconfig stores cluster connection details.

---

# Challenges Completed

- ✅ Recalled Kubernetes history
- ✅ Understood Kubernetes architecture
- ✅ Installed kubectl
- ✅ Installed kind
- ✅ Created a local Kubernetes cluster
- ✅ Explored cluster components
- ✅ Viewed kube-system Pods
- ✅ Practiced cluster deletion and recreation
- ✅ Learned about kubeconfig

---

# Folder Structure

```
2026/
└── day-50/
    ├── day-50-k8s-setup.md
    ├── kubectl-get-nodes.png
    └── kube-system-pods.png
```

---

# Commands Used

```bash
brew install kubectl

brew install kind

kind create cluster --name devops-cluster

kubectl cluster-info

kubectl get nodes

kubectl describe node devops-cluster-control-plane

kubectl get namespaces

kubectl get pods -A

kubectl get pods -n kube-system

kubectl config current-context

kubectl config get-contexts

kubectl config view

kind delete cluster --name devops-cluster
```

---

# Conclusion

Today marked the beginning of my Kubernetes journey. I learned why Kubernetes was created, explored its architecture, set up a local cluster using **kind**, and interacted with the cluster using **kubectl**. Understanding the Control Plane, Worker Nodes, and core Kubernetes components has built a strong foundation for deploying and managing containerized applications in future lessons.