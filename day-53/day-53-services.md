# Day 53 – Kubernetes Services

## Overview

Today I learned how Kubernetes Services provide stable networking for applications running inside a cluster.

Pods receive dynamic IP addresses that change whenever they are recreated. Instead of connecting directly to Pod IPs, Kubernetes Services provide a stable IP address and DNS name while automatically load balancing traffic across healthy Pods.

---

## Objectives

- Create a Deployment with multiple Nginx Pods
- Expose the application using ClusterIP
- Expose the application using NodePort
- Create a LoadBalancer Service
- Verify Service communication
- Test Kubernetes DNS
- Understand Service Endpoints
- Compare different Service types

---

# Architecture

```
                Client
                   |
                   |
          +------------------+
          | Kubernetes       |
          | Service          |
          +------------------+
            /      |      \
           /       |       \
       Pod 1    Pod 2    Pod 3
```

The Service acts as a stable entry point and automatically distributes traffic across all matching Pods.

---

# Files Created

```
app-deployment.yaml
clusterip-service.yaml
nodeport-service.yaml
loadbalancer-service.yaml
```

---

# Deployment

Created a Deployment with:

- Nginx 1.25
- 3 Replicas
- Port 80 exposed

Applied using:

```bash
kubectl apply -f app-deployment.yaml
```

Verified Pods:

```bash
kubectl get pods -o wide
```

---

# ClusterIP Service

Created:

```yaml
type: ClusterIP
```

Purpose:

- Internal communication
- Stable Cluster IP
- Automatic Load Balancing

Applied:

```bash
kubectl apply -f clusterip-service.yaml
```

Verified:

```bash
kubectl get services
```

Tested inside cluster:

```bash
kubectl run test-client \
--image=busybox \
--rm -it \
--restart=Never -- sh

wget -qO- http://web-app-clusterip
```

Successfully received the Nginx welcome page.

---

# Kubernetes DNS

Verified Kubernetes DNS by accessing the Service using:

```
web-app-clusterip
```

and

```
web-app-clusterip.default.svc.cluster.local
```

Checked DNS resolution:

```bash
nslookup web-app-clusterip
```

The DNS resolved to the ClusterIP successfully.

---

# Endpoints

Checked which Pods the Service routes traffic to.

```bash
kubectl get endpoints web-app-clusterip
```

Endpoints displayed all running Pod IP addresses.

---

# NodePort Service

Created:

```yaml
type: NodePort
```

NodePort:

```
30080
```

Purpose:

- External access for development
- Accessible using

```
<Node-IP>:30080
```

Verified:

```bash
kubectl get services
```

Opened the application from browser successfully.

---

# LoadBalancer Service

Created:

```yaml
type: LoadBalancer
```

Purpose:

- Production workloads
- Cloud-managed external load balancer

Verified:

```bash
kubectl get services
```

On the local Kubernetes cluster, the External IP remained:

```
<pending>
```

This is expected because local clusters do not provide a cloud load balancer.

---

# Comparing Service Types

| Service Type | Accessible From | Use Case |
|--------------|-----------------|----------|
| ClusterIP | Inside Cluster | Internal communication |
| NodePort | Node IP + Port | Development & Testing |
| LoadBalancer | Internet | Production |

---

# Kubernetes DNS

Every Service automatically receives a DNS name.

Example:

```
web-app-clusterip.default.svc.cluster.local
```

Pods can communicate using the Service name instead of remembering IP addresses.

---

# What are Endpoints?

Endpoints are the actual Pod IP addresses backing a Service.

View them using:

```bash
kubectl get endpoints web-app-clusterip
```

The Service forwards traffic only to healthy Endpoints.

---

# Key Learnings

- Pods have temporary IP addresses.
- Services provide stable networking.
- Services automatically load balance traffic.
- ClusterIP is used for internal communication.
- NodePort exposes applications externally through Node ports.
- LoadBalancer is used in cloud environments.
- Kubernetes DNS enables Service discovery.
- Endpoints show which Pods receive traffic.

---

# Screenshots

- Deployment Pods
- ClusterIP Service
- BusyBox Connectivity Test
- DNS Lookup
- Endpoints
- LoadBalancer Description
- Services Overview

---

# Commands Used

```bash
kubectl apply -f app-deployment.yaml

kubectl get pods -o wide

kubectl apply -f clusterip-service.yaml

kubectl run test-client --image=busybox --rm -it --restart=Never -- sh

kubectl get endpoints web-app-clusterip

kubectl apply -f nodeport-service.yaml

kubectl apply -f loadbalancer-service.yaml

kubectl describe service web-app-loadbalancer

kubectl get services -o wide

kubectl delete -f .
```

---

# Conclusion

Kubernetes Services provide a reliable networking layer that allows applications to communicate using stable IP addresses and DNS names while distributing traffic across multiple Pods. Understanding ClusterIP, NodePort, and LoadBalancer is essential before moving on to Ingress and production-grade Kubernetes networking.