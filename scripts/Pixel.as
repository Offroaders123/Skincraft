package
{
   import flash.display.Sprite;
   
   public class Pixel extends Sprite
   {
       
      
      public var color:uint;
      
      public var surfaceID:int;
      
      public var eligibleForColor:Boolean;
      
      public var gridX:int;
      
      public var gridY:int;
      
      public var colorAlpha:Number;
      
      public function Pixel(param1:int, param2:int)
      {
         super();
         this.gridX = param1;
         this.gridY = param2;
         this.eligibleForColor = true;
         this.surfaceID = -1;
      }
      
      public function setColor(param1:uint, param2:uint) : void
      {
         if(!this.eligibleForColor)
         {
            return;
         }
         param1 &= 16777215;
         this.color = param1;
         this.colorAlpha = param2;
         graphics.clear();
         graphics.beginFill(param1,param2);
         graphics.drawRect(0,0,PixelEditor.PIXEL_SCALE,PixelEditor.PIXEL_SCALE);
         graphics.endFill();
         this.eligibleForColor = false;
      }
   }
}
