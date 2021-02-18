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

#remove all but n builds and link latest
n=10
cd build
for branch in *; do
    if $(test -d $branch); then
        cd $branch
        # remove builds
        ls -tp | grep -v '/$' | grep -v '^l' | tail -n +$(expr $n + 1) | xargs -I {} rm -- {}

        #create symbolic link to latest
        latest=$(ls *_* -r1 | head -n 1)
        ln=${latest%_*}-latest.jar
  
        cd ..
    fi
done
