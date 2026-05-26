# RUNBOOK for Docker Service

This runbook provides quick troubleshooting steps if the Docker service goes down or becomes slow.

---

# Environment Basics

## Command : uname -a

Output :
Linux ip-172-31-40-205 6.17.0-1012-aws #12~24.04.1-Ubuntu SMP Mon Apr 6 17:36:28 UTC 2026 x86_64 x86_64 x86_64 GNU/Linux

Observation :
Kernel version and system architecture confirmed.

---

## Command : cat /etc/os-release

Output :
PRETTY_NAME="Ubuntu 24.04.4 LTS"

Observation :
Ubuntu distribution and version verified.

---

# Filesystem Sanity

## Command : mkdir /tmp/runbook-demo

Observation :
Temporary directory created successfully.

---

## Command : cp /etc/hosts /tmp/runbook-demo/hosts-copy && ls -l /tmp/runbook-demo

Output :
-rw-r--r-- 1 ubuntu ubuntu 221 May 20 05:36 hosts-copy

Observation :
File copied successfully. Filesystem is writable.

---

# CPU / Memory

## Command : top

Observation :
CPU usage normal and system load healthy. No abnormal resource spikes detected.

---

## Command : free -h

Output :
Mem: 911Mi total, 379Mi used, 203Mi free, 531Mi available

Observation :
Enough memory available and no swap usage detected.

---

## Command : ps aux | grep docker

Output :
root        7036  0.7  8.1 1908936 76284 ?       Ssl  05:42   0:00 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

Observation :
Docker daemon is running successfully with stable CPU and memory usage.

---

# Disk / IO

## Command : df -h

Output :
/dev/root 19G 2.1G 17G 12% /

Observation :
Disk space healthy with enough free storage available.

---

## Command : sudo du -sh /var/log

Output :
17M /var/log

Observation :
Log directory size is normal.

---

# Network

## Command : ss -tulpn

Observation :
System ports are active and listening properly.

---

## Command : curl -I [http://localhost](http://localhost)

Output :
curl: (7) Failed to connect to localhost port 80

Observation :
No web service currently running on port 80.

---

# Logs

## Command : journalctl -u docker -n 50

Observation :
Docker service logs checked successfully. No critical errors found.

---

## Command : tail -n 50 /var/log/syslog

Observation :
System logs showing normal network and service activity.

---

# Quick Review

* Docker service running normally
* CPU and memory usage healthy
* Disk space available
* No major log errors found
* Network ports responding correctly

---

# If This Worsens

## Restart Docker Service

```bash id="4s3hgj"
sudo systemctl restart docker
```

---

## Monitor Live Logs

```bash id="2p9w7n"
sudo journalctl -u docker -f
```

---

## Check Docker Process

```bash id="xv9m1d"
ps aux | grep docker
```

---

## Check Port Usage

```bash id="7m3a2k"
ss -tulpn
```

---

# Conclusion

Today I practiced:

* Linux troubleshooting
* CPU and memory monitoring
* Disk usage checking
* Network troubleshooting
* Log analysis

This helped me understand a basic troubleshooting workflow used in DevOps and production environments.
