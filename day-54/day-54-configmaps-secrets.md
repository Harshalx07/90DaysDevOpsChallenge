# Day 54 – Kubernetes ConfigMaps and Secrets

## Objective

Applications require configuration such as database URLs, feature flags, API keys, and passwords. Hardcoding these values inside container images makes updates difficult because every change requires rebuilding the image.

Kubernetes provides:

* **ConfigMaps** for non-sensitive configuration.
* **Secrets** for sensitive information such as passwords, API keys, and tokens.

---

# Task 1 – Create a ConfigMap from Literals

Created a ConfigMap named **app-config** using command-line literals.

```bash
kubectl create configmap app-config \
--from-literal=APP_ENV=production \
--from-literal=APP_DEBUG=false \
--from-literal=APP_PORT=8080
```

Verified using:

```bash
kubectl describe configmap app-config
kubectl get configmap app-config -o yaml
```

### Result

* Successfully created ConfigMap.
* All key-value pairs were stored as plain text.

---

# Task 2 – Create a ConfigMap from a File

Created a custom **default.conf** for Nginx containing a `/health` endpoint.

```bash
kubectl create configmap nginx-config \
--from-file=default.conf=default.conf
```

Verified using:

```bash
kubectl get configmap nginx-config -o yaml
```

### Result

The complete Nginx configuration file was stored inside the ConfigMap.

---

# Task 3 – Use ConfigMaps in Pods

### Environment Variables

Injected all values from **app-config** using:

```yaml
envFrom:
  - configMapRef:
      name: app-config
```

Verified inside the Pod:

```
APP_ENV=production
APP_DEBUG=false
APP_PORT=8080
```

### Volume Mount

Mounted the Nginx ConfigMap to:

```
/etc/nginx/conf.d
```

Verified:

```
curl http://localhost/health
```

Output:

```
healthy
```

---

# Task 4 – Create a Secret

Created Secret:

```bash
kubectl create secret generic db-credentials \
--from-literal=DB_USER=admin \
--from-literal=DB_PASSWORD=s3cureP@ssw0rd
```

Verified using:

```bash
kubectl get secret db-credentials -o yaml
```

Decoded Secret:

```bash
kubectl get secret db-credentials \
-o jsonpath='{.data.DB_PASSWORD}' \
| base64 --decode
```

Output:

```
s3cureP@ssw0rd
```

---

# Task 5 – Use Secrets in a Pod

Injected Secret as:

* Environment variable
* Mounted volume

Verified that:

* Environment variable contained the decoded value.
* Mounted Secret files also contained plaintext values.

---

# Task 6 – Update ConfigMap

Created:

```bash
kubectl create configmap live-config \
--from-literal=message=hello
```

Updated using:

```bash
kubectl patch configmap live-config \
--type merge \
-p '{"data":{"message":"world"}}'
```

### Observation

Volume-mounted ConfigMaps updated automatically after a short delay.

Environment variables **did not update** because they are only read when the Pod starts.

---

# Task 7 – Cleanup

Deleted all created resources.

```bash
kubectl delete pods --all
kubectl delete configmaps --all
kubectl delete secret db-credentials
```

---

# What are ConfigMaps?

ConfigMaps store **non-sensitive configuration** separately from application images.

Examples:

* Application environment
* Feature flags
* Port numbers
* URLs
* Configuration files

---

# What are Secrets?

Secrets store **sensitive information** such as:

* Passwords
* Database credentials
* API keys
* Tokens
* Certificates

Although Secret values appear as Base64 in YAML, Base64 is **not encryption**.

---

# Environment Variables vs Volume Mounts

| Environment Variables              | Volume Mounts                      |
| ---------------------------------- | ---------------------------------- |
| Easy for simple configuration      | Best for configuration files       |
| Loaded when Pod starts             | Automatically refreshed            |
| Requires Pod restart after changes | Updates without restarting the Pod |

---

# Why Base64 is NOT Encryption

Base64 only converts data into a different text format.

Anyone with access can decode it:

```bash
echo "<base64-value>" | base64 --decode
```

For real protection, Kubernetes relies on:

* RBAC
* Encryption at Rest (optional)
* Restricted access to Secrets

---

# ConfigMap Update Behavior

Mounted ConfigMaps:

* Automatically refresh inside Pods.
* No Pod restart required.

Environment variables:

* Do not refresh.
* Require a Pod restart to load updated values.

---

# Key Takeaways

* ConfigMaps store non-sensitive configuration.
* Secrets store sensitive information.
* ConfigMaps and Secrets can be injected as environment variables or mounted volumes.
* Volume-mounted ConfigMaps update automatically.
* Environment variables remain unchanged until the Pod restarts.
* Base64 encoding is **not** encryption.
* Kubernetes encourages separating configuration from application images.

---

## Skills Learned

* Creating ConfigMaps from literals
* Creating ConfigMaps from files
* Mounting ConfigMaps
* Creating Kubernetes Secrets
* Injecting Secrets into Pods
* Decoding Base64 Secret values
* Understanding automatic ConfigMap propagation
* Kubernetes configuration best practices

---