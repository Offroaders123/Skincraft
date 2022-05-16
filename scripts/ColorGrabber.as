package
{
   import fl.controls.Slider;
   import fl.controls.TextInput;
   import fl.events.ComponentEvent;
   import fl.events.SliderEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   
   public class ColorGrabber extends MovieClip
   {
      
      public static const DEFAULT_COLOR:uint = 16711680;
       
      
      public var btnEyedropper:MovieClip;
      
      public var squareWhite:Sprite;
      
      public var stageBitmap:Bitmap;
      
      public var baseColor:uint;
      
      public var colorWindowSize:uint;
      
      public var mcColorDisplay:MovieClip;
      
      public var stageBitmapData:BitmapData;
      
      public var sldBrightness:Slider;
      
      public var txtColorValue:TextInput;
      
      public var squareBlack:Sprite;
      
      public var usingSpectrum:Boolean;
      
      public var stageBitmapContainer:Sprite;
      
      public var actualColor:uint;
      
      public var savedTool:uint;
      
      public function ColorGrabber()
      {
         super();
         Utilities.mc2Btn(this.btnEyedropper);
         this.btnEyedropper.addEventListener(MouseEvent.CLICK,this.press_btnEyedropper);
         this.txtColorValue.maxChars = 6;
         this.txtColorValue.restrict = "A-Za-z0-9";
         this.txtColorValue.addEventListener(FocusEvent.FOCUS_OUT,this.colorValueFocusOut);
         this.txtColorValue.addEventListener(ComponentEvent.ENTER,this.colorValueEnter);
         this.txtColorValue.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.colorValueFocusOut);
         this.colorWindowSize = 18;
         this.squareBlack = new Sprite();
         this.squareWhite = new Sprite();
         this.squareWhite.graphics.beginFill(16777215);
         this.squareWhite.graphics.drawRect(0,0,this.colorWindowSize,this.colorWindowSize);
         this.squareWhite.graphics.endFill();
         this.squareBlack.graphics.beginFill(0);
         this.squareBlack.graphics.drawRect(0,0,this.colorWindowSize,this.colorWindowSize);
         this.squareBlack.graphics.endFill();
         this.mcColorDisplay.addChild(this.squareBlack);
         this.mcColorDisplay.addChild(this.squareWhite);
         this.mcColorDisplay.graphics.lineStyle(1);
         this.mcColorDisplay.buttonMode = true;
         this.mcColorDisplay.addEventListener(MouseEvent.CLICK,this.clickColorDisplay);
         this.setColor(DEFAULT_COLOR,false);
         this.sldBrightness.addEventListener(SliderEvent.CHANGE,this.sliderChange);
         this.__setProp_sldBrightness_ColorGrabber_Layer1_0();
      }
      
      public function colorValueEnter(param1:ComponentEvent) : void
      {
         this.updateColorFromValueField();
      }
      
      public function clickColorDisplay(param1:MouseEvent) : void
      {
         new SpectrumDialog(this);
         this.usingSpectrum = true;
      }
      
      public function padHex(param1:String) : String
      {
         var _loc3_:int = 0;
         var _loc2_:* = "";
         if(param1.length < 6)
         {
            _loc3_ = 6 - param1.length;
            while(_loc2_.length < _loc3_)
            {
               _loc2_ += "0";
            }
         }
         return _loc2_ + param1;
      }
      
      public function sliderChange(param1:Event) : void
      {
         this.squareBlack.alpha = this.squareWhite.alpha = 0;
         var _loc2_:Number = Math.abs(this.sldBrightness.value) / 100;
         if(this.sldBrightness.value < 0)
         {
            this.squareBlack.alpha = _loc2_;
         }
         else if(this.sldBrightness.value > 0)
         {
            this.squareWhite.alpha = _loc2_;
         }
         var _loc3_:BitmapData = new BitmapData(this.colorWindowSize,this.colorWindowSize);
         _loc3_.draw(this.mcColorDisplay);
         this.actualColor = _loc3_.getPixel(5,5);
         _loc3_.dispose();
         this.txtColorValue.text = this.padHex(this.actualColor.toString(16));
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function colorValueFocusOut(param1:FocusEvent) : void
      {
         this.updateColorFromValueField();
      }
      
      function __setProp_sldBrightness_ColorGrabber_Layer1_0() : *
      {
         try
         {
            this.sldBrightness["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldBrightness.direction = "horizontal";
         this.sldBrightness.enabled = true;
         this.sldBrightness.liveDragging = true;
         this.sldBrightness.maximum = 100;
         this.sldBrightness.minimum = -100;
         this.sldBrightness.snapInterval = 0;
         this.sldBrightness.tickInterval = 0;
         this.sldBrightness.value = 0;
         this.sldBrightness.visible = true;
         try
         {
            this.sldBrightness["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function press_btnEyedropper(param1:MouseEvent) : void
      {
         this.savedTool = Main.curTool;
         Main.rootRef.changeTool(Main.TOOL_EYEDROPPER);
         Main.rootRef.mcToolFollow.visible = true;
         Mouse.hide();
         Main.stageRef.focus = null;
         this.stageBitmapData = new BitmapData(Main.GAME_WIDTH,Main.GAME_HEIGHT);
         this.stageBitmapData.draw(Main.rootRef);
         this.stageBitmap = new Bitmap(this.stageBitmapData);
         this.stageBitmapContainer = new Sprite();
         this.stageBitmapContainer.addChild(this.stageBitmap);
         this.stageBitmapContainer.alpha = 0;
         Main.rootRef.addChild(this.stageBitmapContainer);
         this.stageBitmapContainer.addEventListener(MouseEvent.CLICK,this.clickStageBitmap);
         this.stageBitmapContainer.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveStageBitmap);
      }
      
      public function setColor(param1:uint, param2:Boolean = true) : void
      {
         this.baseColor = this.actualColor = param1;
         this.sldBrightness.value = 0;
         this.squareBlack.alpha = this.squareWhite.alpha = 0;
         this.txtColorValue.text = this.padHex(param1.toString(16));
         this.mcColorDisplay.graphics.clear();
         this.mcColorDisplay.graphics.beginFill(param1);
         this.mcColorDisplay.graphics.drawRect(0,0,this.colorWindowSize,this.colorWindowSize);
         this.mcColorDisplay.graphics.endFill();
         if(param2)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function clickStageBitmap(param1:MouseEvent) : void
      {
         this.stageBitmapContainer.removeEventListener(MouseEvent.CLICK,this.clickStageBitmap);
         this.stageBitmapContainer.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoveStageBitmap);
         Mouse.show();
         Main.rootRef.mcToolFollow.visible = false;
         Main.rootRef.changeTool(this.savedTool);
         this.stageBitmapData.dispose();
         Main.rootRef.removeChild(this.stageBitmapContainer);
         this.stageBitmap = null;
         this.stageBitmapContainer = null;
      }
      
      public function mouseMoveStageBitmap(param1:MouseEvent) : void
      {
         this.setColor(this.stageBitmapData.getPixel(Main.rootRef.mouseX,Main.rootRef.mouseY));
      }
      
      public function updateColorFromValueField() : void
      {
         this.setColor(int("0x" + this.txtColorValue.text));
      }
   }
}
