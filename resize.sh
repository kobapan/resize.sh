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
# eg1.
# sh resize.sh ~/Picture 500x500
#
# This makes DIRECTORY `resize` in ~/Picture , and then make resized image as 500x500
# in ~/Picture/resize/ , geometry is not changed.
#
# If you want to change geometry run resize.sh like
#
# sh resize.sh ~/Picture 500x500!
#
# eg2.
# sh resize.sh filename.jpg 500x500
#
# This resize filename.jpg as 500x500.
#
# eg3.
# sh resize.sh filename.jpg 500x500 newfile.jpg
#
# This copy filename.jpg to newfile.jpg resized as 500x500.

SRC=$1
GEOMETORY=$2

if [ $# == "0" ] ; then
# Help
    
	echo "Usage: sh resize.sh SRC GEOMETRY [DIST] [TYPE]
Resize images from SRC (file or folder) as GEOMETRY

eg1.
sh resize.sh ~/Picture 500x500
This makes DIRECTORY 'resize' in ~/Picture , and then make resized image as 500x500 in ~/Picture/resize/ , geometry is not changed.

eg2.
sh resize.sh filename.jpg 500x500
This resize filename.jpg as 500x500.

eg3.
sh resize.sh filename.jpg 500x500 newfile.jpg
This copy filename.jpg to newfile.jpg resized as 500x500.

"

	
elif [ -f $SRC ] ; then
# Resize file

	DIST=$3
	
	if [ -z $GEOMETORY ] ; then
	    echo $0 SRC-DIRECTORY GEOMETORY [DIST-FILE]
	    exit 0
	fi
	
	if [ -z $DIST ] ; then
	    DIST=$SRC
	else
		cp $SRC $DIST
	fi
	
	echo "resizing..."
	if mogrify -geometry $GEOMETORY $DIST ; then
	    echo "done."
	else
	    echo "fail."
	fi
	

else
# Resize folder
	SRC=$1
	GEOMETORY=$2
	DIST=$3
	TYPE=$4
	
	if [ -z $GEOMETORY ] ; then
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

fi
