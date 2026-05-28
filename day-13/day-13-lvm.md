# Day 13 – Linux Volume Management (LVM)

## Objective

Learn Linux LVM concepts by creating Physical Volumes, Volume Groups, Logical Volumes, and dynamically extending storage.

---

# Step 1: Check Existing Storage

## Commands Used

```bash id="4eqz1j"
lsblk
pvs
vgs
lvs
df -h
```

## Purpose

Checked current block devices, mounted filesystems, and existing LVM configuration.

---

# Step 2: Create Virtual Disk

## Commands Used

```bash id="n8v95x"
dd if=/dev/zero of=/tmp/disk2.img bs=1M count=1024
losetup -f
losetup /dev/loop5 /tmp/disk2.img
losetup -a
```

## Purpose

Created a 1GB virtual disk and attached it to a loop device for LVM practice.

---

# Step 3: Create Physical Volume (PV)

## Commands Used

```bash id="kdm97f"
pvcreate /dev/loop5
pvs
```

## Purpose

Initialized the loop device as a Physical Volume.

---

# Step 4: Create Volume Group (VG)

## Commands Used

```bash id="4ep5es"
vgcreate devops-vg /dev/loop5
vgs
```

## Purpose

Created a Volume Group named `devops-vg`.

---

# Step 5: Create Logical Volume (LV)

## Commands Used

```bash id="g5vqqq"
lvcreate -L 500M -n app-data devops-vg
lvs
```

## Purpose

Created a 500MB Logical Volume named `app-data`.

---

# Step 6: Format and Mount Logical Volume

## Commands Used

```bash id="jlwmc2"
mkfs.ext4 /dev/devops-vg/app-data

mkdir -p /mnt/app-data

mount /dev/devops-vg/app-data /mnt/app-data

df -h /mnt/app-data
```

## Purpose

Formatted the logical volume with EXT4 filesystem and mounted it successfully.

---

# Step 7: Extend Logical Volume

## Commands Used

```bash id="2lyrmt"
lvextend -L +200M /dev/devops-vg/app-data

resize2fs /dev/devops-vg/app-data

df -h /mnt/app-data
```

## Purpose

Extended the logical volume size dynamically and resized the filesystem without data loss.

---

# Screenshots Included

* lsblk output
* pvs output
* vgs output
* lvs output
* Mounted filesystem verification
* Logical volume extension output

---

# What I Learned

1. LVM provides flexible storage management in Linux systems.

2. Storage can be expanded dynamically without repartitioning disks.

3. Physical Volumes, Volume Groups, and Logical Volumes work together to create scalable storage architecture.

---

# LVM Architecture

```text id="6y8w3m"
Disk
 ↓
Physical Volume (PV)
 ↓
Volume Group (VG)
 ↓
Logical Volume (LV)
 ↓
Filesystem
 ↓
Mount Point
```

---



# Conclusion

Today I learned how Linux LVM helps administrators manage storage efficiently by creating scalable and extendable logical volumes dynamically.
