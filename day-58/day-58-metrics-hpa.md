# Day 58 – Metrics Server and Horizontal Pod Autoscaler (HPA)

## 🎯 Objective

Today I learned how Kubernetes automatically scales applications based on CPU utilization using the **Metrics Server** and **Horizontal Pod Autoscaler (HPA)**.

---

# What is the Metrics Server?

The **Metrics Server** is a cluster-wide component that collects CPU and memory usage metrics from every node and pod in a Kubernetes cluster.

These metrics are used by:

* Horizontal Pod Autoscaler (HPA)
* `kubectl top`
* Kubernetes Dashboard

Without the Metrics Server, Kubernetes cannot make autoscaling decisions because it has no visibility into resource usage.

---

# Why HPA Needs the Metrics Server

HPA continuously checks the CPU (or memory/custom metrics in newer versions) of running Pods.

It compares the current utilization against the configured target and automatically adjusts the number of replicas.

Without the Metrics Server:

* `kubectl top` does not work
* HPA shows `<unknown>` in the TARGETS column
* No automatic scaling occurs

---

# Lab Tasks

## ✅ Task 1 – Install Metrics Server

Installed the Metrics Server and verified that it was collecting resource metrics.

### Commands

```bash
kubectl get pods -n kube-system | grep metrics-server
kubectl top nodes
kubectl top pods -A
```

### Result

* Metrics Server running successfully
* `kubectl top` returning CPU and memory usage

---

## ✅ Task 2 – Explore kubectl top

Used `kubectl top` to monitor real-time resource usage.

### Commands

```bash
kubectl top nodes
kubectl top pods -A
kubectl top pods -A --sort-by=cpu
kubectl top pods -A --sort-by=memory
```

### Learned

* Shows **actual resource usage**
* Different from configured **requests** and **limits**
* Updates approximately every 15 seconds

---

## ✅ Task 3 – Create CPU-Based Deployment

Created a Deployment using the Kubernetes HPA example image.

Configured CPU requests:

```yaml
resources:
  requests:
    cpu: 200m
```

Exposed it using a ClusterIP Service.

```bash
kubectl expose deployment php-apache --port=80
```

---

## ✅ Task 4 – Create an HPA (Imperative)

Created a Horizontal Pod Autoscaler.

```bash
kubectl autoscale deployment php-apache \
--cpu-percent=50 \
--min=1 \
--max=10
```

Verified:

```bash
kubectl get hpa
kubectl describe hpa php-apache
```

Initially, the TARGETS field displayed `<unknown>` until metrics became available.

---

## ✅ Task 5 – Generate Load

Created a BusyBox load generator.

```bash
kubectl run load-generator \
--image=busybox:1.36 \
--restart=Never \
-- /bin/sh -c "while true; do wget -q -O- http://php-apache; done"
```

Observed HPA behavior:

* CPU utilization increased
* Replica count automatically increased
* Kubernetes distributed traffic across new Pods

Stopped the load generator:

```bash
kubectl delete pod load-generator
```

Scale-down begins after the default stabilization window.

---

## ✅ Task 6 – Declarative HPA

Created an HPA using the `autoscaling/v2` API.

Features included:

* CPU utilization target
* Scale-up policy
* Scale-down stabilization window
* Fine-grained scaling behavior

---

## ✅ Task 7 – Cleanup

Removed all lab resources except the Metrics Server.

```bash
kubectl delete hpa php-apache
kubectl delete deployment php-apache
kubectl delete svc php-apache
kubectl delete pod load-generator
```

---

# How HPA Calculates Desired Replicas

Formula:

```text
desiredReplicas = ceil(currentReplicas × (currentUsage / targetUsage))
```

Example:

* Current replicas = 2
* Current CPU = 100%
* Target CPU = 50%

```
desiredReplicas = ceil(2 × (100 / 50))
                 = ceil(4)
                 = 4 replicas
```

---

# autoscaling/v1 vs autoscaling/v2

| autoscaling/v1        | autoscaling/v2                            |
| --------------------- | ----------------------------------------- |
| CPU metrics only      | CPU, Memory, Custom and External metrics  |
| Basic configuration   | Advanced scaling behavior                 |
| No scaling policies   | Supports scale-up and scale-down behavior |
| Limited customization | Production-ready autoscaling              |

---

# Key Learnings

* Metrics Server provides real-time resource metrics.
* HPA requires CPU requests to calculate utilization.
* `kubectl top` displays live resource consumption.
* HPA automatically increases replicas during high load.
* Scale-down uses a stabilization window to prevent rapid fluctuations.
* `autoscaling/v2` provides advanced autoscaling capabilities.


## Conclusion

This lab demonstrated how Kubernetes automatically responds to changing workloads using the Metrics Server and Horizontal Pod Autoscaler. By combining resource requests with live metrics, Kubernetes can dynamically scale applications, improving availability, performance, and efficient resource utilization.
