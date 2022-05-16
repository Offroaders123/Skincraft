package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class PixelEditor extends Sprite
   {
      
      public static const VIEW_HEAD:uint = 1;
      
      public static const VIEW_LEG_RIGHT_JACKET:uint = 11;
      
      public static const VIEW_ARM_LEFT:uint = 6;
      
      public static const VIEW_LEG_RIGHT:uint = 3;
      
      public static const VIEW_LEG_LEFT:uint = 7;
      
      public static var PIXEL_SCALE:uint;
      
      public static const VIEW_LEG_LEFT_JACKET:uint = 12;
      
      public static const VIEW_ARM_RIGHT:uint = 4;
      
      public static const VIEW_HAT:uint = 5;
      
      public static var viewNames:Array = new Array("All","Head","Body","Right Leg","Right Arm","Head (hat)","Left Arm","Left Leg","Body (jacket)","Right Arm (jacket)","Left Arm (jacket)","Right Leg (jacket)","Left leg (jacket)");
      
      public static const VIEW_ALL:uint = 0;
      
      public static const VIEW_ARM_RIGHT_JACKET:uint = 9;
      
      public static const VIEW_ARM_LEFT_JACKET:uint = 10;
      
      public static const VIEW_BODY_JACKET:uint = 8;
      
      public static const VIEW_BODY:uint = 2;
       
      
      public var curView:uint;
      
      public var floodAlpha:uint;
      
      public var curViewRect:Rectangle;
      
      public var floodColor:uint;
      
      public var lockX:Number;
      
      public var lockY:Number;
      
      public var tempPixel:Pixel;
      
      public var pixelContainer:Sprite;
      
      public var fillColor:uint;
      
      public var fillAlpha:Number;
      
      public var baseBitmapData:BitmapData;
      
      public var pixels:Vector.<Vector.<Pixel>>;
      
      public var lockHorizontal:Boolean;
      
      public var tempSurface:Surface;
      
      public var incX:Number;
      
      public var incY:Number;
      
      public var lockVertical:Boolean;
      
      public var includedSurfaces:Vector.<Surface>;
      
      public var floodSurface:int;
      
      public var distanceTraveled:Number;
      
      public var undoLog:Vector.<BitmapData>;
      
      public var gridContainer:Sprite;
      
      public var baseBitmap:Bitmap;
      
      public var prevMouseY:Number;
      
      private var i:uint;
      
      private var j:uint;
      
      public var prevMouseX:Number;
      
      public var viewRects:Array;
      
      public var originY:Number;
      
      public function PixelEditor(param1:int, param2:int)
      {
         super();
         x = param1;
         y = this.originY = param2;
         this.prevMouseX = this.prevMouseY = 0;
         this.viewRects = new Array();
         this.viewRects[VIEW_ALL] = new Rectangle(0,0,Main.SKIN_WIDTH,Main.SKIN_HEIGHT);
         this.viewRects[VIEW_HEAD] = new Rectangle(0,0,32,16);
         this.viewRects[VIEW_BODY] = new Rectangle(16,16,24,16);
         this.viewRects[VIEW_LEG_RIGHT] = new Rectangle(0,16,16,16);
         this.viewRects[VIEW_ARM_RIGHT] = new Rectangle(40,16,16,16);
         this.viewRects[VIEW_HAT] = new Rectangle(32,0,32,16);
         this.viewRects[VIEW_LEG_LEFT] = new Rectangle(16,48,16,16);
         this.viewRects[VIEW_ARM_LEFT] = new Rectangle(32,48,16,16);
         this.viewRects[VIEW_BODY_JACKET] = new Rectangle(16,32,24,16);
         this.viewRects[VIEW_ARM_RIGHT_JACKET] = new Rectangle(40,32,16,16);
         this.viewRects[VIEW_ARM_LEFT_JACKET] = new Rectangle(48,48,16,16);
         this.viewRects[VIEW_LEG_RIGHT_JACKET] = new Rectangle(0,32,16,16);
         this.viewRects[VIEW_LEG_LEFT_JACKET] = new Rectangle(0,48,16,16);
         addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         addEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         Main.stageRef.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this.undoLog = new Vector.<BitmapData>();
      }
      
      public function drawView(param1:uint) : void
      {
         var _loc4_:Vector.<Pixel> = null;
         var _loc5_:uint = 0;
         var _loc7_:Rectangle = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         this.clearView();
         this.curView = param1;
         this.curViewRect = this.viewRects[this.curView] as Rectangle;
         if(this.curView == VIEW_ALL)
         {
            PIXEL_SCALE = 8;
         }
         else
         {
            PIXEL_SCALE = 16;
         }
         this.baseBitmapData = new BitmapData(this.curViewRect.width,this.curViewRect.height);
         this.baseBitmapData.copyPixels(new preset_1(64,32),this.curViewRect,new Point(0,0));
         this.baseBitmap = new Bitmap(this.baseBitmapData);
         this.baseBitmap.alpha = 0.2;
         this.baseBitmap.scaleX = this.baseBitmap.scaleY = PIXEL_SCALE;
         addChild(this.baseBitmap);
         this.pixelContainer = new Sprite();
         this.gridContainer = new Sprite();
         this.gridContainer.mouseEnabled = this.gridContainer.mouseChildren = false;
         this.gridContainer.graphics.lineStyle(0.5,0,0.4);
         this.gridContainer.mouseEnabled = false;
         var _loc2_:uint = this.curViewRect.height * PIXEL_SCALE;
         var _loc3_:uint = this.curViewRect.width * PIXEL_SCALE;
         this.pixels = new Vector.<Vector.<Pixel>>();
         var _loc6_:ByteArray;
         (_loc6_ = Main.layerToEdit.getBitmapData().getPixels(this.curViewRect)).position = 0;
         this.i = 0;
         while(this.i <= this.curViewRect.height)
         {
            _loc4_ = new Vector.<Pixel>();
            this.gridContainer.graphics.moveTo(0,this.i * PIXEL_SCALE);
            this.gridContainer.graphics.lineTo(_loc3_,this.i * PIXEL_SCALE);
            if(this.i != this.curViewRect.height)
            {
               this.j = 0;
               while(this.j <= this.curViewRect.width)
               {
                  this.gridContainer.graphics.moveTo(this.j * PIXEL_SCALE,0);
                  this.gridContainer.graphics.lineTo(this.j * PIXEL_SCALE,_loc2_);
                  if(this.j != this.curViewRect.width)
                  {
                     this.tempPixel = new Pixel(this.j,this.i);
                     _loc5_ = _loc6_.readUnsignedInt();
                     this.tempPixel.setColor(_loc5_,_loc5_ == 0 ? uint(0) : uint(1));
                     this.tempPixel.x = this.j * PIXEL_SCALE;
                     this.tempPixel.y = this.i * PIXEL_SCALE;
                     _loc4_.push(this.tempPixel);
                     this.pixelContainer.addChild(this.tempPixel);
                  }
                  ++this.j;
               }
               this.pixels.push(_loc4_);
            }
            ++this.i;
         }
         this.gridContainer.graphics.lineStyle(2,0,1);
         this.includedSurfaces = new Vector.<Surface>();
         for each(this.tempSurface in Main.surfaces)
         {
            _loc7_ = this.tempSurface.sourceRect;
            if(this.curViewRect.containsRect(_loc7_))
            {
               _loc8_ = _loc7_.x - this.curViewRect.x;
               _loc9_ = _loc7_.y - this.curViewRect.y;
               _loc10_ = _loc7_.width;
               _loc11_ = _loc7_.height;
               this.gridContainer.graphics.drawRect(_loc8_ * PIXEL_SCALE,_loc9_ * PIXEL_SCALE,_loc10_ * PIXEL_SCALE,_loc11_ * PIXEL_SCALE);
               this.includedSurfaces.push(this.tempSurface);
               this.i = _loc9_;
               while(this.i < _loc9_ + _loc11_)
               {
                  this.j = _loc8_;
                  while(this.j < _loc8_ + _loc10_)
                  {
                     this.pixels[this.i][this.j].surfaceID = this.tempSurface.id;
                     ++this.j;
                  }
                  ++this.i;
               }
            }
         }
         this.gridContainer.cacheAsBitmap = true;
         this.pixelContainer.cacheAsBitmap = true;
         addChild(this.pixelContainer);
         addChild(this.gridContainer);
      }
      
      public function mouseMove(param1:MouseEvent) : void
      {
         if(Main.rootRef.colorGrabber.usingSpectrum || Main.curTool == Main.TOOL_EYEDROPPER)
         {
            return;
         }
         if(Main.rootRef.pixelEditorMask.getRect(Main.rootRef).contains(Main.rootRef.mouseX,Main.rootRef.mouseY))
         {
            this.tempPixel = this.getPixelAtPoint(mouseX,mouseY);
            if(this.tempPixel.surfaceID == -1)
            {
               Main.rootRef.txtSurfaceName.text = "Unused";
            }
            else
            {
               Main.rootRef.txtSurfaceName.text = Main.getSurface(this.tempPixel.surfaceID).name;
            }
            if(Main.cursorMode == Main.CURSOR_DRAW)
            {
               this.setPixelsEligibleForColor();
               this.incX = mouseX - this.prevMouseX;
               this.incY = mouseY - this.prevMouseY;
               this.distanceTraveled = Math.sqrt(this.incX * this.incX + this.incY * this.incY);
               this.incX /= this.distanceTraveled;
               this.incY /= this.distanceTraveled;
               if(KeyManager.pressing(KeyManager.SHIFT))
               {
                  if(!this.lockHorizontal && !this.lockVertical)
                  {
                     if(Math.abs(this.incX) > Math.abs(this.incY))
                     {
                        this.lockVertical = true;
                        this.lockY = this.prevMouseY;
                     }
                     else
                     {
                        this.lockHorizontal = true;
                        this.lockX = this.prevMouseX;
                     }
                  }
               }
               else
               {
                  this.lockHorizontal = this.lockVertical = false;
               }
               this.i = 0;
               while(this.i < this.distanceTraveled)
               {
                  this.getPixelAtPoint(!!this.lockHorizontal ? Number(this.lockX) : Number(this.prevMouseX),!!this.lockVertical ? Number(this.lockY) : Number(this.prevMouseY)).setColor(this.fillColor,this.fillAlpha);
                  this.prevMouseX += this.incX;
                  this.prevMouseY += this.incY;
                  ++this.i;
               }
               this.transferEditorToLayer();
            }
            else
            {
               this.lockVertical = this.lockHorizontal = false;
            }
         }
         this.prevMouseX = mouseX;
         this.prevMouseY = mouseY;
      }
      
      public function clearView() : void
      {
         if(this.gridContainer)
         {
            this.gridContainer.graphics.clear();
            removeChild(this.gridContainer);
         }
         if(this.pixelContainer)
         {
            removeChild(this.pixelContainer);
         }
         if(this.baseBitmap)
         {
            this.baseBitmap.bitmapData.dispose();
            removeChild(this.baseBitmap);
         }
      }
      
      public function floodFill(param1:Pixel) : void
      {
         if(param1.surfaceID == this.floodSurface && param1.color == this.floodColor && param1.colorAlpha == this.floodAlpha)
         {
            param1.setColor(this.fillColor,this.fillAlpha);
            this.propagateFloodFill(param1.gridX - 1,param1.gridY);
            this.propagateFloodFill(param1.gridX + 1,param1.gridY);
            this.propagateFloodFill(param1.gridX,param1.gridY - 1);
            this.propagateFloodFill(param1.gridX,param1.gridY + 1);
         }
      }
      
      public function cleanup() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
         Main.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
      }
      
      public function getPixelAtPoint(param1:Number, param2:Number) : Pixel
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc3_:uint = param1 / PIXEL_SCALE;
         var _loc4_:uint = param2 / PIXEL_SCALE;
         if(_loc3_ >= this.curViewRect.width)
         {
            _loc3_ = this.curViewRect.width - 1;
         }
         if(_loc4_ >= this.curViewRect.height)
         {
            _loc4_ = this.curViewRect.height - 1;
         }
         return this.pixels[_loc4_][_loc3_];
      }
      
      public function transferEditorToLayer() : void
      {
         var _loc1_:ByteArray = new ByteArray();
         this.i = 0;
         while(this.i < this.curViewRect.height)
         {
            this.j = 0;
            while(this.j < this.curViewRect.width)
            {
               this.tempPixel = this.pixels[this.i][this.j];
               if(this.tempPixel.colorAlpha == 0)
               {
                  _loc1_.writeUnsignedInt(0);
               }
               else
               {
                  _loc1_.writeUnsignedInt(4278190080 | this.tempPixel.color);
               }
               ++this.j;
            }
            ++this.i;
         }
         _loc1_.position = 0;
         CustomLayer(Main.layerToEdit).customBitmapData.setPixels(this.curViewRect,_loc1_);
         Main.rootRef.mcPreviewBox.refreshView();
      }
      
      public function hideBase() : void
      {
         this.baseBitmap.visible = false;
      }
      
      public function captureUndoLevel() : void
      {
         this.undoLog.push(Main.layerToEdit.getBitmapData());
         if(this.undoLog.length > 20)
         {
            this.undoLog.shift();
         }
         Main.rootRef.updateUndoButton();
      }
      
      public function undo() : void
      {
         if(this.undoLog.length == 0)
         {
            trace("no undo levels");
            return;
         }
         CustomLayer(Main.layerToEdit).customBitmapData = this.undoLog[this.undoLog.length - 1].clone();
         this.undoLog.pop();
         this.drawView(this.curView);
         Main.rootRef.mcPreviewBox.refreshView();
         Main.rootRef.btnUndo.gotoAndPlay(2);
         Main.rootRef.updateUndoButton();
      }
      
      public function mouseDown(param1:MouseEvent) : void
      {
         var _loc2_:Pixel = this.getPixelAtPoint(mouseX,mouseY);
         this.setPixelsEligibleForColor();
         Main.stageRef.focus = null;
         if(Main.curTool == Main.TOOL_ERASER)
         {
            this.captureUndoLevel();
            Main.cursorMode = Main.CURSOR_DRAW;
            this.fillAlpha = 0;
            this.fillColor = 0;
            _loc2_.setColor(this.fillColor,this.fillAlpha);
            this.transferEditorToLayer();
            Main.rootRef.mcShiftMessage.visible = true;
         }
         else if(Main.curTool == Main.TOOL_PENCIL)
         {
            this.captureUndoLevel();
            Main.cursorMode = Main.CURSOR_DRAW;
            this.fillAlpha = 1;
            this.fillColor = Main.rootRef.colorGrabber.actualColor;
            _loc2_.setColor(this.fillColor,this.fillAlpha);
            this.transferEditorToLayer();
            Main.rootRef.mcShiftMessage.visible = true;
         }
         else if(Main.curTool == Main.TOOL_BUCKET)
         {
            this.captureUndoLevel();
            this.floodSurface = _loc2_.surfaceID;
            this.floodColor = _loc2_.color;
            this.floodAlpha = _loc2_.colorAlpha;
            this.fillAlpha = 1;
            this.fillColor = Main.rootRef.colorGrabber.actualColor;
            this.floodFill(_loc2_);
            this.transferEditorToLayer();
         }
      }
      
      public function setPixelsEligibleForColor() : void
      {
         this.i = 0;
         while(this.i < this.curViewRect.height)
         {
            this.j = 0;
            while(this.j < this.curViewRect.width)
            {
               this.pixels[this.i][this.j].eligibleForColor = true;
               ++this.j;
            }
            ++this.i;
         }
      }
      
      public function mouseOut(param1:MouseEvent) : void
      {
         Main.rootRef.txtSurfaceName.text = "";
      }
      
      public function showBase() : void
      {
         this.baseBitmap.visible = true;
      }
      
      public function propagateFloodFill(param1:int, param2:int) : void
      {
         if(param1 >= 0 && param1 < this.curViewRect.width && (param2 >= 0 && param2 < this.curViewRect.height))
         {
            this.tempPixel = this.pixels[param2][param1];
            if(this.tempPixel.eligibleForColor)
            {
               this.floodFill(this.tempPixel);
            }
         }
      }
   }
}
