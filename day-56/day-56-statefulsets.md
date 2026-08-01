# Day 56 – Kubernetes StatefulSets

## 📌 Objective

Learn how Kubernetes **StatefulSets** manage stateful applications by providing:

- Stable pod names
- Ordered pod creation and termination
- Persistent storage for each replica
- Stable network identity using Headless Services

Unlike Deployments, StatefulSets are designed for applications that require stable identities and persistent data, such as databases and distributed systems.

---

# What are StatefulSets?

A **StatefulSet** is a Kubernetes workload resource used to manage **stateful applications**.

It guarantees:

- Stable and unique pod names
- Stable DNS names
- Dedicated Persistent Volume Claims (PVCs) for every pod
- Ordered deployment and scaling
- Ordered deletion

Common use cases include:

- MySQL
- PostgreSQL
- MongoDB
- Redis (Persistent Mode)
- Apache Kafka
- Elasticsearch
- ZooKeeper

---

# Deployment vs StatefulSet

| Feature | Deployment | StatefulSet |
|----------|------------|-------------|
| Application Type | Stateless | Stateful |
| Pod Names | Random | Stable (`web-0`, `web-1`) |
| Startup | Parallel | Ordered |
| Shutdown | Parallel | Reverse Order |
| Storage | Shared | One PVC per Pod |
| DNS | No Stable DNS | Stable DNS |
| Database Support | ❌ | ✅ |

---

# Lab Tasks

---

## Task 1 – Deployment with Random Pod Names

Created an Nginx Deployment with **3 replicas**.

```bash
kubectl apply -f deployment.yaml
```

Checked Pods

```bash
kubectl get pods
```

Example Output

```text
nginx-deploy-6d5d67d8bf-8m9fd
nginx-deploy-6d5d67d8bf-rjh9x
nginx-deploy-6d5d67d8bf-v2tz4
```

Deleted one Pod

```bash
kubectl delete pod nginx-deploy-6d5d67d8bf-rjh9x
```

Observed that Kubernetes created a replacement Pod with a **different random name**.

### Why is this a problem?

Databases rely on stable identities for:

- Replication
- Cluster membership
- Leader election
- Persistent storage mapping

Random Pod names break these requirements.

---

## Task 2 – Headless Service

Created a Headless Service.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx-headless
spec:
  clusterIP: None
  selector:
    app: web
  ports:
  - port: 80
```

Applied

```bash
kubectl apply -f headless-service.yaml
```

Verified

```bash
kubectl get svc
```

Output

```text
NAME              TYPE        CLUSTER-IP
nginx-headless    ClusterIP   None
```

### Verification

✅ CLUSTER-IP = **None**

---

## Task 3 – StatefulSet

Created a StatefulSet with:

- 3 replicas
- nginx image
- Headless Service
- VolumeClaimTemplates

Applied

```bash
kubectl apply -f statefulset.yaml
```

Watched Pods

```bash
kubectl get pods -w
```

Observed ordered creation

```text
web-0

↓

web-1

↓

web-2
```

Checked StatefulSet

```bash
kubectl get sts
```

Checked Pods

```bash
kubectl get pods
```

Output

```text
web-0
web-1
web-2
```

---

## Task 4 – Persistent Volume Claims

Verified PVCs

```bash
kubectl get pvc
```

Output

```text
web-data-web-0
web-data-web-1
web-data-web-2
```

Each Pod received its own Persistent Volume Claim.

PVC naming format

```
<template-name>-<pod-name>
```

Example

```
web-data-web-0
```

---

## Task 5 – Stable DNS

Started a BusyBox Pod.

```bash
kubectl run busybox --image=busybox --restart=Never -it -- sh
```

Performed DNS lookups.

```bash
nslookup web-0.nginx-headless.default.svc.cluster.local

nslookup web-1.nginx-headless.default.svc.cluster.local

nslookup web-2.nginx-headless.default.svc.cluster.local
```

Compared Pod IPs

```bash
kubectl get pods -o wide
```

### Verification

The DNS records resolved to the correct Pod IP addresses.

---

## Task 6 – Persistent Storage

Stored unique data.

```bash
kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"
```

Verified

```bash
kubectl exec web-0 -- cat /usr/share/nginx/html/index.html
```

Output

```text
Data from web-0
```

Deleted Pod

```bash
kubectl delete pod web-0
```

Waited until Kubernetes recreated it.

Verified data again.

```bash
kubectl exec web-0 -- cat /usr/share/nginx/html/index.html
```

Output

```text
Data from web-0
```

### Result

The data remained unchanged because the new Pod reattached to the existing Persistent Volume Claim.

---

## Task 7 – Ordered Scaling

Scaled StatefulSet.

```bash
kubectl scale statefulset web --replicas=5
```

Observed Pods

```text
web-3

