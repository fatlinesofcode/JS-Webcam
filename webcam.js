 /* JS-Webcam | https://github.com/fatlinesofcode/JS-Webcam */
(function(wrapperName) { 
  var o = window[wrapperName] = {};

  o.settings = {
    wrapper   : wrapperName, // reference only - see %%NAME%%
    element   : "webcam",
/* some defaults handled in flash (save a few bytes minified)
    bandwidth : 0,
    quality   : 100,
    framerate : 14,
    mirror    : false,
    deblocking: 0,
    smoothing : false,
*/
    bgcolor   : "#000000",
    wmode     : "opaque"
  };


  o.onError = function() { };
  o.onReady = function() { };


  o.documentReady = false;
  var preLoad = window.onload;
  window.onload = function() {
    if(typeof preLoad == 'function') preLoad();
    o.documentReady = true;
  };

  o.embed = function(src, width, height, settings) {
    if(settings != undefined) 
      this.applySettings(settings);
    this.settings.windowWidth = width;
    this.settings.windowHeight = height;
    swfobject.embedSWF(src, this.settings.element, width, height, "11.1.0", null, this.settings, 
      { wmode: this.settings.wmode, bgcolor: this.settings.bgcolor }, null, 
      function(e) { if(!e.success) window[wrapperName].onError({flag: "NOFLASHPLAYER"}); }
    );
  };

  o.isClientReady = function() {
    return !!this.documentReady;
  };

  o.applySettings = function(obj) {
    if(typeof obj == 'object') 
      this.settings = merge(this.settings, obj);
  };

  o.swfReady = function() {
    var el = document.getElementById(this.settings.element);
    this.play = function() { try { return el.play(); } catch (e) { return false; } };
    this.pause = function() { try { return el.pause(); } catch (e) { return false; } };
    this.save = function(resMode) { try { return el.save(resMode); } catch (e) { return false; } };
    this.setCamera = function(i) { try { return el.setCamera(i); } catch (e) { return false; } };
    this.getCameras = function() { try { return el.getCameras(); } catch (e) { return false; } };
    this.chooseCamera = function() { try { return el.chooseCamera(); } catch (e) { return false; } };
    this.getResolution = function() { try { return el.getResolution(); } catch (e) { return false; } };
    this.onReady();
  };

  function merge(baseObj, newObj) {
    for(var key in newObj) 
    if(newObj.hasOwnProperty(key))
      baseObj[key] = newObj[key];
    return baseObj;
  };

})("webcam"); // %%NAME%% - set wrapper name in anonymous function call
              // so it can be changed after being minified if required.

