package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.Medal;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class MedalPopup extends MovieClip
   {
       
      
      public var medalPointsText:TextField;
      
      public var medalNameText:TextField;
      
      public var medalIcon:MovieClip;
      
      public var _unlockedMedal:Medal;
      
      public var _medalQueue:Array;
      
      public function MedalPopup()
      {
         super();
         addFrameScript(0,this.frame1,14,this.frame15,22,this.frame23,104,this.frame105);
      }
      
      function frame1() : *
      {
         gotoAndStop("hidden");
         API.addEventListener(APIEvent.MEDAL_UNLOCKED,this.onMedalUnlocked);
         x = int(x);
         y = int(y);
         this._medalQueue = [];
      }
      
      function frame105() : *
      {
         stop();
         this.showNextUnlock();
      }
      
      function frame15() : *
      {
         if(this._unlockedMedal)
         {
            if(this.medalNameText)
            {
               this.medalNameText.text = this._unlockedMedal.name;
            }
            if(this.medalPointsText)
            {
               this.medalPointsText.text = this._unlockedMedal.value.toString();
            }
         }
      }
      
      public function showNextUnlock() : void
      {
         if(!this._medalQueue.length)
         {
            gotoAndStop("hidden");
            return;
         }
         this._unlockedMedal = Medal(this._medalQueue.shift());
         gotoAndPlay("medalUnlocked");
      }
      
      public function onMedalUnlocked(param1:APIEvent) : void
      {
         if(param1.success)
         {
            this._medalQueue.push(param1.data);
            this.showNextUnlock();
         }
      }
      
      function frame23() : *
      {
         if(this._unlockedMedal && this.medalIcon)
         {
            this._unlockedMedal.attachIcon(this.medalIcon);
         }
      }
   }
}
