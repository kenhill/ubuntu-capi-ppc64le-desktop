#!/bin/bash
/usr/sbin/groupadd -g 505 build
/usr/sbin/useradd -u 505 -g 505 -m -s /bin/bash build
cat <<EOF >/etc/sudoers.d/00-build
Defaults: build !requiretty
Defaults: root !requiretty
build ALL=(ALL) NOPASSWD: ALL
EOF
chmod 0440 /etc/sudoers.d/00-build

