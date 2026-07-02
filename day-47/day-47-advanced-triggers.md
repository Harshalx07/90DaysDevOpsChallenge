# Day 47 – Advanced Triggers: PR Events, Cron Schedules & Event-Driven Pipelines

## Objective

Today I explored advanced GitHub Actions triggers beyond the basic `push` and `pull_request` events. I learned how to automate workflows using Pull Request lifecycle events, scheduled cron jobs, workflow chaining, path filters, and external event triggers.

---

# Learning Outcomes

- Understand Pull Request lifecycle events
- Validate Pull Requests automatically
- Schedule workflows using Cron expressions
- Use path and branch filters
- Chain workflows using `workflow_run`
- Trigger workflows from external systems using `repository_dispatch`

---

# Repository Structure

```text
.github/
└── workflows/
    ├── pr-lifecycle.yml
    ├── pr-checks.yml
    ├── scheduled-tasks.yml
    ├── smart-triggers.yml
    ├── ignore-docs.yml
    ├── tests.yml
    ├── deploy-after-tests.yml
    └── external-trigger.yml

2026/
└── day-47/
    └── day-47-advanced-triggers.md
```

---

# Task 1 – Pull Request Lifecycle Events

## Workflow File

```
.github/workflows/pr-lifecycle.yml
```

## Trigger Events

- opened
- synchronize
- reopened
- closed

## Workflow Features

- Prints event action
- Prints PR title
- Prints PR author
- Prints source branch
- Prints target branch
- Executes an additional step only if the Pull Request has been merged

### Example

```yaml
on:
  pull_request:
    types:
      - opened
      - synchronize
      - reopened
      - closed
```

### Merge Check

```yaml
if: github.event.pull_request.merged == true
```

---

# Task 2 – PR Validation Workflow

## Workflow File

```
.github/workflows/pr-checks.yml
```

## Job 1 – File Size Check

Checks every file in the repository.

Fails if any file exceeds **1 MB**.

---

## Job 2 – Branch Name Validation

Allowed branch names:

```
feature/*
fix/*
docs/*
```

Example

✅ feature/login-page

✅ fix/navbar

✅ docs/readme-update

❌ login-feature

❌ update

---

## Job 3 – PR Description Check

Reads:

```yaml
github.event.pull_request.body
```

If the description is empty:

- Displays a warning
- Does not fail the workflow

---

# Task 3 – Scheduled Workflows

## Workflow File

```
.github/workflows/scheduled-tasks.yml
```

## Triggers

Manual Trigger

```yaml
workflow_dispatch:
```

Scheduled Trigger

```yaml
schedule:
  - cron: '30 2 * * 1'
  - cron: '0 */6 * * *'
```

---

## Cron Expressions

### Every Monday at 2:30 AM UTC

```
30 2 * * 1
```

---

### Every 6 Hours

```
0 */6 * * *
```

---

### Every Weekday at 9:00 AM IST

IST = UTC +5:30

9:00 IST = 3:30 UTC

Cron:

```
30 3 * * 1-5
```

---

### First Day of Every Month at Midnight

```
0 0 1 * *
```

---

## Health Check

Uses curl to verify a website is responding.

Example

```bash
curl https://github.com
```

Workflow fails if HTTP response is not **200**.

---

## Why Scheduled Workflows May Be Delayed

GitHub-hosted runners are shared.

Scheduled workflows:

- may start a few minutes late
- can be delayed during heavy traffic
- may stop running automatically if the repository becomes inactive

---

# Task 4 – Path & Branch Filters

## Workflow

```
smart-triggers.yml
```

Runs only when changes occur inside:

```
src/**
app/**
```

Only on branches:

```
main
release/*
```

Example

```yaml
paths:
  - src/**
  - app/**
```

---

## Ignore Documentation Workflow

```
ignore-docs.yml
```

Skips execution when only documentation changes.

```yaml
paths-ignore:
  - "*.md"
  - docs/**
```

---

## Paths vs Paths Ignore

