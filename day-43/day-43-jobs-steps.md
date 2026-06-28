# Day 43 – Jobs, Steps, Environment Variables & Conditionals

## Objective

Learn how to build smarter GitHub Actions workflows by using:

* Multi-job workflows
* Job dependencies
* Environment variables
* Job outputs
* Conditional execution
* Parallel jobs

---

# Task 1: Multi-Job Workflow

## What I Learned

GitHub Actions allows multiple jobs in a single workflow. Jobs run in parallel by default, but the `needs` keyword creates dependencies between them.

### Example

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building the app"

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - run: echo "Running tests"

  deploy:
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying"
```

### Workflow Graph

```
Build
  │
  ▼
Test
  │
  ▼
Deploy
```

---

# Task 2: Environment Variables

Environment variables can be defined at three different levels.

## Workflow Level

Available to every job.

```yaml
env:
  APP_NAME: myapp
```

## Job Level

Available only inside a specific job.

```yaml
env:
  ENVIRONMENT: staging
```

## Step Level

Available only within a single step.

```yaml
env:
  VERSION: 1.0.0
```

### GitHub Context Variables

Useful built-in variables:

```yaml
${{ github.sha }}
${{ github.actor }}
${{ github.ref }}
${{ github.event_name }}
```

These provide information about the workflow execution.

---

# Task 3: Job Outputs

One job can send data to another using outputs.

### Setting an Output

```yaml
outputs:
  today: ${{ steps.date.outputs.today }}
```

```bash
echo "today=$(date)" >> $GITHUB_OUTPUT
```

### Reading an Output

```yaml
${{ needs.generate-date.outputs.today }}
```

## Why Use Job Outputs?

Job outputs allow one job to share data with another job without recalculating it. They are useful for passing:

* Build versions
* Docker image tags
* Commit IDs
* Dates and timestamps
* Generated artifacts

---

# Task 4: Conditionals

GitHub Actions supports conditional execution using `if`.

## Run Only on Main Branch

```yaml
if: github.ref == 'refs/heads/main'
```

---

## Run Only After Failure

```yaml
if: failure()
```

---

## Run Only on Push Events

```yaml
if: github.event_name == 'push'
```

---

## Continue on Error

```yaml
continue-on-error: true
```

This allows a step to fail without stopping the workflow. The next steps continue to execute normally.

---

# Task 5: Smart Pipeline

Pipeline Structure

```
          Lint
            │
            │
            ▼
        Summary
            ▲
            │
          Test
```

## Workflow Features

* Triggered on every push
* Lint and Test jobs run in parallel
* Summary waits for both jobs
* Detects whether the push is on the `main` branch or a feature branch
* Prints the latest commit message

---

# Key Concepts Learned

## needs

Creates dependencies between jobs.

```yaml
needs: build
```

---

## outputs

Shares values from one job to another.

```yaml
outputs:
```

---

## Environment Variables

Three scopes:

* Workflow
* Job
* Step

---

## GitHub Context

Examples:

* github.sha
* github.actor
* github.ref
* github.event_name

---

## Conditionals

Examples:

```yaml
if: success()
if: failure()
if: always()
```

---

# Summary

Today I learned how to build more intelligent GitHub Actions workflows using job dependencies, environment variables, outputs, and conditional execution. These features make CI/CD pipelines more modular, maintainable, and efficient by controlling workflow execution and sharing information across jobs.

---

## Repository Structure

```
.github/
└── workflows/
    ├── multi-job.yml
    ├── environment.yml
    ├── job-output.yml
    ├── conditionals.yml
    └── smart-pipeline.yml

2026/
└── day-43/
    └── day-43-jobs-steps.md
```

---

**Day 43 Completed ✅**

**Topics Covered**

* Multi-Job Workflows
* Job Dependencies (`needs`)
* Environment Variables
* GitHub Context Variables
* Job Outputs
* Conditional Execution
* Continue on Error
* Parallel Job Execution
* Smart Pipeline Design
