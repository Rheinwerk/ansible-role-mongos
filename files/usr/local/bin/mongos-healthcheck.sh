#!/bin/bash -u

if [[ $# != 1 ]]; then
  echo "usage: $(basename "$0") <host>[:port]"
  # sysexits(3) : EX_USAGE
  exit 64
fi

HOST="$1"

mongo --norc --quiet --tls --host "$HOST" --eval 'db.runCommand({ping: 1})' || exit 2
