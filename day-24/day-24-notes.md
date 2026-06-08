# Day 24 - Advanced Git

## Git Merge

### What is a Fast-Forward Merge?
A fast-forward merge happens when the target branch has no new commits. Git simply moves the branch pointer forward.

### When does Git create a Merge Commit?
Git creates a merge commit when both branches have new commits and histories diverge.

### What is a Merge Conflict?
A merge conflict occurs when Git cannot automatically determine which changes to keep because the same part of a file was modified in different branches.

---

## Git Rebase

### What does Rebase do?
Rebase moves commits from one branch and replays them on top of another branch.

### How is Rebase different from Merge?
Rebase creates a linear history while merge preserves branch history with merge commits.

### Why should you not rebase shared commits?
Rebasing changes commit hashes and can create confusion for collaborators.

### When to use Rebase vs Merge?
Use rebase for clean history before merging and merge when preserving branch history is important.

---

## Squash Merge

### What does Squash Merge do?
Combines multiple commits into a single commit before merging.

### When would you use it?
When a feature branch contains many small commits that do not need to appear individually.

### Trade-off
Cleaner history but loss of detailed commit history.

---

## Git Stash

### Difference between stash pop and stash apply
stash pop applies and removes the stash.
stash apply applies but keeps the stash.

### Real-world use
Useful when switching tasks without committing incomplete work.

---

## Cherry Pick

### What does Cherry Pick do?
Applies a specific commit from one branch onto another branch.

### Real-world use
Useful for moving bug fixes without merging an entire branch.

### What can go wrong?
Conflicts, duplicate commits, and confusing history.