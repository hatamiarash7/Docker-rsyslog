#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

# Remove any old pid file
rm -f /var/run/rsyslogd.pid

exec "$@"
