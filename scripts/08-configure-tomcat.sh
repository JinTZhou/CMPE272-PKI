#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
require_files tomcat/conf/server.xml keystore/tomcat.p12 config/server.xml.example web/index.html
refuse_existing tomcat/conf/server.xml.original tomcat/conf/tomcat.p12
cp tomcat/conf/server.xml tomcat/conf/server.xml.original
cp keystore/tomcat.p12 tomcat/conf/tomcat.p12
cp config/server.xml.example tomcat/conf/server.xml
mkdir -p tomcat/webapps/hw
cp web/index.html tomcat/webapps/hw/index.html
cat > tomcat/bin/setenv.sh <<'SETENV'
export JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
unset JRE_HOME
SETENV
printf 'Next run: nano tomcat/conf/server.xml\n'
printf 'Replace REPLACE_WITH_EXPORT_PASSWORD with the keystore export password.\n'
printf 'Keep the placeholder in config/server.xml.example for GitHub.\n'
