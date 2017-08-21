#!/bin/bash
#
# Copyright 2017 International Business Machines
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

/usr/sbin/groupadd -g 505 build
/usr/sbin/useradd -u 505 -g 505 -m -s /bin/bash build
cat <<EOF >/etc/sudoers.d/00-build
Defaults: build !requiretty
Defaults: root !requiretty
build ALL=(ALL) NOPASSWD: ALL
EOF
chmod 0440 /etc/sudoers.d/00-build

