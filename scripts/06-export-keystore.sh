#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files certs/localhost.key certs/localhost.crt ca/signing/certs/signing.crt
refuse_existing keystore/tomcat.p12
printf 'Choose an EXPORT password. Enter that same password again when keytool asks for it.\n'
openssl pkcs12 -export -name tomcat \
  -inkey certs/localhost.key -in certs/localhost.crt \
  -certfile ca/signing/certs/signing.crt -out keystore/tomcat.p12
keytool -list -v -storetype PKCS12 -keystore keystore/tomcat.p12
