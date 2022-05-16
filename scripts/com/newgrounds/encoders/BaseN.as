package com.newgrounds.encoders
{
   import flash.utils.Dictionary;
   
   public class BaseN
   {
      
      private static const DEFAULT_HASH:String = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~@#$%^&*()+|;/";
       
      
      private var _hash:String;
      
      private var _base:uint;
      
      private var _reverseHash:Dictionary;
      
      public function BaseN(param1:String)
      {
         super();
         if(param1)
         {
            this._hash = param1;
         }
         else
         {
            this._hash = DEFAULT_HASH;
         }
         this._base = this._hash.length;
         this._reverseHash = new Dictionary();
         var _loc2_:uint = 0;
         while(_loc2_ < this._hash.length)
         {
            this._reverseHash[this._hash.charAt(_loc2_)] = _loc2_;
            _loc2_++;
         }
      }
      
      public function encodeUint(param1:uint, param2:uint = 1) : String
      {
         var _loc3_:String = "";
         var _loc4_:uint = param1;
         while(_loc4_ != 0)
         {
            _loc3_ = this._hash.charAt(_loc4_ % this._base) + _loc3_;
            _loc4_ /= this._base;
         }
         while(_loc3_.length < param2)
         {
            _loc3_ = this._hash.charAt(0) + _loc3_;
         }
         return _loc3_;
      }
      
      public function decodeUint(param1:String) : uint
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ *= this._base;
            _loc2_ += this._reverseHash[param1.charAt(_loc3_)];
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
