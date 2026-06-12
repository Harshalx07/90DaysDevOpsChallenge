# Day 28 - Revision Day (Days 1 to 27)

## Overview

Today was dedicated entirely to revision. Instead of learning new concepts, I reviewed all the topics covered during the first 27 days of my DevOps journey. The goal was to identify weak areas, strengthen my understanding, and ensure that I can confidently explain and apply the concepts learned so far.

---

# Self Assessment Checklist

## Linux

| Topic                              | Status             |
| ---------------------------------- | ------------------ |
| File System Navigation             | Can do confidently |
| Process Management                 | Can do confidently |
| Systemd Services                   | Can do confidently |
| Text Editors (Vim/Nano)            | Can do confidently |
| CPU, Memory & Disk Troubleshooting | Need to revisit    |
| Linux File System Hierarchy        | Can do confidently |
| Users and Groups                   | Can do confidently |
| File Permissions                   | Can do confidently |
| Ownership Management               | Can do confidently |
| LVM Management                     | Need to revisit    |
| Network Troubleshooting            | Can do confidently |
| DNS, IP Addressing & Subnets       | Need to revisit    |

### Linux Reflection

Linux has become much more comfortable compared to Day 1. Basic navigation, file manipulation, service management, and permissions now feel natural. However, advanced troubleshooting and storage management still require additional practice.

---

## Shell Scripting

| Topic                  | Status             |
| ---------------------- | ------------------ |
| Variables & Arguments  | Can do confidently |
| Conditional Statements | Can do confidently |
| Loops                  | Can do confidently |
| Functions              | Can do confidently |
| Text Processing Tools  | Can do confidently |
| Error Handling         | Need to revisit    |
| Crontab Automation     | Can do confidently |

### Shell Scripting Reflection

Writing scripts is becoming easier, especially for automation tasks. Error handling and creating production-ready scripts still need more hands-on practice.

---

## Git & GitHub

| Topic                  | Status             |
| ---------------------- | ------------------ |
| Repository Management  | Can do confidently |
| Branching              | Can do confidently |
| Push & Pull Operations | Can do confidently |
| Clone vs Fork          | Can do confidently |
| Merge Strategies       | Can do confidently |
| Rebase                 | Need to revisit    |
| Stash                  | Can do confidently |
| Cherry Pick            | Can do confidently |
| Squash Merge           | Need to revisit    |
| Reset & Revert         | Need to revisit    |
| Branching Strategies   | Can do confidently |
| GitHub CLI             | Can do confidently |

### Git Reflection

Git fundamentals are strong, but advanced history manipulation commands such as reset, revert, rebase, and squash merges require more revision to avoid mistakes in real-world projects.

---

# Topics Revisited

## 1. Logical Volume Manager (LVM)

### What I Reviewed

LVM provides flexible storage management compared to traditional disk partitions.

Key components:

* Physical Volume (PV)
* Volume Group (VG)
* Logical Volume (LV)

### Important Commands

```bash
pvcreate /dev/sdb
vgcreate data_vg /dev/sdb
lvcreate -L 5G -n app_lv data_vg
lvdisplay
```

### What I Learned Again

* Storage can be extended without repartitioning disks.
* Multiple disks can be combined into one volume group.
* Logical volumes can be resized dynamically.
* LVM is widely used in enterprise Linux environments.

---

## 2. Shell Script Error Handling

### What I Reviewed

Reliable scripts should fail safely when unexpected situations occur.

### Important Options

```bash
set -e
set -u
set -o pipefail
```

### Example

```bash
#!/bin/bash

set -euo pipefail

echo "Starting script"
cp file.txt backup/
echo "Completed"
```

### What I Learned Again

* `set -e` exits when a command fails.
* `set -u` prevents undefined variables.
* `pipefail` catches failures inside pipelines.
* `trap` can be used for cleanup actions.

---

## 3. Git Reset vs Git Revert

### Git Reset

Moves the branch pointer backward.

```bash
git reset --hard HEAD~1
```

Effects:

* Removes commits from history.
* Can delete local changes.
* Dangerous on shared branches.

### Git Revert

Creates a new commit that undoes previous changes.

```bash
git revert HEAD
```

Effects:

* Preserves commit history.
* Safe for collaborative projects.
* Recommended for public branches.

### What I Learned Again

Always prefer `git revert` when working with team members and shared repositories.

---

# Quick Fire Questions

## What does chmod 755 script.sh do?

Owner receives read, write, and execute permissions.

Group and others receive read and execute permissions.

Permission breakdown:

```text
7 = rwx
5 = r-x
5 = r-x
```

---

## Difference Between a Process and a Service

A process is any running program currently executing on the system.

A service is a background process managed by the operating system, usually through systemd.

Example:

* Process: Running Vim editor
* Service: Nginx web server

---

## How Do You Find Which Process Is Using Port 8080?

```bash
sudo ss -tulpn | grep 8080
```

Alternative:

```bash
sudo lsof -i :8080
```

---

## What Does set -euo pipefail Do?

It makes shell scripts safer by:

* Exiting on command failures
* Detecting undefined variables
* Catching pipeline failures

---

## Difference Between git reset --hard and git revert

| git reset --hard | git revert              |
| ---------------- | ----------------------- |
| Rewrites history | Preserves history       |
| Removes commits  | Creates new undo commit |
| Risky in teams   | Safe in teams           |

---

## Recommended Branching Strategy for 5 Developers Shipping Weekly

GitHub Flow is a practical choice.

Reasons:

* Simple workflow
* Faster releases
* Easier pull request reviews
* Minimal branching complexity

---

## What Does git stash Do?

Temporarily stores uncommitted changes without creating a commit.

Useful when:

* Switching branches
* Pulling urgent fixes
* Testing another feature

Commands:

```bash
git stash
git stash list
git stash pop
```

---

## Run a Script Every Day at 3 AM

```bash
crontab -e
```

Add:

```bash
0 3 * * * /home/user/backup.sh
```

---

## Difference Between git fetch and git pull

### Git Fetch

Downloads changes only.

```bash
git fetch
```

### Git Pull

Downloads and merges changes.

```bash
git pull
```

---

## What is LVM?

LVM (Logical Volume Manager) is a storage management system that provides flexible disk allocation, resizing, and management compared to traditional partitions.

Benefits:

* Easy storage expansion
* Better disk utilization
* Snapshot support
* Enterprise-ready storage management

---

# Teach It Back

## Explaining File Permissions to a New Linux User

Every file and directory in Linux has permissions that determine who can read, write, or execute it. Permissions are divided into three categories: owner, group, and others. Each category can have read (r), write (w), and execute (x) permissions. Commands like `chmod` modify permissions, while `chown` changes ownership. Understanding permissions is essential because they help secure files and control access within multi-user environments.

---

# Key Takeaways

* Linux fundamentals are becoming second nature.
* Git confidence has increased significantly.
* Shell scripting is becoming more practical for automation tasks.
* LVM and advanced Git operations need additional practice.
* Revision helped expose knowledge gaps that were hidden during daily learning.

## Progress Summary

Completed 28 days of consistent DevOps learning.

Current focus areas:

1. Advanced Linux troubleshooting
2. LVM administration
3. Git history management
4. Production-grade shell scripting

The journey continues toward becoming a skilled DevOps Engineer through consistent practice and hands-on learning.
