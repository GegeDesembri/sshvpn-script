

# Auto Script SSH/VPN

## Docs Index

> [**Docs Index**](#Docs-Index)

> [**Tentang**](#Tentang)

> [**Sistem Konfigurasi**](#Sistem-Konfigurasi)

- [Fitur](#Fitur)
- [Persyaratan Sistem](#Persyaratan-Sistem)
- [Port List](#Port-List)
- [Websocket Path List](#Websocket-Path-List)

> [**Instalasi**](#Instalasi)

- [Tahap 1](#Tahap-1)
- [Tahap 2](#Tahap-2)
- [Informasi](#Informasi)

> [**Berlangganan**](#Berlangganan)

> [**Dukungan**](#Dukungan)

## Tentang

Auto Script ini memiliki masa trial selama 4 hari terhitung sejak script terinstall pada VPS. Setelah masa trial, admin server tidak dapat menambah atau mengahpus akun. Tunnel yang sudah berjalan dan terdapat akun yang masih aktif tetap dapat diakses hingga akun sudah kadaluarsa dan terhapus otomatis dari server.
Peningkatan status script ke Premium akan membuka semua akses yang tidak ada pada status trial. Masa aktif script Premium terhitung sejak hari pembayaran.

## Sistem Konfigurasi

### Fitur

- Simple CLI Dashboard
- One Port Multi Protocol
- Cloudflare SSL
- Cloudflare CDN Support
- AWS CloudFront CDN Support [HTTP/HTTPS] (*with your own AWS account*)
- Free Domain for Tunnel
- Auto Update IP to Cloudflare Domain
- SWAP Memory 2GB
- vnStat Web Interface
- Running the Service depends on the existing account (*Save Resources*)
- Bandwidth Meter direct Provider API [*Hanya VPS yang dibeli dari* [*GegeVPS*](https://www.facebook.com/GegeEmbrie/)]

### Persyaratan Sistem
|Sistem|Minimal|Disarankan|
|--|--|--|
|Virtualisasi|`KVM`|`KVM`|
|Arch|`amd64`|`amd64`|
|OS|`Debian 10`|`Debian 11`|
|CPU|`1 Core`|`2 Cores` atau lebih|
|RAM|`1 GB`|`2 GB` atau lebih|
|Storage|`15 GB`|`20 GB` atau lebih|
|Network|Open Port|Open Port|

### Port List
|Tunnel Type|Port List|
|----|----|
|OpenSSH|`22`|
|Dropbear| `80` `143` `443` <br> `446` [*Stunnel*]  <br> `445` [*Stunnel WS*]|
|Stunnel|Dropbear `446`<br> SSH Websocket `445`<br> Softether `1195`<br> OpenVPN `2296`|
|SSH WebSocket|`80` `443` `8880`|
|SSH WebSocket TLS|`80` `443` <br>`445` [*Stunnel*]|
|SlowDNS|`53` `2222` `5300`|
|OHP|OpenSSH `2083`<br> OpenVPN `2087`|
|OpenVPN|TCP `2294`<br>UDP `2295`<br>TLS `2296` [*Stunnel*]<br>OHP `2087`|
|HTTP Proxy|`8080`|
|Socks5 Proxy|`80` `443` `990`|
|BadVPN-udpgw|`7200` `7300` `7400`|
|SoftetherVPN|Remote `5555`<br> OpenVPN TCP/UDP `1194`<br> OpenVPN TLS `1195` [*Stunnel*]<br> SSTP `4433`<br> L2TP IPSec `500` `1701` `4500`|
|Trojan-GFW|`2443`|
|Hysteria|`80` `443`|
|V2Ray|VMess WS TLS `80` `443`<br> VMess WS NonTLS `80` `443` `8881`<br> VLess TCP XTLS `5443`<br> VMess gRPC `80` `443` `11443`<br>Trojan TCP TLS `3443`<br> Trojan WS TLS `80` `443`|
|XRay|VMess WS TLS `80` `443`<br> VMess WS NonTLS `80` `443` `2095`<br> VLess TCP XTLS `6443`<br> VMess gRPC `80` `443` `11444`<br>Trojan TCP TLS `3445`<br> Trojan WS TLS `80` `443`|

### Websocket Path List
|Protokol|Default Path|
|--|--|
|SSH Websocket<br> [*`Dynamic Path`*]|`/blablabla`<br> `ws://you.dom.com`<br> `wss://you.dom.com`|
|V2Ray<br> [*`Dynamic Path`*]<br> [*`Static Path`*]| `/YOURPATH/v2ray-vmess-ws-tls`<br> `/YOURPATH/v2ray-vmess-ws-ntls`<br> `/YOURPATH/v2ray-trojan-ws-tls`<br> `/YOURPATH?type=v2ray-vmess-ws-tls`<br> `/YOURPATH?type=v2ray-vmess-ws-ntls`<br> `/YOURPATH?type=v2ray-trojan-ws-tls`<br>`/v2ray-vmess-grpc`<br> <br> **Replace `YOURPATH` with your method path*<br> ***Path not marked with a "`?`" support for Clash* |
|XRay<br> [*`Dynamic Path`*]<br> [*`Static Path`*]|`/YOURPATH/vxray-vmess-ws-tls`<br> `/YOURPATH/xray-vmess-ws-ntls`<br> `/YOURPATH/xray-trojan-ws-tls`<br> `/YOURPATH?type=xray-vmess-ws-tls`<br> `/YOURPATH?type=xray-vmess-ws-ntls`<br> `/YOURPATH?type=xray-trojan-ws-tls`<br>`/xray-vmess-grpc`<br> <br> **Replace `YOURPATH` with your method path*<br> ***Path not marked with a "`?`" support for Clash*|


## Instalasi

### Tahap 1

    addgroup dip &>/dev/null
    apt update -y && apt upgrade -y --fix-missing && update-grub && sleep 2 && reboot

### Tahap 2

    apt update && apt --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen nscd && wget --inet4-only --no-check-certificate -O debian.sh 'https://script2.gegevps.com/debian.sh' && chmod +x debian.sh && screen -S debian ./debian.sh

### Informasi

- Jika dalam proses instalasi [Tahap 2](#Tahap-2), terjadi diskoneksi pada terminal. Jangan masukkan kembali perintah instalasi [Tahap 2](#Tahap-2). Silahkan masukkan perintah `screen -r debian` untuk melihat proses yang telah berjalan.
- Jika ingin melihat log instalasi dapat dilihat pada `/root/syslog.log`.
- Laporan bug bisa dilakukan pada akun [GegeVPS Admin](https://t.me/GegeVPS) atau melalui [AutoScript Technical Support](https://t.me/gegevps_sctech).

## Berlangganan

- Proses pembelian bisa dilakukan melalui [GegeVPS Admin](https://t.me/GegeVPS)
- Pembelian pertama untuk 1 IP Rp. 20.000,-
- Perpanjangan Rp. 25.000,- /IP /30Hari
- Proses resolv IP pada database memakan waktu sekitar 5 - 10 menit
- Selama masa Trial pastikan semua layanan dapat berjalan tanpa masalah
- Pengujian koneksi layanan gunakan koneksi internet yang normal bukan menggunakan method
- Tanggung jawab admin hanya sebatas fitur dan layanan yang sudah tertulis
- Server yang tersuspend karena larangan penggunaan VPN oleh provider VPS adalah diluar kuasa admin. Jadi pastikan server yang akan digunakan memiliki izin untuk penggunaan VPN Server
- Pelanggan dianggap setuju dengan ketentuan di atas
- Tidak ada refund setelah transaksi berhasil

## Dukungan

Silahkan bergabung pada grup dan channel Telegram berikut untuk mendapatkan informasi tentang Patch atau hal yang berhubungan dengan peningkatan fungsi script.
- Telegram : [GegeVPS Admin](https://t.me/GegeVPS)
- Telegram Grup : [AutoScript Technical Support](https://t.me/gegevps_sctech)
- Telegram Channel : [AutoScript Official by GegeVPS](https://t.me/gegevps_autoscript)
