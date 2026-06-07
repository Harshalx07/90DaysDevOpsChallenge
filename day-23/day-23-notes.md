# Day 23 – Git Branching & Working with GitHub

## What is a branch in Git?

A branch is an independent line of development in Git. It allows developers to work on new features, bug fixes, and experiments without affecting the main codebase.

## Why do we use branches instead of committing everything to main?

Branches help keep the main branch stable. Developers can work on features separately, test them, and merge them into main only when they are ready.

## What is HEAD in Git?

HEAD is a pointer that refers to the current branch and the latest commit you are working on.

## What happens to your files when you switch branches?

Git updates your working directory to match the selected branch. Files and changes specific to that branch become visible.

## Branching Commands Used

### List all branches

```bash
git branch
```

### Create a branch

```bash
git branch feature-1
```

### Switch to a branch

```bash
git switch feature-1
```

### Create and switch in one command

```bash
git switch -c feature-2
```

### Delete a branch

```bash
git branch -d feature-2
```

### Force delete a branch

```bash
git branch -D feature-2
```

## Difference Between git switch and git checkout

`git switch` is used specifically for switching branches.

`git checkout` can switch branches, restore files, and move to specific commits.

`git switch` is the newer and safer command.

## What is the difference between origin and upstream?

**origin** is the remote repository that you own or cloned from.

**upstream** is the original repository from which a fork was created.

## What is the difference between git fetch and git pull?

**git fetch** downloads changes from the remote repository but does not merge them into the current branch.

**git pull** downloads changes and automatically merges them into the current branch.

## What is the difference between clone and fork?

**Clone** creates a local copy of a repository on your machine.

**Fork** creates a copy of someone else's repository under your GitHub account.

## When would you clone vs fork?

Clone a repository when you have direct access to it and want a local copy.

Fork a repository when you want to contribute to a project without direct write access.

## After forking, how do you keep your fork in sync with the original repository?

Add the original repository as an upstream remote and periodically fetch and merge changes from upstream.

```bash
git remote add upstream <repository-url>
git fetch upstream
git merge upstream/main
```

## GitHub Push Commands

### Add remote repository

```bash
git remote add origin <repository-url>
```

### Push main branch

```bash
git push -u origin main
```

### Push feature branch

```bash
git push -u origin feature-1
```

## Learning Outcome

Today I learned:

* Git branching fundamentals
* Creating and switching branches
* Understanding HEAD
* Working with feature branches
* Pushing branches to GitHub
* Pulling changes from GitHub
* Difference between fetch and pull
* Difference between clone and fork
* Managing upstream repositories
* Real-world Git workflow used by DevOps engineers
