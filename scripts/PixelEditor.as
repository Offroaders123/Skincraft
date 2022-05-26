package
{	
  import com.adobe.protocols.dict.events.ConnectedEvent;
  import fl.motion.Color;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;
  import flash.display.BitmapData;
  import flash.display.BlendMode;
  
  public class PixelEditor extends Sprite
  {
    //instance vars
    public var pixelContainer:Sprite;
    public var gridContainer:Sprite;
    public var tempPixel:Pixel;
    public var pixels:Vector.<Vector.<Pixel>>;
    public var fillColor:uint; //what we use when painting
    public var fillAlpha:Number; //alpha to use when painting
    public var curView:uint; //which view we are targeting
    public var curViewRect:Rectangle;
    public var viewRects:Array; //rectangles that define each view area
    public var tempSurface:Surface;
    public var baseBitmap:Bitmap;
    public var baseBitmapData:BitmapData;
    public var includedSurfaces:Vector.<Surface>;
    public var lockHorizontal:Boolean;
    public var lockVertical:Boolean;
    public var lockX:Number;
    public var lockY:Number;
    public var floodColor:uint;
    public var floodSurface:int;
    public var floodAlpha:uint;
    public var undoLog:Vector.<BitmapData>;
    private var i:uint, j:uint;
    
    //frame-independent check
    public var prevMouseX:Number;
    public var prevMouseY:Number;
    public var incX:Number;
    public var incY:Number;
    public var distanceTraveled:Number;
    
    public static var viewNames:Array = new Array("All","Head","Body","Leg","Arm","Hat");
    public static var PIXEL_SCALE:uint;
    
    public static const VIEW_ALL:uint = 0;
    public static const VIEW_HEAD:uint = 1;
    public static const VIEW_BODY:uint = 2;
    public static const VIEW_LEG:uint = 3;
    public static const VIEW_ARM:uint = 4;
    public static const VIEW_HAT:uint = 5;
    
    public function PixelEditor(inX:int, inY:int):void
    {
      //init
      x = inX;
      y = inY;
      prevMouseX = prevMouseY = 0;
      
      //define view rectangles
      viewRects = new Array();
      viewRects[VIEW_ALL] = new Rectangle(0,0,Main.SKIN_WIDTH, Main.SKIN_HEIGHT);
      viewRects[VIEW_HEAD] = new Rectangle(0,0,32,16);
      viewRects[VIEW_BODY] = new Rectangle(16,16,24,16);
      viewRects[VIEW_LEG] = new Rectangle(0,16,16,16);
      viewRects[VIEW_ARM] = new Rectangle(40,16,16,16);
      viewRects[VIEW_HAT] = new Rectangle(32,0,32,16);
      
      //mouse listeners
      addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      addEventListener(MouseEvent.ROLL_OUT, mouseOut);
      Main.stageRef.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
      
      //drawView(VIEW_ALL);
      
      undoLog = new Vector.<BitmapData>;
    }
    
    public function undo():void
    {
      //just in case there aren't any previous states
      if(undoLog.length == 0)
      {
        trace("no undo levels");
        return;
      }
      
      //revert to the undo state at the end of the log, then erase it
      CustomLayer(Main.layerToEdit).customBitmapData = undoLog[undoLog.length - 1].clone();
      undoLog.pop();
      
      //update editor and model view
      drawView(curView);
      Main.rootRef.mcPreviewBox.refreshView();
      
      //play the button's animation
      Main.rootRef.btnUndo.gotoAndPlay(2);
      
      //update the button
      Main.rootRef.updateUndoButton();
    }
    
    public function drawView(inView:uint):void
    {
      //clear any existing junk
      clearView();
      
      //get cur view and rect
      curView = inView;
      curViewRect = viewRects[curView] as Rectangle;
      
      //augment pixel scale based on view
      if(curView == VIEW_ALL) PIXEL_SCALE = 8;
      else PIXEL_SCALE = 16;
      
      //add the base skin at the bottom
      baseBitmapData = new BitmapData(curViewRect.width, curViewRect.height);
      //baseBitmapData.copyPixels(Main.rootRef.mcPreviewBox.baseBitmapData, curViewRect, new Point(0,0));
      baseBitmapData.copyPixels(new preset_1(64,32), curViewRect, new Point(0,0));
      baseBitmap = new Bitmap(baseBitmapData);
      baseBitmap.alpha = .2;
      baseBitmap.scaleX = baseBitmap.scaleY = PIXEL_SCALE;
      addChild(baseBitmap);
      
      pixelContainer = new Sprite();
      gridContainer = new Sprite();
      gridContainer.mouseEnabled = gridContainer.mouseChildren = false;
      gridContainer.graphics.lineStyle(.5, 0x000000, .4);
      gridContainer.mouseEnabled = false;
      var gridHeight:uint = curViewRect.height * PIXEL_SCALE;
      var gridWidth:uint = curViewRect.width * PIXEL_SCALE;
      
      pixels = new Vector.<Vector.<Pixel>>;
      var rowPixels:Vector.<Pixel>;
      var curColor:uint;
      
      //read the byte array of pixels from the layer's bitmap data
      var pixelByteArray:ByteArray = Main.layerToEdit.getBitmapData().getPixels(curViewRect);
      pixelByteArray.position = 0;
      
      for(i = 0; i <=curViewRect.height; i++)
      {
        rowPixels = new Vector.<Pixel>;
        gridContainer.graphics.moveTo(0, i*PIXEL_SCALE);
        gridContainer.graphics.lineTo(gridWidth, i*PIXEL_SCALE);
        
        //we go one iteration extra to draw the full grid, so break out here before adding more pixels
        if(i == curViewRect.height) continue;
        
        for(j = 0; j <=curViewRect.width; j++)
        {
          gridContainer.graphics.moveTo(j * PIXEL_SCALE, 0);
          gridContainer.graphics.lineTo(j * PIXEL_SCALE, gridHeight);
          
          //we go one iteration extra to draw the full grid, so break out here before adding more pixels
          if(j == curViewRect.width) continue;
          
          tempPixel = new Pixel(j,i);
          curColor = pixelByteArray.readUnsignedInt();
          tempPixel.setColor(curColor, curColor == 0?0:1);
          
          tempPixel.x = j * PIXEL_SCALE;
          tempPixel.y = i * PIXEL_SCALE;
          
          rowPixels.push(tempPixel);
          pixelContainer.addChild(tempPixel);
        }
        pixels.push(rowPixels);
      }
      
      //find the surfaces contained within the current view rect and draw them on the grid
      gridContainer.graphics.lineStyle(2,0x000000,1);
      var surfaceRect:Rectangle;
      var drawX:uint, drawY:uint;
      var drawWidth:uint, drawHeight:uint;
      includedSurfaces = new Vector.<Surface>;
      for each(tempSurface in Main.surfaces)
      {
        surfaceRect = tempSurface.sourceRect;
        if(curViewRect.containsRect(surfaceRect))
        {
          //paint and save it
          drawX = (surfaceRect.x - curViewRect.x);
          drawY = (surfaceRect.y - curViewRect.y);
          drawWidth = surfaceRect.width;
          drawHeight = surfaceRect.height;
          gridContainer.graphics.drawRect(drawX*PIXEL_SCALE, drawY*PIXEL_SCALE, drawWidth*PIXEL_SCALE, drawHeight*PIXEL_SCALE);
          includedSurfaces.push(tempSurface);
          
          for(i = drawY; i < (drawY + drawHeight); i++)
          {
            for(j = drawX; j <(drawX + drawWidth); j++)
            {
              pixels[i][j].surfaceID = tempSurface.id;
              //trace("pixel at " +j + "," + i + "assigned to surface " + tempSurface.name);
            }
          }
        }
      }
      
      //gridContainer.blendMode = BlendMode.INVERT;
      gridContainer.cacheAsBitmap = true;
      pixelContainer.cacheAsBitmap = true;
      addChild(pixelContainer);
      addChild(gridContainer);
    }
    
    public function clearView():void
    {
      if(gridContainer)
      {
        gridContainer.graphics.clear();
        removeChild(gridContainer);
      }
      if(pixelContainer)
      {
        removeChild(pixelContainer);
      }
      if(baseBitmap)
      {
        baseBitmap.bitmapData.dispose();
        removeChild(baseBitmap);
      }
    }
    
    public function mouseDown(e:MouseEvent):void
    {
      //get target pixel
      var targetPixel:Pixel = getPixelAtPoint(mouseX, mouseY);
      setPixelsEligibleForColor();
      
      Main.stageRef.focus = null;
      
      //do they have a tool selected?
      if(Main.curTool == Main.TOOL_ERASER)
      {
        captureUndoLevel();
        Main.cursorMode = Main.CURSOR_DRAW;
        fillAlpha = 0;
        fillColor = 0;
        targetPixel.setColor(fillColor,fillAlpha);
        transferEditorToLayer();
        Main.rootRef.mcShiftMessage.visible = true;
      }
      else if(Main.curTool == Main.TOOL_PENCIL)
      {
        captureUndoLevel();
        Main.cursorMode = Main.CURSOR_DRAW;
        fillAlpha = 1;
        fillColor = Main.rootRef.colorGrabber.actualColor;
        targetPixel.setColor(fillColor,fillAlpha);
        transferEditorToLayer();
        Main.rootRef.mcShiftMessage.visible = true;
      }
      else if(Main.curTool == Main.TOOL_BUCKET)
      {
        captureUndoLevel();
        
        //constrain the ensuing fill to the surface/color/alpha of this pixel, then start the flood fill
        floodSurface = targetPixel.surfaceID;
        floodColor = targetPixel.color;
        floodAlpha = targetPixel.colorAlpha;
        
        fillAlpha = 1;
        fillColor = Main.rootRef.colorGrabber.actualColor;
        floodFill(targetPixel);
        transferEditorToLayer();
      }
    }
    
    public function captureUndoLevel():void
    {
      undoLog.push(Main.layerToEdit.getBitmapData());
      
      //too many?
      if(undoLog.length > 20) undoLog.shift();
      
      //the button will be usable now
      Main.rootRef.updateUndoButton();
    }
    
    public function floodFill(inPixel:Pixel):void
    {
      //if this pixel matches the requirements, fill and move on to its neighbors
      if(inPixel.surfaceID == floodSurface && inPixel.color == floodColor && inPixel.colorAlpha == floodAlpha)
      {
        inPixel.setColor(fillColor, fillAlpha);
        
        //neighbors
        propagateFloodFill(inPixel.gridX-1,inPixel.gridY);
        propagateFloodFill(inPixel.gridX+1,inPixel.gridY);
        propagateFloodFill(inPixel.gridX,inPixel.gridY-1);
        propagateFloodFill(inPixel.gridX,inPixel.gridY+1);
      }
    }
    
    public function propagateFloodFill(pixelX:int, pixelY:int):void
    {
      //the pixel x/y being passed in are hypothetical neighbor locations to another pixel. make sure they are even valid
      if( (pixelX >= 0 && pixelX < curViewRect.width) && (pixelY >=0 && pixelY < curViewRect.height) )
      {
        tempPixel = pixels[pixelY][pixelX];
        if(tempPixel.eligibleForColor) floodFill(tempPixel);
      }
    }
    
    public function mouseOut(e:MouseEvent):void
    {
      Main.rootRef.txtSurfaceName.text = "";
    }
    
    public function setPixelsEligibleForColor():void
    {
      for(i = 0; i < curViewRect.height; i++)
      {
        for(j = 0; j < curViewRect.width; j++)
        {
          pixels[i][j].eligibleForColor = true;
        }
      }
    }
    
    public function getPixelAtPoint(inX:Number, inY:Number):Pixel
    {
      //first find the pixel that is being targetted
      if(inX < 0) inX = 0;
      if(inY < 0) inY = 0;
      var pixelX:uint = inX / PIXEL_SCALE;
      var pixelY:uint = inY / PIXEL_SCALE;
      
      if(pixelX >= curViewRect.width) pixelX = curViewRect.width - 1;
      if(pixelY >= curViewRect.height) pixelY = curViewRect.height - 1;
      
      return pixels[pixelY][pixelX];
    }
    
    public function mouseMove(e:MouseEvent):void
    {
      //if the spectrum chooser is active, or using the eyedropper tool, don't mess with this
      if(Main.rootRef.colorGrabber.usingSpectrum || Main.curTool==Main.TOOL_EYEDROPPER) return;
      
      var thisRect:Rectangle = new Rectangle(0,0,width,height);
      if(thisRect.contains(mouseX,mouseY))
      {				
        //always update with the current pixel's surface name
        tempPixel = getPixelAtPoint(mouseX, mouseY);
        if(tempPixel.surfaceID == -1) Main.rootRef.txtSurfaceName.text = "Unused";
        else Main.rootRef.txtSurfaceName.text = Main.getSurface(tempPixel.surfaceID).name;
        
        //see if we're drawing
        if(Main.cursorMode == Main.CURSOR_DRAW)
        {
          setPixelsEligibleForColor();
          
          //draw line between old and current mouse x/y, attempt to fill the pixels along the way
          incX = mouseX - prevMouseX;
          incY = mouseY - prevMouseY;
          distanceTraveled = Math.sqrt( incX*incX + incY*incY );
          incX /= distanceTraveled;
          incY /= distanceTraveled;
          
          //lock a direction?
          if(KeyManager.pressing(KeyManager.SHIFT))
          {
            if(!lockHorizontal && !lockVertical)
            {
              if(Math.abs(incX) > Math.abs(incY))
              {
                lockVertical = true;
                lockY = prevMouseY;
                //trace("lock vertical");
              }
              else
              {
                lockHorizontal = true;
                lockX = prevMouseX;
                //trace("lock horizontal");
              }
            }
          }
          else
          {
            lockHorizontal = lockVertical = false;
          }
          
          for(i = 0; i < distanceTraveled; i++)
          {
            getPixelAtPoint(lockHorizontal? lockX:prevMouseX, lockVertical?lockY:prevMouseY).setColor(fillColor, fillAlpha);
            
            prevMouseX += incX;
            prevMouseY += incY;
          }
          
          //transfer that shit
          transferEditorToLayer();
        }
        else
        {
          //if we're not drawing, cancel any axis locks
          lockVertical = lockHorizontal = false;
        }
      }
      
      //update previous coords now
      prevMouseX = mouseX;
      prevMouseY = mouseY;
    }
    
    public function transferEditorToLayer():void
    {
      //loop through and transfer each pixel color into a byte array
      var pixelBytes:ByteArray = new ByteArray();
      for(i = 0; i < curViewRect.height; i++)
      {
        for(j = 0; j < curViewRect.width; j++)
        {
          tempPixel = pixels[i][j];
          if(tempPixel.colorAlpha == 0) pixelBytes.writeUnsignedInt(0);
          else 
          {
            pixelBytes.writeUnsignedInt((0xFF000000 | tempPixel.color));
            //pixelBytes.writeUnsignedInt((tempPixel.color));
          }
        }
      }
      
      pixelBytes.position = 0;
      CustomLayer(Main.layerToEdit).customBitmapData.setPixels(curViewRect, pixelBytes);
      Main.rootRef.mcPreviewBox.refreshView();
    }
    
    public function hideBase():void{baseBitmap.visible = false;}
    public function showBase():void{baseBitmap.visible = true;}
    
    public function cleanup():void
    {
      removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
      removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
      Main.stageRef.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
    }
  }
}