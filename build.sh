#!/bin/bash

CURRENT_SCRIPT=`python -c "import os,sys; print os.path.abspath(sys.argv[1])" "$0"`
CURRENT_DIR=`dirname "$CURRENT_SCRIPT"`
SOURCE_DIR=$CURRENT_DIR/src
BUILD_DIR=$CURRENT_DIR/build

FLEX=`type -p mxmlc`

if [ -z $FLEX ]; then
	echo "aborting: Adobe flex compiler (mxmlc) wasn't found. please add it to your path"
	exit 1
fi

# compile ActionScript object directly to 'build' directory
$FLEX $SOURCE_DIR/SoundCanvas.as -use-network=true -target-player 10.0.0 -output $BUILD_DIR/SoundCanvas.swf

# copy auxiliar files to 'build' directory
cp $SOURCE_DIR/SoundCanvas.js $CURRENT_DIR/build