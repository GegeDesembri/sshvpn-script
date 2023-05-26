#!/bin/bash

ln -fs /usr/local/bin/hidessh-ssh-create /usr/local/bin/add-ssh-user
ln -fs /usr/local/bin/hidessh-ssh-delete /usr/local/bin/del-ssh-user
ln -fs /usr/local/bin/hidessh-ssh-check /usr/local/bin/cek-ssh-user
ln -fs /usr/local/bin/hidessh-vmess-create /usr/local/bin/add-vmess-user
ln -fs /usr/local/bin/hidessh-vmess-delete /usr/local/bin/del-vmess-user
ln -fs /usr/local/bin/hidessh-vmess-check /usr/local/bin/cek-vmess-user
ln -fs /usr/local/bin/hidessh-trojan-create /usr/local/bin/add-trojan-user
ln -fs /usr/local/bin/hidessh-trojan-delete /usr/local/bin/del-trojan-user
ln -fs /usr/local/bin/hidessh-trojan-check /usr/local/bin/cek-trojan-user

echo -e "HideSSH Plugin Installed"
