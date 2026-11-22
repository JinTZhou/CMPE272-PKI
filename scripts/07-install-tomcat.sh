#!/usr/bin/env bash
source "$(dirname -- "${BASH_SOURCE[0]}")/_common.sh"
refuse_existing tomcat
# Optional argument: another current Tomcat 10.1 version from Apache's download page.
HW_TOMCAT_VERSION="${1:-10.1.62}"
if [[ ! "$HW_TOMCAT_VERSION" =~ ^10\.1\.[0-9]+$ ]]; then
  printf 'Expected a Tomcat 10.1 version, for example 10.1.62.\n' >&2
  exit 1
fi
HW_ARCHIVE="apache-tomcat-${HW_TOMCAT_VERSION}.tar.gz"
mkdir -p downloads
(
  cd downloads
  curl --fail --location --retry 3 --output "$HW_ARCHIVE" \
    "https://dlcdn.apache.org/tomcat/tomcat-10/v${HW_TOMCAT_VERSION}/bin/${HW_ARCHIVE}"
  curl --fail --location --retry 3 --output "${HW_ARCHIVE}.sha512" \
    "https://downloads.apache.org/tomcat/tomcat-10/v${HW_TOMCAT_VERSION}/bin/${HW_ARCHIVE}.sha512"
  sha512sum -c "${HW_ARCHIVE}.sha512"
)
mkdir tomcat
tar -xzf "downloads/$HW_ARCHIVE" -C tomcat --strip-components=1
printf 'Installed Tomcat %s in %s/tomcat\n' "$HW_TOMCAT_VERSION" "$PWD"
