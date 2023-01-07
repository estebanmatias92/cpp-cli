#!/bin/sh

# Get current script directory path
#rootdir=$(dirname $(readlink -f "$0"))
# Build path for the binaries
binarydir="./build"
# App's executable
executable="${binarydir}/src/${PROJECT_NAME}"

# Log the directories
echo "Binaries path: '${binarydir}'"
echo "Executable path: '${executable}'"

echo "Sourcing the script functions..."

# Simply run the exe (function keyword is optional)
run() {
    ${executable}
}

# Make the directory for the build and build the project
build() {
    mkdir -p $binarydir
    (cd $binarydir; cmake .. && cmake --build .)
}

# Remove the build directory
clean() {
    rm -rf ${binarydir}
    [ ! -d ${binarydir} ] && 
        echo "Build directory '${binarydir}' removed successfully." ||
        echo "'${binarydir}' directory could not be removed."
}

# Destroy and re-build everything
rebuild() {
    clean && build
}

echo "Successfully sourced all the functions."