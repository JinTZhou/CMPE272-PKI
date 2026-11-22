#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files ca/root/certs/root.crt
openssl x509 -in ca/root/certs/root.crt -outform DER -out certs/root-ca.cer
printf 'Exported the public root certificate to certs/root-ca.cer.\n'
printf 'Run explorer.exe . and open certs/root-ca.cer to import it in Windows.\n'
