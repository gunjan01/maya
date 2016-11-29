#!/bin/bash

set -ex

GO_VERSION="1.7.3"

# Setup go, for development
SRCROOT="/opt/go"
SRCPATH="/opt/gopath"

# Get the ARCH
ARCH=`uname -m | sed 's|i686|386|' | sed 's|x86_64|amd64|'`

# Install Go
cd /tmp

curl -sSL https://storage.googleapis.com/golang/go${GO_VERSION}.linux-${ARCH}.tar.gz
tar -xf go${GO_VERSION}.linux-${ARCH}.tar.gz
sudo mv go $SRCROOT
sudo chmod 775 $SRCROOT
sudo chown vagrant:vagrant $SRCROOT

# Setup the GOPATH; 
# This allows subsequent "go get" commands to work.
sudo mkdir -p $SRCPATH
sudo chown -R vagrant:vagrant $SRCPATH 2>/dev/null || true
# ^^ silencing errors here because we expect this to fail for the shared folder

cat <<EOF >/tmp/gopath.sh
export GOPATH="$SRCPATH"
export GOROOT="$SRCROOT"
export PATH="$SRCROOT/bin:$SRCPATH/bin:\$PATH"
EOF

sudo mv /tmp/gopath.sh /etc/profile.d/gopath.sh
sudo chmod 0755 /etc/profile.d/gopath.sh
source /etc/profile.d/gopath.sh