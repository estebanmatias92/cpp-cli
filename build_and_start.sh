#!/bin/sh

# Get current script directory path
rootdir=$(dirname $(readlink -f $0))
# Build path for the binaries
binarydir="${rootdir}/build"
# App's executable
executable="${binarydir}/src/${PROJECT_NAME}"

# Log the directories
echo ""
echo "Root: '${rootdir}'"
echo "Binaries: '${binarydir}'"
echo "Executable: '${executable}'"
echo ""

# Make the directory for the build and build the project
build () {
    (mkdir -p $binarydir)
    (cd $binarydir; cmake .. && cmake --build .)
}

run() {
    ${executable}
}

build
run