#!/bin/sh

FLEX_SDK_HOME="/Applications/Adobe/flex_sdks/4.5.0_a3.0"
JAVA6_PATH="/usr/bin/java"
MAKE="$JAVA6_PATH -jar $FLEX_SDK_HOME/lib/mxmlc.jar +flexlib=$FLEX_SDK_HOME/frameworks webcam.as"

echo "Executing:"
echo $MAKE
echo " "
echo `$MAKE`

