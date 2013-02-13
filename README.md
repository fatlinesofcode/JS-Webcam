# JS-Webcam - 9th Feb 2013
*// Myles Jubb @Digigizmo*

**@see** https://github.com/Digigizmo/JS-Webcam

## Overview

Rewritten Flash-based webcam and Javascript wrapper allowing you to save images as base64 encoded data URI.  Many of the differences purely suit preference but there are also some alterations that may lend themself better to your own situation.  Key points as follows:

* **Stripped out jQuery**  
If you want to use jQuery inside the event handlers, groovy - it's just nice when it's optional.
* **Embedded with sfwobject**  
Dynamic, cross-browser and versatile.  Note you can load this yourself (before the webcam scripts are embedded) if you already have the Google jsapi in your page then simply use: `google.load("swfobject", "2.2");` 
* **Simplified API**  
Fewer hooks, ie. single handler for errors, settings in their own context and single set of width/height - attempts to force best fit to the size of the embedded object (best to try and keep to a 4:3 aspect ratio)
* **Mirror Mode**  
When the intended use for the webcam is to point it at the user while they are watching the screen, then it's disorientating - this setting flips the image horizontally.
* **Saving can now scale image**  
By default images are saved at the camera's output resolution, but you can optionally specify that Flash scale the image to the same size at which the video is being viewed - in most cases this will be scaled up with inevitably lower quality but this behaviour was none the less missing.
* **Switch camera**  
The original get and set cameras are preserved but added an API call to the native Flash prompt that allows you to switch camera without having to fuss over your own interface.
* **Shutter sounds**  
Optional and loaded externally so as not to increase the filesize of the SWF, when embedding the camera you can pass a URL to a small sound file which will be triggered when saving an image.


## Usage

The scripts to include the webcam can be added anywhere within your HTML document so long as they appear in the following order.  If for any reason you wish to change the name of the webcam object in the global scope, you can edit the string at the end of the last line in `webcam.min.js` 

```html
<script src="https://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
<script src="di/rec/tory/webcam.min.js"></script>
```

### Event Handlers

* `webcam.onReady = function( ){ }`  
Fires when the camera is rolling

* `webcam.onError = function(e){ }`  
Passes `e:Object{ flag:String }` on the following events
  -  `CAMNOTFOUND` no cameras connected or switched on
  -  `CAMDISABLED` camera/s found but user has denied permission
  -  `NOFLASHPLAYER` there is no flash player, or it's out of date (the SWF was compiled with version 11.1)


### Initialising

`webcam.embed(swfFilePath, width, height [, settings]);`

Once you have hooked your functions onto the event handlers, settings can be passed to the embed function - the following settings reflect their **default** state.

```javascript
(function(){ 
  var preLoaded = window.onload;
  window.onload = function(){
    if(typeof preLoaded == 'function') preLoaded();
    webcam.embed('di/rec/tory/webcam.swf', 500, 375, {
      element      : "webcam",    // DOM ID to be replaced with SWF object
      bandwidth    : 0,           // camera - bytes/second cap.
      quality      : 100,         // 0..100 video and saved image quality
      framerate    : 14,          // Desired framerate (may be overruled)
      mirror       : false,       // Flip video on x-axis
      deblocking   : 0,           // see: flash.media.Video api
      smoothing    : false,       // ditto
      bgcolor      : "#000000",   // Ronseal
      wmode        : "opaque",    // window, opaque, transparent
      shutterSound : ''           // URL to sound file to play while saving
    });
  };
})();
```

### API Calls

While a camera is rolling you may make any of the following API calls.

`webcam.save(resMode);`  
returns base64 Jpeg data URI or false  
params (optional):
* `'camera'` - **default** - returns image at camera's best fit resolution
* `'window'` - returns camera's resolution scaled to fit embedded object


`webcam.getCameras();`  
returns zero-indexed array of camera names  


`webcam.setCamera(i);`  
returns true or false depending on success  
params (required):
* integer matching camera from list of cameras


`webcam.chooseCamera();`  
shows Flash security prompt on "choose cam" tab  
returns true or false on api success


`webcam.getResolution();`  
returns object containing resolutions for the flash `camera`, `stage` and `window`


`webcam.pause();`  
Pauses the video on the last frame


`webcam.play();`  
Restarts the last camera that was set


### Miscellaneous Notes

* The webcam will not work on a local machine, test on a server.

* Saving an image will now pass the the base64 encoded string including the proper URI scheme.

* When saving an image, the video will pause on the last frame - `webcam.play()` will start it again.



## TODO

* Saving an image while the video is paused will result in a blank image.


## Licence

<<<<<<< HEAD
Source code: MIT / public domain - no warranty, no liability.

The file: `shutter.mp3` is Copyright and lent courtesy of [soundjay.com](http://www.soundjay.com).
=======
Source Code: MIT / public domain - no warranty, no liability.

The file named `shutter.mp3` is property of [soundjay.com](http://www.soundjay.com) and included with permission.
>>>>>>> 886c5396095b007db7c454c431f1d1da388723b5





*[EOF]*
