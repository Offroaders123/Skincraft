package com.newgrounds
{
   public class SaveGroup
   {
      
      public static const TYPE_SYSTEM:uint = 0;
      
      public static const TYPE_PRIVATE:uint = 1;
      
      public static const TYPE_PUBLIC:uint = 2;
      
      public static const TYPE_MODERATED:uint = 3;
       
      
      private var _connection:APIConnection;
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _type:uint;
      
      private var _keysArray:Array;
      
      private var _ratingsArray:Array;
      
      private var _keys:Object;
      
      private var _ratings:Object;
      
      public function SaveGroup(param1:APIConnection, param2:String, param3:uint, param4:uint, param5:Array, param6:Array)
      {
         var _loc7_:uint = 0;
         var _loc8_:SaveKey = null;
         var _loc9_:SaveRating = null;
         super();
         this._connection = param1;
         this._id = param3;
         this._name = param2;
         this._type = param4;
         this._keysArray = param5;
         this._ratingsArray = param6;
         this._keys = new Object();
         this._ratings = new Object();
         for each(_loc8_ in param5)
         {
            this._keys[_loc8_.name] = _loc8_;
         }
         for each(_loc9_ in param6)
         {
            this._ratings[_loc9_.name] = _loc9_;
         }
      }
      
      public function get connection() : APIConnection
      {
         return this._connection;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get keys() : Array
      {
         return this._keysArray;
      }
      
      public function get ratings() : Array
      {
         return this._ratingsArray;
      }
      
      public function getKey(param1:String) : SaveKey
      {
         return this._keys[param1];
      }
      
      public function getRating(param1:String) : SaveRating
      {
         return this._ratings[param1];
      }
      
      public function getKeyById(param1:uint) : SaveKey
      {
         var _loc2_:SaveKey = null;
         for each(_loc2_ in this._keys)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getRatingById(param1:uint) : SaveRating
      {
         var _loc2_:SaveRating = null;
         for each(_loc2_ in this._ratings)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function toString() : String
      {
         return "SaveGroup: " + this.name + "  Keys: " + this._keysArray + "  Ratings: " + this._ratingsArray;
      }
   }
}
