# Build arguments
ARG PROJECT_NAME="cppner"
ARG CMAKE_VERSION="3.18"
ARG buildpath="./build"
# Image dependencies
FROM estebanmatias92/gccplus:latest as buildeps
FROM estebanmatias92/gccplus-coding:latest as devdeps


#
# Image to compile the source code to binary
#
FROM buildeps as builder
# Modifyble through cli args
ARG PROJECT_NAME
ARG CMAKE_VERSION
ARG buildpath
# Runtime usage
ENV PROJECT_NAME=${PROJECT_NAME}
ENV CMAKE_VERSION=${CMAKE_VERSION}
ENV buildpath=${buildpath}

WORKDIR /code
# Pull the source code
COPY . .
# Add the build script commands to the shell session and run the build instruction
RUN ./build.sh && ./install.sh


#
# Preparing the runtime artifacs
#
FROM debian:stable-slim as runtime
# Copy the binaries from the build to the current directory
COPY --from=builder /usr/local /usr/local
# Regenerate the shared-library cache.
RUN ldconfig


#
# VS Code Stage 
# (This is preferred to run as a Docker Dev Environment)
#
FROM devdeps AS development
# Modifyble through cli args
ARG PROJECT_NAME
ARG CMAKE_VERSION
ARG WORKDIR=/com.docker.devenvironments.code
ARG buildpath
# Runtime usage
ENV PROJECT_NAME=${PROJECT_NAME}
ENV CMAKE_VERSION=${CMAKE_VERSION}
ENV buildpath=${buildpath}
# Create and change user
ARG DEVUSER="vscode"
RUN useradd -s /bin/bash -m $DEVUSER \
    && groupadd docker \
    && usermod -aG docker $DEVUSER
USER $DEVUSER
# Get the build script commands added to the shell session
COPY --chown=${DEVUSER}:docker script.sh ${WORKDIR}/
RUN echo "\n#Add script for building\n. ${WORKDIR}/script.sh" >> $HOME/.bashrc 
# Keep the container alive
CMD ["sleep", "infinity"]


#
# Production Target Stage 
# Normally called without specifying "target" in compose
#
FROM runtime as production

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}
# Run the container as an executable
ENTRYPOINT ${PROJECT_NAME}