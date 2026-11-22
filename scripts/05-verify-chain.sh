#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files ca/root/certs/root.crt ca/signing/certs/signing.crt certs/localhost.crt
openssl verify -show_chain -x509_strict -purpose sslserver \
  -verify_hostname localhost -CAfile ca/root/certs/root.crt \
  -untrusted ca/signing/certs/signing.crt certs/localhost.crt
