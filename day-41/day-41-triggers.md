# Day 41 – Triggers & Matrix Builds

## Objective

Today I explored different ways to trigger GitHub Actions workflows and learned how to execute the same workflow across multiple environments using Matrix Builds.

---

# Task 1 – Pull Request Trigger

## Workflow File

```text
.github/workflows/pr-check.yml
```

### What I Learned

* Trigger workflows automatically when a Pull Request is opened.
* Trigger workflows when new commits are pushed to an existing Pull Request.
* Use GitHub context variables to access branch information.

### Trigger Configuration

```yaml
on:
  pull_request:
    branches:
      - main
    types:
      - opened
      - synchronize
```

### Output

```text
PR check running for branch: feature/day41
```

---

# Task 2 – Scheduled Trigger

## Workflow File

```text
.github/workflows/schedule.yml
```

### What I Learned

* Automate workflows using Cron expressions.
* Scheduled workflows execute without manual intervention.
* Useful for backups, maintenance, security scans, dependency updates, and reporting.

### Daily at Midnight (UTC)

```yaml
on:
  schedule:
    - cron: '0 0 * * *'
```

### Cron Expression Answer

Every Monday at **9:00 AM**

```text
0 9 * * 1
```

### Cron Format

```text
* * * * *
│ │ │ │ │
│ │ │ │ └── Day of Week (0-7)
│ │ │ └──── Month
│ │ └────── Day of Month
│ └──────── Hour
└────────── Minute
```

---

# Task 3 – Manual Trigger

## Workflow File

```text
.github/workflows/manual.yml
```

### What I Learned

* Trigger workflows manually from the GitHub Actions UI.
* Accept user input before executing the workflow.
* Useful for production deployments and on-demand operations.

### Workflow Dispatch

```yaml
on:
  workflow_dispatch:
```

### Input Example

```text
Environment:
- staging
- production
```

### Sample Output

```text
Deploying to staging
```

---

# Task 4 – Matrix Builds

## Workflow File

```text
.github/workflows/matrix.yml
```

### Matrix Configuration

* Operating Systems

  * Ubuntu Latest
  * Windows Latest

* Python Versions

  * 3.10
  * 3.11
  * 3.12

### Total Jobs

| Operating System | Python Version |
| ---------------- | -------------- |
| Ubuntu           | 3.10           |
| Ubuntu           | 3.11           |
| Ubuntu           | 3.12           |
| Windows          | 3.10           |
| Windows          | 3.11           |
| Windows          | 3.12           |

**Total Jobs = 6**

### What I Learned

Matrix builds allow a single workflow to execute across multiple operating systems and language versions simultaneously.

Benefits include:

* Faster testing
* Better compatibility
* Reduced duplicate workflow code
* Parallel execution

---

# Task 5 – Exclude & Fail-Fast

## Excluded Combination

```yaml
exclude:
  - os: windows-latest
    python-version: "3.10"
```

This reduced the total jobs from **6** to **5**.

---

## Fail Fast

### Default

```yaml
fail-fast: true
```

If one matrix job fails, GitHub cancels the remaining running jobs.

### Disabled

```yaml
fail-fast: false
```

Even if one job fails, the remaining jobs continue until completion.

---

# Summary

Today I learned how GitHub Actions supports multiple workflow triggers and powerful matrix strategies.

## Triggers Learned

* Push Trigger
* Pull Request Trigger
* Scheduled Trigger
* Manual Trigger

## Matrix Features Learned

* Multiple Python versions
* Multiple operating systems
* Parallel execution
* Excluding specific combinations
* Fail-Fast behavior

---

# Key Takeaways

* Pull Request workflows help validate code before merging.
* Scheduled workflows automate recurring tasks.
* Manual workflows allow controlled executions.
* Matrix builds make cross-platform testing simple.
* Excluding unnecessary combinations reduces execution time.
* Fail-Fast behavior can be customized based on project requirements.

---

# Repository Structure

```text
.github/
└── workflows/
    ├── pr-check.yml
    ├── schedule.yml
    ├── manual.yml
    └── matrix.yml

2026/
└── day-41/
    └── day-41-triggers.md
```

---

# Screenshots

* Pull Request Workflow
* Scheduled Workflow
* Manual Workflow
* Matrix Build (6 Parallel Jobs)
* Exclude & Fail-Fast Execution

---

## Skills Gained

* GitHub Actions Triggers
* Pull Request Automation
* Scheduled Workflows
* Manual Workflow Dispatch
* Matrix Builds
* Cross-Platform CI
* Workflow Strategy
* GitHub CI/CD Automation

---
