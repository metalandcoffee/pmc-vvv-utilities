#!/usr/bin/env bash

CORETECH_DIR="/tmp/pmc-coretech"

REPO_LIST="/srv/provision/extensions/pmc/coretech/repos.yml"

vvv_info " * Preparing to clone common code for reuse during site provisioning..."

rm -rf "$CORETECH_DIR"
noroot mkdir "$CORETECH_DIR"
cd "$CORETECH_DIR"

vvv_info " * Starting clone operations..."

set +e
noroot shyaml get-values-0 < "${REPO_LIST}" |
while IFS='' read -r -d '' key &&
      IFS='' read -r -d '' value; do
  echo " * Cloning '${value}' into '${CORETECH_DIR}/${key}'"
  noroot git clone --recursive --quiet "${value}" "${CORETECH_DIR}/${key}"
done
set -e

