#!/bin/bash

function setupdartpath() {
  # cd /
  # mkdir -p /dart
  # cd /dart
  # curl "https://storage.googleapis.com/dart-archive/channels/stable/release/2.13.4/sdk/dartsdk-linux-x64-release.zip" -o "sdk.zip"
  # unzip -n -d /dart sdk.zip
  cat >> ~/.bashrc << EOT
  export PATH=$PATH:/sandbox/dart/dart-sdk/bin:~/.pub-cache/bin
EOT
  PATH=$PATH:/sandbox/dart/dart-sdk/bin:~/.pub-cache/bin
  # Reload current environment
  source ~/.bashrc
}

setupdartpath
