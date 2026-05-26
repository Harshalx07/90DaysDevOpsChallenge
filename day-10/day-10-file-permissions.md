# File Permissions & File Operations Challenge

## Files Created

* Create empty file devops.txt using touch
* Create notes.txt with some content using cat or echo
* Create script.sh using vim with content: echo "Hello DevOps"
* Verify: ls -l to see permissions

![snapshot](<Screenshot 2026-05-25 at 5.36.35 AM.png>)

## Read Files

* Read notes.txt using cat

![snapshot](<Screenshot 2026-05-25 at 5.52.09 AM.png>)

* View script.sh in vim read-only mode - `vim -R script.sh`

![snapshot](images/vim.png)

* Display first 5 lines of /etc/passwd using head

![snapshot](<Screenshot 2026-05-25 at 5.37.50 AM.png>)

* Display last 5 lines of /etc/passwd using tail

![snapshot](<Screenshot 2026-05-25 at 5.37.58 AM.png>)

# Permission Changes

## Understand Permissions

![snapshot](<Screenshot 2026-05-25 at 5.39.18 AM.png>)

* Current permissions :

  Devops.txt : -rw-rw-r--
  
  - `-`     → indicates it’s a regular file (not a directory or special file).
  - `rw-` → (user/owner) → read + write, no execute.
  - `rw-` → (group) → read + write, no execute.
  - `r--` → (others) → read only, no write or execute.

* Same permissions applied to notes.txt and script.sh.

## Modify Permissions

* Make script.sh executable → run it with ./script.sh

![snapshot](<Screenshot 2026-05-25 at 5.40.27 AM.png>)

* Set devops.txt to read-only (remove write for all)

![snapshot](<Screenshot 2026-05-25 at 5.41.07 AM.png>)

* Set notes.txt to 640 (owner: rw, group: r, others: none)

![snapshot](<Screenshot 2026-05-25 at 5.41.48 AM.png>)

* Create directory project/ with permissions 755

![snapshot](<Screenshot 2026-05-25 at 5.42.30 AM.png>)

## Test Permissions

* Writing to a read-only file - what happens?

Answer : Writing to a read‑only file normally gives Permission denied. 
With sudo, you can override and write to the file — but only if the redirection itself is executed with root privileges (using tee or sudo bash -c).
Even sudo won’t help if the file is set to immutable (via chattr +i) or mounted on a read‑only filesystem.
    

* Try executing a file without execute permission.

Answer : Executing a file without execute permission gives Permission denied. 
Even sudo cannot bypass this, because the shell requires the execute bit.
However, you can still run the file by explicitly invoking the interpreter (e.g., bash script.sh or python3 script.py).


## Commands Used

* `touch fname` - Creates empty file.
* `echo "Hello" > fname` - Create file with content.
* `vim fname` - Create/open file in Vim.
* `cat fname` - Prints files content.
* `vim -R fname` - Open file in read only mode.
* `cat /etc/passwd | head -5` - Prints first 5 lines of /etc/passwd.
* `cat /etc/passwd | tail -5` - Prints last 5 lines of /etc/passwd.
* `chmod +x fname` - Adding executable permission for all(owner,group,others).
* `chmod -w fname` - Removing write permission for all(owner,group,others).
* `mkdir -m 755 dname` - Create directory with permissions(rwx,r-x,r-x).

## What I Learned

* Managing files permissions effectively.
* Using sudo can override read & write restrictions.
* Sudo cannot override execute permission but calling the interpreter directly allows execution.