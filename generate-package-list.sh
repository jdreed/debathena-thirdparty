#!/bin/sh

set -e

CHDIST_DATA=$(mktemp -d)
DISTRO=$(lsb_release -sc)
: ${MIRRORHOST=localhost:9999}
if [ "$(lsb_release -is)" = "Ubuntu" ]; then
    chdist --data-dir "$CHDIST_DATA" create "$DISTRO" http://$MIRRORHOST/ubuntu $DISTRO main restricted universe multiverse
    chdist --data-dir "$CHDIST_DATA" apt-get "$DISTRO" update
    export APT_CONFIG="$CHDIST_DATA/$DISTRO/etc/apt/apt.conf"
fi
./generate-package-list.pl
rm -rf "$CHDIST_DATA"
exit 0
