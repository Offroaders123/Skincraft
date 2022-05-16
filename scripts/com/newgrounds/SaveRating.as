package com.newgrounds
{
   public class SaveRating
   {
       
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _isFloat:Boolean;
      
      private var _minimum:Number;
      
      private var _maximum:Number;
      
      public function SaveRating(param1:String, param2:uint, param3:Boolean, param4:Number, param5:Number)
      {
         super();
         this._name = param1;
         this._id = param2;
         this._isFloat = param3;
         this._minimum = param4;
         this._maximum = param5;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get isFloat() : Boolean
      {
         return this._isFloat;
      }
      
      public function get minimum() : Number
      {
         return this._minimum;
      }
      
      public function get maximum() : Number
      {
         return this._maximum;
      }
      
      public function validateValue(param1:*) : Number
      {
         var _loc3_:int = 0;
         var _loc2_:Number = Number(param1);
         if(isNaN(_loc2_))
         {
            Logger.logError("Invalid value for rating \"" + this._name + "\".");
            return NaN;
         }
         if(_loc2_ < this._minimum)
         {
            Logger.logWarning(_loc2_ + " is out of acceptable range for rating \"" + this._name + "\". Clamping to " + this._minimum + ".");
            return this._minimum;
         }
         if(_loc2_ > this._maximum)
         {
            Logger.logWarning(_loc2_ + " is out of acceptable range for rating \"" + this._name + "\". Clamping to " + this._maximum + ".");
            return this._maximum;
         }
         if(!this.isFloat)
         {
            _loc3_ = int(_loc2_);
            if(_loc3_ != _loc2_)
            {
               Logger.logWarning("Float value " + _loc2_ + " given for integer rating \"" + this._name + "\". Clamping to " + _loc3_ + ".");
            }
            return _loc3_;
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
