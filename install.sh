#!/bin/sh

if [ $(whoami) != "root" ] 
then
    cmake --install $buildpath --prefix $HOME/opt/
else
    cmake --install $buildpath
fi