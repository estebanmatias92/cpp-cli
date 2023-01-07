# C/C++ Docker Dev Environment

An isolated Docker Development Environment for building C/C++ CLI Apps.

## Use

### From outside the container/dev-environment

**Compile and run service interactively:**

_`docker compose build app && docker compose run --rm app`_

### Inside the dev-environment

**Compile and run from a C++ environment:**

_`./app/build_and_start.sh`_

## Folder structure

I use the [The Pitchfork Layout (PFL)](https://api.csswg.org/bikeshed/?force=1&url=https://raw.githubusercontent.com/vector-of-bool/pitchfork/develop/data/spec.bs) in order to structure the project.

Modules/Libraries names must be the same as the directory name in which they are.

The src/CmakeLists.txt will search for every subdirectory and add those who have a CMakeLists.txt in it as libraries automatically.
