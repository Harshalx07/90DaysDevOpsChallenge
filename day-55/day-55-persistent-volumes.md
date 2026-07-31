# Day 55 – Kubernetes Persistent Volumes (PV) & Persistent Volume Claims (PVC)

## Objective

Containers are ephemeral by design. When a Pod is deleted, all data stored inside the container is lost. This is a major challenge for stateful applications like databases. In this lab, I explored Kubernetes Persistent Volumes (PV) and Persistent Volume Claims (PVC) to provide persistent storage that survives Pod restarts and recreations.

---

## What I Learned

- Why container storage is ephemeral
- Difference between ephemeral and persistent storage
- Creating a PersistentVolume (PV)
- Creating a PersistentVolumeClaim (PVC)
- Binding PVCs to available PVs
- Mounting persistent storage into Pods
- Verifying data persistence across Pod recreation
- Static vs Dynamic Provisioning
- Understanding StorageClasses
- Access Modes and Reclaim Policies

---

# Task 1 – Demonstrating Ephemeral Storage

Created a Pod using an `emptyDir` volume.

### Steps

- Created a BusyBox Pod
- Mounted an `emptyDir` volume
- Wrote a timestamp to `/data/message.txt`
- Verified the file existed
- Deleted the Pod
- Recreated the Pod
- Checked the file again

### Result

The previous file was lost after Pod deletion.

**Observation**

`emptyDir` exists only for the lifetime of a Pod.

---

# Task 2 – Creating a PersistentVolume

Created a static PersistentVolume with:

- Capacity: **1Gi**
- Access Mode: **ReadWriteOnce**
- Reclaim Policy: **Retain**
- Storage Type: **hostPath**

Example

```yaml
capacity:
  storage: 1Gi

accessModes:
- ReadWriteOnce

persistentVolumeReclaimPolicy: Retain
```

### Verification

```bash
kubectl get pv
```

Status

```
Available
```

---

# Task 3 – Creating a PersistentVolumeClaim

Created a PVC requesting

- Storage: **500Mi**
- Access Mode: **ReadWriteOnce**

After applying

```bash
kubectl get pvc
```

Result

```
STATUS   Bound
VOLUME   my-pv
```

The PVC successfully bound to the available PersistentVolume.

---

# Task 4 – Using PVC in a Pod

Mounted the PVC inside a Pod.

```
/data
```

Added data to

```
/data/message.txt
```

Deleted the Pod.

Created it again.

Verified

```
cat /data/message.txt
```

The file still existed and contained entries from both Pod instances.

### Result

Persistent storage survives Pod deletion.

---

# Task 5 – StorageClass

Checked available StorageClasses.

```bash
kubectl get storageclass
```

Observed

- Provisioner
- Reclaim Policy
- Volume Binding Mode

Dynamic provisioning allows Kubernetes to create PersistentVolumes automatically whenever a matching PVC is created.

---

# Task 6 – Dynamic Provisioning

Created a PVC using

```yaml
storageClassName: standard
```

Kubernetes automatically created a new PersistentVolume.

Verification

```bash
kubectl get pv
```

Observed

- One manually created PV
- One dynamically provisioned PV

Successfully mounted the dynamic PVC into a Pod and verified persistent storage.

---

# Task 7 – Cleanup

Deleted

- Pods
- PVCs

Observed

Dynamic PV

```
Deleted
```

Manual PV

```
Released
```

Deleted the retained PV manually.

---

# Static vs Dynamic Provisioning

## Static Provisioning

- Administrator creates the PV manually.
- Developers create PVCs.
- PVC binds to an existing PV.

### Advantages

- Full control
- Predictable storage

---

## Dynamic Provisioning

- Developer creates only the PVC.
- StorageClass automatically provisions the PV.

### Advantages

- Faster
- Scalable
- Cloud-native approach

---

# Access Modes

| Access Mode | Description |
|-------------|-------------|
| ReadWriteOnce (RWO) | Read and write by one node |
| ReadOnlyMany (ROX) | Read-only by many nodes |
| ReadWriteMany (RWX) | Read and write by many nodes |

---

# Reclaim Policies

| Policy | Behavior |
|---------|----------|
| Retain | Keeps the volume and data after PVC deletion |
| Delete | Deletes the storage automatically |
| Recycle | Deprecated |

---

# Key Kubernetes Objects

## PersistentVolume (PV)

A cluster-wide storage resource provided by the administrator.

## PersistentVolumeClaim (PVC)

A request for storage made by a user or application.

## StorageClass

Defines how storage should be dynamically provisioned.

---

# Commands Used

```bash
kubectl apply -f pv.yaml

kubectl apply -f pvc.yaml

kubectl apply -f pod-pvc.yaml

kubectl get pv

kubectl get pvc

kubectl get storageclass

kubectl describe storageclass

kubectl exec -it pvc-pod -- cat /data/message.txt

kubectl delete pod pvc-pod

kubectl delete pvc my-pvc

kubectl delete pv my-pv
```

---

# Key Takeaways

- Containers are ephemeral.
- PersistentVolumes provide durable storage.
- PersistentVolumeClaims request storage from Kubernetes.
- StorageClasses enable automatic volume provisioning.
- Persistent data survives Pod recreation.
- Reclaim policies determine what happens to storage after PVC deletion.
- Persistent storage is essential for stateful workloads such as databases.

---

## Challenge Status

- Demonstrated ephemeral storage
- Created a PersistentVolume
- Created a PersistentVolumeClaim
- Mounted persistent storage into Pods
- Verified data persistence
- Explored StorageClasses
- Tested dynamic provisioning
- Completed cleanup

---

## Folder Structure

```
2026/
└── day-55/
    ├── ephemeral-pod.yaml
    ├── pv.yaml
    ├── pvc.yaml
    ├── pod-pvc.yaml
    ├── dynamic-pvc.yaml
    ├── dynamic-pod.yaml
    └── day-55-persistent-volumes.md
```

---

## Conclusion

Today's lab demonstrated one of the most important concepts in Kubernetes—persistent storage. While containers are designed to be disposable, applications often require durable storage. By using Persistent Volumes, Persistent Volume Claims, and StorageClasses, Kubernetes provides reliable storage solutions for stateful workloads.