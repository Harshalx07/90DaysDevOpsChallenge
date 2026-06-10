# Day 26 - GitHub CLI

## Task 1: Authentication

### Authentication Methods Supported
- Browser OAuth
- Personal Access Token
- SSH
- HTTPS
- GitHub Enterprise

## Task 2: Repository Management

### Commands Used
- gh repo create
- gh repo view
- gh repo list
- gh repo clone
- gh repo delete

### Observations
GitHub repositories can be created and managed directly from the terminal without opening a browser.

## Task 3: Issues

### Commands Used
- gh issue create
- gh issue list
- gh issue view
- gh issue close

### How gh issue can be used in automation
- Auto-create bug reports
- Create monitoring alerts
- Generate maintenance tasks
- Track CI/CD failures

## Task 4: Pull Requests

### Commands Used
- gh pr create
- gh pr list
- gh pr view
- gh pr checks
- gh pr merge

### Merge Methods Supported
- Merge Commit
- Squash Merge
- Rebase Merge

### Reviewing Someone Else's PR
- gh pr checkout
- gh pr review --approve
- gh pr review --comment
- gh pr review --request-changes

## Task 5: GitHub Actions

### Commands Used
- gh run list
- gh run view

### CI/CD Benefits
- Monitor builds
- Check deployment status
- View logs
- Re-run workflows
- Automate release pipelines

## Task 6: Useful Commands

- gh api
- gh gist
- gh release
- gh alias
- gh search repos

## Key Takeaway

GitHub CLI allows complete repository, issue, pull request, and workflow management directly from the terminal, making it a powerful tool for DevOps automation and CI/CD workflows.