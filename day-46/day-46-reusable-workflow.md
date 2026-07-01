# Day 46 – Reusable Workflows & Composite Actions

## Objective

Today's goal was to understand how to eliminate duplicate GitHub Actions workflows by creating reusable workflows and custom composite actions. These features help standardize CI/CD pipelines and improve maintainability across multiple repositories.

---

# Task 1 – Understanding Reusable Workflows

## What is a Reusable Workflow?

A reusable workflow is a GitHub Actions workflow that can be called from another workflow using the `workflow_call` trigger. It allows teams to define common CI/CD logic once and reuse it across multiple repositories or workflows.

---

## What is the `workflow_call` Trigger?

`workflow_call` is a special GitHub Actions event that enables one workflow to invoke another workflow. Unlike `push` or `pull_request`, a workflow with `workflow_call` cannot run independently and must be called by another workflow.

Example:

```yaml
on:
  workflow_call:
```

---

## Reusable Workflow vs Regular Action

| Reusable Workflow                               | Regular Action                  |
| ----------------------------------------------- | ------------------------------- |
| Contains one or more jobs                       | Contains only steps             |
| Triggered using `workflow_call`                 | Used with `uses:` inside a step |
| Can run on multiple runners                     | Runs inside the current job     |
| Supports jobs, permissions, secrets and outputs | Supports reusable steps         |

---

## Where Must a Reusable Workflow Live?

```
.github/workflows/
```

---

# Task 2 – Reusable Workflow

File:

```
.github/workflows/reusable-build.yml
```

```yaml
name: Reusable Build Workflow

on:
  workflow_call:
    inputs:
      app_name:
        required: true
        type: string
      environment:
        required: true
        default: staging
        type: string

    secrets:
      docker_token:
        required: true

    outputs:
      build_version:
        description: Build Version
        value: ${{ jobs.build.outputs.build_version }}

jobs:
  build:
    runs-on: ubuntu-latest

    outputs:
      build_version: ${{ steps.version.outputs.build_version }}

    steps:
      - uses: actions/checkout@v4

      - name: Print Build Info
        run: |
          echo "Building ${{ inputs.app_name }}"
          echo "Environment: ${{ inputs.environment }}"
          echo "Docker Token Present: ${{ secrets.docker_token != '' }}"

      - name: Generate Version
        id: version
        run: |
          VERSION=v1.0-${GITHUB_SHA::7}
          echo "build_version=$VERSION" >> $GITHUB_OUTPUT
```

---

# Task 3 – Caller Workflow

File:

```
.github/workflows/call-build.yml
```

```yaml
name: Call Reusable Workflow

on:
  push:
    branches:
      - main

jobs:
  build:
    uses: ./.github/workflows/reusable-build.yml

    with:
      app_name: "my-web-app"
      environment: "production"

    secrets:
      docker_token: ${{ secrets.DOCKER_TOKEN }}

  print-version:
    needs: build
    runs-on: ubuntu-latest

    steps:
      - name: Print Build Version
        run: |
          echo "Version: ${{ needs.build.outputs.build_version }}"
```

---

# Task 4 – Workflow Outputs

The reusable workflow generates a build version using the current Git commit SHA.

Example output:

```
v1.0-abcdef1
```

The caller workflow accesses this output using:

```yaml
needs.build.outputs.build_version
```

---

# Task 5 – Composite Action

Directory:

```
.github/actions/setup-and-greet/
```

File:

```
action.yml
```

```yaml
name: Setup and Greet

description: Custom Composite Action

inputs:
  name:
    required: true

  language:
    required: false
    default: en

outputs:
  greeted:
    value: ${{ steps.done.outputs.greeted }}

runs:
  using: composite

  steps:
    - name: Greeting
      shell: bash
      run: |
        if [ "${{ inputs.language }}" = "en" ]; then
          echo "Hello ${{ inputs.name }}"
        elif [ "${{ inputs.language }}" = "hi" ]; then
          echo "Namaste ${{ inputs.name }}"
        else
          echo "Hi ${{ inputs.name }}"
        fi

    - name: Runner Information
      shell: bash
      run: |
        echo "Date: $(date)"
        echo "Runner OS: $RUNNER_OS"

    - name: Set Output
      id: done
      shell: bash
      run: |
        echo "greeted=true" >> $GITHUB_OUTPUT
```

---

# Workflow Using Composite Action

File:

```
.github/workflows/composite-demo.yml
```

```yaml
name: Composite Action Demo

on:
  workflow_dispatch:

jobs:
  demo:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Run Composite Action
        id: greet
        uses: ./.github/actions/setup-and-greet

        with:
          name: Harshal
          language: hi

      - name: Print Output
        run: |
          echo "Greeting Completed: ${{ steps.greet.outputs.greeted }}"
```

---

# Task 6 – Comparison

| Feature                    | Reusable Workflow      | Composite Action                |
| -------------------------- | ---------------------- | ------------------------------- |
| Triggered By               | `workflow_call`        | `uses:` inside a workflow step  |
| Can Contain Jobs           | ✅ Yes                  | ❌ No                            |
| Can Contain Multiple Steps | ✅ Yes                  | ✅ Yes                           |
| Runs on Multiple Runners   | ✅ Yes                  | ❌ No                            |
| Location                   | `.github/workflows/`   | `.github/actions/`              |
| Accepts Secrets Directly   | ✅ Yes                  | ❌ Passed as inputs              |
| Best For                   | Entire CI/CD pipelines | Reusing repeated workflow steps |

---

# Verification

* Created a reusable workflow using `workflow_call`.
* Passed inputs and secrets from the caller workflow.
* Generated and returned workflow outputs.
* Accessed outputs using the `needs` context.
* Built a custom composite action.
* Successfully executed the composite action in a separate workflow.

---

# Screenshot

> **Add a screenshot here showing:**
>
> * GitHub Actions workflow run
> * Caller workflow invoking the reusable workflow
> * Logs displaying:
>
>   * Building `my-web-app`
>   * Environment: `production`
>   * Docker Token Present: `true`
>   * Build Version output

---

# Key Learnings

* Learned how to create reusable workflows using `workflow_call`.
* Understood the difference between reusable workflows and composite actions.
* Passed inputs, secrets, and outputs between workflows.
* Built a custom composite action for reusable workflow steps.
* Improved CI/CD workflow reusability by reducing duplicate code.
* Learned a production-ready GitHub Actions pattern used in enterprise DevOps environments.
