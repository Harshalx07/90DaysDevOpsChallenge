# Day 39 - CI/CD Concepts

## Objective

Understand the fundamentals of CI/CD, why it exists, and how modern software teams use it to build, test, and deliver applications faster and more reliably.

---

# Task 1: The Problem

## Scenario

Imagine a team of five developers working on the same application. Each developer manually pushes code and manually deploys changes to production.

### What Can Go Wrong?

* Code conflicts between developers
* Human errors during deployment
* Bugs reaching production
* Missing dependencies on servers
* Inconsistent environments
* Difficult rollback process
* Slow and unreliable releases

### What Does "It Works on My Machine" Mean?

"It works on my machine" refers to a situation where an application runs perfectly on a developer's local system but fails in another environment.

Common reasons:

* Different operating systems
* Different software versions
* Missing libraries or dependencies
* Environment configuration differences

This is one of the major challenges CI/CD helps solve.

### How Many Times Can a Team Safely Deploy Manually?

Manual deployments are time-consuming and error-prone.

Typical deployment frequency:

* Small teams: 1–2 deployments per day
* Large teams: Often limited due to risk

With CI/CD, teams can deploy multiple times a day confidently and consistently.

---

# Task 2: CI vs CD

## Continuous Integration (CI)

Continuous Integration is the practice of frequently merging code changes into a shared repository.

Whenever code is pushed:

* The application is built
* Automated tests are executed
* Code quality checks are performed

### Goal

Catch issues early before they reach production.

### Example

A developer pushes code to GitHub.

GitHub Actions automatically:

1. Builds the application
2. Runs unit tests
3. Reports success or failure

---

## Continuous Delivery (CD)

Continuous Delivery extends CI by automatically preparing applications for release.

The application is always in a deployable state, but production deployment requires manual approval.

### Goal

Reduce release risk while maintaining control over production deployments.

### Example

Code is automatically deployed to a staging environment after passing tests.

A release manager approves deployment to production.

---

## Continuous Deployment

Continuous Deployment is the next step after Continuous Delivery.

Every change that passes all automated checks is automatically deployed to production without human intervention.

### Goal

Deliver features to users as quickly as possible.

### Example

A successful build automatically triggers deployment to production.

Users receive updates immediately after all tests pass.

---

# Task 3: Pipeline Anatomy

## Trigger

An event that starts the pipeline.

Examples:

* Git push
* Pull request
* Scheduled execution
* Manual trigger

---

## Stage

A major phase within a pipeline.

Examples:

* Build
* Test
* Security Scan
* Deploy

---

## Job

A collection of related tasks executed within a stage.

Example:

Build Job

* Install dependencies
* Compile application
* Package application

---

## Step

A single action or command executed inside a job.

Example:

```bash
npm install
```

---

## Runner

The machine responsible for executing pipeline jobs.

Examples:

* GitHub-hosted runner
* Self-hosted runner
* Jenkins agent

---

## Artifact

A file or package produced during the pipeline.

Examples:

* Docker Image
* JAR File
* ZIP Package
* Build Reports

---

# Task 4: CI/CD Pipeline Diagram

## Scenario

Developer pushes code to GitHub.

The application is tested, built into a Docker image, and deployed to a staging server.

```text
┌─────────────┐
│ Developer   │
└──────┬──────┘
       │ Git Push
       ▼
┌─────────────┐
│ GitHub Repo │
└──────┬──────┘
       │ Trigger
       ▼
┌─────────────────┐
│ Stage 1: Test   │
├─────────────────┤
│ Unit Tests      │
│ Lint Checks     │
└──────┬──────────┘
       │ Success
       ▼
┌─────────────────┐
│ Stage 2: Build  │
├─────────────────┤
│ Build App       │
│ Docker Build    │
└──────┬──────────┘
       │
       ▼
┌─────────────────┐
│ Artifact Store  │
├─────────────────┤
│ Docker Image    │
└──────┬──────────┘
       │
       ▼
┌─────────────────┐
│ Stage 3: Deploy │
├─────────────────┤
│ Deploy Staging  │
└──────┬──────────┘
       │
       ▼
┌─────────────────┐
│ Staging Server  │
└─────────────────┘
```

---

# Task 5: Exploring an Open Source Workflow

## Repository

React

## Workflow Location

```text
.github/workflows/
```

## Observations

### Trigger

The workflow starts on:

* Push events
* Pull Request events

### Jobs

The workflow contains multiple jobs responsible for:

* Building code
* Running tests
* Validation checks

### Purpose

The workflow ensures that:

* New code does not break existing functionality
* Code quality standards are maintained
* Changes are verified before merging

---

# Key Takeaways

* CI/CD is a practice, not a tool.
* CI focuses on integrating and testing code continuously.
* Continuous Delivery prepares software for release.
* Continuous Deployment automatically releases software to production.
* Pipeline failures are helpful because they prevent faulty code from reaching users.
* Automation improves speed, consistency, and reliability.

---

## Tools That Implement CI/CD

* GitHub Actions
* Jenkins
* GitLab CI/CD
* CircleCI
* Azure DevOps
* Argo CD

---

## Conclusion

CI/CD enables teams to build, test, and deliver software faster while reducing manual effort and deployment risks. Understanding these concepts forms the foundation for working with tools like GitHub Actions, Jenkins, Docker, and Kubernetes in modern DevOps workflows.
