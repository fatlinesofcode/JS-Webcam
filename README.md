# JS-Webcam / v1.0.0
*9th Feb 2013 // Myles Jubb*

**@see** https://github.com/Digigizmo/JS-Webcam

## Overview
*Forked from [jQuery-AS3-Webcam](https://github.com/sshilko/jQuery-AS3-Webcam) [sshilko]*

Rewritten Flash-based webcam and Javascript wrapper allowing you to save images as base64 encoded data URI.  Many of the differences purely suit preference but there are also some additions that may lend themself better to your own situation.  Key points as follows:

* **Stripped out jQuery**  
If you want to use jQuery inside the event handlers, groovy - it's just nice when it's optional.
* **Embedded with sfwobject**  
Dynamic, cross-browser and versatile.  Note you can load this yourself (before the webcam scripts are embedded) if you already have the Google jsapi in your page then simply use: `google.load("swfobject", "2.2");` 
* **Simplified API**  
Fewer hooks, ie. single handler for errors, `settings` in their own context and single set of width/height - attempts to force best fit to the size of the embedded object (best to try and keep to a 4:3 aspect ratio)
* **Mirror Mode**  
When the intended use for the webcam is to point it at the user while they are watching the screen, then it's disorientating - this setting flips the image horizontally.
* **Saving can now scale image**  
By default images are saved at the camera's output resolution, but you can optionally specify to have Flash scale the image to the same size at which the video is being viewed - in most cases this will be scaled up with inevitably low quality but this behaviour was none the less missing.
* **Switch camera**  
The original get and set cameras are preserved but added an API call to the native Flash prompt that allows you to switch camera without having to fuss about your own interface.

## Usage

The following swfobject and webcam*.js can be embedded anywhere but must appear before the code below in this order.  If for any reason you wish to change the name of the `webcam` variable in the global scope, you can edit the string at the end of the last line in `webcam.min.js` 

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

Once you have set up hooks on the event handlers, settings can be passed to the embed function when initialising - the following settings reflect their default state.

```javascript
(function(){ 
  var preLoaded = window.onload;
  window.onload = function(){
    if(typeof preLoaded == 'function') preLoaded();
    webcam.embed('di/rec/tory/webcam.swf', 500, 375, {
      element   : "webcam",    // DOM ID to be replaced with SWF object
      bandwidth : 0,           // camera - bytes/second cap.
      quality   : 100,         // 0..100 video and saved image quality
      framerate : 14,          // Desired framerate (may be overruled)
      mirror    : false,       // Flip video on x-axis
      deblocking: 0,           // see: flash.media.Video api
      smoothing : false,       // ditto
      bgcolor   : "#000000",   // Ronseal
      wmode     : "opaque"     // window, opaque, transparent
    });
  };
})();
```

### API Calls

While a camera is rolling you may make any of the following API calls.

`webcam.save(resMode); `  
returns base64 Jpeg data URI or false  
params (optional):
* `'camera'` - **default** - returns image at camera's best fit resolution
* `'window'` - returns camera's resolution scaled to fit embedded object

`webcam.getCameras();`  
returns zero-indexed array of camera names  
params *none*

`webcam.setCamera(i);`  
returns true or false depending on success  
params (required):
* integer matching camera from list of cameras

`webcam.chooseCamera();`  
shows Flash security prompt on "choose cam" tab  
returns true or false on api success  
params *none*

`webcam.getResolution();`  
returns object containing resolutions for the flash `camera`, `stage` and `window`  
params *none*


### Miscellaneous Notes

* The webcam will not work on a local machine, test on a server.

* `webcam.save` will now pass the the image including the proper URI scheme.  When saving an image, the video will pause on the last frame - you can start the webcam again by setting the appropriate camera id, eg. `webcam.setCamera(0);`


[END]
