# Day 04 – Linux Practice: Processes and Services
**Date:** 2026-05-19  
**Goal:** Hands-on practice with process inspection, service management, and log reading.

---

## 1. Process Checks

### Command 1: `ps aux` — List all running processes
```bash
$ ps aux --sort=-%cpu | head -10
```
**Output:**
```
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       563 75.0  0.1   7900  4220 ?        R    04:23   0:00 ps aux --sort=-%cpu
root       489 18.4  0.8 1955296 34232 ?       Sl   04:23   0:00 /opt/rclone/rclone-filestore
root         1 16.8  0.1  15408  5888 ?        Sl   04:23   0:01 /process_api --firecracker-init
root        11  0.3  0.0      0     0 ?        I    04:23   0:00 [kworker/0:1-cgroup_offline]
root        14  0.1  0.0      0     0 ?        S    04:23   0:00 [ksoftirqd/0]
```
**What I learned:**
- `ps aux` shows ALL processes for ALL users
- Columns: USER, PID, %CPU, %MEM, STAT (R=running, S=sleeping, I=idle kernel thread)
- Sorted by `-%cpu` so highest CPU consumers appear first
- PID 1 is always the init/root process

---

### Command 2: `top -bn1` — Real-time process snapshot (one-shot)
```bash
$ top -bn1 | head -20
```
**Output:**
```
top - 04:23:14 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00
Tasks:  55 total,   1 running,  54 sleeping,   0 stopped,   0 zombie
%Cpu(s): 16.7 us, 16.7 sy,  0.0 ni, 66.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem :   4003.1 total,   3859.7 free,    219.2 used,     87.4 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   3784.0 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0   15408   5892   2848 S   0.0   0.1   0:01.53 process_a+
    2 root      20   0       0      0      0 S   0.0   0.0   0:00.00 kthreadd
```
**What I learned:**
- `load average: 0.00` = system is idle (1min, 5min, 15min averages)
- `wa = 0.0` = no disk I/O wait — healthy!
- `-bn1` flag: batch mode, 1 iteration — great for scripting/logging
- Zombie processes (Z state) = processes not cleaned up by parent

---

### Command 3: `ps -ef` — Full process tree with parent PIDs
```bash
$ ps -ef | head -15
```
**Output:**
```
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0 11 04:23 ?        00:00:01 /process_api --firecracker-init
root         2     0  0 04:23 ?        00:00:00 [kthreadd]
root         3     2  0 04:23 ?        00:00:00 [pool_workqueue_release]
root        14     2  0 04:23 ?        00:00:00 [ksoftirqd/0]
root        15     2  0 04:23 ?        00:00:00 [rcu_preempt]
```
**What I learned:**
- PPID = Parent Process ID — shows who spawned each process
- `[kthreadd]` (PID 2) = kernel thread daemon, parent of all kernel threads
- Kernel threads shown in `[brackets]`
- PID 1's PPID is 0 (kernel itself)

---

## 2. Service Checks

### Command 4: `systemctl status ssh` — Inspect SSH service
```bash
$ systemctl status ssh
```
> *Note: In this minimal environment, systemd services are not running. On a full Ubuntu/CentOS server this is what you'd see:*

**Expected Output (on a real server):**
```
● ssh.service - OpenBSD Secure Shell server
     Loaded: loaded (/lib/systemd/system/ssh.service; enabled; vendor preset: enabled)
     Active: active (running) since Mon 2026-05-19 09:00:00 IST; 2h 15min ago
   Main PID: 1234 (sshd)
      Tasks: 1 (limit: 4915)
     Memory: 5.2M
        CPU: 102ms
     CGroup: /system.slice/ssh.service
             └─1234 sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
```
**What to look for:**
- `Active: active (running)` = service is healthy ✅
- `Active: failed` = service crashed ❌
- `enabled` = starts automatically on boot
- `Main PID` = the actual process ID of the service

---

### Command 5: `systemctl list-units --type=service --state=running`
```bash
$ systemctl list-units --type=service --state=running
```
**Expected Output (on a real server):**
```
UNIT                        LOAD   ACTIVE SUB     DESCRIPTION
cron.service                loaded active running Regular background program processing daemon
dbus.service                loaded active running D-Bus System Message Bus
docker.service              loaded active running Docker Application Container Engine
networking.service          loaded active running Raise network interfaces
ssh.service                 loaded active running OpenBSD Secure Shell server
```
**What I learned:**
- Lists ONLY services that are currently running (not stopped/failed)
- Use `--state=failed` to see broken services quickly
- Use `--all` to see every service regardless of state

