# Build arguments
ARG PROJECT_NAME="cppner"
ARG CMAKE_VERSION="3.18"
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
# Runtime usage
ENV PROJECT_NAME=${PROJECT_NAME}
ENV CMAKE_VERSION=${CMAKE_VERSION}

WORKDIR /project
# Pull the source code
COPY . .
# Add the build script commands to the shell session and run the build instruction
RUN . ./build.sh && build


#
# Preparing the runtime artifacs
#
FROM debian:stable-slim as runtime

WORKDIR /root/app
# Copy the binaries from the build to the current directory
COPY --from=builder /project/build/ .


#
# VS Code Stage 
# (This is preferred to run as a Docker Dev Environment)
#
FROM devdeps AS development
# Modifyble through cli args
ARG PROJECT_NAME
ARG CMAKE_VERSION
ARG WORKDIR=/com.docker.devenvironments.code
# Runtime usage
ENV PROJECT_NAME=${PROJECT_NAME}
ENV CMAKE_VERSION=${CMAKE_VERSION}
# Create and change user
ARG DEVUSER="nonroot"
RUN useradd -s /bin/bash -m $DEVUSER \
    && groupadd docker \
    && usermod -aG docker $DEVUSER
USER $DEVUSER
# Get the build script commands added to the shell session
COPY --chown=${DEVUSER}:docker build.sh ${WORKDIR}/
RUN echo "\n#Add script for building\n. ${WORKDIR}/build.sh" >> $HOME/.bashrc 
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
ENTRYPOINT ./src/${PROJECT_NAME}