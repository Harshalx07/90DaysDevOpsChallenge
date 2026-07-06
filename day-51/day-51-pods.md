# Day 51 – Kubernetes Manifests and Your First Pods

## Objective

Today I learned how Kubernetes uses YAML manifests to define resources and deployed my first Pods from scratch. I explored Pod creation, inspection, labels, imperative vs declarative management, manifest validation, and cleanup.

---

# What is a Kubernetes Manifest?

A Kubernetes manifest is a YAML file that describes the desired state of a Kubernetes resource.

Every manifest contains four important top-level fields.

| Field | Description |
|--------|-------------|
| apiVersion | Specifies which Kubernetes API version should be used. |
| kind | Defines the type of Kubernetes resource (Pod, Deployment, Service, etc.). |
| metadata | Contains information like resource name, labels, and namespace. |
| spec | Describes the desired state of the resource such as containers, images, ports, and commands. |

Example:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: example-pod

spec:
  containers:
    - name: nginx
      image: nginx:latest
```

---

# Task 1 – Nginx Pod

## Manifest

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: nginx-pod
  labels:
    app: nginx

spec:
  containers:
    - name: nginx
      image: nginx:latest
      ports:
        - containerPort: 80
```

## Commands Used

```bash
kubectl apply -f nginx-pod.yaml

kubectl get pods

kubectl get pods -o wide

kubectl describe pod nginx-pod

kubectl logs nginx-pod

kubectl exec -it nginx-pod -- /bin/bash
```

Inside the container:

```bash
curl localhost
```

### Result

Successfully deployed an Nginx Pod and viewed the default Nginx welcome page from inside the container.

---

# Task 2 – BusyBox Pod

## Manifest

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: busybox-pod
  labels:
    app: busybox
    environment: dev

spec:
  containers:
    - name: busybox
      image: busybox:latest
      command:
        - sh
        - -c
        - echo Hello from BusyBox && sleep 3600
```

## Commands

```bash
kubectl apply -f busybox-pod.yaml

kubectl get pods

kubectl logs busybox-pod
```

### Result

```
Hello from BusyBox
```

The `command` field keeps the container running. Without it, BusyBox would exit immediately and the Pod would stop.

---

# Task 3 – Third Pod (Alpine)

## Manifest

```yaml
apiVersion: v1
kind: Pod

metadata:
  name: alpine-pod
  labels:
    app: alpine
    environment: testing
    team: devops

spec:
  containers:
    - name: alpine
      image: alpine:latest
      command:
        - sh
        - -c
        - sleep 3600
```

---

# Imperative vs Declarative

## Imperative Approach

Commands directly tell Kubernetes what to do.

Example:

```bash
kubectl run redis-pod --image=redis:latest
```

Advantages

- Fast
- Useful for testing
- No YAML required

Disadvantages

- Difficult to version control
- Not suitable for production

---

## Declarative Approach

Write the desired configuration in YAML.

Example:

```bash
kubectl apply -f nginx-pod.yaml
```

Advantages

- Infrastructure as Code
- Version controlled
- Repeatable deployments
- Easy collaboration
- Production standard

---

# Generate YAML with Dry Run

Generate a manifest without creating the resource.

```bash
kubectl run test-pod \
--image=nginx \
--dry-run=client \
-o yaml > generated-pod.yaml
```

This command creates a template manifest that can be customized before deployment.

---

# Validate Manifest

Client-side validation

```bash
kubectl apply -f nginx-pod.yaml --dry-run=client
```

Server-side validation

```bash
kubectl apply -f nginx-pod.yaml --dry-run=server
```

If the `image` field is removed, Kubernetes returns an error similar to:

```
spec.containers[0].image: Required value
```

Validation helps detect errors before resources are created.

---

# Working with Labels

View labels

```bash
kubectl get pods --show-labels
```

Filter by app

```bash
kubectl get pods -l app=nginx
```

Filter by environment

```bash
kubectl get pods -l environment=dev
```

Filter by team

```bash
kubectl get pods -l team=devops
```

Add a label

```bash
kubectl label pod nginx-pod environment=production
```

Remove a label

```bash
kubectl label pod nginx-pod environment-
```

Labels help organize resources and are heavily used by Services, Deployments, and selectors.

---

# Screenshot

**Running Pods**

> Insert screenshot here

```
kubectl get pods
```

or

```
kubectl get pods -o wide
```

---

# What Happens When a Standalone Pod is Deleted?

A standalone Pod is permanently removed after deletion.

Since it is not managed by a controller like a Deployment, ReplicaSet, or StatefulSet, Kubernetes will **not recreate** it automatically.

This is why production workloads are usually deployed using Deployments instead of standalone Pods.

---

# Commands Used

```bash
kubectl apply -f nginx-pod.yaml

kubectl apply -f busybox-pod.yaml

kubectl apply -f alpine-pod.yaml

kubectl get pods

kubectl get pods -o wide

kubectl describe pod nginx-pod

kubectl logs nginx-pod

kubectl logs busybox-pod

kubectl exec -it nginx-pod -- /bin/bash

kubectl get pods --show-labels

kubectl get pods -l app=nginx

kubectl get pods -l environment=dev

kubectl label pod nginx-pod environment=production

kubectl label pod nginx-pod environment-

kubectl run redis-pod --image=redis:latest

kubectl get pod redis-pod -o yaml

kubectl run test-pod --image=nginx --dry-run=client -o yaml

kubectl apply -f nginx-pod.yaml --dry-run=client

kubectl apply -f nginx-pod.yaml --dry-run=server

kubectl delete pod nginx-pod

kubectl delete pod busybox-pod

kubectl delete pod alpine-pod

kubectl delete pod redis-pod
```

---

# Key Takeaways

- Learned the structure of a Kubernetes manifest.
- Deployed Pods using YAML manifests.
- Created three different Pods from scratch.
- Used `kubectl describe`, `logs`, and `exec` to inspect Pods.
- Understood the difference between imperative and declarative resource management.
- Practiced using labels for organizing and filtering resources.
- Learned to validate manifests using dry-run.
- Understood why standalone Pods are not suitable for production.
- Explored how Kubernetes automatically generates metadata for resources.

---

# Folder Structure

```
2026/
└── day-51/
    ├── nginx-pod.yaml
    ├── busybox-pod.yaml
    ├── alpine-pod.yaml
    ├── generated-pod.yaml
    ├── day-51-pods.md
    └── screenshots/
        └── kubectl-get-pods.png
```

---

# Conclusion

Today I learned how Kubernetes manages workloads using Pod manifests. I manually created multiple Pods, explored them using kubectl commands, worked with labels, compared imperative and declarative approaches, validated manifests before deployment, and understood why Deployments are preferred over standalone Pods in production environments.