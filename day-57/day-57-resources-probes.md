# Day 57 – Kubernetes Resource Requests, Limits, and Probes

## Objective

Today's goal was to understand how Kubernetes manages CPU and memory resources while ensuring application reliability using health probes.

By the end of this lab, I was able to:

* Configure CPU and memory requests and limits.
* Observe an **OOMKilled** event when memory usage exceeded the configured limit.
* Understand why Pods remain **Pending** when requesting unavailable resources.
* Configure **Liveness**, **Readiness**, and **Startup** probes.
* Learn how Kubernetes automatically recovers unhealthy workloads.

---

# Task 1 – Resource Requests and Limits

## Resource Configuration

```yaml
resources:
  requests:
    cpu: "100m"
    memory: "128Mi"
  limits:
    cpu: "250m"
    memory: "256Mi"
```

### Result

* CPU Request: **100m**
* CPU Limit: **250m**
* Memory Request: **128Mi**
* Memory Limit: **256Mi**

### Verification

```
QoS Class: Burstable
```

### Explanation

**Requests**

* Minimum resources guaranteed to the Pod.
* Used by the Kubernetes scheduler.

**Limits**

* Maximum resources the container can consume.
* Enforced by the kubelet during runtime.

---

# Task 2 – OOMKilled

A Pod was deployed using the `polinux/stress` image with:

* Memory Limit: **100Mi**
* Requested Allocation: **200M**

Since the application attempted to use more memory than allowed, Kubernetes immediately terminated the container.

### Result

```
Reason: OOMKilled
Exit Code: 137
```

### Observation

* CPU overuse is throttled.
* Memory overuse results in immediate termination.

---

# Task 3 – Pending Pod

A Pod requested:

* CPU: **100**
* Memory: **128Gi**

The cluster did not have sufficient resources.

### Result

```
STATUS: Pending
```

Scheduler Events:

```
0/1 nodes are available
Insufficient cpu
Insufficient memory
```

### Explanation

The scheduler could not find a node capable of satisfying the requested resources.

---

# Task 4 – Liveness Probe

A BusyBox container created a health file during startup and removed it after 30 seconds.

The liveness probe continuously checked for the existence of that file.

When the file disappeared:

* Probe failed three consecutive times.
* Kubernetes restarted the container automatically.

### Result

```
Container Restarted ✔
```

---

# Task 5 – Readiness Probe

An NGINX Pod was configured with an HTTP readiness probe.

Initially:

* Pod became Ready.
* Service endpoints contained the Pod IP.

After deleting the default web page:

* Pod changed to **0/1 READY**
* Service endpoints became empty.
* Container continued running.

### Result

```
Container Restarted?
No
```

### Key Point

Readiness probes only determine whether a Pod should receive traffic.

---

# Task 6 – Startup Probe

A BusyBox container intentionally delayed startup for 20 seconds.

The startup probe allowed Kubernetes to wait before executing liveness checks.

### Configuration

* periodSeconds: **5**
* failureThreshold: **12**

This provided a startup window of **60 seconds**.

### What if failureThreshold = 2?

The startup probe would fail after only **10 seconds**, causing Kubernetes to restart the container before the application finished starting.

---

# Task 7 – Cleanup

Deleted all created Pods and Services.

```
kubectl delete pods --all
kubectl delete svc --all
```

---

# Resource Requests vs Limits

| Requests                     | Limits                    |
| ---------------------------- | ------------------------- |
| Minimum guaranteed resources | Maximum allowed resources |
| Used by Scheduler            | Enforced by Kubelet       |
| Determines Pod placement     | Controls runtime usage    |

---

# CPU vs Memory Limits

| CPU                              | Memory                  |
| -------------------------------- | ----------------------- |
| Throttled when limit is exceeded | Container is OOMKilled  |
| Compressible resource            | Incompressible resource |

---

# Kubernetes QoS Classes

| QoS Class  | Condition             |
| ---------- | --------------------- |
| Guaranteed | Requests = Limits     |
| Burstable  | Requests < Limits     |
| BestEffort | No requests or limits |

---

# Kubernetes Probes

## Liveness Probe

* Detects unhealthy containers.
* Restarts failed containers automatically.

---

## Readiness Probe

* Controls whether a Pod receives traffic.
* Does not restart the container.

---

## Startup Probe

* Protects slow-starting applications.
* Disables liveness and readiness probes until startup completes.

---

# Screenshots

Include the following screenshots:

* Resource Requests and Limits
* QoS Class (Burstable)
* OOMKilled (Exit Code 137)
* Pending Pod with Scheduler Events
* Liveness Probe Restart Events
* Readiness Probe (0/1 READY)
* Empty Service Endpoints
* Successful Startup Probe

---

# Key Learnings

* Requests help Kubernetes schedule Pods efficiently.
* Limits prevent containers from consuming excessive resources.
* Memory limit violations result in **OOMKilled**.
* CPU limits throttle execution instead of terminating the container.
* Liveness probes provide automatic recovery.
* Readiness probes protect users from unhealthy Pods.
* Startup probes prevent premature restarts of slow applications.

---

## Conclusion

Day 57 introduced one of Kubernetes' most important production concepts: resource management and health monitoring. Understanding requests, limits, QoS classes, and probes is essential for building reliable, scalable, and self-healing applications in Kubernetes.

---