↓

web-4
```

Scaled back.

```bash
kubectl scale statefulset web --replicas=3
```

Observed reverse deletion.

```text
web-4

↓

web-3
```

Verified PVCs.

```bash
kubectl get pvc
```

Output

```text
web-data-web-0
web-data-web-1
web-data-web-2
web-data-web-3
web-data-web-4
```

### Result

Even after scaling down, all PVCs remained.

---

## Task 8 – Cleanup

Deleted StatefulSet

```bash
kubectl delete statefulset web
```

Deleted Headless Service

```bash
kubectl delete svc nginx-headless
```

Checked PVCs

```bash
kubectl get pvc
```

PVCs still existed.

Deleted PVCs manually.

```bash
kubectl delete pvc --all
```

---

# How StatefulSets Work

## Stable Pod Names

Pods receive predictable names.

```
web-0
web-1
web-2
```

These names never change.

---

## Stable DNS

Every Pod receives a DNS entry.

```
web-0.nginx-headless.default.svc.cluster.local

web-1.nginx-headless.default.svc.cluster.local

web-2.nginx-headless.default.svc.cluster.local
```

Applications can communicate reliably using these hostnames.

---

## VolumeClaimTemplates

Instead of sharing storage, every Pod receives its own Persistent Volume Claim.

Example

```
web-data-web-0

web-data-web-1

web-data-web-2
```

Even if a Pod is deleted, its PVC remains attached when recreated.

---

## Ordered Deployment

Pods start one by one.

```
web-0

↓

web-1

↓

web-2
```

Each Pod waits until the previous Pod is ready.

---

## Ordered Deletion

Pods terminate in reverse order.

```
web-2

↓

web-1

↓

web-0
```

This prevents accidental failures in clustered applications.

---

# Screenshots

Include the following screenshots:

- Deployment Pods with random names
- Headless Service (`CLUSTER-IP: None`)
- StatefulSet Pods (`web-0`, `web-1`, `web-2`)
- Persistent Volume Claims
- BusyBox DNS resolution
- `kubectl get pods -o wide`
- Data before Pod deletion
- Data after Pod recreation
- Scaling to 5 replicas
- Scaling back to 3 replicas
- PVCs after scale-down
- PVCs after StatefulSet deletion
- Manual PVC cleanup

---

# Key Learnings

- StatefulSets are designed for stateful workloads.
- Pod names remain stable throughout the application lifecycle.
- Every Pod receives its own Persistent Volume Claim.
- Headless Services provide stable DNS records.
- Data survives Pod deletion because storage is persistent.
- Pods are created sequentially and deleted in reverse order.
- Scaling down does not remove Persistent Volume Claims.
- Deleting a StatefulSet does not automatically delete Persistent Volume Claims.

---

# Commands Used

```bash
kubectl apply -f deployment.yaml

kubectl delete deployment nginx-deploy

kubectl apply -f headless-service.yaml

kubectl apply -f statefulset.yaml

kubectl get pods

kubectl get sts

kubectl get svc

kubectl get pvc

kubectl get pods -o wide

kubectl run busybox --image=busybox --restart=Never -it -- sh

nslookup web-0.nginx-headless.default.svc.cluster.local

kubectl exec web-0 -- sh -c "echo 'Data from web-0' > /usr/share/nginx/html/index.html"

kubectl exec web-0 -- cat /usr/share/nginx/html/index.html

kubectl delete pod web-0

kubectl scale statefulset web --replicas=5

kubectl scale statefulset web --replicas=3

kubectl delete statefulset web

kubectl delete svc nginx-headless

kubectl delete pvc --all
```

---

# Conclusion

StatefulSets solve the limitations of Deployments for stateful workloads by providing **stable identities, predictable networking, and persistent storage**. Through this lab, I learned how Headless Services, StatefulSets, and Persistent Volume Claims work together to ensure that applications like databases can recover safely from Pod failures while retaining their identity and data.
