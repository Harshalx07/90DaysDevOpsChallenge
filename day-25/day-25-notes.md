# Day 25 – Git Reset vs Revert & Branching Strategies

## Task 1: Git Reset

### What happens with `git reset --soft`?

- Moves HEAD back one commit.
- Removes commit from history.
- Keeps all changes staged.
- Ready to commit again.

### What happens with `git reset --mixed`?

- Moves HEAD back one commit.
- Removes commit from history.
- Keeps changes in working directory.
- Changes become unstaged.

### What happens with `git reset --hard`?

- Moves HEAD back one commit.
- Removes commit from history.
- Deletes all changes permanently.

### Difference Between `--soft`, `--mixed`, and `--hard`

- `--soft` → Removes commit but keeps changes staged.
- `--mixed` → Removes commit and keeps changes unstaged.
- `--hard` → Removes commit and deletes changes completely.

### Which One Is Destructive?

- `git reset --hard`
- Permanently removes commits and working directory changes.

### When Would You Use Each One?

- `--soft` → Modify commit message or combine commits.
- `--mixed` → Reorganize files before committing again.
- `--hard` → Discard unwanted local changes.

### Should You Use Reset on Pushed Commits?

- No.
- It rewrites history and can cause conflicts for collaborators.

---

## Task 2: Git Revert

### What Happens When Reverting Commit Y?

- Git creates a new commit.
- The new commit reverses the changes made by commit Y.
- Commit Y remains in history.

### Is Commit Y Still in History?

- Yes.
- Git Revert preserves history.

### Difference Between Reset and Revert

- `git reset` rewrites history and removes commits.
- `git revert` preserves history and creates an undo commit.

### Why Is Revert Safer?

- History remains intact.
- Safe for shared repositories.
- No force push required.

### When To Use Revert vs Reset?

- Use Revert for shared or pushed commits.
- Use Reset for local commits that haven't been pushed.

---

## Task 3: Reset vs Revert Comparison

| Feature | git reset | git revert |
|----------|-----------|------------|
| What it does | Rewrites history and removes commits | Creates a new commit that undoes changes |
| Removes commit history | Yes | No |
| Creates new commit | No | Yes |
| Safe for shared branches | No | Yes |
| Best use case | Local cleanup | Undo pushed commits |

---

## Task 4: Branching Strategies

### GitFlow
![alt text](gitflow.jpg)
#### How It Works

- `main` contains production-ready code.
- `develop` contains latest development work.
- `feature/*` branches are created from develop.
- `release/*` branches prepare releases.
- `hotfix/*` branches fix production issues.

#### Pros

- Structured workflow.
- Clear release process.
- Suitable for large teams.

#### Cons

- Complex.
- More branch management.

#### Used For

- Enterprise teams.
- Scheduled releases.

### GitHub Flow

#### How It Works

- Single `main` branch.
- Create feature branch.
- Open Pull Request.
- Review and merge back to main.

#### Pros

- Simple.
- Fast deployment.
- Easy to learn.

#### Cons

- Less release control.

#### Used For

- Startups.
- Continuous deployment.

### Trunk-Based Development

#### How It Works

- Developers work on short-lived branches.
- Merge changes frequently into main.
- Main branch always stays deployable.

#### Pros

- Fast development.
- Supports CI/CD.
- Fewer merge conflicts.

#### Cons

- Requires strong testing.

#### Used For

- DevOps teams.
- Fast-moving projects.

---

## Answers

### Which Strategy Would You Use for a Startup Shipping Fast?

**Trunk-Based Development**

Reason:
- Fast feedback.
- Rapid delivery.
- Minimal branching overhead.

### Which Strategy Would You Use for a Large Team with Scheduled Releases?

**GitFlow**

Reason:
- Better release management.
- Clear separation of development and production.

### Which Strategy Does an Open Source Project Use?

**Kubernetes**

- Uses a Trunk-Based/GitHub Flow style workflow.
- Main branch for active development.
- Release branches for stable versions.

---

## Git Reflog

### What Is Git Reflog?

- Records all HEAD movements.
- Tracks resets, commits, checkouts, and merges.

### Why Is It Useful?

- Recover lost commits.
- Undo accidental hard resets.
- Restore deleted work.

### Example

```bash
git reflog
git reset --hard HEAD@{1}