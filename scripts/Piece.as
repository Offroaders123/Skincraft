package
{
  import flash.display.BitmapData;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.getDefinitionByName;
  
  public class Piece
  {
    //instance vars
    public var id:uint;
    public var name:String;
    public var exportName:String;
    public var subcategory:uint;
    public var tempSurface:Surface;
    public var allowedSurfaces:Vector.<Surface>; //vector of surfaces that this piece is allowed to touch. the first one is also the piece's default view
    public var canMove:Boolean; //whether or not the piece can be moved pixel by pixel
    public var defaultView:uint;
    
    //static id
    public static var uniqueID:int = -1;
    
    public function Piece(inName:String, inSubcategory:uint, inAllowedSurfaces:Array, inCanMove:Boolean=true, inAltDisplayName:String=""):void
    {
      id = generateUniqueID();
      name = inName;
      subcategory = inSubcategory;
      canMove = inCanMove;
      
      //derive export name from given name
      exportName = name.split(" ").join("") + ".png";
      
      //allowed surfaces are passed as an array of surface ids, convert them to actual surface objects in the vector
      allowedSurfaces = new Vector.<Surface>;
      for each(var surfaceID:int in inAllowedSurfaces)
      {
        //if we find surface id -1, skip (it was used as a placeholder)
        if(surfaceID == -1) continue;
        allowedSurfaces.push(Main.getSurface(surfaceID));
      }
      
      //set default view
      defaultView = allowedSurfaces[0].viewableFrom;
      
      //did they provide an alternative display name?
      if(inAltDisplayName != "") name = inAltDisplayName;
    }
    
    public function generateUniqueID():int
    {
      uniqueID++;
      return uniqueID;
    }
    
    public function generateBitmapData():BitmapData
    {
      var bitmapDataClass:Class = getDefinitionByName(exportName) as Class;
      return new bitmapDataClass(Main.SKIN_WIDTH, Main.SKIN_HEIGHT);
    }
    
    //pointName is for testing, to see which point fails the test
    public function surfacesContain(testPoint:Point, pointName:String=""):Boolean
    {	
      for each(tempSurface in allowedSurfaces)
      {
        if(rectContains(tempSurface.sourceRect, testPoint)) return true;
      }
      
      //trace("point (" + testPoint.x +","+testPoint.y + ") not found on a surface. " + pointName);
      return false;
    }
    
    public function rectContains(inRect:Rectangle, inPoint):Boolean
    {
      if( (inPoint.x <= inRect.right && inPoint.x >= inRect.left) &&
        (inPoint.y <= inRect.bottom && inPoint.y >= inRect.top))return true;
      
      return false;
    }
  }
}