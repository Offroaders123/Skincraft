package com.newgrounds.components
{
   import flash.display.MovieClip;
   import flash.system.Security;
   import flash.utils.getDefinitionByName;
   
   public dynamic class APIConnector extends MovieClip
   {
       
      
      public var ad:FlashAd;
      
      public var connectorType:String;
      
      public var movieVersion:String;
      
      public var loader:Preloader;
      
      public var apiId:String;
      
      public var debugMode:String;
      
      public var encryptionKey:String;
      
      public function APIConnector()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         if(root && root is MovieClip)
         {
            MovieClip(root).stop();
         }
         x = int(x);
         y = int(y);
         if(!this.debugMode)
         {
            this.debugMode = "Simulate Logged-in User";
         }
         if(!this.connectorType)
         {
            this.connectorType = "Flash Ad + Preloader";
         }
         switch(this.connectorType)
         {
            case "Flash Ad + Preloader":
               gotoAndStop("adPreloader");
               break;
            case "Flash Ad Only":
               gotoAndStop("ad");
               break;
            case "Invisible":
               gotoAndStop("invisible");
         }
         if(this.debugMode != "Off" && Security.sandboxType != Security.REMOTE)
         {
            FlashAd.debugMode = true;
         }
         this.ad.apiId = this.apiId;
         this._apiConnect();
      }
      
      public function _apiConnect() : void
      {
         var _loc1_:* = undefined;
         _loc1_ = getDefinitionByName("com.newgrounds.API");
         if(_loc1_ && !_loc1_.connected)
         {
            switch(this.debugMode)
            {
               case "Off":
               default:
                  _loc1_.debugMode = _loc1_.RELEASE_MODE;
                  break;
               case "Simulate Logged-in User":
                  _loc1_.debugMode = _loc1_.DEBUG_MODE_LOGGED_IN;
                  break;
               case "Simulate Logged-out User":
                  _loc1_.debugMode = _loc1_.DEBUG_MODE_LOGGED_OUT;
                  break;
               case "Simulate New Version":
                  _loc1_.debugMode = _loc1_.DEBUG_MODE_NEW_VERSION;
                  break;
               case "Simulate Host Blocked":
                  _loc1_.debugMode = _loc1_.DEBUG_MODE_HOST_BLOCKED;
            }
            _loc1_.connect(root,this.apiId,this.encryptionKey,this.movieVersion);
         }
      }
      
      public function _onLoaded() : void
      {
         gotoAndStop("invisible");
         this._apiConnect();
      }
   }
}
