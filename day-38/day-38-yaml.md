# Day 38 – YAML Basics

## Overview

Today I learned the fundamentals of YAML (YAML Ain't Markup Language), the configuration language used across modern DevOps tools such as:

* GitHub Actions
* Kubernetes
* Docker Compose
* Ansible
* ArgoCD
* GitLab CI/CD
* Azure Pipelines

Understanding YAML is essential because almost every automation workflow, deployment pipeline, and infrastructure definition relies on it.

---

# Task 1 – Key Value Pairs

## person.yml

```yaml
---
name: Harshal Galande
role: DevOps Engineer
experience_years: 06
learning: true
```

### Concepts Learned

* YAML uses `key: value` pairs.
* Booleans use `true` or `false`.
* Quotes are optional for simple strings.
* Indentation matters.

---

# Task 2 – Lists

## Updated person.yml

```yaml
---
name: Harshal Galande
role: DevOps Engineer
experience_years: 0
learning: true

tools:
  - Docker
  - Kubernetes
  - Jenkins
  - Terraform
  - AWS

hobbies: [Coding, Gaming, Learning, Reading, Walking]
```

### Two Ways to Write Lists

### Block Style

```yaml
tools:
  - Docker
  - Kubernetes
  - Jenkins
```

### Inline Style

```yaml
tools: [Docker, Kubernetes, Jenkins]
```

### Key Takeaway

YAML supports both styles depending on readability requirements.

---

# Task 3 – Nested Objects

## server.yml

```yaml
---
server:
  name: web-server
  ip: 192.168.1.10
  port: 8080

database:
  host: localhost
  name: appdb

  credentials:
    user: admin
    password: password123
```

### Concepts Learned

Nested objects are created using indentation.

Example:

```yaml
database:
  host: localhost
```

Represents:

```json
{
  "database": {
    "host": "localhost"
  }
}
```

---

# Task 4 – Multi-line Strings

## Literal Style (|)

```yaml
startup_script_literal: |
  #!/bin/bash
  echo "Starting Application"
  systemctl start nginx
```

### Output

```bash
#!/bin/bash
echo "Starting Application"
systemctl start nginx
```

---

## Folded Style (>)

```yaml
startup_script_folded: >
  This is a long startup
  script description that
  becomes a single line.
```

### Output

```text
This is a long startup script description that becomes a single line.
```

---

# When To Use | vs >

| Operator | Purpose                         |                      |
| -------- | ------------------------------- | -------------------- |
| `        | `                               | Preserve line breaks |
| `>`      | Convert line breaks into spaces |                      |

### Real DevOps Examples

#### GitHub Actions

```yaml
run: |
  npm install
  npm test
  npm run build
```

#### Long Workflow Description

```yaml
description: >
  Build, test and deploy the
  application using GitHub Actions.
```

---

# Task 5 – YAML Validation

### Tool Used

```bash
yamllint
```

### Validation Commands

```bash
yamllint person.yml
yamllint server.yml
```

### Common Errors Found

#### Tabs Instead of Spaces

```yaml
server:
	name: web-server
```

Error:

```text
found character '\t' that cannot start any token
```

---

#### Bad Indentation

```yaml
tools:
  - Docker
   - Kubernetes
```

Error:

```text
expected <block end>, but found '<block sequence start>'
```

---

# Task 6 – Spot The Difference

### Correct

```yaml
name: devops

tools:
  - docker
  - kubernetes
```

### Incorrect

```yaml
name: devops

tools:
- docker
  - kubernetes
```

### Why It Fails

The list items are not properly aligned under the `tools` key.

Correct indentation is mandatory in YAML.

---

# YAML Rules Cheat Sheet

## DO

✅ Use spaces only

✅ Keep indentation consistent

✅ Validate files before committing

✅ Use meaningful key names

✅ Prefer 2-space indentation

---

## DON'T

❌ Use tabs

❌ Mix indentation levels

❌ Forget list indentation

❌ Assume YAML ignores spacing

---

# Real World DevOps Usage

| Tool            | Uses YAML |
| --------------- | --------- |
| GitHub Actions  | ✅         |
| Kubernetes      | ✅         |
| Docker Compose  | ✅         |
| Ansible         | ✅         |
| ArgoCD          | ✅         |
| GitLab CI/CD    | ✅         |
| Azure Pipelines | ✅         |

---

# What I Learned

### 1. Indentation Controls Structure

Unlike JSON or XML, YAML uses indentation to define hierarchy.

### 2. YAML Supports Multiple Data Types

* Strings
* Numbers
* Booleans
* Lists
* Objects

### 3. Small Formatting Mistakes Can Break Automation

A single tab or incorrect indentation can fail an entire deployment pipeline.

---

# Aha Moment

> YAML looks simple, but one misplaced space can break an entire CI/CD pipeline, Kubernetes deployment, or automation workflow.

Today I learned that YAML is less about syntax and more about precision.

---

# Day 38 Status

* [x] Key-Value Pairs
* [x] Lists
* [x] Nested Objects
* [x] Multi-line Strings
* [x] YAML Validation
* [x] Error Debugging
* [x] YAML Best Practices

## Challenge Completed ✅