# Day 52 – Kubernetes Namespaces and Deployments

## Objective

Today I learned how Kubernetes organizes resources using **Namespaces** and how **Deployments** provide self-healing, scaling, and rolling updates for applications.

---

# What are Namespaces?

Namespaces are logical partitions inside a Kubernetes cluster that help organize and isolate resources.

### Why use Namespaces?

* Separate development, staging, and production environments.
* Prevent resource conflicts.
* Improve cluster organization.
* Enable team-based resource isolation.
* Apply namespace-specific security policies and resource quotas.

---

# Built-in Namespaces

| Namespace         | Purpose                              |
| ----------------- | ------------------------------------ |
| `default`         | Default namespace for resources.     |
| `kube-system`     | Kubernetes system components.        |
| `kube-public`     | Publicly readable cluster resources. |
| `kube-node-lease` | Stores node heartbeat information.   |

Command used:

```bash
kubectl get namespaces
```

View Kubernetes system Pods:

```bash
kubectl get pods -n kube-system
```

---

# Creating Custom Namespaces

Created two namespaces:

```bash
kubectl create namespace dev
kubectl create namespace staging
```

Created another namespace using a YAML manifest.

**namespace.yaml**

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

Apply:

```bash
kubectl apply -f namespace.yaml
```

---

# Running Pods in Different Namespaces

Development Pod

```bash
kubectl run nginx-dev --image=nginx:latest -n dev
```

Staging Pod

```bash
kubectl run nginx-staging --image=nginx:latest -n staging
```

View all Pods:

```bash
kubectl get pods -A
```

---

# Deployment Manifest

**nginx-deployment.yaml**

```yaml
apiVersion: apps/v1
kind: Deployment

metadata:
  name: nginx-deployment
  namespace: dev
  labels:
    app: nginx

spec:
  replicas: 3

  selector:
    matchLabels:
      app: nginx

  template:
    metadata:
      labels:
        app: nginx

    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
```

---

# Deployment Manifest Explained

### apiVersion

Specifies the Kubernetes API version.

```yaml
apiVersion: apps/v1
```

---

### kind

Defines the resource type.

```yaml
kind: Deployment
```

---

### metadata

Contains resource information.

```yaml
metadata:
  name: nginx-deployment
  namespace: dev
```

---

### replicas

Maintains the desired number of Pods.

```yaml
replicas: 3
```

---

### selector

Matches the Pods managed by the Deployment.

```yaml
selector:
  matchLabels:
    app: nginx
```

---

### template

Blueprint used to create Pods.

```yaml
template:
```

---

### containers

Defines the container image and exposed port.

```yaml
containers:
- name: nginx
  image: nginx:1.24
```

---

# Deployment vs Standalone Pod

| Standalone Pod        | Deployment                          |
| --------------------- | ----------------------------------- |
| Created manually      | Managed by Deployment controller    |
| No automatic recovery | Automatically recreates failed Pods |
| No scaling            | Supports scaling                    |
| No rolling updates    | Supports rolling updates            |
| Best for testing      | Recommended for production          |

---

# Self-Healing

Deleted one Pod manually.

```bash
kubectl delete pod <pod-name> -n dev
```

The Deployment controller immediately created a new Pod to maintain the desired replica count.

The replacement Pod had a **different name**, confirming that Kubernetes created a new Pod instead of restoring the deleted one.

---

# Scaling

### Imperative Scaling

Scale to five replicas.

```bash
kubectl scale deployment nginx-deployment --replicas=5 -n dev
```

Scale back to two.

```bash
kubectl scale deployment nginx-deployment --replicas=2 -n dev
```

Kubernetes automatically created or removed Pods to match the desired replica count.

---

### Declarative Scaling

Updated the Deployment manifest.

```yaml
replicas: 4
```

Applied the changes.

```bash
kubectl apply -f nginx-deployment.yaml
```

---

# Rolling Update

Updated the container image.

```bash
kubectl set image deployment/nginx-deployment nginx=nginx:1.25 -n dev
```

Monitor rollout.

```bash
kubectl rollout status deployment/nginx-deployment -n dev
```

Kubernetes replaced Pods gradually, ensuring zero downtime.

---

# Rollback

Viewed rollout history.

```bash
kubectl rollout history deployment/nginx-deployment -n dev
```

Rolled back.

```bash
kubectl rollout undo deployment/nginx-deployment -n dev
```

Verified image version.

```bash
kubectl describe deployment nginx-deployment -n dev
```

The Deployment successfully returned to **nginx:1.24**.

---

# ReplicaSets

Deployments automatically create ReplicaSets to maintain the desired state.

Command:

```bash
kubectl get replicasets -n dev
```

---

# Cleanup

Deleted all resources.

```bash
kubectl delete deployment nginx-deployment -n dev

kubectl delete pod nginx-dev -n dev

kubectl delete pod nginx-staging -n staging

kubectl delete namespace dev staging production
```

Verified cleanup.

```bash
kubectl get namespaces

kubectl get pods -A
```

---

# Screenshots

* `kubectl get namespaces`
* `kubectl get pods -A`
* `kubectl get deployments -n dev`
* `kubectl get pods -n dev`
* Deployment scaled to 5 replicas
* Rolling update in progress
* Rollback completed
* Final cleanup

---

# Key Takeaways

* Learned how Kubernetes Namespaces organize cluster resources.
* Created multiple namespaces for environment isolation.
* Deployed an application using a Deployment.
* Observed Kubernetes self-healing by deleting a Pod.
* Scaled Deployments both imperatively and declaratively.
* Performed a zero-downtime rolling update.
* Rolled back to a previous application version.
* Understood how Deployments use ReplicaSets to maintain the desired state.

---