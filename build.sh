#!/bin/bash

rootdir=/app/
cd $rootdir

git clone https://github.com/tinnuadan/PaperBuild.git
cp config.ini PaperBuild/
cd PaperBuild
bash build.sh

cd $rootdir
cp PaperBuild/build . -ur
rm -rv PaperBuild/build
