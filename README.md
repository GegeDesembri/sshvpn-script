# Auto Script SSH/VPN

### Sistem Minimal
|System|Minimal|Disarankan|
|--|--|--|
|Arch|amd64|amd64|
|OS|Debian 10|Debian 11|
|CPU|1 Core|2 Cores or more|
|RAM|amd64|amd64|
|Storage|15 GB|20 GB|


### Langkah 1

    addgroup dip
    apt update -y && apt upgrade -y --fix-missing && update-grub && sleep 2 && reboot

### Langkah 2

    apt update && apt --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen nscd && wget --inet4-only --no-check-certificate -O debian.sh 'https://script2.gegevps.com/debian.sh' && chmod +x debian.sh && screen -S debian ./debian.sh
