# PaperBuildDocker
Docker container for paper build

## Setup
* Copy config.ini.example to config.ini and adapt if necessary
* Adapt build.sh if necesarry, by default the last 10 builds will be kept in the container
* Build docker `docker build /path/to/directory/with/Dockerfile -t paperbuild`

## Compiling custom paper 
Just run the container everytime you want to build a new paper.jar

## Getting the files
`cp docker cp <containerId>:/app/build/ /host/target/path/`
(also works if container is not running)

The build directory will have the structure `build/<branch>/paper-<version>-<compiledate>.jar`. You can always find a `paper-<version>-latest.jar` which links to the last compiled jar.