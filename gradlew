#!/bin/sh
set -eu
GRADLE_VERSION="8.11.1"
CACHE_DIR="${HOME}/.gradle/roshd-gradle"
DIST="${CACHE_DIR}/gradle-${GRADLE_VERSION}"
if [ ! -x "${DIST}/bin/gradle" ]; then
  mkdir -p "${CACHE_DIR}"
  TMP="${CACHE_DIR}/gradle-${GRADLE_VERSION}.zip"
  if [ ! -f "$TMP" ]; then
    curl -L --fail --retry 3 -o "$TMP" "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
  fi
  rm -rf "${DIST}.tmp"
  mkdir -p "${DIST}.tmp"
  unzip -q "$TMP" -d "${DIST}.tmp"
  rm -rf "${DIST}"
  mv "${DIST}.tmp/gradle-${GRADLE_VERSION}" "${DIST}"
  rm -rf "${DIST}.tmp"
fi
exec "${DIST}/bin/gradle" "$@"
