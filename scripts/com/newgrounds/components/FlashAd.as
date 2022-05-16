package com.newgrounds.components
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.system.Security;
   
   public class FlashAd extends MovieClip
   {
      
      private static const TEST_AD_FEED_URL:String = "http://www.ngads.com/adtest.php";
      
      public static var debugMode:Boolean;
      
      static var _adFeedURL:String = "http://www.ngads.com/getad.php?url=http%3A%2F%2Fserver.cpmstar.com%2Fadviewas3.swf%3Fpoolid=731%26subpoolid=";
       
      
      public var adContainer:Sprite;
      
      public var newgroundsButton:DisplayObject;
      
      private var _apiId:String;
      
      private var _showBorder:Boolean;
      
      private var _adFeedLoader:URLLoader;
      
      private var _ad:Loader;
      
      public function FlashAd()
      {
         super();
         try
         {
            Security.allowDomain("server.cpmstar.com");
         }
         catch(error:*)
         {
         }
         x = int(x);
         y = int(y);
         stop();
         if(stage)
         {
            stage.addEventListener(Event.RENDER,this.onRender);
         }
         if(this.newgroundsButton)
         {
            this.newgroundsButton.addEventListener(MouseEvent.CLICK,this.onNGClick);
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      private function init() : void
      {
         if(!this._apiId || this._apiId == "")
         {
            trace("[Newgrounds API] :: You must enter the API ID for your movie into the ad component.\nFor more info, please see http://www.newgrounds.com/wiki.");
         }
      }
      
      public function get apiId() : String
      {
         return this._apiId;
      }
      
      public function set apiId(param1:String) : void
      {
         this._apiId = param1;
         if(this._apiId && this._apiId != "")
         {
            this.loadAdFeed(_adFeedURL);
         }
      }
      
      public function get showBorder() : Boolean
      {
         return this._showBorder;
      }
      
      public function set showBorder(param1:Boolean) : void
      {
         this._showBorder = param1;
         if(this._showBorder)
         {
            if(this._ad)
            {
               if(this._ad.content)
               {
                  gotoAndStop("loaded");
               }
               else
               {
                  gotoAndStop("loading");
               }
            }
            else
            {
               gotoAndStop("idle");
            }
         }
         else
         {
            gotoAndStop("noBorder");
         }
      }
      
      private function loadAdFeed(param1:String) : void
      {
         var trackerId:String = null;
         var i:uint = 0;
         var adFeedURL:String = param1;
         if(!adFeedURL)
         {
            return;
         }
         if(this._showBorder)
         {
            gotoAndStop("loading");
         }
         this._adFeedLoader = new URLLoader();
         this._adFeedLoader.addEventListener(Event.COMPLETE,this.onAdFeedLoaded);
         this._adFeedLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onAdError);
         this._adFeedLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onAdError);
         if(debugMode)
         {
            adFeedURL = TEST_AD_FEED_URL;
         }
         else
         {
            trackerId = this._apiId;
            i = trackerId.indexOf(":");
            if(i != -1)
            {
               trackerId = trackerId.substring(0,i);
            }
            adFeedURL += trackerId;
         }
         var adFeedRequest:URLRequest = new URLRequest(adFeedURL);
         try
         {
            this._adFeedLoader.load(adFeedRequest);
         }
         catch(e:Error)
         {
            onAdError();
         }
      }
      
      private function onAdFeedLoaded(param1:Event) : void
      {
         if(this._adFeedLoader && this._adFeedLoader.data && this._adFeedLoader.data != "")
         {
            this.loadAd(this._adFeedLoader.data);
         }
         else
         {
            this.onAdError();
         }
      }
      
      private function loadAd(param1:String) : void
      {
         var adURL:String = param1;
         if(this._ad)
         {
            this.removeAd();
         }
         this._ad = new Loader();
         this._ad.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onAdError);
         try
         {
            Object(this._ad.contentLoaderInfo).uncaughtErrorEvents.addEventListener("uncaughtError",function(param1:Event):void
            {
               param1.preventDefault();
            });
         }
         catch(error:Error)
         {
         }
         try
         {
            this._ad.load(new URLRequest(adURL),new LoaderContext(false,new ApplicationDomain(null)));
            if(this.adContainer)
            {
               this.adContainer.addChild(this._ad);
            }
            if(this._showBorder)
            {
               gotoAndStop("loaded");
            }
         }
         catch(error:Error)
         {
            onAdError();
         }
      }
      
      public function removeAd() : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
         if(this._adFeedLoader)
         {
            try
            {
               this._adFeedLoader.close();
            }
            catch(e:Error)
            {
            }
         }
         if(this._ad)
         {
            try
            {
               this._ad.close();
            }
            catch(e:Error)
            {
            }
            try
            {
               Object(this._ad).unloadAndStop(true);
            }
            catch(e:Error)
            {
               _ad.unload();
               trace("unload");
            }
            if(this._ad.parent)
            {
               this._ad.parent.removeChild(this._ad);
            }
            this._ad = null;
         }
         trace("[Newgrounds API] :: Ad destroyed.");
      }
      
      private function onAdError(param1:Event = null) : void
      {
         trace("[Newgrounds API] :: Unable to load ad.\n" + param1);
         this.removeAd();
      }
      
      private function onRemovedFromStage(param1:Event) : void
      {
         this.removeAd();
      }
      
      private function onNGClick(param1:MouseEvent) : void
      {
         navigateToURL(new URLRequest("http://www.newgrounds.com"),"_blank");
      }
      
      private function onRender(param1:Event) : void
      {
         if(stage)
         {
            stage.removeEventListener(Event.RENDER,this.onRender);
         }
         this.init();
      }
   }
}
