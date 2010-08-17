#!/bin/bash

########################
# resize.sh
# This is Free Software
#
# ######################
# This software use `ImageMagick`
#
# If you are using Ubuntu
# type
#
# $ sudo apt-get install imagemagick
#
# to install `ImageMagick`
#
########################
# Usage
#
# sh resize.sh SRC-DIRECTORY GEOMETORY [TYPE] [DIST-DIRECTORY]
#
# eg.
#
# sh resize.sh ~/Picture 500x500
#
# This makes DIRECTORY `resize` in ~/Picture , and then make resized image as 500x500
# in ~/Picture/resize/ , geometry is not changed.
#
# If you want to change geometry run resize.sh like
#
# sh resize.sh ~/Picture 500x500!
#

SRC=$1
GEOMETORY=$2
TYPE=$3
DIST=$4


if [ -z $SRC ] ; then
    echo $0 SRC-DIRECTORY GEOMETORY [TYPE] [DIST-DIRECTORY]
    exit 0
elif [ -z $GEOMETORY ] ; then
    echo $0 SRC-DIRECTORY GEOMETORY [TYPE] [DIST-DIRECTORY]
    exit 0
fi

if [ -z $TYPE ] ; then
    TYPE="*"
fi

if [ -z $DIST ] ; then
    DIST="resize"
fi

if [ -d $SRC/$DIST ] ; then
    echo "$SRC/$DIST exists."
else
    if mkdir $SRC/$DIST ; then
        echo "mkdir $SRC/$DIST"
    else
        exit 0
    fi
fi

echo "cp $SRC/* $SRC/$DIST/"
find $SRC/* -maxdepth 0 -type f -exec cp -f {} $SRC/$DIST/ \;

echo "cd $SRC/$DIST"
cd $SRC/$DIST

echo "resizing..."
if mogrify -geometry $GEOMETORY $TYPE ; then
    echo "done."
else
    echo "fail."
fi


