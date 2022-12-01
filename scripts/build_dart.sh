#!/usr/bin/zsh

# Codesandbox.io has a file sync mechanism that keeps the browser client files list and the container file system in sync.
# The sync mechanism freaks out when Dart's build process creates files too quickly and creates files that are too large and will disable file sync all togeather.
# To avoid this, we clone the project directory to a directory not in scope of the file sync mechanism and run the build and serve the project from there.
# cs_hostname=$(echo "$CODESANDBOX_HOST:s/"\$PORT"/"8080"") 
export PATH=$PATH:/project/codesandbox-overreact/dart-sdk/bin:$HOME/.pub-cache/bin
pwd
dart pub get 
dart pub global activate webdev
# webdev serve web:9000 --auto=refresh &
# node ./scripts/proxy.js 9000 8080
dart run build_runner watch --release -o ./build web --delete-conflicting-outputs &
cd /project/codesandbox-overreact/build/web
npx live-server --wait=500 --ignorePattern=".*(\.(dart|ddc\.js)|/test/).*" --port=8080
   