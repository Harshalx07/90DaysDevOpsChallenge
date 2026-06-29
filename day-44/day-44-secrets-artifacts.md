# Day 44 – Secrets, Artifacts & Running Real Tests in CI

## Objective

Today focused on making GitHub Actions workflows production-ready by learning how to securely manage secrets, store and share build artifacts, execute real tests, and optimize workflow execution using dependency caching.

---

## Repository Structure

```text
github-actions-practice/
│
├── .github/
│   └── workflows/
│       ├── secrets.yml
│       ├── artifacts.yml
│       ├── test.yml
│       └── cache.yml
│
├── scripts/
│   └── hello.py
│
├── reports/
│
└── 2026/
    └── day-44/
        └── day-44-secrets-artifacts.md
```

---

# Task 1 – GitHub Secrets

## What I Did

* Created a repository secret named `MY_SECRET_MESSAGE`.
* Accessed:

  * **Settings**
  * **Secrets and Variables**
  * **Actions**
* Used the secret inside a workflow.
* Verified that GitHub automatically masks secret values in workflow logs.

### Output

```text
The secret is set: true
```

Attempting to print the secret directly resulted in:

```text
***
```

instead of the actual value.

### Why Secrets Should Never Be Printed

Printing secrets in CI logs can expose:

* API Keys
* Docker Tokens
* AWS Credentials
* Database Passwords
* Personal Access Tokens

Anyone with access to workflow logs could misuse these credentials. GitHub masks secret values automatically, but workflows should never intentionally print them.

---

# Task 2 – Using Secrets as Environment Variables

Secrets were passed securely as environment variables.

Example:

```yaml
env:
  USERNAME: ${{ secrets.DOCKER_USERNAME }}
  TOKEN: ${{ secrets.DOCKER_TOKEN }}
```

The secret values were used inside shell commands without hardcoding sensitive information.

---

# Task 3 – Upload Artifacts

Generated a sample report file during the workflow and uploaded it using:

```yaml
uses: actions/upload-artifact@v4
```

Artifact Name:

```text
test-report
```

### Verification

Successfully downloaded the artifact from the **GitHub Actions** page after workflow completion.

---

## Screenshot

> 📷 Add screenshot of the downloaded artifact here.

---

# Task 4 – Download Artifacts Between Jobs

Created a workflow with two jobs.

### Job 1

* Generated a file
* Uploaded it as an artifact

### Job 2

* Downloaded the artifact
* Printed its contents

Example output:

```text
Build Successful
```

### Real-World Use Cases

Artifacts are commonly used for:

* Build binaries
* JAR/WAR files
* Test reports
* Code coverage reports
* Terraform plans
* Deployment packages
* Log files

---

# Task 5 – Running Real Tests in CI

Added a Python script from previous exercises.

Workflow steps:

* Checkout repository
* Install Python
* Execute script
* Fail pipeline if the script exits with a non-zero status

Example script:

```python
print("Running Tests...")

assert 2 + 2 == 4

print("Tests Passed!")
```

### Testing Failure

Changed the assertion to:

```python
assert 2 + 2 == 5
```

Result:

❌ Workflow Failed

Fixed the assertion:

```python
assert 2 + 2 == 4
```

Result:

✅ Workflow Passed

This demonstrated how Continuous Integration automatically catches errors before code reaches production.

---

## Screenshot

> 📷 Add screenshot of the successful workflow here.

---

# Task 6 – Dependency Caching

Configured GitHub Actions cache using:

```yaml
uses: actions/cache@v4
```

Cached directory:

```text
~/.cache/pip
```

### Observation

First Workflow Run

* Cache Miss
* Downloaded dependencies

Second Workflow Run

* Cache Hit
* Dependencies restored from cache
* Faster execution time

### What Is Being Cached?

The cache stores downloaded Python packages so future workflow runs can reuse them instead of downloading everything again.

GitHub stores the cache on its hosted infrastructure and restores it whenever the cache key matches.

---

# Key Learnings

* GitHub Secrets securely store sensitive information.
* Secrets are automatically masked in workflow logs.
* Environment variables are the safest way to use secrets.
* Artifacts allow files to be shared between jobs.
* Artifacts can be downloaded after workflow completion.
* Continuous Integration automatically runs tests on every workflow execution.
* Failing tests stop the pipeline and help catch bugs early.
* Dependency caching significantly reduces workflow execution time.
* Production CI/CD pipelines rely heavily on secrets, artifacts, testing, and caching.

---

# Files Created

```text
.github/workflows/secrets.yml
.github/workflows/artifacts.yml
.github/workflows/test.yml
.github/workflows/cache.yml
scripts/hello.py
2026/day-44/day-44-secrets-artifacts.md
```

---

# Screenshots Checklist

* [ ] GitHub Secrets workflow
* [ ] Secret masking (`***`)
* [ ] Artifact upload
* [ ] Artifact download
* [ ] Passing test workflow
* [ ] Failed workflow (optional)
* [ ] Cache restored (optional)

---

# Outcome

Today I learned how to build more production-ready GitHub Actions workflows by securely handling secrets, preserving build artifacts, running automated tests, and improving CI performance using dependency caching. These features form the foundation of reliable and scalable CI/CD pipelines used in real-world DevOps environments.
