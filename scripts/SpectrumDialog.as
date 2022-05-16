package
{
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class SpectrumDialog extends MovieClip
   {
       
      
      public var mcBacking:MovieClip;
      
      public var associatedColorGrabber:ColorGrabber;
      
      public var mcSpectrum:MovieClip;
      
      public var selectedColor:uint;
      
      public var spectrumBitmapData:BitmapData;
      
      public var mcCrosshair:MovieClip;
      
      public var colorPreview:Sprite;
      
      public function SpectrumDialog(param1:ColorGrabber)
      {
         super();
         this.associatedColorGrabber = param1;
         Mouse.hide();
         addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         addEventListener(MouseEvent.CLICK,this.clickColor);
         this.mcBacking.buttonMode = true;
         this.mcBacking.useHandCursor = false;
         this.spectrumBitmapData = new BitmapData(width,height,true,0);
         this.spectrumBitmapData.draw(this);
         this.colorPreview = new Sprite();
         this.colorPreview.x = this.mcSpectrum.x;
         this.colorPreview.y = 350;
         addChild(this.colorPreview);
         setChildIndex(this.mcCrosshair,numChildren - 1);
         Main.rootRef.addChildAt(this,Main.rootRef.numChildren);
         this.mouseMove(null);
      }
      
      public function mouseMove(param1:MouseEvent) : void
      {
         this.mcCrosshair.x = mouseX;
         this.mcCrosshair.y = mouseY;
         this.selectedColor = this.spectrumBitmapData.getPixel(mouseX,mouseY);
         this.colorPreview.graphics.clear();
         this.colorPreview.graphics.beginFill(this.selectedColor);
         this.colorPreview.graphics.drawRect(0,0,this.mcSpectrum.width,25);
         this.colorPreview.graphics.endFill();
      }
      
      public function clickColor(param1:MouseEvent) : void
      {
         Mouse.show();
         this.spectrumBitmapData.dispose();
         this.colorPreview.graphics.clear();
         this.associatedColorGrabber.usingSpectrum = false;
         this.associatedColorGrabber.setColor(this.selectedColor);
         this.associatedColorGrabber = null;
         removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         removeEventListener(MouseEvent.CLICK,this.clickColor);
         Main.rootRef.removeChild(this);
      }
   }
}
