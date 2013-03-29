## Overview

Rewritten Flash-based webcam and Javascript wrapper allowing you to save images as base64 encoded data URI.  Many of the differences purely suit preference but there are also some alterations that may lend themself better to your own situation.  Key points as follows:

## Usage

```javascript

//-------------------- initialise the webcam
    (function () {
        var preLoaded = window.onload;
        window.onload = function () {
            if (typeof preLoaded == 'function') preLoaded();
            //webcam.embed('webcam.swf', 500, 375, {
            webcam.embed('webcam.swf', 640, 480, {
                mirror: true,
                smoothing: true,
                framerate: 20,
                shutterSound: 'shutter.mp3'
            });
        };
    })();

// take a photo and append img in result div
        $("#takephoto").click(function () {
            var result = webcam.save('window');
            var img = new Image();
            img.src = result;
            $("#result").append(img);

        });
```

#forked from: JS-Webcam - 9th Feb 2013
*// Myles Jubb @Digigizmo*

* added fixed bug: onReady not trigger if camera settings are remember.
* added better example of image capture using jQuery.



**@see** https://github.com/Digigizmo/JS-Webcam