#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
refuse_existing ca certs keystore
mkdir -p ca/root/{private,certs,newcerts} ca/signing/{private,certs,newcerts}
mkdir -p certs keystore docs/screenshots downloads
touch ca/root/index.txt ca/signing/index.txt
printf '1000\n' > ca/root/serial
printf '2000\n' > ca/signing/serial
printf 'Created fresh HW folders and CA databases in %s\n' "$PWD"
