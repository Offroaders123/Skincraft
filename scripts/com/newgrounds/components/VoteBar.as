package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.Logger;
   import com.newgrounds.SaveFile;
   import com.newgrounds.SaveRating;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public dynamic class VoteBar extends MovieClip
   {
       
      
      public var _rating:SaveRating;
      
      public var fileMode:String;
      
      public var ratingName:String;
      
      public var title:String;
      
      public var saveFile:SaveFile;
      
      public var voteMenu:MovieClip;
      
      public var i:uint;
      
      public const _numButtons:uint = 6;
      
      public var voteButton;
      
      public function VoteBar()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,58,this.frame59);
      }
      
      function frame59() : *
      {
         stop();
      }
      
      public function _onNewFile(param1:APIEvent) : void
      {
         if(param1.success)
         {
            this.saveFile = param1.data;
            this.start();
         }
      }
      
      public function _onVoteClick(param1:MouseEvent) : void
      {
         var _loc4_:uint = 0;
         var _loc2_:* = param1.target;
         if(!this.voteMenu)
         {
            return;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < this._numButtons)
         {
            if(_loc2_ == this.voteMenu["voteButton" + _loc3_])
            {
               break;
            }
            _loc3_++;
         }
         if(_loc3_ < this._numButtons)
         {
            _loc4_ = this._rating.minimum + _loc3_ * (this._rating.maximum - this._rating.minimum) / (this._numButtons - 1);
            this.saveFile.sendVote(this.ratingName,_loc4_);
            gotoAndStop("voting");
            this.saveFile.addEventListener(APIEvent.VOTE_COMPLETE,this._onVoteComplete);
         }
      }
      
      public function _onVoteComplete(param1:APIEvent) : void
      {
         if(param1.success)
         {
            gotoAndPlay("voteComplete");
         }
         else
         {
            gotoAndStop("hidden");
         }
      }
      
      public function start() : void
      {
         if(this.saveFile)
         {
            this._rating = this.saveFile.group.getRating(this.ratingName);
            if(!this.ratingName)
            {
               if(!(this.saveFile.group && this.saveFile.group.ratings.length))
               {
                  Logger.logError("The save group \"" + this.saveFile.group + "\" has no ratings to vote on. You can create ratings on you API Settings page at http://www.newgrounds.com/account/flashapi");
                  return;
               }
               this._rating = this.saveFile.group.ratings[0];
               this.ratingName = this._rating.name;
               Logger.logWarning("No rating name set in Vote Bar. Defaulting to \"" + this.ratingName + "\".");
            }
            gotoAndStop("ballot");
         }
      }
      
      function frame1() : *
      {
         x = int(x);
         y = int(y);
         if(!this.title)
         {
            this.title = "Submit your vote!";
         }
         if(!this.fileMode)
         {
            this.fileMode = "Use Current File";
         }
         if(this.fileMode == "Use Current File")
         {
            API.addEventListener(APIEvent.FILE_LOADED,this._onNewFile);
            API.addEventListener(APIEvent.FILE_SAVED,this._onNewFile);
            if(SaveFile.currentFile)
            {
               this.saveFile = SaveFile.currentFile;
               this.start();
            }
         }
         gotoAndStop("hidden");
      }
      
      function frame2() : *
      {
         if(!this.saveFile)
         {
            gotoAndStop("hidden");
         }
         if(this.voteMenu)
         {
            this.i = 0;
            while(this.i < this._numButtons)
            {
               this.voteButton = this.voteMenu["voteButton" + this.i];
               if(this.voteButton)
               {
                  this.voteButton.addEventListener(MouseEvent.CLICK,this._onVoteClick);
               }
               ++this.i;
            }
         }
      }
   }
}
