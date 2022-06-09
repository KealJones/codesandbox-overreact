#!/bin/bash

# Codesandbox.io has a file sync mechanism that keeps the browser client files list and the container file system in sync.
# The sync mechanism freaks out when Dart's build process creates files too quickly and creates files that are too large and will disable file sync all togeather.
# To avoid this, we clone the project directory to a directory not in scope of the file sync mechanism and run the build and serve the project from there.

PROJECT_SRC_DIR=/sandbox
PROJECT_CLONE_DIR=/dart-project-clone
PROJECT_BUILD_DIR=/dart-build
dart=/sandbox/dart/dart-sdk/bin/dart

mkdir $PROJECT_CLONE_DIR

daemon() {
    chsum1=""
    pubchsum1=""

    while :
    do
        # Monitor pubspec.yaml for changes and run `pub get` 
        pubchsum2=`find /sandbox/pubspec.yaml -type f -exec md5sum {} \;`
        if [[ $pubchsum1 != $pubchsum2 ]] ; then           
            if [ -n "$pubchsum1" ]; then
                cloneproject
                cd $PROJECT_CLONE_DIR
                $dart pub get
            fi
            pubchsum1=$pubchsum2
        fi
        # Monitor project for file changes and run build
        chsum2=`find /sandbox/ -type f -exec md5sum {} \;`
        if [[ $chsum1 != $chsum2 ]] ; then           
            if [ -n "$chsum1" ]; then
                cloneproject
                cd $PROJECT_CLONE_DIR
                $dart run build_runner build -o $PROJECT_BUILD_DIR web
            fi
            chsum1=$chsum2
        fi
        sleep 2
    done
}

cloneproject() {
    rm -rf $PROJECT_CLONE_DIR/*
    cp -rs /sandbox/. $PROJECT_CLONE_DIR
}

cloneproject
cd $PROJECT_CLONE_DIR
$dart pub get
$dart run build_runner build -o /dart-build web
daemon