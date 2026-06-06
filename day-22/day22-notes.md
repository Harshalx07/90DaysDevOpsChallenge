# Day 22 Notes

## What is the difference between git add and git commit?

git add moves changes into the staging area. git commit saves staged changes permanently into Git history.

## What does the staging area do? Why doesn't Git just commit directly?

The staging area allows developers to choose exactly which changes should be included in the next commit. This gives more control over commit history.

## What information does git log show you?

git log shows commit IDs, author information, dates, and commit messages.

## What is the .git/ folder and what happens if you delete it?

The .git folder stores all repository history, branches, commits, and configuration. If deleted, Git no longer recognizes the project as a repository.

## What is the difference between a working directory, staging area, and repository?

Working Directory:
Where files are edited.

Staging Area:
Temporary area where selected changes wait before commit.

Repository:
Permanent Git history containing all commits.