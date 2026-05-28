# Day 13 - Linux Volume Management (LVM)

## Introduction

Today I learned about Linux Volume Management (LVM).
LVM helps manage storage in a flexible way compared to traditional disk partitioning. It allows logical volumes to be resized easily without recreating partitions.

For this task, I created a virtual disk, configured LVM, mounted the filesystem, and extended the storage dynamically.

---

# Step 1 - Checking Current Storage

First, I checked the current disks and filesystem usage in the system.

## Commands Used

```bash id="x90z2d"
lsblk
pvs
vgs
lvs
df -h
```

## What I Observed

* `lsblk` showed available block devices
* `pvs`, `vgs`, and `lvs` showed no existing LVM setup
* `df -h` displayed mounted filesystems and storage usage

---

# Step 2 - Creating a Virtual Disk

Since I did not have an extra disk attached, I created a virtual disk file for practice.

## Commands Used

```bash id="pw3m2q"
dd if=/dev/zero of=/tmp/disk2.img bs=1M count=1024
```

Then I attached it to a loop device.

```bash id="y6uznp"
losetup -f
losetup /dev/loop5 /tmp/disk2.img
losetup -a
```

## What I Learned

Loop devices help simulate real disks in Linux systems.

---

# Step 3 - Creating Physical Volume

Next, I initialized the loop device as a Physical Volume.

## Commands Used

```bash id="o3l6y4"
pvcreate /dev/loop5
pvs
```

## What Happened

The system successfully created the Physical Volume and displayed it in the PV list.

---

# Step 4 - Creating Volume Group

After creating the PV, I created a Volume Group.

## Commands Used

```bash id="siv6qj"
vgcreate devops-vg /dev/loop5
vgs
```

## What I Learned

A Volume Group combines physical storage and acts like a storage pool for Logical Volumes.

---

# Step 5 - Creating Logical Volume

Then I created a Logical Volume from the Volume Group.

## Commands Used

```bash id="bjlwm1"
lvcreate -L 500M -n app-data devops-vg
lvs
```

## What Happened

A 500MB logical volume named `app-data` was successfully created.

---

# Step 6 - Formatting and Mounting

After creating the logical volume, I formatted it using the EXT4 filesystem and mounted it.

## Commands Used

```bash id="u6b12q"
mkfs.ext4 /dev/devops-vg/app-data

mkdir -p /mnt/app-data

mount /dev/devops-vg/app-data /mnt/app-data

df -h /mnt/app-data
```

## What I Observed

The filesystem mounted successfully and storage became available under `/mnt/app-data`.

---

# Step 7 - Extending the Logical Volume

Finally, I extended the storage size dynamically.

## Commands Used

```bash id="8bhp4u"
lvextend -L +200M /dev/devops-vg/app-data

resize2fs /dev/devops-vg/app-data

df -h /mnt/app-data
```

## What Happened

* The logical volume size increased by 200MB
* The filesystem resized successfully
* Storage expansion happened without recreating partitions

---

# Challenges Faced

While doing this assignment, I faced multiple issues:

* Loop device conflicts
* Mounted filesystem errors
* Duplicate Physical Volume UUID warnings

I solved them by:

* Cleaning old loop devices
* Recreating the virtual disk
* Using a fresh loop device

This troubleshooting helped me understand Linux storage management much better.

---

# What I Learned

1. LVM provides flexible storage management in Linux.

2. Logical Volumes can be resized dynamically without data loss.

3. Troubleshooting storage issues is an important Linux administration skill.

---

# Screenshots Added

* lsblk output
* pvcreate output
* vgcreate output
* lvcreate output
* Mounted filesystem output
* Logical volume extension output

---

# Conclusion

This task gave me practical experience with Linux storage management using LVM.
I learned how enterprise systems manage storage dynamically and how Linux administrators handle real-world storage troubleshooting.
