package com.newgrounds.encoders.json
{
   public class JSON
   {
       
      
      public function JSON()
      {
         super();
      }
      
      public static function encode(param1:Object) : String
      {
         return encodeJson(param1);
      }
      
      public static function decode(param1:String) : Object
      {
         return decodeJson(param1);
      }
   }
}
