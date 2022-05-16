package
{
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   
   public class KeyManager
   {
      
      public static var keyCounts:Vector.<uint>;
      
      public static var LTR_A:uint = 65;
      
      public static var keysToDetect:Vector.<uint>;
      
      public static var LTR_Z:uint = 90;
      
      public static var SHIFT:uint;
      
      public static var pressingCTRL:Boolean;
      
      public static var keyCode:uint;
      
      public static var keys:Vector.<Boolean>;
      
      public static var ENTER:uint;
      
      public static var CONTROL:uint;
       
      
      public function KeyManager()
      {
         super();
      }
      
      public static function detectKeyUp(param1:KeyboardEvent) : void
      {
         keys[param1.keyCode] = false;
         keyCounts[param1.keyCode] = 0;
         pressingCTRL = param1.ctrlKey;
      }
      
      public static function init() : void
      {
         keys = new Vector.<Boolean>();
         keyCounts = new Vector.<uint>();
         keysToDetect = new Vector.<uint>();
         var _loc1_:uint = 0;
         while(_loc1_ < 300)
         {
            keys.push(false);
            keyCounts.push(0);
            _loc1_++;
         }
         Main.stageRef.addEventListener(KeyboardEvent.KEY_UP,detectKeyUp);
         Main.stageRef.addEventListener(KeyboardEvent.KEY_DOWN,detectKeyDown);
         SHIFT = Keyboard.SHIFT;
         CONTROL = Keyboard.CONTROL;
         ENTER = Keyboard.ENTER;
         keysToDetect.push(SHIFT);
         keysToDetect.push(LTR_A);
         keysToDetect.push(CONTROL);
         keysToDetect.push(LTR_Z);
         keysToDetect.push(ENTER);
      }
      
      public static function singlePress(param1:uint) : Boolean
      {
         return keyCounts[param1] == 1;
      }
      
      public static function releaseAllKeys() : void
      {
         for each(keyCode in keysToDetect)
         {
            keys[keyCode] = false;
            keyCounts[keyCode] = 0;
         }
      }
      
      public static function detectKeys() : void
      {
         for each(keyCode in keysToDetect)
         {
            if(keys[keyCode])
            {
               ++keyCounts[keyCode];
            }
         }
      }
      
      public static function detectKeyDown(param1:KeyboardEvent) : void
      {
         keys[param1.keyCode] = true;
         pressingCTRL = param1.ctrlKey;
      }
      
      public static function pressing(param1:uint) : Boolean
      {
         return keyCounts[param1] > 0;
      }
   }
}
