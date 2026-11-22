#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files config/signing.cnf ca/root/private/root.key ca/root/certs/root.crt ca/signing/index.txt
refuse_existing ca/signing/private/signing.key ca/signing/signing.csr ca/signing/certs/signing.crt
printf 'First choose a SIGNING CA passphrase. Then enter the ROOT CA passphrase to sign its CSR.\n'
openssl req -new -newkey rsa:4096 -sha256 \
  -config config/signing.cnf \
  -keyout ca/signing/private/signing.key -out ca/signing/signing.csr
openssl ca -batch -config config/root.cnf -extensions signing_ext \
  -days 1825 -notext -in ca/signing/signing.csr -out ca/signing/certs/signing.crt
openssl x509 -in ca/signing/certs/signing.crt \
  -noout -subject -issuer -ext basicConstraints
openssl verify -CAfile ca/root/certs/root.crt ca/signing/certs/signing.crt
