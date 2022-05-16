package com.newgrounds
{
   public class Score
   {
       
      
      private var _numericValue:Number;
      
      private var _rank:uint;
      
      private var _username:String;
      
      private var _score:String;
      
      private var _tag:String;
      
      public function Score(param1:uint, param2:String, param3:String, param4:Number, param5:String)
      {
         super();
         this._rank = param1;
         this._username = param2;
         this._score = param3;
         this._numericValue = param4;
         this._tag = param5;
      }
      
      public function get numericValue() : Number
      {
         return this._numericValue;
      }
      
      public function get rank() : uint
      {
         return this._rank;
      }
      
      public function get score() : String
      {
         return this._score;
      }
      
      public function get tag() : String
      {
         return this._tag;
      }
      
      public function get username() : String
      {
         return this._username;
      }
      
      public function toString() : String
      {
         return this._rank + ".\t" + this._username + "\t" + this._score;
      }
   }
}
