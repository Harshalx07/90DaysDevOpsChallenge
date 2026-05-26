# File Ownership Challenge (chown & chgrp)

## Users Created
- tokyo
- berlin
- nairobi
- professor

## Groups Created
- heist-team
- planners
- vault-team
- tech-team

## Files & Directories Created
- devops-file.txt
- app-logs/
- bank-heist/access-codes.txt
- bank-heist/blueprints.pdf
- bank-heist/escape-plan.txt
- heist-project/plans/strategy.conf
- heist-project/vault/gold.txt
- project-config.yaml
- team-notes.txt

---

## Understanding Ownership

- Run `ls -l` in your home directory
- Identify the owner and group columns
- Check who owns your files

```bash
ls -l
```

### Difference Between Owner and Group

- Owner: The owner is usually the user who created the file or directory. The owner can modify file permissions.
- Group: A group is a collection of users who share access permissions to files and directories.

---

## Basic chown Operations

### Create File

```bash
touch devops-file.txt
```

### Check Current Owner

```bash
ls -l devops-file.txt
```

### Change Owner to tokyo

```bash
sudo chown tokyo devops-file.txt
```

### Change Owner to berlin

```bash
sudo chown berlin devops-file.txt
```

### Verify Changes

```bash
ls -l devops-file.txt
```

---

## Basic chgrp Operations

### Create File

```bash
touch team-notes.txt
```

### Check Current Group

```bash
ls -l team-notes.txt
```

### Create Group

```bash
sudo groupadd heist-team
```

### Change Group

```bash
sudo chgrp heist-team team-notes.txt
```

### Verify Change

```bash
ls -l team-notes.txt
```

---

## Combined Owner & Group Change

Using `chown` you can change both owner and group together.

### Create File

```bash
touch project-config.yaml
```

### Change Owner and Group

```bash
sudo chown professor:heist-team project-config.yaml
```

### Create Directory

```bash
mkdir app-logs
```

### Change Directory Ownership

```bash
sudo chown berlin:heist-team app-logs
```

### Verify

```bash
ls -ld app-logs
```

---

## Recursive Ownership

### Create Directory Structure

```bash
mkdir -p heist-project/vault
mkdir -p heist-project/plans

touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf
```

### Create Group

```bash
sudo groupadd planners
```

### Recursive Ownership Change

```bash
sudo chown -R professor:planners heist-project/
```

### Verify Recursively

```bash
ls -lR heist-project/
```

---

## Practice Challenge

### Create Directory

```bash
mkdir bank-heist
```

### Create Files

```bash
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt
```

### Assign Ownership

```bash
sudo chown tokyo:vault-team bank-heist/access-codes.txt
```

```bash
sudo chown berlin:tech-team bank-heist/blueprints.pdf
```

```bash
sudo chown nairobi:vault-team bank-heist/escape-plan.txt
```

### Verify Ownership

```bash
ls -l bank-heist/
```

---

## Commands Used

### View Ownership

```bash
ls -l filename
```

### Change Owner Only

```bash
sudo chown newowner filename
```

### Change Group Only

```bash
sudo chgrp newgroup filename
```

### Change Both Owner and Group

```bash
sudo chown owner:group filename
```

### Recursive Ownership Change

```bash
sudo chown -R owner:group directory/
```

### Change Only Group Using chown

```bash
sudo chown :groupname filename
```

---

## What I Learned

- Managing Linux users and groups
- Understanding file ownership and permissions
- Using `chown` to change ownership
- Using `chgrp` to change groups
- Applying recursive ownership changes with `-R`
- Importance of ownership in DevOps environments

---

## Why File Ownership Matters in DevOps

- Secure application deployments
- Shared team collaboration
- Managing CI/CD pipeline artifacts
- Container and Docker permissions
- Log file management
- Server security and access control