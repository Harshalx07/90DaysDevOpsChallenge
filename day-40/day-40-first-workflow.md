# Day 40 – Your First GitHub Actions Workflow

## Objective

Today I created my first GitHub Actions workflow and learned how Continuous Integration (CI) works in GitHub.

Whenever I push code to my repository, GitHub automatically starts a workflow on a virtual machine and executes the steps defined in the workflow file.

---

# Repository Structure

```text
github-actions-practice
├── .github
│   └── workflows
│       └── hello.yml
└── README.md
```

---

# Workflow File (`.github/workflows/hello.yml`)

```yaml
name: My First GitHub Actions Workflow

on:
  push:

jobs:
  greet:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Print Hello
        run: echo "Hello from GitHub Actions!"

      - name: Print Current Date
        run: date

      - name: Print Branch Name
        run: echo "Branch: ${{ github.ref_name }}"

      - name: List Repository Files
        run: ls -la

      - name: Print Runner Operating System
        run: echo "Runner OS: $RUNNER_OS"
```

---

# Workflow Explanation

## `name`

Defines the name of the workflow displayed in the GitHub Actions tab.

---

## `on`

Specifies when the workflow should run.

```yaml
on:
  push:
```

This workflow runs automatically whenever code is pushed to the repository.

---

## `jobs`

A workflow consists of one or more jobs.

```yaml
jobs:
```

Each job runs independently on a GitHub-hosted runner.

---

## `runs-on`

Specifies the operating system for the runner.

```yaml
runs-on: ubuntu-latest
```

GitHub creates a fresh Ubuntu virtual machine to execute the workflow.

---

## `steps`

A job is made up of multiple sequential steps.

Each step performs a specific task.

---

## `uses`

Runs a reusable GitHub Action.

```yaml
uses: actions/checkout@v4
```

This downloads the repository code onto the runner.

---

## `run`

Executes shell commands on the runner.

Example:

```yaml
run: echo "Hello from GitHub Actions!"
```

---

## `name` (Step Name)

Provides a readable label for each step in the GitHub Actions interface.

Example:

```yaml
- name: Print Hello
```

---

# Additional Workflow Steps

The workflow also demonstrates:

* Printing the current date and time
* Displaying the branch name
* Listing repository files
* Showing the runner operating system

---

# Intentional Failure Test

To understand pipeline failures, I intentionally added the following step:

```yaml
- name: Break Pipeline
  run: exit 1
```

This caused the workflow to fail with a non-zero exit code.

After reviewing the logs in the **Actions** tab, I removed the failing step and pushed the fix.

---

# What I Learned

* GitHub Actions automatically runs workflows after a push.
* Workflow files are stored in `.github/workflows/`.
* Each workflow contains jobs and each job contains steps.
* `uses` executes reusable GitHub Actions.
* `run` executes Linux shell commands.
* GitHub provides hosted runners for CI/CD.
* Failed workflows provide detailed logs that help identify and fix issues quickly.

---


## Workflow Logs

> Insert screenshot of the workflow logs.

---

# Conclusion

Today I built and executed my first GitHub Actions workflow. I learned the basic structure of a workflow, how GitHub-hosted runners execute jobs, and how to debug pipeline failures using workflow logs.

This marks my first practical step into Continuous Integration (CI) using GitHub Actions.

---

## Repository

```
github-actions-practice
```

---

### #90DaysOfDevOps #GitHubActions #CI #DevOps #TrainWithShubham
