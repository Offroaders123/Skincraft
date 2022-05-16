package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.media.SoundMixer;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.net.registerClassAlias;
   import flash.system.System;
   import flash.text.TextField;
   import flash.ui.ContextMenu;
   import flash.utils.ByteArray;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public final class Utilities
   {
      
      public static var sharedObject:SharedObject;
      
      private static var fader:Sprite;
      
      private static var curFrameRate:Number;
      
      public static var saveFile:SaveFile;
      
      static var gameFrameRate:uint;
      
      private static var frames:uint;
      
      private static var fadeSpeed:Number;
      
      private static var stageRef:Stage;
      
      public static const DEGREE_CONVERTER:Number = 180 / Math.PI;
      
      private static var startTime:uint;
      
      private static var rootRef:MovieClip;
      
      private static var memoryTextField:TextField;
      
      public static const RADIAN_CONVERTER:Number = Math.PI / 180;
      
      private static var fpsTextField:TextField;
      
      private static var msElapsed:Number;
       
      
      public function Utilities()
      {
         super();
      }
      
      public static function loadSharedObject(param1:String) : void
      {
         var name:String = param1;
         registerClassAlias("SaveFile",SaveFile);
         sharedObject = SharedObject.getLocal(name);
         if(sharedObject.size == 0)
         {
            createNewSaveFile();
         }
         else
         {
            try
            {
               loadGame();
            }
            catch(e:Error)
            {
               trace(e.message);
               createNewSaveFile();
            }
         }
      }
      
      public static function lowQuality() : void
      {
         stageRef.quality = StageQuality.LOW;
      }
      
      public static function saveGame() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeObject(saveFile);
         encryptByteArray(_loc1_,"209335432159");
         _loc1_.compress();
         encryptByteArray(_loc1_,"843021");
         sharedObject.data.gameData = _loc1_;
         sharedObject.flush();
      }
      
      public static function toggleQuality() : void
      {
         switch(stageRef.quality.toLowerCase())
         {
            case StageQuality.LOW:
               mediumQuality();
               break;
            case StageQuality.MEDIUM:
               highQuality();
               break;
            case StageQuality.HIGH:
               lowQuality();
         }
      }
      
      public static function toggleMute() : void
      {
         SoundMixer.soundTransform.volume = SoundMixer.soundTransform.volume == 1 ? Number(0) : Number(1);
      }
      
      public static function decryptByteArray(param1:ByteArray, param2:String) : void
      {
         var _loc3_:* = param2.split();
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            param1[_loc5_] = ~param1[_loc5_];
            if(++_loc4_ == param2.length)
            {
               _loc4_ = 0;
            }
            _loc5_++;
         }
      }
      
      public static function createOutsideBounds(param1:uint, param2:uint) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(0);
         _loc3_.graphics.drawRect(0,0,param1 * 2,param2 / 2);
         _loc3_.graphics.drawRect(0,param2 / 2,param1 / 2,param2);
         _loc3_.graphics.drawRect(param1 * 1.5,param2 / 2,param1 / 2,param2);
         _loc3_.graphics.drawRect(0,param2 * 1.5,param1 * 2,param2 / 2);
         _loc3_.graphics.endFill();
         _loc3_.x -= param1 / 2;
         _loc3_.y -= param2 / 2;
         return _loc3_;
      }
      
      public static function showFPS() : void
      {
         curFrameRate = frames = msElapsed = 0;
         startTime = getTimer();
         fpsTextField = new TextField();
         fpsTextField.selectable = false;
         fpsTextField.mouseEnabled = false;
         fpsTextField.textColor = 0;
         fpsTextField.x = 10;
         fpsTextField.y = 50;
         stageRef.addChild(fpsTextField);
         memoryTextField = new TextField();
         memoryTextField.selectable = false;
         memoryTextField.mouseEnabled = false;
         memoryTextField.textColor = 0;
         memoryTextField.x = 10;
         memoryTextField.y = 65;
         stageRef.addChild(memoryTextField);
         stageRef.addEventListener(Event.ENTER_FRAME,countFPS);
      }
      
      public static function clickLink(param1:String, param2:String = "_blank") : void
      {
         var inLocation:String = param1;
         var inWindow:String = param2;
         var req:URLRequest = new URLRequest(inLocation);
         try
         {
            navigateToURL(req,inWindow);
         }
         catch(e:SecurityError)
         {
         }
      }
      
      private static function fadeOut(param1:Event) : void
      {
         fader.alpha -= fadeSpeed;
         if(fader.alpha <= 0)
         {
            fader.removeEventListener(Event.ENTER_FRAME,fadeOut);
            rootRef.removeChild(fader);
         }
      }
      
      public static function createNewSaveFile() : void
      {
         trace("new save file created");
         sharedObject.clear();
         saveFile = new SaveFile();
         saveGame();
      }
      
      private static function fadeIn(param1:Event) : void
      {
         fader.alpha += fadeSpeed;
         if(fader.alpha >= 1)
         {
            fader.removeEventListener(Event.ENTER_FRAME,fadeIn);
            rootRef.removeChild(fader);
            rootRef.gotoAndPlay(1,"INTROS");
         }
      }
      
      public static function setRefs(param1:MovieClip, param2:Stage) : void
      {
         rootRef = param1;
         stageRef = param2;
      }
      
      public static function hideFPS() : void
      {
         stageRef.removeEventListener(Event.ENTER_FRAME,countFPS);
         stageRef.removeChild(fpsTextField);
         fpsTextField = null;
         stageRef.removeChild(memoryTextField);
         memoryTextField = null;
      }
      
      public static function cleanupMCBtn(param1:MovieClip) : void
      {
         param1.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         param1.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
      }
      
      public static function mediumQuality() : void
      {
         stageRef.quality = StageQuality.MEDIUM;
      }
      
      private static function countFPS(param1:Event) : void
      {
         ++frames;
         if(frames == stageRef.frameRate)
         {
            msElapsed = (getTimer() - startTime) / 1000;
            curFrameRate = frames / msElapsed;
            frames = 0;
            startTime = getTimer();
         }
         fpsTextField.text = curFrameRate.toFixed(2).toString() + "fps";
         memoryTextField.text = Math.round(System.totalMemory / 1000) + "kb";
      }
      
      public static function encryptByteArray(param1:ByteArray, param2:String) : void
      {
         var _loc3_:* = param2.split();
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            param1[_loc5_] = ~param1[_loc5_];
            if(++_loc4_ == param2.length)
            {
               _loc4_ = 0;
            }
            _loc5_++;
         }
      }
      
      public static function createClass(param1:String) : Object
      {
         return new getDefinitionByName(param1)();
      }
      
      public static function mc2Btn(param1:MovieClip) : void
      {
         param1.buttonMode = true;
         param1.stop();
         param1.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         param1.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         param1.mouseChildren = false;
      }
      
      public static function fadeBlack(param1:String, param2:Number = 0.03) : void
      {
         fader = new Sprite();
         fader.graphics.beginFill(0);
         fader.graphics.drawRect(0,0,stageRef.stageWidth,stageRef.stageHeight);
         fader.graphics.endFill();
         fadeSpeed = param2;
         if(param1 == "in")
         {
            fader.alpha = 0;
            fader.addEventListener(Event.ENTER_FRAME,fadeIn);
         }
         else if(param1 == "out")
         {
            fader.alpha = 1;
            fader.addEventListener(Event.ENTER_FRAME,fadeOut);
         }
         rootRef.addChild(fader);
      }
      
      public static function loadGame() : void
      {
         decryptByteArray(sharedObject.data.gameData,"843021");
         sharedObject.data.gameData.uncompress();
         decryptByteArray(sharedObject.data.gameData,"209335432159");
         saveFile = SaveFile(sharedObject.data.gameData.readObject());
         if(saveFile == null)
         {
            createNewSaveFile();
         }
         else
         {
            saveGame();
         }
      }
      
      public static function generateContextMenu() : ContextMenu
      {
         var _loc1_:ContextMenu = new ContextMenu();
         _loc1_.hideBuiltInItems();
         _loc1_.builtInItems.quality = true;
         return _loc1_;
      }
      
      public static function highQuality() : void
      {
         stageRef.quality = StageQuality.HIGH;
      }
   }
}