---

## 3. Log Checks

### Command 6: `journalctl -u ssh --since today` — Service-specific logs
```bash
$ journalctl -u ssh --since today
$ journalctl -u ssh -n 50    # last 50 lines of ssh logs
```
**Expected Output (on a real server):**
```
May 19 09:00:01 myserver sshd[1234]: Server listening on 0.0.0.0 port 22.
May 19 09:15:44 myserver sshd[1234]: Accepted publickey for devops from 192.168.1.5 port 51234
May 19 10:02:11 myserver sshd[1234]: Failed password for invalid user admin from 45.33.32.156
```
**What I learned:**
- `journalctl -u <service>` = logs for ONE specific service
- `--since today` filters from midnight today
- `--since "1 hour ago"` = very useful for recent issues
- Failed login attempts visible here → security monitoring!

---

### Command 7: `tail -n 50 /var/log/syslog` — General system logs
```bash
$ tail -n 50 /var/log/syslog
# or on RHEL/CentOS:
$ tail -n 50 /var/log/messages
```
**Expected Output:**
```
May 19 04:23:01 myserver kernel: [    0.000000] Linux version 6.8.0-52-generic
May 19 04:23:01 myserver systemd[1]: Started OpenBSD Secure Shell server.
May 19 04:23:05 myserver CRON[585]: (root) CMD (   cd / && run-parts --report /etc/cron.hourly)
```
**What I learned:**
- `/var/log/syslog` = Ubuntu/Debian. `/var/log/messages` = RHEL/CentOS
- `tail -f /var/log/syslog` = **live** log watching (follow mode) — used constantly in production
- Combine with `grep`: `tail -n 100 /var/log/syslog | grep ERROR`

---

### Command 8 (Bonus): System resource check
```bash
$ uptime
04:23:14 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00

$ free -h
               total        used        free      shared  buff/cache   available
Mem:           3.9Gi       219Mi       3.8Gi       4.2Mi        87Mi       3.7Gi
Swap:             0B          0B          0B         0B

$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda        252G  8.6G   10G  47% /
```
**What I learned:**
- `free -h`: human-readable memory. `buff/cache` is reusable by OS — not really "used"
- `df -h`: disk usage. Watch for `Use%` above 85% — that's a production alert!
- `uptime`: load average above `(number of CPUs)` = system overloaded

---

## 4. Mini Troubleshooting Flow

**Scenario:** SSH service is not responding. What do I check?

```bash
# Step 1: Is the service running?
systemctl status ssh

# Step 2: If failed, check WHY it failed
journalctl -u ssh -n 50 --no-pager

# Step 3: Try to restart it
sudo systemctl restart ssh

# Step 4: Check if it came back up
systemctl is-active ssh

# Step 5: Check if port 22 is listening
ss -tlnp | grep :22
# or
netstat -tlnp | grep :22

# Step 6: Check system resources (maybe OOM killed it?)
free -h
dmesg | tail -20 | grep -i kill
```

**Decision tree:**
```
Service down?
├── Active: failed  →  journalctl -u <service> → find the error → fix config → restart
├── Active: inactive → systemctl start <service> → check status again
└── Active: running but not responding → check port with ss/netstat → check firewall
```

---

## Key Commands Summary

| Command | Purpose |
|---|---|
| `ps aux` | All processes, sorted by CPU |
| `top -bn1` | One-shot live system snapshot |
| `ps -ef` | Full process tree with PPIDs |
| `pgrep <name>` | Find PID of a process by name |
| `systemctl status <svc>` | Service health + recent logs |
| `systemctl list-units --type=service` | All running services |
| `journalctl -u <svc> -n 50` | Last 50 lines of service logs |
| `tail -f /var/log/syslog` | Live system log stream |
| `free -h` | Memory usage |
| `df -h` | Disk usage |

---

## What I Learned Today

1. `ps aux` and `top` are my first tools when something feels slow
2. Always check `journalctl -u <service>` before restarting anything — know WHY it failed
3. `tail -f` is your live window into what the system is doing right now
4. Load average > number of CPUs = investigate immediately
5. `systemctl status` gives you the last few log lines inline — very convenient