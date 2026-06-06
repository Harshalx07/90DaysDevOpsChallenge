# Git Local Setup

## Check Git Installation

Verify that Git is installed on your system:

```bash
git --version
```

## Install Git (Ubuntu/Debian)

Update package lists and install Git:

```bash
sudo apt update
sudo apt install git -y
```

Verify installation:

```bash
git --version
```

## Configure Git Identity

Set your Git username and email globally:

```bash
git config --global user.name "Harshal Galande"
git config --global user.email "harshalgalande9@gmail.com"
```

Verify your configuration:

```bash
git config --list
```

---

# Essential Git Commands

| Command                        | Description                                                         | Example                                      |
| ------------------------------ | ------------------------------------------------------------------- | -------------------------------------------- |
| `git init`                     | Initialize a new Git repository in the current directory            | `git init`                                   |
| `git clone <repository-url>`   | Create a local copy of a remote repository                          | `git clone https://github.com/user/repo.git` |
| `git status`                   | Display the current state of the working directory and staging area | `git status`                                 |
| `git add <file>`               | Stage a specific file for commit                                    | `git add demo.txt`                           |
| `git add .`                    | Stage all modified and new files                                    | `git add .`                                  |
| `git commit -m "message"`      | Save staged changes with a descriptive message                      | `git commit -m "Add login script"`           |
| `git log`                      | Display detailed commit history                                     | `git log`                                    |
| `git log --oneline`            | Show compact commit history                                         | `git log --oneline`                          |
| `git diff`                     | Show unstaged changes                                               | `git diff`                                   |
| `git diff --staged`            | Show staged changes before commit                                   | `git diff --staged`                          |
| `git reset <file>`             | Remove a file from the staging area                                 | `git reset demo.txt`                         |
| `git restore <file>`           | Discard changes in a file                                           | `git restore demo.txt`                       |
| `git rm <file>`                | Remove a file from Git tracking and local system                    | `git rm demo.txt`                            |
| `git branch`                   | List all local branches                                             | `git branch`                                 |
| `git branch <branch-name>`     | Create a new branch                                                 | `git branch feature-login`                   |
| `git checkout <branch>`        | Switch to another branch                                            | `git checkout main`                          |
| `git checkout -b <branch>`     | Create and switch to a new branch                                   | `git checkout -b feature-login`              |
| `git merge <branch>`           | Merge another branch into current branch                            | `git merge feature-login`                    |
| `git remote -v`                | Show configured remote repositories                                 | `git remote -v`                              |
| `git remote add origin <url>`  | Connect local repository to a remote repository                     | `git remote add origin <repo-url>`           |
| `git push origin <branch>`     | Push commits to remote repository                                   | `git push origin main`                       |
| `git pull origin <branch>`     | Fetch and merge latest remote changes                               | `git pull origin main`                       |
| `git fetch`                    | Download changes without merging                                    | `git fetch`                                  |
| `git revert <commit-id>`       | Create a new commit that reverses a previous commit                 | `git revert 4ae73`                           |
| `git reset --soft <commit-id>` | Move HEAD while keeping staged changes                              | `git reset --soft 4ae73`                     |
| `git reset --hard <commit-id>` | Reset repository and discard all changes after commit               | `git reset --hard 4ae73`                     |

---

# Common Git Workflow

## 1. Initialize Repository

```bash
git init
```

## 2. Check Repository Status

```bash
git status
```

## 3. Stage Changes

```bash
git add .
```

## 4. Commit Changes

```bash
git commit -m "Initial commit"
```

## 5. View Commit History

```bash
git log --oneline
```

## 6. Connect to GitHub

```bash
git remote add origin https://github.com/username/repository.git
```

## 7. Push Code

```bash
git push -u origin main
```

---

# Git Areas Explained

### Working Directory

Files you are currently editing.

### Staging Area

Temporary area where changes are prepared before committing.

### Repository

Permanent Git history containing all commits and versions of the project.

---

# Useful Commands for Beginners

```bash
git status
git add .
git commit -m "message"
git log --oneline
git diff
git branch
git checkout branch-name
git pull
git push
```

These commands cover 90% of day-to-day Git usage for most DevOps engineers.
