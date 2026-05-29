# Day 14 - Networking Fundamentals & Hands-on Checks

## Quick Concepts

### OSI Model vs TCP/IP

* OSI has 7 layers from Physical to Application.
* TCP/IP simplifies networking into 4 layers: Link, Internet, Transport, and Application.

### Protocol Placement

* IP works at the Internet layer.
* TCP and UDP work at the Transport layer.
* HTTP/HTTPS and DNS work at the Application layer.

### Real Example

* `curl https://google.com`
* Application Layer (HTTP/HTTPS) → TCP → IP → Network Link

---

## Hands-on Checklist

### Identity Check

```bash
hostname -I
```

Observation:

* My system IP address is: `<YOUR_IP>`
![alt text](<Screenshot 2026-05-29 at 8.25.05 PM.png>)

### Reachability Test

```bash
ping -c 4 google.com
```

Observation:

* Average latency: `<LATENCY>`
* Packet loss: `<LOSS>`
![alt text](<Screenshot 2026-05-29 at 8.25.34 PM.png>)
### Path Discovery

```bash
tracepath google.com
```

Observation:

* Multiple network hops observed.
* Some hops may not respond due to firewall restrictions.
![alt text](<Screenshot 2026-05-29 at 8.25.45 PM.png>)

### Listening Services

```bash
ss -tulpn
```

Observation:

* SSH service listening on port 22.
![alt text](<Screenshot 2026-05-29 at 8.27.10 PM.png>)

### DNS Resolution

```bash
dig google.com
```

Observation:

* Domain successfully resolved to an IP address.

![alt text](<Screenshot 2026-05-29 at 8.26.15 PM.png>)
### HTTP Check

```bash
curl -I https://google.com
```

Observation:

* HTTP status code received successfully.
![alt text](<Screenshot 2026-05-29 at 8.26.33 PM.png>)

### Connections Snapshot

```bash
netstat -an | head
```

Observation:

* Active LISTEN and ESTABLISHED connections observed.
![alt text](<Screenshot 2026-05-29 at 8.26.48 PM.png>)

---

## Mini Task: Port Probe

```bash
nc -zv localhost 22
```

Observation:

* SSH port is reachable.
* If unreachable, check service status and firewall configuration.
![alt text](<Screenshot 2026-05-29 at 8.27.21 PM.png>)

---

## Reflection

### Fastest Command for Troubleshooting

* ping provides the quickest indication of connectivity issues.

### If DNS Fails

* Inspect the Application layer and DNS configuration.

### If HTTP 500 Appears

* Inspect the Application layer and web server logs.

### Two Follow-up Checks

1. Verify service status using systemctl.
2. Check firewall rules and network logs.

---

## Key Learnings

* Learned how networking layers relate to real-world traffic.
* Used essential troubleshooting commands.
* Verified connectivity, DNS, ports, and HTTP responses.
