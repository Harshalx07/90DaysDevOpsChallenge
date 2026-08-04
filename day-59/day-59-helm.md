# Day 59 – Helm: Kubernetes Package Manager

## Objective

Over the past several days, Kubernetes applications have been deployed using individual YAML files such as Deployments, Services, ConfigMaps, Secrets, and Persistent Volume Claims. As applications grow, managing dozens of YAML files becomes difficult. Helm simplifies this process by packaging Kubernetes resources into reusable charts that can be installed, upgraded, rolled back, and shared easily.

---

# What is Helm?

Helm is the **package manager for Kubernetes**. It helps deploy and manage Kubernetes applications using reusable packages called **Charts**.

Instead of manually creating multiple YAML files, Helm installs an entire application stack with a single command.

Example:

```bash
helm install my-nginx bitnami/nginx
```

This command creates all the required Kubernetes resources such as Deployments, Services, ConfigMaps, and other objects automatically.

---

# Core Concepts

## 1. Chart

A **Chart** is a package containing Kubernetes manifest templates and configuration files.

Examples:

* NGINX
* MySQL
* PostgreSQL
* Redis
* Prometheus

---

## 2. Release

A **Release** is a deployed instance of a Chart.

The same chart can be installed multiple times with different configurations.

Example:

```
Chart
└── bitnami/nginx

Release 1
└── my-nginx

Release 2
└── production-nginx
```

---

## 3. Repository

A **Repository** stores Helm Charts.

Popular repositories include:

* Bitnami
* Artifact Hub
* Grafana
* Prometheus Community

Repositories are similar to:

* apt (Ubuntu)
* yum (CentOS)
* npm
* Docker Hub

---

# Task 1 – Install Helm

## Install

### macOS

```bash
brew install helm
```

### Linux

```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

---

## Verify Installation

```bash
helm version
```

Check environment variables:

```bash
helm env
```

---

# Task 2 – Add the Bitnami Repository

Add the repository:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Update repositories:

```bash
helm repo update
```

Search for available charts:

```bash
helm search repo nginx
```

Search all Bitnami charts:

```bash
helm search repo bitnami
```

Count available charts:

```bash
helm search repo bitnami | wc -l
```

---

# Task 3 – Install an NGINX Chart

Install the chart:

```bash
helm install my-nginx bitnami/nginx
```

Verify the release:

```bash
helm list
```

Check release status:

```bash
helm status my-nginx
```

View generated manifests:

```bash
helm get manifest my-nginx
```

Inspect Kubernetes resources:

```bash
kubectl get all
```

Expected resources include:

* Deployment
* ReplicaSet
* Pod
* Service

---

# Task 4 – Customize the Deployment

View the default values:

```bash
helm show values bitnami/nginx
```

Install with command-line overrides:

```bash
helm install nginx-custom bitnami/nginx \
--set replicaCount=3 \
--set service.type=NodePort
```

Verify deployment:

```bash
kubectl get deployment
```

Verify service:

```bash
kubectl get svc
```

---

# custom-values.yaml

```yaml
replicaCount: 3

service:
  type: NodePort

resources:
  requests:
    cpu: "100m"
    memory: "128Mi"

  limits:
    cpu: "500m"
    memory: "512Mi"
```

Install using the values file:

```bash
helm install nginx-values bitnami/nginx \
-f custom-values.yaml
```

View applied values:

```bash
helm get values nginx-values
```

---

# Task 5 – Upgrade and Roll Back

Upgrade the release:

```bash
helm upgrade my-nginx bitnami/nginx \
--set replicaCount=5
```

Check revision history:

```bash
helm history my-nginx
```

Roll back to Revision 1:

```bash
helm rollback my-nginx 1
```

View history again:

```bash
helm history my-nginx
```

**Note:** A rollback creates a new revision instead of overwriting previous revisions.

---

# Task 6 – Create Your Own Helm Chart

Generate a new chart:

```bash
helm create my-app
```

Generated directory:

```
my-app/
├── Chart.yaml
├── values.yaml
├── charts/
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    ├── ingress.yaml
    ├── serviceaccount.yaml
    └── _helpers.tpl
