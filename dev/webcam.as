/* JS-Webcam 1.0 | FreeBSD | https://github.com/Digigizmo/JS-Webcam
 * 2013-FEB-09 // Myles Jubb (@Digigizmo)
 *
 * Rewritten AS3 webcam based on example by Sergey Shilko
 *        => https://github.com/sshilko/jQuery-AS3-Webcam
 *
 * ------------------------------------------------------------
 * Major Differences:
 *
 *  >  Stripped out unnecessary jQuery dependency 
 *  >  Added option to flip horizontally (mirror mode)
 *  >  Simplified structure for cleaner JS-API
 *  >  Saving can now optionally scale image to fit embedded object
 *
 * Minor Differences:
 *
 *  >  Added API call to allow flash to handle camera choice
 *  >  Rijigged some remaining functionality - personal pref.
 *
 * ------------------------------------------------------------
 */

package {

  import flash.system.Security;
  import flash.system.SecurityPanel;
  import flash.external.ExternalInterface;
  import flash.display.Sprite;
  import flash.media.Camera;
  import flash.media.Video;
  import flash.display.BitmapData;
  import flash.events.*;
  import flash.utils.ByteArray;
  import flash.utils.Timer;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.display.StageQuality;
  import flash.geom.Matrix;
  import com.adobe.images.JPGEncoder;
  import Base64;

  public class webcam extends Sprite {

    private var settings:Object = {
      bandwidth    : 0,         // max bytes per second - zero prioritises quality
      quality      : 100,       // image & video quality [0-100]
      framerate    : 14,        // frames per second
      mirror       : false,     // flip video horizontally
      smoothing    : false,     // Boolean
      deblocking   : 0,         // Number
      wrapper      : 'webcam',  // JS wrapper name
      windowWidth  : 0,
      windowHeight : 0
    }

    private var cam:Camera      = null;
    private var vid:Video       = null;
    private var img:BitmapData  = null;

    public function webcam():void {
      flash.system.Security.allowDomain("*");
      stage.scaleMode = StageScaleMode.EXACT_FIT;
      stage.quality   = StageQuality.BEST;
      stage.align     = ''; // centre
      settings        = merge(settings, this.loaderInfo.parameters);

      cam = Camera.getCamera();

      if(cam != null) {
        if(cam.muted) Security.showSettings(SecurityPanel.PRIVACY);
        if(ExternalInterface.available){
          loadCamera();
          var timer:Timer = new Timer(250);
          timer.addEventListener(TimerEvent.TIMER, clientReadyListener);
          timer.start();
        } else {

        }
      } else { 
        error('CAMNOTFOUND');
      }
    } 

    private function loadCamera(name:String = '0'):void {
      cam = Camera.getCamera(name);
      cam.addEventListener(StatusEvent.STATUS, cameraStatusListener);
      cam.setMode(stage.stageWidth, stage.stageHeight, settings.framerate);
      cam.setQuality(settings.bandwidth, settings.quality);
      vid = new Video(cam.width, cam.height);
      vid.smoothing = settings.smoothing;
      vid.deblocking = settings.deblocking;
      vid.attachCamera(cam);
      if(!!settings.mirror){
        vid.scaleX = -1;
        vid.x = vid.width + vid.x;
      }
      stage.addChild(vid);
    }

    private function cameraStatusListener(evt:StatusEvent):void {
      if(!cam.muted) triggerEvent('swfReady');
      else error('CAMDISABLED');
    }

    private function triggerEvent(func:String, param:Object = null):Boolean {
      return ExternalInterface.call(settings.wrapper + "." + func, param);
    }

    private function error(flag:String = '0'):Boolean {
      return triggerEvent('onError', {'flag':flag});
    }

    private function clientReadyListener(event:TimerEvent):void {
      if(!!triggerEvent('isClientReady')){
        Timer(event.target).stop();
        ExternalInterface.addCallback('save'         , save         );
        ExternalInterface.addCallback('setCamera'    , setCamera    );
        ExternalInterface.addCallback('getResolution', getResolution);
        ExternalInterface.addCallback('getCameras'   , getCameras   );
      }
    }

    public function getResolution():Object {
      return { 
        camera : { width: cam.width           , height: cam.height            },
        window : { width: settings.windowWidth, height: settings.windowHeight },
        stage  : { width: stage.stageWidth    , height: stage.stageHeight     }
      };
    }

    public function getCameras():Array {
      return Camera.names;
    }

    public function setCamera(id:String):Boolean {
      loadCamera(id.toString());
      return !!cam;
    }

    public function chooseCamera():Boolean {
      Security.showSettings(SecurityPanel.CAMERA);
      return true;
    }

    public function save(resMode:String = ''):String {
      if(resMode!='stage' && resMode!='window') resMode = 'camera';
      var c:Object = getResolution()['camera'];
      var r:Object = getResolution()[resMode];
      var m:Matrix = new Matrix();
      var f:Number = !!settings.mirror ? -1 : 1;
      img = new BitmapData(r.width, r.height);
      if(c.width!=r.width || c.height!=r.height){
        var imgT:BitmapData = new BitmapData(c.width, c.height);
        m.scale(f * r.width / c.width, r.height / c.height);       
      } else {
        m.scale(f * 1, 1);
      }
      if(!!settings.mirror) 
        m.translate(r.width, 0);
      img.draw(vid, m);
      vid.attachCamera(null); // pause 
      var byteArray:ByteArray = new JPGEncoder(settings.quality).encode(img);
      var string:String = 'data:image/jpeg;base64,' + Base64.encodeByteArray(byteArray);
      return string;
    }

    public static function merge(base:Object, overwrite:Object):Object {
      for(var key:String in overwrite) 
        if(overwrite.hasOwnProperty(key)){
          // lazy data type fix
          if(!isNaN(overwrite[key])) base[key] = parseInt(overwrite[key]);
          else if(overwrite[key]==='true') base[key] = true;
          else if(overwrite[key]==='false') base[key] = false;
          else base[key] = overwrite[key];
        }
      return base;
    }

  }
}
