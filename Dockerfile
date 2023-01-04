#
# Base Stage
#
FROM gcc:11 as base

LABEL description="Installing dependencies..."

# Arguments
ARG PROJECT_NAME="cppcli"
ARG CMAKE_VERSION="3.18"
# Sotring the variables in the container
ENV CMAKE_VERSION=$CMAKE_VERSION
ENV PROJECT_NAME=$PROJECT_NAME

RUN apt-get update && apt-get install -y --no-install-recommends \
        binutils \
        cmake \
        libboost-dev \
        ninja-build \
    && apt-get clean



#
# Build Stage
#
FROM base as builder

LABEL description="Building project..."

# Create folder for app service and change directory
WORKDIR /workdir/app

# Copying all the files from app to container's workdir
COPY . .

# Build the binaries
RUN chmod +x ./build_and_start.sh && ./build_and_start.sh



#
# VS Code Stage 
# (This is preferred to run as a Docker Dev Environment)
#
FROM base AS development

# Get packages for editors and CVS
RUN apt-get update && apt-get install -y \
        cppcheck \
        flawfinder \
        git \
        gdb \
    && apt-get clean

COPY build_and_start.sh .

RUN chmod +x ./build_and_start.sh

# Create and change user
ARG VSCODEUSER="vscode"

RUN useradd -s /bin/bash -m $VSCODEUSER \
    && groupadd docker \
    && usermod -aG docker $VSCODEUSER

USER $VSCODEUSER

# Keep the container alive
CMD ["sleep", "infinity"]



#
# Production Target Stage 
# Normally called without specifying "target" in compose
#
FROM debian:stable-slim

LABEL description="Creating runtime container..."

# Get the Environment Variable
ARG PROJECT_NAME
ENV PROJECT_NAME=$PROJECT_NAME

# Create production ready folder for the binaries and change directory
WORKDIR /usr/local/app

# Copy the binaries from the build to the current directory
COPY --from=builder /workdir/app/build .
    
# Execute the app
CMD ./src/${PROJECT_NAME}