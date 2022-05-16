package
{
   import flash.geom.Rectangle;
   
   public class Surface
   {
      
      public static const ARM_RIGHT_LEFT_JACKET:uint = 48;
      
      public static const HEAD_LEFT:uint = 0;
      
      public static const BODY_BACK_JACKET:uint = 45;
      
      public static const LEG_LEFT_BACK:uint = 39;
      
      public static const ARM_RIGHT_FRONT_JACKET:uint = 49;
      
      public static const ARM_RIGHT_BOTTOM:uint = 17;
      
      public static const LEG_LEFT_TOP_JACKET:uint = 70;
      
      public static const BODY_TOP:uint = 10;
      
      public static const LEG_LEFT_BOTTOM_JACKET:uint = 71;
      
      public static const BODY_RIGHT:uint = 8;
      
      public static const ARM_RIGHT_BACK_JACKET:uint = 51;
      
      public static const ARM_LEFT_BOTTOM_JACKET:uint = 65;
      
      public static const LEG_LEFT_BACK_JACKET:uint = 69;
      
      public static const LEG_RIGHT_FRONT_JACKET:uint = 55;
      
      public static const LEG_RIGHT_RIGHT:uint = 20;
      
      public static const HAT_BACK:uint = 27;
      
      public static const BODY_FRONT:uint = 7;
      
      public static const ARM_RIGHT_BACK:uint = 15;
      
      public static const LEG_LEFT_LEFT:uint = 36;
      
      public static const ARM_RIGHT_TOP:uint = 16;
      
      public static const LEG_RIGHT_LEFT_JACKET:uint = 54;
      
      public static const LEG_RIGHT_FRONT:uint = 19;
      
      public static const HAT_RIGHT:uint = 26;
      
      public static const LEG_RIGHT_BACK:uint = 21;
      
      public static const LEG_LEFT_TOP:uint = 40;
      
      public static const BODY_FRONT_JACKET:uint = 43;
      
      public static const HAT_FRONT:uint = 25;
      
      public static const HAT_LEFT:uint = 24;
      
      public static const ARM_RIGHT_LEFT:uint = 12;
      
      public static const LEG_RIGHT_BACK_JACKET:uint = 57;
      
      public static const ARM_LEFT_TOP_JACKET:uint = 64;
      
      public static const HEAD_TOP:uint = 4;
      
      public static const LEG_RIGHT_LEFT:uint = 18;
      
      public static const LEG_RIGHT_TOP:uint = 22;
      
      public static const BODY_BACK:uint = 9;
      
      public static const ARM_LEFT_RIGHT_JACKET:uint = 62;
      
      public static const BODY_BOTTOM:uint = 11;
      
      public static const LEG_RIGHT_TOP_JACKET:uint = 58;
      
      public static const HAT_BOTTOM:uint = 29;
      
      public static const HAT_TOP:uint = 28;
      
      public static const ARM_LEFT_LEFT_JACKET:uint = 60;
      
      public static const HEAD_BOTTOM:uint = 5;
      
      public static const ARM_RIGHT_RIGHT:uint = 14;
      
      public static const LEG_RIGHT_BOTTOM:uint = 23;
      
      public static const ARM_RIGHT_FRONT:uint = 13;
      
      public static const BODY_LEFT:uint = 6;
      
      public static const BODY_BOTTOM_JACKET:uint = 47;
      
      public static const LEG_RIGHT_BOTTOM_JACKET:uint = 59;
      
      public static const LEG_LEFT_BOTTOM:uint = 41;
      
      public static const ARM_LEFT_BACK_JACKET:uint = 63;
      
      public static const LEG_LEFT_RIGHT_JACKET:uint = 68;
      
      public static const ARM_LEFT_TOP:uint = 34;
      
      public static const ARM_LEFT_RIGHT:uint = 32;
      
      public static const ARM_LEFT_FRONT:uint = 31;
      
      public static const LEG_LEFT_RIGHT:uint = 38;
      
      public static const ARM_RIGHT_RIGHT_JACKET:uint = 50;
      
      public static const ARM_LEFT_FRONT_JACKET:uint = 61;
      
      public static const LEG_RIGHT_RIGHT_JACKET:uint = 56;
      
      public static const LEG_LEFT_FRONT:uint = 37;
      
      public static const BODY_TOP_JACKET:uint = 46;
      
      public static const ARM_LEFT_BACK:uint = 33;
      
      public static const HEAD_RIGHT:uint = 2;
      
      public static const ARM_LEFT_BOTTOM:uint = 35;
      
      public static const ARM_RIGHT_TOP_JACKET:uint = 52;
      
      public static const HEAD_BACK:uint = 3;
      
      public static const BODY_LEFT_JACKET:uint = 42;
      
      public static const HEAD_FRONT:uint = 1;
      
      public static const ARM_RIGHT_BOTTOM_JACKET:uint = 53;
      
      public static const BODY_RIGHT_JACKET:uint = 44;
      
      public static const LEG_LEFT_FRONT_JACKET:uint = 67;
      
      public static const ARM_LEFT_LEFT:uint = 30;
      
      public static const LEG_LEFT_LEFT_JACKET:uint = 66;
       
      
      public var id:uint;
      
      public var viewableFrom:uint;
      
      public var name:String;
      
      public var sourceRect:Rectangle;
      
      public function Surface(param1:uint, param2:String, param3:Rectangle, param4:uint)
      {
         super();
         this.id = param1;
         this.name = param2;
         this.sourceRect = param3;
         this.viewableFrom = param4;
      }
   }
}
