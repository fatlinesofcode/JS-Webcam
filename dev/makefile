#!/bin/bash

# cd [project-folder]/dev; bash makefile

# SWF built with FLEX: http://www.adobe.com/devnet/flex/flex-sdk-download.html
# JS minified with Google Closure: https://developers.google.com/closure/compiler/

eval MYTOOLS="~/dev/.tools"
eval PROJECT="~/dev/js-webcam"

     DIR_CAM="/www/assets/webcam"

     MAKESWF="$MYTOOLS/flex/bin/mxmlc -static-link-runtime-shared-libraries=true webcam.as"
     MAKE_JS="$MAKE_JS java -jar $MYTOOLS/jscompiler.jar --js webcam.js --js_output_file webcam.min.js"

# run
clear


echo -e "JS-WEBCAM: make\n\nBuild: webcam.as\n--------------------\n"
$MAKESWF
mv -f webcam.swf "$PROJECT$DIR_CAM"
echo -e "\nMinify: webcam.js\n--------------------\n"
$MAKE_JS
echo "/* JS-Webcam | 2013-FEB-09 | https://github.com/Digigizmo/JS-Webcam */" > webcam.min.js~
cat webcam.min.js >> webcam.min.js~
mv -f webcam.min.js~ webcam.min.js
mv -f webcam.min.js "$PROJECT$DIR_CAM"
# create bare essentials zip
echo -e "\nZipping Assets:\n--------------------\n"
cd $PROJECT
rm the-bare-essentials.zip
cp -r www js-webcam
echo 'For documentation see: https://github.com/Digigizmo/JS-Webcam' > js-webcam/readme.txt
zip -r the-bare-essentials.zip js-webcam
rm -r js-webcam
echo -e "\n...DONE\n"

