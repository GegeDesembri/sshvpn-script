# Auto Script SSH/VPN

> [!NOTE]  
> **FREE TO USE**. Mulai 20 April 2025 autoscript ini bebas dan gratis untuk dipakai. Pengguna tidak memiliki kewajiban untuk melakukan pembayaran langganan. Langganan hanya diperlukan apabila pengguna membutuhkan support lebih oleh Admin untuk menangani dan mengelola server apabila terjadi masalah atau hal-hal lain seperti Bug dan semacamnya. Bantuan atau support dari Admin hanya untuk VPS dengan IP yang sudah terdaftar sebagai Premium Support.

## Batasan Cloudflare DNS Records

> [!IMPORTANT]
> Autoscript ini menggunakan Cloudflare sebagai perantara untuk memanajemen Domain yang digunakan. Sayangnya Cloudflare telah menurunkan batas limit DNS Record per Domain dari 1000 menjadi 200 [[*sumber*]](https://developers.cloudflare.com/dns/troubleshooting/faq/#does-cloudflare-limit-the-number-of-dns-records-a-domain-can-have). Hal ini menyebabkan domain yang digunakan akan mencapai limit seiring bertambahnya orang yang memakai script ini dan itu akan menyebabkan script ini gagal dalam pemasangan.

### [SOLUSI 1] Open Donasi Domain

Oleh karena batasan ini, saya membuka bagi siapapun yang ingin menyumbangkan sebuah domain, bisa melakukannya secara mandiri dengan cara mengatur nameservers ke Cloudflare Nameservers dibawah ini

 - `gannon.ns.cloudflare.com`
 - `pat.ns.cloudflare.com`

Kemudian lakukan curl 
```bash
curl --location --request POST 'zones.gegevps.com/zone' \
--header 'domain: <DOMAINMU>'
```
Akan diperoleh output kurang lebih seperti ini

```json
{
    "message": "Zone added successfully",
    "result": {
        "id": "fde38dee7cc6346d475e2986exxxxx",
        "name": "domainmu.com",
        "status": "pending",
        "name_servers": [
            "gannon.ns.cloudflare.com",
            "pat.ns.cloudflare.com"
        ]
    }
}
```

Pantau aktivasi domain disini

```url
https://zones.gegevps.com/domain/<DOMAINMU>
```

Jika `status` bernilai `active` seperti pada sampel dibawah ini maka domain telah berhasil terintegrasi dengan autoscript

```json
{
  "domain": "<DOMAINMU>",
  "created_on": "2022-12-16T17:49:17.320690Z",
  "status": "active",
  "records": 0,
  "records_remaining": 1000,
  "record_limit_estimate": 1000,
  "percentage_used": 0
}
```

untuk melihat daftar domain yang terintegrasi bisa kunjungi url
```url
https://zones.gegevps.com/domains
```

### [SOLUSI 2] Gunakan API Key dari akun Cloudflare Pribadi

Pada langkah Step 2, gunakan penyesuaian berikut untuk memasukkan kode Cloudflare API Key

```bash
export DEBIAN_FRONTEND=noninteractive
source /etc/os-release
apt-get update && \
apt-get --reinstall --fix-missing install -y whois bzip2 gzip coreutils wget screen nscd && \
wget --inet4-only --no-check-certificate -O setup.sh "https://script.gegevps.com/deb${VERSION_ID}/setup.sh" && \
chmod +x setup.sh && \
screen -S setup ./setup.sh "CFAPIKEY"

# Ganti CFAPIKEY dengan API Key milikmu
```

#### Cara membuat API Key

1. Pergi ke https://dash.cloudflare.com/profile/api-tokens
2. Pilih `Create Token`
3. Pilih template `Edit zone DNS`, lalu `Use template`
![Edit zone DNS Template](https://i.imgur.com/9l7CxbI.png)
4. Beri nama API Key atau Token name dan sesuaikan pengaturan seperti pada gambar dibawah ini, pilih satu domain yang akan digunakan
![API Key Setting](https://i.imgur.com/fyrnJgi.png)
5. Jika sudah, klik `Continue to Summary`
6. Periksa kembali ringkasan pengaturan, pastikan sesuai pada contoh dibawah in
![Token Summary](https://i.imgur.com/OySG2Gf.png)
7. Jika sudah yakin, klik `Create Token`
8. API Key akan muncul seperti pada gambar dibawah ini
![API Key Result](https://i.imgur.com/upz2Vng.png)
9. Copy dan Simpan API key ditempat yang aman karena kode tersebut hanya diperlihat sekali saja.
10. API Key sudah siap digunakan untuk instalasi Autoscript 

Sekian, terima kasih atas partisipasinya. Semoga bermanfaat

## Docs Index

> [**Docs Index**](#Docs-Index)

> [**Tentang**](#Tentang)

> [**Sistem Konfigurasi**](#Sistem-Konfigurasi)

- [Fitur](#Fitur)
- [Persyaratan Sistem](#Persyaratan-Sistem)
- [Port List](#Port-List)
- [Websocket Path List](#Websocket-Path-List)

> [**Installation**](#Installation)

- [Step 1](#Step-1)
- [Step 2](#Step-2)
- [Informasi](#Informasi)

> [**Tutorial**](#Tutorial)

- [Auto Reboot](#auto-reboot)
- [Disable Pre-fill VPNRay](#disable-pre-fill-vpnray)
- [Disable VPNRay Coloring Text](#disable-vpnray-coloring-text)
- [Disable Clash Configuration](#disable-clash-configuration)
- [Ganti banner OpenSSH/Dropbear](#ganti-banner-opensshdropbear)
- [Ganti SSH Websocket Dropbear ke OpenSSH](#ganti-ssh-websocket-dropbear-ke-openssh)
- [Ganti SSH Stunnel Dropbear ke OpenSSH](#ganti-ssh-stunnel-dropbear-ke-openssh)
- [Ganti Port SSH Stunnel ke 443 (Default 446)](#ganti-port-ssh-stunnel-ke-443-default-446)
- [Softether VPN Server Password](#softether-vpn-server-password)
- [Cloudflare Public API Keys](#cloudflare-public-api-keys)
- [AWS CloudFront CDN (API Key)](#aws-cloudfront-cdn-api-key)

> [**Berlangganan**](#Berlangganan)

> [**Dukungan**](#Dukungan)

## Tentang

Auto Script ini memiliki masa trial selama 4 hari terhitung sejak script terinstall pada VPS. Setelah masa trial, admin server tidak dapat menambah atau mengahpus akun. Tunnel yang sudah berjalan dan terdapat akun yang masih aktif tetap dapat diakses hingga akun sudah kadaluarsa dan terhapus otomatis dari server.
Peningkatan status script ke Premium akan membuka semua akses yang tidak ada pada status trial. Masa aktif script Premium terhitung sejak hari pembayaran.

## Sistem Konfigurasi

### Fitur

- Cloudflare SSL
- Simple CLI Dashboard
- vnStat Web Interface
- Free Domain for Tunnel
- Cloudflare CDN Support
- Multi Port Multi Protocol
- Auto Update IP to Cloudflare Domain
- SWAP Memory 2GB (*Modular: Default Enable*)
- Load Balance [`80`/`443`] (*Modular: Default Enable*)
- SSH Limit login (*Disconnecting last session only*)
- Cloudflare WARP [`V2ray`/`XRay`] (*Modular: Default Disable*)
- Cloudflare WARP support Domain, GeoIP, and IP/CIDR Targeting
- Lightweight CPU on idle after Fresh Install (*CPU Usage Avrg. 2-3%*)
- Running the Service depends on the existing account (*Saving Resources*)
- AWS CloudFront CDN Support [`HTTP`/`HTTPs`] (*with your own AWS account*)
- Auto Generate Clash Configuration (`VMess`, `VLess`, `Trojan`, `Shadowsocks`, `Socks`)
- Bandwidth Meter direct Provider API [*Hanya VPS yang dibeli dari* [*GegeVPS*](https://www.facebook.com/GegeEmbrie/)]
- Support Bypass Site tertentu menggunakan V2Ray atau XRay (Disney+, Hotstar, Netflix, dan lain sebagainya)
- VPNRay JSON Converter for Custom Config and HTTP Custom
- Telegram Bot Remote
- WebAPI Services for Web Development - [**Documentation**](https://github.com/GegeDevs/sshvpn-api)
- Telegram Bot Seller Panel - [**Documentation**](https://github.com/GegeDevs/sshvpn-telegram-panel)
- HideSSH Web Panel Plugin [_Included_] - Reference [**HideSSH Web Panel Plugin**](https://github.com/hidessh99/Developers)

### Persyaratan Sistem
|Sistem|Supported|Tested|Minimal|Disarankan|
|--|--|--|--|--|
|Virtualisasi|`KVM` `Xen`<br>  `VMware`<br>  `VirtualBox`|`Xen`|`Xen` `KVM`|`Xen` `KVM`|
|CPU Arch|`amd64`|`amd64`|`amd64`|`amd64`|
|OS|`Debian 10`<br> `Debian 11`<br> `Debian 12`|`Debian 12`|`Debian 11`|`Debian 12`|
|OS Arch|`64 Bit`|`64 Bit`|`64 Bit`|`64 Bit`|`64 Bit`|
|CPU|-|`1 Core`|`1 Core`|`2 Cores` *atau lebih*|
|RAM|-|`512 MB`|`1 GB`|`2 GB` *atau lebih*|
|Storage|-|`20 GB`|`15 GB`|`20 GB` *atau lebih*|
|Network|*1xIPv4<br> Disable IPv6<br> Open Port*|*1xIPv4<br> Disable IPv6<br> Open Port*|*1xIPv4<br> Disable IPv6<br> Open Port*|*1xIPv4<br> Disable IPv6<br> Open Port*|
|ISP|*AWS Lightsail<br> DigitalOcean<br> Linode<br> Vultr<br> OVH<br> iTLDC<br> APIK Media<br> Atha Media<br> Biznet<br> Media Antar Nusa<br> IP ServerOne*|*AWS Lightsail*|-|-|

### Port List
|Tunnel Type|Port List|
|----|----|
|OpenSSH|`22`|
|Dropbear| `80` `143` `443` <br> `446` [*Stunnel*]  <br> `445` [*Stunnel WS*]|
|Stunnel|Dropbear `446`<br> SSH Websocket `445`<br> Softether `1195`<br> OpenVPN `2296`|
|SSH WebSocket|`80` `443` `8880`|
|SSH WebSocket TLS|`80` `443` <br>`445` [*Stunnel*]|
|SlowDNS|`53` `2222`|
|OHP|OpenSSH `2083`<br> OpenVPN `2087`|
|OpenVPN|TCP `2294`<br>UDP `2295`<br>TLS `2296` [*Stunnel*]<br>OHP `2087`|
|HTTP Proxy|`8080`|
|Socks5 Proxy|`80` `443` `990`|
|BadVPN-udpgw|`7200` `7300` `7400`|
|SoftetherVPN|Remote `5555`<br> OpenVPN TCP/UDP `1194`<br> OpenVPN TLS `1195` [*Stunnel*]<br> SSTP `4433`<br> L2TP IPSec `500` `1701` `4500`|
|Hysteria|Load Balance `random`<br> Non-Load Balance `80` `443`|
|Trojan-Go|Websocket TLS `80` `443`|
|V2Ray<br> `VMess`<br> `VLess`<br> `Trojan`|VMess WS Non-TLS `80` `443`<br>VMess WS TLS `80` `443`<br>VMess gRPC TLS `443`<br>VLess WS Non-TLS `80` `443`<br>VLess WS TLS `80` `443`<br>VLess gRPC TLS `443`<br>Trojan TCP TLS `random`<br>Trojan WS Non-TLS `80` `443`<br>Trojan WS TLS `80` `443`<br>Trojan gRPC TLS `443`<br>|
|XRay<br> `VMess`<br> `VLess`<br> `Shadowsocks`<br> `Socks`<br> `Trojan`|VMess WS Non-TLS `80` `443`<br>VMess WS TLS `80` `443`<br>VMess gRPC TLS `443`<br>VLess WS Non-TLS `80` `443`<br>VLess WS TLS `80` `443`<br>VLess gRPC TLS `443`<br>Shadowsocks TCP Non-TLS `random`<br>Shadowsocks WS Non-TLS `80` `443`<br>Shadowsocks WS TLS `80` `443`<br>Shadowsocks gRPC TLS `443`<br>Socks TCP Non-TLS `random`<br>Socks WS Non-TLS `80` `443`<br>Socks WS TLS `80` `443`<br>Trojan TCP TLS `random`<br>Trojan WS Non-TLS `80` `443`<br>Trojan WS TLS `80` `443`<br>Trojan gRPC TLS `443`<br>|

### Websocket Path List
|Protokol|Default Path|
|--|--|
|SSH Websocket<br> [*`Dynamic`*]|`/blablabla`<br> `ws://you.dom.com`<br> `wss://you.dom.com`|
|Trojan-Go<br> [*`Dynamic`*]|`/YOURPATH/trojan-go`|
|V2Ray<br> [*`Dynamic`*]<br> [`Static`]|Path with Query <br> *`/YOURPATH?type=v2ray-vmess-ws-ntls`*<br> *`/YOURPATH?type=v2ray-vmess-ws-tls`*<br> *`/YOURPATH?type=v2ray-vless-ws-ntls`*<br> *`/YOURPATH?type=v2ray-vless-ws-tls`*<br> *`/YOURPATH?type=v2ray-trojan-ws-ntls`*<br> *`/YOURPATH?type=v2ray-trojan-ws-tls`*<br><br> Path without Query <br>*`/YOURPATH/v2ray-vmess-ws-tls`*<br> *`/YOURPATH/v2ray-vmess-ws-ntls`*<br> *`/YOURPATH/v2ray-vless-ws-ntls`*<br> *`/YOURPATH/v2ray-vless-ws-tls`*<br> *`/YOURPATH/v2ray-trojan-ws-ntls`*<br> *`/YOURPATH/v2ray-trojan-ws-tls`*<br> <br>gRPC Service Name <br> `v2ray-trojan-grpc-tls`<br> `v2ray-vless-grpc-tls`<br> `v2ray-vmess-grpc-tls`<br> <br> **Replace `YOURPATH` with your method path*<br> ***Path not marked with a "`?`" support for Clash* |
|XRay<br> [*`Dynamic`*]<br> [`Static`]|Path with Query <br> *`/YOURPATH?type=xray-vmess-ws-ntls`*<br> *`/YOURPATH?type=xray-vmess-ws-tls`*<br> *`/YOURPATH?type=xray-vless-ws-ntls`*<br> *`/YOURPATH?type=xray-vless-ws-tls`*<br> *`/YOURPATH?type=xray-trojan-ws-ntls`*<br> *`/YOURPATH?type=xray-trojan-ws-tls`*<br>*`/YOURPATH?type=xray-shadowsocks-ws-ntls`*<br> *`/YOURPATH?type=xray-shadowsocks-ws-tls`*<br>*`/YOURPATH?type=xray-socks-ws-ntls`*<br> *`/YOURPATH?type=xray-socks-ws-tls`*<br><br> Path without Query <br>*`/YOURPATH/xray-vmess-ws-tls`*<br> *`/YOURPATH/xray-vmess-ws-ntls`*<br> *`/YOURPATH/xray-vless-ws-ntls`*<br> *`/YOURPATH/xray-vless-ws-tls`*<br> *`/YOURPATH/xray-trojan-ws-ntls`*<br> *`/YOURPATH/xray-trojan-ws-tls`*<br> *`/YOURPATH/xray-shadowsocks-ws-ntls`* <br> *`/YOURPATH/xray-shadowsocks-ws-tls`*<br> *`/YOURPATH/xray-socks-ws-ntls`* <br> *`/YOURPATH/xray-socks-ws-tls`*<br> <br>gRPC Service Name <br> `xray-trojan-grpc-tls`<br>`xray-socks-grpc-tls`<br>`xray-shadowsocks-grpc-tls`<br> `xray-vless-grpc-tls`<br> `xray-vmess-grpc-tls`<br> <br> **Replace `YOURPATH` with your method path*<br> ***Path not marked with a "`?`" support for Clash* |


## Installation

### Step 1

    export DEBIAN_FRONTEND=noninteractive
	addgroup dip &>/dev/null
	apt-get update -y --allow-releaseinfo-change && \
	apt-get install --reinstall -y grub && \
	apt-get upgrade -y --fix-missing && \
	update-grub && \
	sleep 2 && \
	reboot

### Step 2

	export DEBIAN_FRONTEND=noninteractive
	source /etc/os-release
	apt-get update && \
	apt-get --reinstall --fix-missing install -y whois bzip2 gzip coreutils wget screen nscd && \
	wget --inet4-only --no-check-certificate -O setup.sh "https://script.gegevps.com/deb${VERSION_ID}/setup.sh" && \
	chmod +x setup.sh && \
	screen -S setup ./setup.sh

### Informasi

- Jika dalam proses instalasi [Step 2](#Step-2), terjadi diskoneksi pada terminal. Jangan masukkan kembali perintah instalasi [Step 2](#Step-2). Silahkan masukkan perintah `screen -r setup` untuk melihat proses yang telah berjalan.
- Jika ingin melihat log instalasi dapat dilihat pada `/root/syslog.log`.
- Laporan bug bisa dilakukan pada akun [GegeVPS Admin](https://t.me/GegeVPS).

## Tutorial

### Auto Reboot

Secara default script ini tidak diberikan sistem auto reboot karena tidak semua pengguna membutuhkannya. Jika kamu ingin memasang auto reboot pada VPS bisa gunakan perintah berikut ini

    crontab -l > /tmp/cron.txt
    sed -i "/reboot$/d" /tmp/cron.txt
    echo -e "\n"'0 4 * * * '"$(which reboot)" >> /tmp/cron.txt
    crontab /tmp/cron.txt
    rm -rf /tmp/cron.txt

Perintah di atas akan memasang auto reboot setiap jam 04.00.

Perintah untuk membatalkan.

    crontab -l > /tmp/cron.txt
    sed -i "/reboot$/d" /tmp/cron.txt
    crontab /tmp/cron.txt
    rm -rf /tmp/cron.txt

### Disable Pre-fill VPNRay

Jika tidak membutuhkan fitur *prefill* untuk kebutuhan penambahan, penghapusan, pembaruan akun VPNRay dalam pengembangan web bisa masukkan perintah dibawah ini.

    echo 'disable' > /etc/gegevps/vpnray/vpnray-prefill

Untuk membatalkan

    rm -rf /etc/gegevps/vpnray/vpnray-prefill

### Disable VPNRay Coloring Text

Jika tidak membutuhkan fitur *Coloring* pada teks output. Gunakan perintah berikut ini.

    echo 'disable' > /etc/gegevps/vpnray/vpnray-color

Untuk membatalkan

    rm -rf /etc/gegevps/vpnray/vpnray-color


### Disable Clash Configuration

Jika tidak membutuhkan fitur *CLASH PROXY* bisa masukkan perintah dibawah ini.

    echo 'disable' > /etc/gegevps/vpnray/vpnray-clash

Untuk membatalkan

    rm -rf /etc/gegevps/vpnray/vpnray-clash

### Ganti banner OpenSSH/Dropbear

Bisa edit file berikut

    nano /etc/gegevps/banner

### Ganti SSH Websocket Dropbear ke OpenSSH

Edit file berikut

    nano /usr/local/bin/sshws

Ganti baris yang berisi

    DEFAULT_HOST = '127.0.0.1:143'

Menjadi

    DEFAULT_HOST = '127.0.0.1:22'

Reboot VPS.

### Ganti SSH Stunnel Dropbear ke OpenSSH

Edit file berikut

    nano /etc/gegevps/stunnel/server.conf

Cari bagian `SSH Section`

    [ssh]
    accept = 446
    connect = 127.0.0.1:143

Ganti port 143 (`Dropbear`) menjadi 22 (`OpenSSH`)

    [ssh]
    accept = 446
    connect = 127.0.0.1:22

Restart Stunnel

    systemctl restart stunnel@server

### Ganti Port SSH Stunnel ke 443 (Default 446)

***Perhatian***: *Penggantian port ini akan menyebabkan port 443 hanya akan digunakan untuk SSH Stunnel dan semua layanan yang pada awalnya menggunakan port 443 melalui port 663 (NginX) kehilangan akses port 443. Gunakan apabila anda yakin hanya ingin memakaian port 443 SSL untuk SSH Stunnel saja.*

Bisa masukkan perintah berikut ini.

    cat /etc/gegevps/sslhm/443.ports | sed "/^$/d" | while read sslhm_ports; do
        sed -i "s|663|446|g" /etc/gegevps/sslhm/${sslhm_ports}.cfg
    done
    reboot

Untuk membatalkan

    cat /etc/gegevps/sslhm/443.ports | sed "/^$/d" | while read sslhm_ports; do
        sed -i "s|446|663|g" /etc/gegevps/sslhm/${sslhm_ports}.cfg
    done
    reboot

Setiap pengubahan konfigurasi dengan perintah diatas, VPS akan reboot terlebih dahulu.

### Softether VPN Server Password

Gunakan perintah berikut ini untuk melihat Password Server SoftetherVPN untuk melakukan remote melalui SoftetherVPN Manager.

    source /etc/gegevps/softether/params && echo "${MYPASS}"

Password akan muncul.

### Cloudflare Public API Keys

 1. Pergi ke https://dash.cloudflare.com/profile/api-tokens
 2. Bagian "*API Keys*"
 3. Pilih "*Global API Key*"
 4. Klik "*View*"
 5. Masukkan "*Password Cloudflare*"
 6. Copy dan Paste Key yang muncul

### AWS CloudFront CDN (API Key)

 1. Pergi ke https://go.aws/3FVihd9
 2. Cari bagian "*Access keys*"
 3. Klik "*Buat access key*"
 4. Ikuti prosedur
 5. Download dan simpan API Key
 6. Masukkan "*aws_access_key_id*" dan "*aws_secret_access_key*" ke VPS

## Berlangganan

- Proses pembelian bisa dilakukan melalui [GegeVPS Admin](https://t.me/GegeVPS)
- Pembelian pertama untuk 1 IP Rp. 25.000,-
- Perpanjangan Rp. 20.000,- /IP /30Hari
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
