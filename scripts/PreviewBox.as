package
{
   import com.adobe.images.PNGEncoder;
   import com.newgrounds.components.VoteBar;
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.filters.BlurFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.FileReference;
   import flash.utils.ByteArray;
   
   public class PreviewBox extends MovieClip
   {
      
      public static var brightness:Color = new Color();
      
      public static const VIEW_LEFT:uint = 2;
      
      public static var viewNames:Array;
      
      public static const VIEW_BOTTOM:uint = 5;
      
      public static const VIEW_BACK:uint = 1;
      
      public static const VIEW_RIGHT:uint = 3;
      
      public static const blur2:BlurFilter = new BlurFilter(3,3,1);
      
      public static const blur3:BlurFilter = new BlurFilter(4,4,1);
      
      public static const blur4:BlurFilter = new BlurFilter(5,5,1);
      
      public static const VIEW_FRONT:uint = 0;
      
      public static const blur1:BlurFilter = new BlurFilter(2,2,1);
      
      public static const VIEW_TOP:uint = 4;
      
      {
         brightness.brightness = 0.8;
      }
      
      public var showingDummySkin:Boolean;
      
      public var curView:uint;
      
      public var btnDownload:MovieClip;
      
      public var gradientOverlay:MovieClip;
      
      public var tempPixel:uint;
      
      public var mcNGLogo:MovieClip;
      
      public var btnSplit:MovieClip;
      
      public var minecraftViewer:MinecraftViewer;
      
      public var tempBitmap:Bitmap;
      
      public var baseBitmapData:BitmapData;
      
      public var watermarkData:BitmapData;
      
      public var sourceBitmap:Bitmap;
      
      public var tempSurface:Surface;
      
      public var hatRects:Vector.<Rectangle>;
      
      public var btnToEditor:MovieClip;
      
      public var btnBGLeft:MovieClip;
      
      public var viewPieces:Vector.<Bitmap>;
      
      public var needVoteBar:Boolean;
      
      public var mcModelMessage:MovieClip;
      
      public var mcBGS:MovieClip;
      
      public var mcBGLabel:MovieClip;
      
      public var baseBitmap:Bitmap;
      
      private var i:int;
      
      private var j:int;
      
      public var tempBitmapData:BitmapData;
      
      public var newByteArray:ByteArray;
      
      public var originalScaleX:Number;
      
      public var originalScaleY:Number;
      
      public var baseWrapper:Sprite;
      
      public var skin:Skin;
      
      public var sourceBitmaps:Vector.<BitmapSprite>;
      
      public var sourceContainer:Sprite;
      
      public var previewWrapper:Sprite;
      
      public var watermarkBitmap:Bitmap;
      
      public var voteBar:VoteBar;
      
      public var mcOutline:MovieClip;
      
      public var curByteArray:ByteArray;
      
      public var tempRect:Rectangle;
      
      public var bitmapSprite:BitmapSprite;
      
      public var tempLayer:Layer;
      
      public var sourceBitmapData:BitmapData;
      
      public var btnBGRight:MovieClip;
      
      public function PreviewBox()
      {
         var _loc1_:MovieClip = null;
         super();
         this.curView = VIEW_FRONT;
         viewNames = new Array("Front","Back","Left","Right","Top","Bottom");
         this.sourceContainer = new Sprite();
         this.baseWrapper = new Sprite();
         this.sourceContainer.x = this.mcOutline.width / 2 - Main.SKIN_WIDTH / 2;
         this.sourceContainer.y = this.mcOutline.height;
         this.baseBitmap = new Bitmap();
         this.baseWrapper.addChild(this.baseBitmap);
         this.sourceContainer.addChild(this.baseWrapper);
         addChild(this.sourceContainer);
         this.watermarkData = new watermark(64,32);
         this.watermarkBitmap = new Bitmap(this.watermarkData);
         this.sourceContainer.addChild(this.watermarkBitmap);
         this.viewPieces = new Vector.<Bitmap>();
         this.sourceBitmaps = new Vector.<BitmapSprite>();
         this.i = 0;
         if(this.i >= 6)
         {
         }
         this.btnBGLeft.buttonMode = this.btnBGRight.buttonMode = true;
         this.btnBGLeft.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnBGLeft.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnBGRight.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnBGRight.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnBGLeft.addEventListener(MouseEvent.CLICK,this.press_btnBGLeft);
         this.btnBGRight.addEventListener(MouseEvent.CLICK,this.press_btnBGRight);
         this.mcBGS.gotoAndStop(Main.savedBG);
         this.mcBGS.mouseEnabled = false;
         this.mcBGS.mouseChildren = false;
         this.updateBGButtons();
         this.btnSplit.buttonMode = true;
         this.btnSplit.addEventListener(MouseEvent.CLICK,this.press_btnSplit);
         this.btnSplit.visible = false;
         this.minecraftViewer = new MinecraftViewer(new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT),465,465);
         this.minecraftViewer.x = -100;
         this.minecraftViewer.y = -107;
         this.minecraftViewer.visible = false;
         addChild(this.minecraftViewer);
         this.mcModelMessage.visible = false;
         setChildIndex(this.mcModelMessage,numChildren - 1);
         this.mcOutline.alpha = 0;
         this.mcOutline.buttonMode = true;
         this.mcOutline.addEventListener(MouseEvent.MOUSE_DOWN,this.press_outline);
         Main.stageRef.addEventListener(MouseEvent.MOUSE_MOVE,this.minecraftViewer.mouseMove);
         setChildIndex(this.mcOutline,numChildren - 1);
         this.mcNGLogo.buttonMode = true;
         this.mcNGLogo.addEventListener(MouseEvent.CLICK,this.press_btnNGLogo);
         this.hatRects = new Vector.<Rectangle>();
         this.hatRects.push(new Rectangle(40,0,16,8));
         this.hatRects.push(new Rectangle(32,8,32,8));
         this.btnDownload.visible = this.btnToEditor.visible = false;
         this.btnDownload.stop();
         this.btnToEditor.stop();
         tabEnabled = tabChildren = false;
      }
      
      public function press_btnDownload(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var skinBitmapData:* = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT,true,0);
         skinBitmapData.draw(Main.rootRef.mcPreviewBox.sourceContainer);
         var skinByteArray:ByteArray = new ByteArray();
         skinByteArray = PNGEncoder.encode(skinBitmapData);
         var fileReference:FileReference = new FileReference();
         fileReference.addEventListener(Event.COMPLETE,this.fileComplete);
         fileReference.addEventListener(IOErrorEvent.IO_ERROR,this.fileError);
         try
         {
            fileReference.save(skinByteArray,"downloaded_skin.png");
         }
         catch(e:Error)
         {
            fileError(null);
         }
         skinBitmapData.dispose();
         skinByteArray = null;
      }
      
      public function refreshView() : void
      {
         var _loc1_:Rectangle = null;
         this.clearSourceBitmaps();
         if(this.skin)
         {
            this.j = this.skin.layers.length - 1;
            while(this.j >= 0)
            {
               this.tempLayer = this.skin.layers[this.j];
               if(!this.tempLayer.hidden)
               {
                  this.bitmapSprite = new BitmapSprite();
                  this.bitmapSprite.init(this.tempLayer);
                  _loc1_ = this.bitmapSprite.mainLayerBitmapData.getColorBoundsRect(4294967295,0,false);
                  this.bitmapSprite.alpha = this.tempLayer.opacity / 100;
                  this.bitmapSprite.x += this.tempLayer.offsetX;
                  this.bitmapSprite.y += this.tempLayer.offsetY;
                  this.bitmapSprite.blendMode = this.tempLayer.blendMode;
                  if(this.tempLayer.blur > 0)
                  {
                     this.bitmapSprite.filters = new Array(PreviewBox["blur" + this.tempLayer.blur]);
                  }
                  if(this.tempLayer.invertX)
                  {
                     this.bitmapSprite.x += _loc1_.left * 2 + _loc1_.width;
                     this.bitmapSprite.scaleX = -1;
                  }
                  if(this.tempLayer.invertY)
                  {
                     this.bitmapSprite.y += _loc1_.top * 2 + _loc1_.height;
                     this.bitmapSprite.scaleY = -1;
                  }
                  this.tempLayer.linkedSprite = this.bitmapSprite;
                  this.sourceBitmaps.push(this.bitmapSprite);
                  this.sourceContainer.addChildAt(this.bitmapSprite,1);
               }
               --this.j;
            }
         }
         this.sourceBitmapData = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT,true,0);
         this.sourceBitmapData.draw(this.sourceContainer);
         for each(this.tempRect in this.hatRects)
         {
            this.curByteArray = this.sourceBitmapData.getPixels(this.tempRect);
            this.curByteArray.position = 0;
            this.newByteArray = new ByteArray();
            while(this.curByteArray.position < this.curByteArray.length)
            {
               this.tempPixel = this.curByteArray.readUnsignedInt();
               if(this.tempPixel >>> 24 < 255)
               {
                  this.tempPixel &= 16777215;
               }
               this.newByteArray.writeUnsignedInt(this.tempPixel);
            }
            this.newByteArray.position = 0;
            this.sourceBitmapData.setPixels(this.tempRect,this.newByteArray);
         }
         this.minecraftViewer.updateSkin(this.sourceBitmapData);
      }
      
      public function clearSourceBitmaps() : void
      {
         for each(this.bitmapSprite in this.sourceBitmaps)
         {
            this.bitmapSprite.cleanup();
            this.sourceContainer.removeChild(this.bitmapSprite);
         }
         this.sourceBitmaps = new Vector.<BitmapSprite>();
      }
      
      public function press_outline(param1:MouseEvent) : void
      {
         this.minecraftViewer._canRotate = true;
         this.mcModelMessage.visible = false;
         if(this.showingDummySkin)
         {
            if(Utilities.saveFile.firstRotate)
            {
               Utilities.saveFile.firstRotate = false;
               Utilities.saveGame();
            }
         }
      }
      
      public function press_btnToEditor(param1:MouseEvent) : void
      {
         Main.newDialogBox = new DialogBox("Take this skin to the editor?");
         Main.newDialogBox.createAsYesNo("TAKESKINTOEDITOR");
         Main.newDialogBox.display();
      }
      
      public function press_btnNGLogo(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://newgrounds.com");
      }
      
      public function press_btnBGLeft(param1:MouseEvent) : void
      {
         this.mcBGS.prevFrame();
         Main.savedBG = this.mcBGS.currentFrame;
         this.updateBGButtons();
         this.btnBGRight.alpha = 1;
         this.btnBGRight.mouseEnabled = true;
      }
      
      public function press_btnBGRight(param1:MouseEvent) : void
      {
         this.mcBGS.nextFrame();
         Main.savedBG = this.mcBGS.currentFrame;
         this.updateBGButtons();
         this.btnBGLeft.alpha = 1;
         this.btnBGLeft.mouseEnabled = true;
      }
      
      public function initBrowseMode() : void
      {
         this.mcBGS.gotoAndStop(1);
         this.mcBGLabel.visible = false;
         this.btnBGLeft.visible = false;
         this.btnBGRight.visible = false;
         this.mcNGLogo.visible = false;
         this.needVoteBar = true;
         Utilities.mc2Btn(this.btnDownload);
         Utilities.mc2Btn(this.btnToEditor);
         this.btnDownload.alpha = this.btnToEditor.alpha = 0.3;
         this.btnDownload.mouseEnabled = this.btnToEditor.mouseEnabled = false;
         this.btnDownload.visible = this.btnToEditor.visible = true;
         this.btnDownload.addEventListener(MouseEvent.CLICK,this.press_btnDownload);
         this.btnToEditor.addEventListener(MouseEvent.CLICK,this.press_btnToEditor);
      }
      
      public function press_btnSplit(param1:MouseEvent) : *
      {
         if(this.btnSplit.currentFrame == 1)
         {
            this.btnSplit.nextFrame();
            this.minecraftViewer.splitModel();
         }
         else
         {
            this.btnSplit.prevFrame();
            this.minecraftViewer.joinModel();
         }
      }
      
      public function cleanup() : void
      {
         this.clearPieces();
         this.clearSourceBitmaps();
         if(this.sourceBitmapData)
         {
            this.sourceBitmapData.dispose();
         }
         this.minecraftViewer.cleanup();
         Main.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE,this.minecraftViewer.mouseMove);
         this.mcOutline.removeEventListener(MouseEvent.MOUSE_DOWN,this.press_outline);
         this.btnBGLeft.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnBGLeft.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnBGRight.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnBGRight.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnBGLeft.removeEventListener(MouseEvent.CLICK,this.press_btnBGLeft);
         this.btnBGRight.removeEventListener(MouseEvent.CLICK,this.press_btnBGRight);
         Utilities.cleanupMCBtn(this.btnDownload);
         Utilities.cleanupMCBtn(this.btnToEditor);
         this.mcNGLogo.removeEventListener(MouseEvent.CLICK,this.press_btnNGLogo);
      }
      
      public function mapSurface(param1:uint, param2:Number, param3:Number, param4:Boolean = false) : void
      {
         this.tempSurface = Main.getSurface(param1);
         this.tempBitmapData = new BitmapData(this.tempSurface.sourceRect.width,this.tempSurface.sourceRect.height);
         this.tempBitmapData.copyPixels(this.sourceBitmapData,this.tempSurface.sourceRect,new Point(0,0));
         this.tempBitmap = new Bitmap(this.tempBitmapData);
         this.viewPieces.push(this.tempBitmap);
         this.tempBitmap.x = param2;
         this.tempBitmap.y = param3;
         if(param4)
         {
            this.tempBitmap.scaleX = -this.tempBitmap.scaleX;
            this.tempBitmap.x += this.tempBitmap.width;
         }
         if(param1 >= Surface.HAT_LEFT)
         {
            this.tempBitmap.scaleX = this.tempBitmap.scaleY = 1.125;
         }
         this.previewWrapper.addChild(this.tempBitmap);
      }
      
      public function updateBGButtons() : void
      {
         if(this.mcBGS.currentFrame == 1)
         {
            this.btnBGLeft.mouseEnabled = false;
            this.btnBGLeft.alpha = 0.3;
         }
         else if(this.mcBGS.currentFrame == this.mcBGS.totalFrames)
         {
            this.btnBGRight.mouseEnabled = false;
            this.btnBGRight.alpha = 0.3;
         }
      }
      
      public function fileComplete(param1:Event) : void
      {
         Main.generateOKDialog("Your skin file was saved successfully",true);
      }
      
      public function loadBase(param1:BitmapData) : void
      {
         var _loc2_:MovieClip = null;
         param1 = Main.convertBmpdTo1_8(param1);
         this.baseBitmap.bitmapData = this.baseBitmapData = param1;
         this.sourceContainer.alpha = 0;
         if(this.showingDummySkin)
         {
            this.baseWrapper.transform.colorTransform = brightness;
         }
         this.i = 0;
         if(this.i >= 6)
         {
         }
         this.minecraftViewer.visible = true;
         this.btnSplit.visible = true;
         if(this.needVoteBar)
         {
            this.btnDownload.alpha = this.btnToEditor.alpha = 1;
            this.btnDownload.mouseEnabled = this.btnToEditor.mouseEnabled = true;
         }
      }
      
      public function fileError(param1:IOErrorEvent) : void
      {
         Main.generateOKDialog("There was an error saving your file");
      }
      
      public function clearPieces() : void
      {
         for each(this.tempBitmap in this.viewPieces)
         {
            this.tempBitmap.bitmapData.dispose();
            this.previewWrapper.removeChild(this.tempBitmap);
         }
         this.viewPieces = new Vector.<Bitmap>();
      }
      
      public function press_btnChangeView(param1:MouseEvent) : void
      {
         Main.savedView = this.curView = MovieClip(param1.currentTarget).viewID;
         this.refreshView();
      }
   }
}
