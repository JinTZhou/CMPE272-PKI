#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files config/server.cnf ca/signing/private/signing.key ca/signing/certs/signing.crt
refuse_existing certs/localhost.key certs/localhost.csr certs/localhost.crt
printf 'Enter the SIGNING CA passphrase when signing the localhost CSR.\n'
openssl req -new -newkey rsa:2048 -noenc -sha256 \
  -config config/server.cnf -keyout certs/localhost.key -out certs/localhost.csr
openssl ca -batch -config config/signing.cnf -extensions server_ext \
  -days 90 -notext -in certs/localhost.csr -out certs/localhost.crt
openssl x509 -in certs/localhost.crt -noout -subject -issuer \
  -ext subjectAltName,extendedKeyUsage,basicConstraints
