# Day 42 – GitHub Actions Runners (GitHub-Hosted & Self-Hosted)

## Objective

Learn how GitHub Actions executes workflows using runners, understand the difference between GitHub-hosted and self-hosted runners, and configure a self-hosted runner to execute workflows on a personal machine.

---

## What is a GitHub Actions Runner?

A **runner** is a machine that executes the jobs defined in a GitHub Actions workflow.

There are two types of runners:

* **GitHub-hosted runners** – Virtual machines managed by GitHub.
* **Self-hosted runners** – Machines managed by the user, such as a local computer or cloud VM.

---

# Task 1 – GitHub-Hosted Runners

Created a workflow with three jobs running on different operating systems:

* Ubuntu (`ubuntu-latest`)
* Windows (`windows-latest`)
* macOS (`macos-latest`)

Each job printed:

* Operating System
* Hostname
* Current User

### What is a GitHub-hosted Runner?

GitHub-hosted runners are temporary virtual machines created and managed by GitHub. They are automatically provisioned for every workflow execution and destroyed once the workflow completes.

**Managed By:** GitHub

---

# Task 2 – Explore Pre-installed Software

Verified the tools already available on the Ubuntu runner.

Commands executed:

```bash
docker --version
python3 --version
node --version
git --version
```

### Why are pre-installed tools important?

GitHub-hosted runners include many commonly used development tools, reducing setup time and making CI/CD workflows faster and more efficient.

---

# Task 3 – Configure a Self-Hosted Runner

Configured a self-hosted runner on my local machine.

Steps performed:

* Opened Repository Settings
* Navigated to **Actions → Runners**
* Added a new self-hosted runner
* Downloaded the runner package
* Configured the runner
* Started the runner using:

```bash
./run.sh
```

Successfully connected to GitHub.

**Runner Status**

* Connected to GitHub
* Listening for Jobs

---

# Task 4 – Execute Workflow on Self-Hosted Runner

Created the workflow:

```text
.github/workflows/self-hosted.yml
```

Workflow tasks:

* Print machine hostname
* Print current working directory
* Create a file
* Verify file creation

The workflow was successfully picked up by the self-hosted runner, confirming that GitHub scheduled the job on my local machine.

---

# Task 5 – Runner Labels

Default labels assigned:

* self-hosted
* macOS
* X64

Labels help GitHub choose the appropriate runner when multiple self-hosted runners are available.

Example:

```yaml
runs-on:
  - self-hosted
  - macOS
```

---

# GitHub-Hosted vs Self-Hosted

| Feature             | GitHub-Hosted                | Self-Hosted                                 |
| ------------------- | ---------------------------- | ------------------------------------------- |
| Managed By          | GitHub                       | User                                        |
| Infrastructure      | GitHub Virtual Machines      | Local Machine / Cloud VM                    |
| Cost                | Included with GitHub minutes | User pays for infrastructure                |
| Pre-installed Tools | Yes                          | User installs required tools                |
| Custom Software     | Limited                      | Fully customizable                          |
| Best Use Cases      | General CI/CD                | Custom environments, GPUs, internal servers |
| Maintenance         | None                         | User responsible                            |
| Security            | Managed by GitHub            | User responsible                            |

---

# Key Learnings

* Learned how GitHub Actions runners execute workflow jobs.
* Explored GitHub-hosted runners across multiple operating systems.
* Verified pre-installed development tools available on hosted runners.
* Configured a self-hosted runner on a local machine.
* Executed workflows using a self-hosted runner.
* Understood how runner labels help target specific machines.
* Compared GitHub-hosted and self-hosted runners based on management, flexibility, and use cases.

---


## Conclusion

GitHub Actions runners provide the execution environment for CI/CD workflows. GitHub-hosted runners offer a managed, ready-to-use environment, while self-hosted runners provide complete control over hardware, software, and configuration. Understanding both options helps in choosing the right runner based on project requirements and infrastructure needs.