```

---

## Modify values.yaml

```yaml
replicaCount: 3

image:
  repository: nginx
  tag: "1.25"
```

---

## Go Template Example

Inside the Deployment template:

```yaml
replicas: {{ .Values.replicaCount }}
```

Helm replaces this placeholder with the value from `values.yaml`.

Another example:

```yaml
{{ .Chart.Name }}
```

This inserts the chart name dynamically.

---

## Validate the Chart

```bash
helm lint my-app
```

---

## Preview Rendered YAML

```bash
helm template my-release ./my-app
```

This renders the manifests locally without installing them.

---

## Install the Chart

```bash
helm install my-release ./my-app
```

Verify:

```bash
kubectl get deployment
```

Expected:

* 3 replicas

Upgrade the deployment:

```bash
helm upgrade my-release ./my-app \
--set replicaCount=5
```

Verify again:

```bash
kubectl get deployment
```

Expected:

* 5 replicas

---

# Task 7 – Cleanup

Remove all releases:

```bash
helm uninstall my-nginx
helm uninstall nginx-custom
helm uninstall nginx-values
helm uninstall my-release
```

Delete local files:

```bash
rm custom-values.yaml
rm -rf my-app
```

Confirm cleanup:

```bash
helm list
```

Expected output:

```
No releases found
```

---

# Helm Chart Structure

| File         | Purpose                       |
| ------------ | ----------------------------- |
| Chart.yaml   | Chart metadata                |
| values.yaml  | Default configuration values  |
| templates/   | Kubernetes manifest templates |
| charts/      | Dependency charts             |
| _helpers.tpl | Template helper functions     |

---

# Go Template Variables

| Template                   | Description                      |
| -------------------------- | -------------------------------- |
| `{{ .Values.key }}`        | Access values from `values.yaml` |
| `{{ .Chart.Name }}`        | Chart name                       |
| `{{ .Release.Name }}`      | Release name                     |
| `{{ .Release.Namespace }}` | Kubernetes namespace             |

---

# Key Helm Commands

| Command             | Purpose                          |
| ------------------- | -------------------------------- |
| `helm version`      | Display Helm version             |
| `helm repo add`     | Add a chart repository           |
| `helm repo update`  | Update repository indexes        |
| `helm search repo`  | Search available charts          |
| `helm install`      | Install a chart                  |
| `helm list`         | List installed releases          |
| `helm status`       | Show release status              |
| `helm get values`   | Display configured values        |
| `helm get manifest` | Show rendered manifests          |
| `helm show values`  | Display chart defaults           |
| `helm upgrade`      | Upgrade a release                |
| `helm rollback`     | Roll back to a previous revision |
| `helm history`      | View release revision history    |
| `helm template`     | Render manifests locally         |
| `helm lint`         | Validate chart structure         |
| `helm uninstall`    | Remove a release                 |

---

# Learning Outcomes

After completing this lab, I learned:

* How Helm simplifies Kubernetes application deployment.
* The difference between Charts, Releases, and Repositories.
* How to install applications from the Bitnami repository.
* How to customize deployments using `--set` and `values.yaml`.
* How to upgrade and roll back Helm releases.
* How to build, validate, and deploy a custom Helm chart.
* How Go templating enables reusable Kubernetes manifests.
* Why Helm is the standard package manager for Kubernetes in production environments.

---

# Repository Structure

```
2026/
└── day-59/
    ├── day-59-helm.md
    └── custom-values.yaml
```

---

# Conclusion

Helm significantly reduces the complexity of managing Kubernetes applications by packaging multiple Kubernetes resources into reusable, configurable Charts. It provides version control through Releases, supports safe upgrades and rollbacks, and enables reusable deployments using Go templates. Helm has become an essential tool for deploying and maintaining production-grade Kubernetes workloads efficiently.
