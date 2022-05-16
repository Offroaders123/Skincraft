package com.newgrounds.components
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public dynamic class Preloader extends MovieClip
   {
       
      
      public var playButton:SimpleButton;
      
      public var loadingBar:MovieClip;
      
      public function Preloader()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10);
      }
      
      function frame10() : *
      {
         addEventListener(Event.ENTER_FRAME,this.findPlayButton);
      }
      
      function frame1() : *
      {
         stop();
         addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      public function enterFrameHandler(param1:Event) : void
      {
         var _loc2_:Number = 0;
         if(loaderInfo)
         {
            _loc2_ = loaderInfo.bytesLoaded / loaderInfo.bytesTotal;
         }
         if(this.loadingBar)
         {
            this.loadingBar.gotoAndStop(int(_loc2_ * (this.loadingBar.totalFrames - 1)) + 1);
         }
         if(_loc2_ >= 1)
         {
            removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
            gotoAndStop("loaded");
         }
      }
      
      public function _onPlayClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         if(root && root is MovieClip)
         {
            _loc2_ = parent as MovieClip;
            MovieClip(root).play();
         }
      }
      
      public function findPlayButton(param1:Event) : void
      {
         if(this.playButton)
         {
            this.playButton.addEventListener(MouseEvent.CLICK,this._onPlayClick);
            removeEventListener(Event.ENTER_FRAME,this.findPlayButton);
         }
      }
   }
}
