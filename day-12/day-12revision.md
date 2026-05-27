# Day 12 – Revision & Reinforcement

Today was a light revision day to strengthen the Linux and DevOps basics I learned in the last 11 days.  
Instead of learning something new, I focused on repeating important commands and understanding them better.

---

# Revision Goals

- Revise Linux basics from Days 01–11
- Improve command confidence
- Practice permissions and ownership again
- Refresh service troubleshooting commands

---

# Processes & Services Revision

## Commands Practiced

```bash
ps aux
```

Used to check all running processes in the system.

```bash
systemctl status ssh
```

Checked whether the SSH service was active and healthy.

```bash
journalctl -u ssh
```

Viewed logs related to the SSH service for troubleshooting practice.

## What I Observed

- `ps aux` gives detailed information about active processes.
- `systemctl status` is one of the fastest ways to verify service health.
- `journalctl` helps understand service activity and errors.

---

# File Operations Practice

## Commands Practiced

```bash
echo "DevOps Revision Day" >> notes.txt
```

Added text into a file using append redirection.

```bash
chmod 755 script.sh
```

Changed file permissions to make the script executable.

```bash
ls -l
```

Verified permissions and ownership details.

```bash
cp notes.txt backup-notes.txt
```

Created a backup copy of a file.

```bash
mkdir revision-practice
```

Created a new directory for practice.

---

# User & Group Management Revision

## Scenario Practiced

```bash
sudo useradd devuser
```

Created a new user.

```bash
sudo passwd devuser
```

Assigned a password to the user.

```bash
id devuser
```

Verified the user ID and group details.

```bash
sudo chown devuser:devuser notes.txt
```

Changed ownership of a file.

```bash
ls -l
```

Confirmed the ownership changes.

## Observation

I understood better how ownership and permissions work together in Linux.

---

# Cheat Sheet Refresh

## 5 Commands I Would Use First During an Incident

### 1. ps aux
To quickly inspect running processes.

### 2. top
To monitor CPU and memory usage live.

### 3. systemctl status
To verify whether a service is running correctly.

### 4. journalctl -xe
To investigate logs and system errors.

### 5. ls -l
To check file permissions and ownership.

---

# Mini Self-Check

## Which 3 commands save me the most time right now?

### 1. ls -l
Quickly helps me verify permissions and ownership.

### 2. systemctl status
Very useful for checking service health instantly.

### 3. ps aux
Helps identify running processes and troubleshoot quickly.

---

## How do I check if a service is healthy?

Commands I would run first:

```bash
systemctl status nginx
```

```bash
journalctl -u nginx
```

```bash
ps aux | grep nginx
```

---

## How do I safely change ownership and permissions?

Example:

```bash
sudo chown ubuntu:ubuntu app.log
```

```bash
chmod 644 app.log
```

I first verify permissions using `ls -l` and avoid giving unnecessary permissions like `777`.

---

# Focus Areas For The Next 3 Days

- Improve Linux troubleshooting skills
- Practice permissions more confidently
- Learn more about SSH and networking
- Reduce dependency on notes while using commands

---

# Key Takeaways

- Revision is important for retention.
- Repeating commands improves confidence.
- Understanding logs and permissions is very important in DevOps.
- Small daily practice is helping me become more comfortable with Linux.