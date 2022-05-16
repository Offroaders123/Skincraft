package com.newgrounds
{
   import flash.events.Event;
   
   public class APIEvent extends Event
   {
      
      static const COMMAND_COMPLETE:String = "commandComplete";
      
      static const MEDAL_UNLOCK_CONFIRMED:String = "medalUnlockConfirmed";
      
      public static const API_CONNECTED:String = "movieConnected";
      
      public static const MEDAL_UNLOCKED:String = "medalUnlocked";
      
      public static const SCORES_LOADED:String = "scoresLoaded";
      
      public static const SCORE_POSTED:String = "scorePosted";
      
      public static const QUERY_COMPLETE:String = "queryComplete";
      
      public static const FILE_LOADED:String = "fileLoaded";
      
      public static const FILE_SAVED:String = "fileSaved";
      
      public static const VOTE_COMPLETE:String = "voteComplete";
      
      public static const ERROR_NONE:String = "noError";
      
      public static const ERROR_UNKNOWN:String = "unknownError";
      
      public static const ERROR_COMMAND_FAILED:String = "commandFailed";
      
      public static const ERROR_NOT_CONNECTED:String = "notConnected";
      
      public static const ERROR_INVALID_ARGUMENT:String = "invalidArgument";
      
      public static const ERROR_TIMED_OUT:String = "timedOut";
      
      public static const ERROR_BAD_FILE:String = "badFile";
      
      public static const ERROR_BAD_RESPONSE:String = "badResponse";
      
      public static const ERROR_SENDING_COMMAND:String = "errorSendingCommand";
      
      public static const ERROR_HOST_BLOCKED:String = "hostBlocked";
      
      public static const ERROR_ALREADY_VOTED:String = "alreadyVoted";
       
      
      private var _data;
      
      private var _success:Boolean;
      
      private var _error:String;
      
      public function APIEvent(param1:String, param2:* = null, param3:String = null)
      {
         super(param1);
         if(!param3 || param3 == "" || param3 == ERROR_NONE)
         {
            this._error = ERROR_NONE;
            this._success = true;
         }
         else
         {
            this._error = param3;
            this._success = false;
         }
         if(param2)
         {
            this._data = param2;
         }
         else
         {
            this._data = {};
         }
      }
      
      override public function clone() : Event
      {
         return new APIEvent(type,this._data,this._error);
      }
      
      public function get success() : Boolean
      {
         return this._success;
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get error() : String
      {
         return this._error;
      }
   }
}
