package com.newgrounds
{
   public class SaveKey
   {
      
      public static const TYPE_FLOAT:uint = 1;
      
      public static const TYPE_INTEGER:uint = 2;
      
      public static const TYPE_STRING:uint = 3;
      
      public static const TYPE_BOOLEAN:uint = 4;
       
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _type:uint;
      
      public function SaveKey(param1:String, param2:uint, param3:uint)
      {
         super();
         this._name = param1;
         this._id = param2;
         this._type = param3;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function validateValue(param1:*) : *
      {
         var _loc2_:int = 0;
         switch(this._type)
         {
            case TYPE_INTEGER:
               param1 = Number(param1);
               if(!isNaN(param1))
               {
                  _loc2_ = int(param1);
                  if(_loc2_ != param1)
                  {
                     Logger.logWarning("Float value " + param1 + " given for integer key \"" + this._name + "\". Clamping to " + _loc2_ + ".");
                  }
                  return _loc2_;
               }
               break;
            case TYPE_FLOAT:
               param1 = Number(param1);
               if(!isNaN(param1))
               {
                  return isNaN(Number(param1));
               }
               break;
            case TYPE_BOOLEAN:
               return Boolean(param1);
            case TYPE_STRING:
               return !!param1 ? param1.toString() : "";
         }
         return null;
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
