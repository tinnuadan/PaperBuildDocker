#!/bin/bash

rootdir=/app/
cd $rootdir

git clone https://github.com/tinnuadan/PaperBuild.git
cp config.ini PaperBuild/
cd PaperBuild
bash build.sh

cd $rootdir
#copy new files
cp PaperBuild/build . -ur
#remove temporary build files
rm -rv PaperBuild/build

#remove all but n builds
n=10
cd build
for branch in *; do
    if $(test -d $branch); then
        cd $branch
        ls -tp | grep -v '/$' | tail -n +$(expr $n + 1) | xargs -I {} rm -- {}    
        cd ..
    fi
done
