# Shell Scripting Cheat Sheet

## Quick Reference Table

| Topic    | Syntax                   | Example                            |
| -------- | ------------------------ | ---------------------------------- |
| Variable | `VAR="value"`            | `NAME="DevOps"`                    |
| Argument | `$1`, `$2`               | `./script.sh arg1`                 |
| If       | `if [ condition ]; then` | `if [ -f file ]; then`             |
| For Loop | `for i in list; do`      | `for i in 1 2 3; do`               |
| Function | `name() {}`              | `greet() { echo "Hi"; }`           |
| Grep     | `grep pattern file`      | `grep -i error log.txt`            |
| Awk      | `awk '{print $1}' file`  | `awk -F: '{print $1}' /etc/passwd` |
| Sed      | `sed 's/old/new/g' file` | `sed -i 's/foo/bar/g' file`        |

---

# 1. Basics

## Shebang

```bash
#!/bin/bash
```

Specifies Bash as the interpreter for the script.

## Running Scripts

```bash
chmod +x script.sh
./script.sh

bash script.sh
```

## Comments

```bash
# Single line comment

echo "Hello" # Inline comment
```

## Variables

```bash
NAME="Harshal"

echo $NAME
echo "$NAME"
echo '$NAME'
```

## User Input

```bash
read -p "Enter Name: " NAME
echo "$NAME"
```

## Command-Line Arguments

```bash
$0   # Script name
$1   # First argument
$2   # Second argument
$#   # Total arguments
$@   # All arguments
$?   # Exit status
```

Example:

```bash
./script.sh DevOps Linux
```

---

# 2. Operators and Conditionals

## String Comparisons

```bash
[ "$a" = "$b" ]
[ "$a" != "$b" ]
[ -z "$a" ]
[ -n "$a" ]
```

## Integer Comparisons

```bash
[ $a -eq $b ]
[ $a -ne $b ]
[ $a -lt $b ]
[ $a -gt $b ]
[ $a -le $b ]
[ $a -ge $b ]
```

## File Test Operators

```bash
-f file
-d dir
-e file
-r file
-w file
-x file
-s file
```

## If / Elif / Else

```bash
if [ condition ]; then
    echo "True"
elif [ condition ]; then
    echo "Another Condition"
else
    echo "False"
fi
```

## Logical Operators

```bash
[ condition1 ] && [ condition2 ]

[ condition1 ] || [ condition2 ]

! [ condition ]
```

## Case Statement

```bash
case $choice in
    start)
        echo "Starting"
        ;;
    stop)
        echo "Stopping"
        ;;
    *)
        echo "Invalid"
        ;;
esac
```

---

# 3. Loops

## For Loop

```bash
for fruit in apple banana mango
do
    echo $fruit
done
```

## C-Style For Loop

```bash
for ((i=1; i<=5; i++))
do
    echo $i
done
```

## While Loop

```bash
count=1

while [ $count -le 5 ]
do
    echo $count
    ((count++))
done
```

## Until Loop

```bash
count=1

until [ $count -gt 5 ]
do
    echo $count
    ((count++))
done
```

## Break and Continue

```bash
break
continue
```

## Loop Through Files

```bash
for file in *.log
do
    echo "$file"
done
```

## Read Command Output

```bash
cat users.txt | while read line
do
    echo "$line"
done
```

---

# 4. Functions

## Define Function

```bash
greet() {
    echo "Hello"
}
```

## Call Function

```bash
greet
```

## Function Arguments

```bash
greet() {
    echo "Hello $1"
}

greet Harshal
```

## Return Values

```bash
sum() {
    echo $(( $1 + $2 ))
}
```

## Local Variables

```bash
demo() {
    local name="Harshal"
}
```

---

# 5. Text Processing Commands

## grep

```bash
grep error log.txt
grep -i error log.txt
grep -r error .
grep -c error log.txt
grep -n error log.txt
grep -v error log.txt
grep -E "error|warning" log.txt
```

## awk

```bash
awk '{print $1}' file.txt

awk -F: '{print $1}' /etc/passwd

awk 'BEGIN {print "START"} {print $1} END {print "END"}' file.txt
```

## sed

```bash
sed 's/old/new/g' file.txt
sed -i 's/foo/bar/g' config.txt
sed '5d' file.txt
```

## cut

```bash
cut -d',' -f1 users.csv
```

## sort

```bash
sort file.txt
sort -n file.txt
sort -r file.txt
sort -u file.txt
```

## uniq

```bash
uniq file.txt
uniq -c file.txt
```

## tr

```bash
tr a-z A-Z
tr -d ','
```

## wc

```bash
wc file.txt
wc -l file.txt
wc -w file.txt
```

## head / tail

```bash
head -5 file.txt
tail -5 file.txt
tail -f app.log
```

---

# 6. Useful One-Liners

## Delete Files Older Than 30 Days

```bash
find . -type f -mtime +30 -delete
```

## Count Lines in Log Files

```bash
wc -l *.log
```

## Replace String Across Multiple Files

```bash
sed -i 's/http/https/g' *.conf
```

## Check Service Status

```bash
systemctl is-active nginx
```

## Disk Usage Alert

```bash
df -h | awk '$5+0 > 80 {print}'
```

## Parse CSV

```bash
cut -d',' -f1 users.csv
```

## Real-Time Error Monitoring

```bash
tail -f app.log | grep ERROR
```

---

# 7. Error Handling and Debugging

## Exit Codes

```bash
echo $?

exit 0
exit 1
```

## Exit on Error

```bash
set -e
```

## Unset Variable Error

```bash
set -u
```

## Catch Pipeline Errors

```bash
set -o pipefail
```

## Debug Mode

```bash
set -x
```

## Trap Cleanup

```bash
cleanup() {
    echo "Cleaning up..."
}

trap cleanup EXIT
```

---

# 8. Production Script Header

```bash
#!/bin/bash

set -euo pipefail
```

Recommended for production-grade scripts.

---

# 9. Common DevOps Commands

```bash
find /var/log -name "*.log"

grep -r ERROR /var/log

df -h

free -h

top

ps aux

systemctl status nginx

journalctl -xe

tail -f app.log
```

---

# Key Takeaway

Shell scripting is essential for automation, server administration, log management, monitoring, backups, deployments, and everyday DevOps operations.
