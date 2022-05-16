package
{
   public class Subcategory
   {
      
      public static const SKIRTS:uint = 11;
      
      public static const SYMBOLS:uint = 19;
      
      public static const SHOES:uint = 2;
      
      public static const BELTS:uint = 16;
      
      public static const ACCESSORY_HEAD:uint = 15;
      
      public static const GLASSES:uint = 17;
      
      public static const COATS:uint = 5;
      
      public static const FACE:uint = 12;
      
      public static const HATS_AND_MASKS:uint = 8;
      
      public static const CAPES:uint = 10;
      
      public static const HAIR:uint = 0;
      
      public static const ACCESSORY_LOWER:uint = 14;
      
      public static const TUNICS:uint = 9;
      
      public static const SHIRTS_AND_TIES:uint = 4;
      
      public static const HEAD_SHAPES:uint = 6;
      
      public static const PACKS:uint = 18;
      
      public static const ACCESSORY_UPPER:uint = 13;
      
      public static const TEXTURES:uint = 1;
      
      public static const GLOVES:uint = 7;
      
      public static const PANTS:uint = 3;
       
      
      public var id:uint;
      
      public var parentCategory:Category;
      
      public var name:String;
      
      public function Subcategory(param1:uint, param2:String, param3:uint)
      {
         super();
         this.id = param1;
         this.name = param2;
         this.parentCategory = Main.getCategory(param3);
      }
   }
}
