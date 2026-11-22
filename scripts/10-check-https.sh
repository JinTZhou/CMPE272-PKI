#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files ca/root/certs/root.crt
curl --fail --show-error --cacert ca/root/certs/root.crt \
  --resolve localhost:8443:127.0.0.1 -I https://localhost:8443/hw/
openssl s_client -connect 127.0.0.1:8443 -servername localhost \
  -CAfile ca/root/certs/root.crt -verify_hostname localhost \
  -verify_return_error -showcerts </dev/null
