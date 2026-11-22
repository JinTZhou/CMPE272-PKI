#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files tomcat/bin/catalina.sh tomcat/conf/server.xml tomcat/conf/tomcat.p12
if grep -q 'REPLACE_WITH_EXPORT_PASSWORD' tomcat/conf/server.xml; then
  printf 'Edit tomcat/conf/server.xml and set the keystore export password first.\n' >&2
  exit 1
fi
export CATALINA_HOME="$PWD/tomcat"
export CATALINA_BASE="$CATALINA_HOME"
chmod +x tomcat/bin/*.sh
printf 'Open https://localhost:8443/hw/ after startup. Keep this terminal open; Ctrl+C stops Tomcat.\n'
exec bash tomcat/bin/catalina.sh run
