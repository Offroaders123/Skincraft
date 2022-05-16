package com.newgrounds
{
   import flash.system.Security;
   
   public class APIConnection
   {
      
      public static const NOT_CONNECTED:String = "notConnected";
      
      public static const CONNECTING:String = "connecting";
      
      public static const CONNECTED:String = "connected";
       
      
      public var initialized:Boolean;
      
      public var connectionState:String = "notConnected";
      
      public var apiURL:String = "http://www.ngads.com/gateway_v2.php";
      
      public var apiId:String;
      
      public var debug:Boolean;
      
      public var trackerId:uint;
      
      public var publisherId:uint;
      
      public var encryptionKey:String;
      
      public var sessionId:String;
      
      public var userEmail:String;
      
      public var username:String;
      
      public var userId:uint;
      
      public var userpageFormat:uint;
      
      private var _hostURL:String;
      
      public var hostDomain:String;
      
      public function APIConnection()
      {
         super();
         this.reset();
      }
      
      public function get hostURL() : String
      {
         return this._hostURL;
      }
      
      public function set hostURL(param1:String) : void
      {
         this._hostURL = param1;
         this.hostDomain = null;
         if(this._hostURL && this._hostURL.indexOf("file://") != -1 || this._hostURL == "localhost")
         {
            this.hostDomain = this._hostURL.split("/")[2];
         }
         if(!this.hostDomain)
         {
            this.hostDomain = "localhost";
         }
      }
      
      public function get sandboxType() : String
      {
         return Security.sandboxType;
      }
      
      public function get isNetworkHost() : Boolean
      {
         switch(this.sandboxType)
         {
            case "localWithFile":
            case "localWithNetwork":
            case "localTrusted":
            case "application":
               return false;
            case "remote":
         }
         return true;
      }
      
      public function get hasUserSession() : Boolean
      {
         return this.sessionId != null && this.sessionId != "" && this.publisherId != 0;
      }
      
      public function get connected() : Boolean
      {
         return this.connectionState == CONNECTED;
      }
      
      public function reset() : void
      {
         this.connectionState = NOT_CONNECTED;
         this.apiId = null;
         this.trackerId = 0;
         this.publisherId = 0;
         this.encryptionKey = null;
         this.sessionId = null;
         this.userEmail = null;
         this.username = null;
         this.userId = 0;
         this.userpageFormat = 0;
         this.hostURL = null;
      }
      
      public function assertInitialized() : Boolean
      {
         if(!this.initialized)
         {
            Logger.logError("You must initialized the API using API.connect() before using this command.");
            return false;
         }
         return true;
      }
      
      public function assertConnected() : Boolean
      {
         if(!this.connectionState == CONNECTED)
         {
            Logger.logError("You must establish a connection using API.connect() before using this command.");
            return false;
         }
         return true;
      }
      
      public function sendSimpleCommand(param1:String, param2:Function, param3:Object = null, param4:Object = null) : void
      {
         var _loc5_:APICommand;
         (_loc5_ = new APICommand(param1)).parameters = param3;
         _loc5_.secureParameters = param4;
         if(param2 != null)
         {
            _loc5_.addEventListener(APIEvent.COMMAND_COMPLETE,param2);
         }
         _loc5_.send(this);
      }
      
      public function sendCommand(param1:APICommand) : void
      {
         param1.send(this);
      }
   }
}
