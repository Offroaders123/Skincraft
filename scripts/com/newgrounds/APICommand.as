package com.newgrounds
{
   import com.newgrounds.crypto.MD5;
   import com.newgrounds.crypto.RC4;
   import com.newgrounds.encoders.BaseN;
   import com.newgrounds.encoders.json.JSON;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   import flash.utils.Timer;
   
   public class APICommand extends APIEventDispatcher
   {
      
      private static const TIMEOUT_INTERVAL:uint = 10000;
      
      private static const THROTTLE_INTERVAL:uint = 5000;
      
      private static const THROTTLE_THRESHOLD:uint = 7;
      
      private static var _throttleCount:uint = 0;
      
      private static var _commandQueue:Array = [];
      
      private static const ENCRYPTOR_RADIX:String = "/g8236klvBQ#&|;Zb*7CEA59%s`Oue1wziFp$rDVY@TKxUPWytSaGHJ>dmoMR^<0~4qNLhc(I+fjn)X";
      
      private static var _encryptor:BaseN = new BaseN(ENCRYPTOR_RADIX);
      
      private static var _pendingCommands:Array = [];
      
      private static const CRLF:String = "\r\n";
      
      private static var _throttleTimer:Timer = function():Timer
      {
         var _loc1_:* = new Timer(THROTTLE_INTERVAL,0);
         _loc1_.addEventListener(TimerEvent.TIMER,onThrottleTimer);
         _loc1_.start();
         return _loc1_;
      }();
       
      
      private var _command:String;
      
      private var _parameters:Object;
      
      private var _secureParameters:Object;
      
      private var _files:Object;
      
      private var _preventCache:Boolean;
      
      private var _openBrowser:Boolean;
      
      private var _hasTimeout:Boolean;
      
      private var _timeoutTimer:Timer;
      
      private var _loader:URLLoader;
      
      public function APICommand(param1:String)
      {
         super();
         this._command = param1;
         this._parameters = new Object();
         this._secureParameters = new Object();
         this._timeoutTimer = new Timer(TIMEOUT_INTERVAL,1);
         this._timeoutTimer.addEventListener(TimerEvent.TIMER,this.onTimeout);
         this._hasTimeout = true;
      }
      
      public static function stopPendingCommands() : void
      {
         var _loc1_:APICommand = null;
         for each(_loc1_ in _pendingCommands)
         {
            _loc1_.close();
         }
         _pendingCommands = [];
      }
      
      private static function onThrottleTimer(param1:*) : void
      {
         var _loc2_:Object = null;
         if(_throttleCount > 0)
         {
            --_throttleCount;
         }
         if(_commandQueue.length)
         {
            _loc2_ = _commandQueue.shift();
            _loc2_.command.send(_loc2_.connection);
         }
      }
      
      private static function encryptHex(param1:String) : String
      {
         var _loc2_:uint = param1.length % 6;
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ += _encryptor.encodeUint(uint("0x" + param1.substr(_loc4_,6)),4);
            _loc4_ += 6;
         }
         return _loc2_.toString() + _loc3_;
      }
      
      public function get command() : String
      {
         return this._command;
      }
      
      public function set command(param1:String) : void
      {
         this._command = param1;
      }
      
      public function get hasTimeout() : Boolean
      {
         return this._hasTimeout;
      }
      
      public function set hasTimeout(param1:Boolean) : void
      {
         this._hasTimeout = param1;
      }
      
      public function get parameters() : Object
      {
         return this._parameters;
      }
      
      public function set parameters(param1:Object) : void
      {
         var _loc2_:* = null;
         this._parameters = new Object();
         if(param1)
         {
            for(_loc2_ in param1)
            {
               this._parameters[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function get preventCache() : Boolean
      {
         return this._preventCache;
      }
      
      public function set preventCache(param1:Boolean) : void
      {
         this._preventCache = param1;
      }
      
      public function get secureParameters() : Object
      {
         return this._secureParameters;
      }
      
      public function set secureParameters(param1:Object) : void
      {
         var _loc2_:* = null;
         this._secureParameters = new Object();
         if(param1)
         {
            for(_loc2_ in param1)
            {
               this._secureParameters[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function get hasSecureParameters() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:int = 0;
         var _loc3_:* = this._secureParameters;
         for(_loc1_ in _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function get openBrowser() : Boolean
      {
         return this._openBrowser;
      }
      
      public function set openBrowser(param1:Boolean) : void
      {
         this._openBrowser = param1;
      }
      
      public function addFile(param1:String, param2:ByteArray, param3:String, param4:String = "application/octet-stream") : void
      {
         if(!this._files)
         {
            this._files = new Object();
         }
         var _loc5_:Object = {
            "filename":param1,
            "data":param2,
            "dataField":param3,
            "contentType":param4
         };
         this._files[param1] = _loc5_;
      }
      
      public function removeFile(param1:String) : void
      {
         if(this._files)
         {
            delete this._files[param1];
         }
      }
      
      public function clearFiles() : void
      {
         this._files = null;
      }
      
      public function close() : void
      {
         var _loc1_:uint = 0;
         if(this._loader)
         {
            try
            {
               this._loader.close();
            }
            catch(error:Error)
            {
            }
            this._timeoutTimer.stop();
            _loc1_ = 0;
            while(_loc1_ < _pendingCommands.length)
            {
               if(_pendingCommands[_loc1_] == this)
               {
                  _pendingCommands.splice(_loc1_,1);
                  break;
               }
               _loc1_++;
            }
            this._loader = null;
         }
      }
      
      public function send(param1:APIConnection) : void
      {
         if(_throttleCount >= THROTTLE_THRESHOLD)
         {
            _commandQueue.push({
               "connection":param1,
               "command":this
            });
         }
         else
         {
            this.sendInternal(param1);
         }
      }
      
      private function sendInternal(param1:APIConnection) : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = null;
         var _loc4_:* = undefined;
         var _loc5_:uint = 0;
         var _loc6_:* = null;
         var _loc7_:Object = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:URLRequest = null;
         _loc2_ = new URLVariables();
         _loc2_.command_id = this._command;
         _loc2_.tracker_id = param1.apiId;
         if(param1.debug)
         {
            _loc2_.debug = 1;
         }
         if(this._preventCache)
         {
            _loc2_.seed = Math.random();
         }
         for(_loc3_ in this._parameters)
         {
            if((_loc4_ = this._parameters[_loc3_]) != null)
            {
               if(_loc4_ is Boolean)
               {
                  _loc2_[_loc3_] = int(_loc4_);
               }
               else
               {
                  _loc2_[_loc3_] = _loc4_;
               }
            }
         }
         if(this.hasSecureParameters)
         {
            _loc7_ = new Object();
            for(_loc3_ in this._secureParameters)
            {
               if((_loc4_ = this._secureParameters[_loc3_]) != null)
               {
                  if(_loc4_ is Boolean)
                  {
                     _loc7_[_loc3_] = int(_loc4_);
                  }
                  else
                  {
                     _loc7_[_loc3_] = _loc4_;
                  }
               }
            }
            _loc8_ = "";
            _loc5_ = 0;
            while(_loc5_ < 16)
            {
               _loc8_ += ENCRYPTOR_RADIX.charAt(uint(Math.random() * ENCRYPTOR_RADIX.length));
               _loc5_++;
            }
            _loc2_.command_id = "securePacket";
            _loc7_.command_id = this._command;
            _loc7_.as_version = 3;
            _loc7_.session_id = param1.sessionId;
            _loc7_.user_email = param1.userEmail;
            _loc7_.publisher_id = param1.publisherId;
            _loc7_.seed = _loc8_;
            _loc9_ = MD5.hash(_loc8_);
            _loc10_ = RC4.encrypt(com.newgrounds.encoders.json.JSON.encode(_loc7_),param1.encryptionKey);
            _loc2_.secure = encryptHex(_loc9_ + _loc10_);
         }
         Logger.logInternal("Sending packet:",_loc2_);
         if(this._files)
         {
            _loc11_ = "";
            _loc5_ = 0;
            while(_loc5_ < 32)
            {
               _loc11_ += String.fromCharCode(uint(97 + Math.random() * 25));
               _loc5_++;
            }
            _loc6_ = "multipart/form-data; boundary=\"" + _loc11_ + "\"";
            _loc2_ = this.buildMultipartData(_loc11_,_loc2_,this._files);
         }
         else
         {
            for(_loc3_ in _loc2_)
            {
               if(typeof _loc2_[_loc3_] == "object")
               {
                  _loc2_[_loc3_] = com.newgrounds.encoders.json.JSON.encode(_loc2_[_loc3_]);
               }
            }
            _loc6_ = "application/x-www-form-urlencoded";
         }
         if(this._openBrowser)
         {
            (_loc12_ = new URLRequest(param1.apiURL)).method = URLRequestMethod.GET;
            navigateToURL(_loc12_,"_blank");
         }
         else
         {
            _pendingCommands.push(this);
            ++_throttleCount;
            this.startLoader(param1.apiURL,_loc2_,_loc6_);
         }
      }
      
      private function onTimeout(param1:*) : void
      {
         this.close();
         Logger.logError("Command timed out.");
         dispatchEvent(new APIEvent(APIEvent.COMMAND_COMPLETE,null,APIEvent.ERROR_TIMED_OUT));
      }
      
      private function onError(param1:String) : void
      {
         Logger.logError("Error when sending command:",param1);
         dispatchEvent(new APIEvent(APIEvent.COMMAND_COMPLETE,null,APIEvent.ERROR_UNKNOWN));
         this.close();
      }
      
      private function onComplete(param1:String) : void
      {
         var response:Object = null;
         var data:String = param1;
         try
         {
            if(!data || data == "")
            {
               throw new Error();
            }
            Logger.logInternal("Received packet:",data);
            response = com.newgrounds.encoders.json.JSON.decode(data);
            if(!response)
            {
               throw new Error();
            }
            dispatchEvent(new APIEvent(APIEvent.COMMAND_COMPLETE,response,response && response.success ? APIEvent.ERROR_NONE : APIEvent.ERROR_COMMAND_FAILED));
         }
         catch(e:Error)
         {
            Logger.logError("Invalid response returned from server: " + data);
            dispatchEvent(new APIEvent(APIEvent.COMMAND_COMPLETE,null,APIEvent.ERROR_BAD_RESPONSE));
         }
         this.close();
      }
      
      private function startLoader(param1:String, param2:Object, param3:String) : void
      {
         var _loc4_:URLRequest;
         (_loc4_ = new URLRequest(param1)).data = param2;
         _loc4_.method = URLRequestMethod.POST;
         _loc4_.contentType = param3;
         this._loader = new URLLoader();
         this._loader.addEventListener(Event.COMPLETE,this.as3CompleteHandler);
         this._loader.addEventListener(Event.OPEN,this.as3UpdateHandler);
         this._loader.addEventListener(ProgressEvent.PROGRESS,this.as3UpdateHandler);
         this._loader.addEventListener(IOErrorEvent.IO_ERROR,this.as3ErrorHandler);
         this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.as3ErrorHandler);
         this._loader.load(_loc4_);
         if(this._hasTimeout)
         {
            this._timeoutTimer.start();
         }
      }
      
      private function as3CompleteHandler(param1:Event) : void
      {
         this.onComplete(this._loader.data);
      }
      
      private function as3UpdateHandler(param1:Event) : void
      {
         if(this._timeoutTimer.running)
         {
            this._timeoutTimer.reset();
            this._timeoutTimer.start();
         }
      }
      
      private function as3ErrorHandler(param1:Event) : void
      {
         this.onError(param1.toString());
      }
      
      private function buildMultipartData(param1:String, param2:Object, param3:Object) : ByteArray
      {
         var _loc5_:* = null;
         var _loc6_:Object = null;
         var _loc4_:ByteArray;
         (_loc4_ = new ByteArray()).endian = Endian.BIG_ENDIAN;
         param1 = "--" + param1;
         for(_loc5_ in param2)
         {
            _loc4_.writeUTFBytes(param1 + CRLF);
            _loc4_.writeUTFBytes("Content-Disposition: form-data; name=\"" + _loc5_ + "\"" + CRLF);
            _loc4_.writeUTFBytes(CRLF);
            _loc4_.writeUTFBytes(param2[_loc5_].toString() + CRLF);
         }
         if(this._files)
         {
            for each(_loc6_ in param3)
            {
               _loc4_.writeUTFBytes(param1 + CRLF);
               _loc4_.writeUTFBytes("Content-Disposition: form-data; name=\"Filename\"" + CRLF);
               _loc4_.writeUTFBytes(CRLF);
               _loc4_.writeUTFBytes(_loc6_.filename + CRLF);
               _loc4_.writeUTFBytes(param1 + CRLF);
               _loc4_.writeUTFBytes("Content-Disposition: form-data; name=\"" + _loc6_.dataField + "\"; filename=\"" + _loc6_.filename + "\"" + CRLF);
               _loc4_.writeUTFBytes("Content-Type: " + _loc6_.contentType + CRLF);
               _loc4_.writeUTFBytes(CRLF);
               _loc4_.writeBytes(_loc6_.data);
               _loc4_.writeUTFBytes(CRLF);
            }
            _loc4_.writeUTFBytes(param1 + CRLF);
            _loc4_.writeUTFBytes("Content-Disposition: form-data; name=\"Upload\"" + CRLF);
            _loc4_.writeUTFBytes(CRLF);
            _loc4_.writeUTFBytes("Submit Query" + CRLF);
         }
         _loc4_.writeUTFBytes(param1 + "--");
         _loc4_.position = 0;
         return _loc4_;
      }
   }
}
