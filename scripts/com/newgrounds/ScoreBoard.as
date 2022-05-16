package com.newgrounds
{
   public class ScoreBoard extends APIEventDispatcher
   {
      
      public static const TODAY:String = "Today";
      
      public static const THIS_WEEK:String = "This Week";
      
      public static const THIS_MONTH:String = "This Month";
      
      public static const THIS_YEAR:String = "This Year";
      
      public static const ALL_TIME:String = "All-Time";
       
      
      private var _connection:APIConnection;
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _period:String = "All-Time";
      
      private var _firstResult:uint = 1;
      
      private var _numResults:uint = 10;
      
      private var _tag:String;
      
      private var _scores:Array;
      
      public function ScoreBoard(param1:APIConnection, param2:String, param3:uint)
      {
         super();
         this._connection = param1;
         this._name = param2;
         this._id = param3;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get scores() : Array
      {
         return this._scores;
      }
      
      public function get period() : String
      {
         return this._period;
      }
      
      public function set period(param1:String) : void
      {
         this._period = param1;
      }
      
      public function get firstResult() : uint
      {
         return this._firstResult;
      }
      
      public function set firstResult(param1:uint) : void
      {
         this._firstResult = Math.max(1,param1);
      }
      
      public function get numResults() : uint
      {
         return this._numResults;
      }
      
      public function set numResults(param1:uint) : void
      {
         this._numResults = param1;
      }
      
      public function get tag() : String
      {
         return this._tag;
      }
      
      public function set tag(param1:String) : void
      {
         this._tag = param1;
      }
      
      public function get page() : uint
      {
         return Math.ceil((this._firstResult - 1) / this._numResults) + 1;
      }
      
      public function prevPage() : void
      {
         if(this.firstResult > this._numResults)
         {
            this.firstResult -= this._numResults;
         }
      }
      
      public function nextPage() : void
      {
         this.firstResult += this._numResults;
      }
      
      public function loadScores() : void
      {
         this._connection.sendSimpleCommand("loadScores",this.onScoresLoaded,{
            "publisher_id":this._connection.publisherId,
            "board":this._id,
            "page":(this._firstResult - 1) / this._numResults + 1,
            "num_results":this._numResults,
            "period":this._period,
            "tag":this._tag
         });
      }
      
      public function postScore(param1:Number, param2:String = null) : void
      {
         if(isNaN(param1))
         {
            Logger.logError("Cannot post invalid score: " + param1);
            dispatchEvent(new APIEvent(APIEvent.SCORE_POSTED,null,APIEvent.ERROR_INVALID_ARGUMENT));
            return;
         }
         Logger.logMessage("Posting a score of " + param1 + " by " + this._connection.username + " to scoreboard \"" + this._name + "\"...");
         this._connection.sendSimpleCommand("postScore",this.onScorePosted,null,{
            "user_name":this._connection.username,
            "board":this._id,
            "value":param1,
            "tag":param2
         });
      }
      
      private function onScoresLoaded(param1:APIEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         var _loc2_:Object = param1.data;
         this._scores = [];
         if(_loc2_.first_result)
         {
            _loc3_ = _loc2_.first_result;
         }
         else
         {
            _loc3_ = this._firstResult;
         }
         if(_loc2_.scores)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.scores.length)
            {
               if(_loc5_ = _loc2_.scores[_loc4_])
               {
                  this._scores[_loc4_] = new Score(_loc3_,_loc5_.username,_loc5_.value,_loc5_.numeric_value,_loc5_.tag);
               }
               _loc4_++;
               _loc3_++;
            }
         }
         dispatchEvent(new APIEvent(APIEvent.SCORES_LOADED,this));
      }
      
      private function onScorePosted(param1:APIEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         if(param1.success)
         {
            Logger.logMessage("Score posted!");
            _loc2_ = param1.data;
            _loc3_ = {};
            _loc3_.bestScore = {};
            _loc3_.bestRank = {};
            _loc3_.score = _loc2_.value;
            _loc3_.scoreBoard = this;
            if(_loc2_.best_scores.D)
            {
               _loc3_.bestScore.daily = _loc2_.best_scores.D;
            }
            if(_loc2_.best_scores.W)
            {
               _loc3_.bestScore.weekly = _loc2_.best_scores.W;
            }
            if(_loc2_.best_scores.M)
            {
               _loc3_.bestScore.monthly = _loc2_.best_scores.M;
            }
            if(_loc2_.best_scores.Y)
            {
               _loc3_.bestScore.yearly = _loc2_.best_scores.Y;
            }
            if(_loc2_.best_scores.A)
            {
               _loc3_.bestScore.allTime = _loc2_.best_scores.A;
            }
            if(_loc2_.best_ranks.D)
            {
               _loc3_.bestRank.daily = _loc2_.best_ranks.D;
            }
            if(_loc2_.best_ranks.W)
            {
               _loc3_.bestRank.weekly = _loc2_.best_ranks.W;
            }
            if(_loc2_.best_ranks.M)
            {
               _loc3_.bestRank.monthly = _loc2_.best_ranks.M;
            }
            if(_loc2_.best_ranks.Y)
            {
               _loc3_.bestRank.yearly = _loc2_.best_ranks.Y;
            }
            if(_loc2_.best_ranks.A)
            {
               _loc3_.bestRank.allTime = _loc2_.best_ranks.A;
            }
         }
         else
         {
            Logger.logError("Error posting score: " + param1.error);
         }
         dispatchEvent(new APIEvent(APIEvent.SCORE_POSTED,param1.data,param1.error));
      }
      
      override public function toString() : String
      {
         return "Scoreboard: " + this._name;
      }
   }
}