### paths

Runs workflow **only when selected files change.**

Example:

```
src/**
```

Useful for:

- backend
- frontend
- infrastructure
- application code

---

### paths-ignore

Runs workflow for everything except selected files.

Useful for:

- documentation
- README updates
- licenses
- markdown files

---

# Task 5 – Workflow Chaining

## Test Workflow

```
tests.yml
```

Runs on every push.

Example:

```
Push
      ↓
Run Tests
```

---

## Deployment Workflow

```
deploy-after-tests.yml
```

Triggered by:

```yaml
workflow_run
```

Only deploys if tests succeed.

Example:

```
Push
      ↓
Tests
      ↓
Success
      ↓
Deploy
```

If tests fail:

```
Deployment Skipped
```

---

# workflow_run vs workflow_call

| workflow_run | workflow_call |
|--------------|---------------|
| Starts after another workflow completes | Calls another reusable workflow |
| Used for pipeline chaining | Used for workflow reuse |
| Depends on workflow result | Accepts inputs and secrets |
| Great for CI/CD pipelines | Great for reusable templates |

---

# Task 6 – External Event Triggers

## Workflow File

```
external-trigger.yml
```

Trigger

```yaml
repository_dispatch
```

Event Type

```
deploy-request
```

Payload Example

```json
{
  "environment": "production"
}
```

---

## Trigger Using GitHub CLI

```bash
gh api repos/<owner>/<repo>/dispatches \
-f event_type=deploy-request \
-f client_payload='{"environment":"production"}'
```

---

## When to Use repository_dispatch

Useful when an external system needs to start a workflow.

Examples

- Slack Bot
- Jenkins
- Monitoring Tools
- Grafana Alerts
- Prometheus Alerts
- Internal Deployment Portal
- Custom Dashboard
- Web Applications

---

# Key GitHub Context Variables

| Variable | Description |
|----------|-------------|
| github.event.action | Current event type |
| github.head_ref | Source branch |
| github.base_ref | Target branch |
| github.event.pull_request.title | Pull Request title |
| github.event.pull_request.body | Pull Request description |
| github.event.pull_request.user.login | PR author |
| github.event.schedule | Triggered cron expression |
| github.event.workflow_run.conclusion | Result of previous workflow |
| github.event.client_payload.environment | Custom payload value |

---

# Screenshots

Add screenshots of:

- PR Lifecycle workflow
- PR Checks
- Scheduled Workflow
- Smart Trigger
- workflow_run execution
- External Trigger execution

---

# Key Takeaways

- Pull Request events allow automation throughout the PR lifecycle.
- PR validation improves code quality before merging.
- Cron jobs automate recurring maintenance tasks.
- Path filters reduce unnecessary workflow executions.
- workflow_run enables sequential CI/CD pipelines.
- workflow_call creates reusable workflows.
- repository_dispatch lets external applications trigger GitHub Actions.
- Event-driven automation is a core practice in modern DevOps.

---

# Files Created

```
.github/workflows/pr-lifecycle.yml
.github/workflows/pr-checks.yml
.github/workflows/scheduled-tasks.yml
.github/workflows/smart-triggers.yml
.github/workflows/ignore-docs.yml
.github/workflows/tests.yml
.github/workflows/deploy-after-tests.yml
.github/workflows/external-trigger.yml

2026/day-47/day-47-advanced-triggers.md
```

---

# Conclusion

Day 47 introduced advanced GitHub Actions event triggers used in real-world DevOps pipelines. By combining Pull Request events, scheduled workflows, path filters, chained workflows, and external triggers, I built smarter and more efficient CI/CD automation that closely reflects production-grade software delivery practices.

---

## Connect with Me

- **GitHub:** https://github.com/Harshalx07
- **LinkedIn:** https://www.linkedin.com/in/harshal-galande/

---

**#90DaysOfDevOps #GitHubActions #DevOps #CI #CD #Automation #OpenSource #Cloud #TrainWithShubham**