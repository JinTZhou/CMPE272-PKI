#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files config/root.cnf ca/root/index.txt ca/root/serial
refuse_existing ca/root/private/root.key ca/root/certs/root.crt
printf 'Choose a new ROOT CA passphrase when prompted.\n'
openssl req -new -x509 -newkey rsa:4096 -sha256 -days 3650 \
  -config config/root.cnf -extensions root_ext \
  -keyout ca/root/private/root.key -out ca/root/certs/root.crt
openssl x509 -in ca/root/certs/root.crt \
  -noout -subject -issuer -dates -ext basicConstraints
