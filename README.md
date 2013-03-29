

#added fixed bug: onReady not trigger if camera settings are remember.
#added better example of image capture using jQuery.
```javascript
            $("#takephoto").click(function(){
                var result = webcam.save('window');
                var img = new Image();
                img.src = result;
                $("#result").prepend(img);

            });
```

#forked from:
# JS-Webcam - 9th Feb 2013
*// Myles Jubb @Digigizmo*

**@see** https://github.com/Digigizmo/JS-Webcam