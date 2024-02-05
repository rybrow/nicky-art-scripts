#! /bin/bash

./requirements.sh

# Create /scripts directory
mkdir /scripts
cp ./scan.sh /scripts/scan.sh

# Copy Service file to service directory
cp ./scanner_loop.service /etc/systemd/system/scanner_loop.service

# Reload and Enable Service

systemctl daemon-reload
sytemctl enable scanner_loop.service

