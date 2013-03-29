## Overview
Capture jpeg image from AS3 webcam using javascript.

## Usage

```javascript

//-------------------- initialise the webcam
    (function () {
        var preLoaded = window.onload;
        window.onload = function () {
            if (typeof preLoaded == 'function') preLoaded();
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

* added: bug fix, onReady not triggered if camera settings are remembered.
* added: better example of image capture using jQuery.



**@see** https://github.com/Digigizmo/JS-Webcam