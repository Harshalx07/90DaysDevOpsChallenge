# Read and Write text files in Linux

* `touch notes.txt`

   Create a text file with name notes.txt

* `echo "Hello, this is Harshal" > notes.txt`

   Write data into notes.txt

* `echo "I am practicing Linux commands" >> notes.txt`

* `echo "Today is Day 06 of DevOps" >> notes.txt`

   Append new lines into notes.txt

* `echo "Learning file handling is important" | tee -a notes.txt`

   Write using tee command and print output on terminal  
   `-a` is used for append mode

* `cat notes.txt`

   Read complete notes.txt file

* `cat notes.txt | head -n 1`

   Read first line of notes.txt

* `cat notes.txt | tail -n 2`

   Read last two lines of notes.txt

## Hands on of above commands

<img width="1512" height="982" alt="Screenshot 2026-05-21 at 1 14 15 PM" src="https://github.com/user-attachments/assets/254d1b0c-cbf8-4422-a005-8149f78a5a70" />
