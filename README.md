# makeDirs
Creating directories to read lines in dirlist file

### dirlist
Writing permission, user:group, and directory
ig)
777, root:root, /WORK/SFTP/IF/
755, sysg:sysg, /WORK/SFTP/IF/sysg/
755, sysg:sysg, /WORK/SFTP/IF/sysg/snd/
755, sysg:sysg, /WORK/SFTP/IF/sysg/srcv/

### createDir.sh
Reading a line from the directory list and creating directories to set permissions, user, and group.
If the error occurs, write the error logs and output to the error-log file.
