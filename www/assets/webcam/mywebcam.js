//-------------------- custom event handlers
(function(){

  webcam.onReady = function(){
    console.log('ready'); 
  };

  webcam.onError = function(e){
    switch(e.flag||false){

      case 'CAMNOTFOUND': 
        console.error('No webcam detected!'); 
        break;

      case 'CAMDISABLED': 
        console.warn('We need permission to access the webcam.');
        break;

      case 'NOFLASHPLAYER': 
        console.error('No up-to-date flash player installed. (min. 11.1.0)');
        break;

      default:
        console.log('Webcam: unknown error.');
    }
  };


})();


//-------------------- initialise the webcam
(function(){ 
  var preLoaded = window.onload;
  window.onload = function(){
    if(typeof preLoaded == 'function') preLoaded();
    webcam.embed('assets/webcam/webcam.swf', 500, 375, {
      mirror    : true,
      smoothing : true,
      framerate : 20
    });
  };
})();
