package
{	
  import flash.geom.Rectangle;
  
  public class Surface
  {
    //instance vars
    public var id:uint;
    public var name:String;
    public var sourceRect:Rectangle;
    public var viewableFrom:uint;
    
    //surface consts
    public static const HEAD_LEFT:uint = 0;
    public static const HEAD_FRONT:uint = 1;
    public static const HEAD_RIGHT:uint = 2;
    public static const HEAD_BACK:uint = 3;
    public static const HEAD_TOP:uint = 4;
    public static const HEAD_BOTTOM:uint = 5;
    
    public static const BODY_LEFT:uint = 6;
    public static const BODY_FRONT:uint = 7;
    public static const BODY_RIGHT:uint = 8;
    public static const BODY_BACK:uint = 9;
    public static const BODY_TOP:uint = 10;
    public static const BODY_BOTTOM:uint = 11;
    
    public static const ARM_LEFT:uint = 12;
    public static const ARM_FRONT:uint = 13;
    public static const ARM_RIGHT:uint = 14;
    public static const ARM_BACK:uint = 15;
    public static const ARM_TOP:uint = 16;
    public static const ARM_BOTTOM:uint = 17;
    
    public static const LEG_LEFT:uint = 18;
    public static const LEG_FRONT:uint = 19;
    public static const LEG_RIGHT:uint = 20;
    public static const LEG_BACK:uint = 21;
    public static const LEG_TOP:uint = 22;
    public static const LEG_BOTTOM:uint = 23;
    
    public static const HAT_LEFT:uint = 24;
    public static const HAT_FRONT:uint = 25;
    public static const HAT_RIGHT:uint = 26;
    public static const HAT_BACK:uint = 27;
    public static const HAT_TOP:uint = 28;
    public static const HAT_BOTTOM:uint = 29;
    
    public function Surface(inID:uint, inName:String, inSourceRect:Rectangle, inViewableFrom:uint):void
    {
      id = inID;
      name = inName;
      sourceRect = inSourceRect;
      viewableFrom = inViewableFrom;
    }
  }
}