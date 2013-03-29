## Usage
```
<div id="webcam"></div><!-- see: mywebcam.js for configuration -->
    <hr/>
    <button id="takephoto">take photo</button>
    <div id="result"></div>
    <script src="//ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="webcam.js"></script>
```

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