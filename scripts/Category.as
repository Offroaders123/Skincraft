package
{
   public class Category
   {
      
      public static const HEAD:uint = 0;
      
      public static const UPPER_BODY:uint = 1;
      
      public static const LOWER_BODY:uint = 3;
      
      public static const FULL:uint = 2;
       
      
      public var name:String;
      
      public var id:uint;
      
      public function Category(param1:uint, param2:String)
      {
         super();
         this.id = param1;
         this.name = param2;
      }
   }
}
