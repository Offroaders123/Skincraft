package com.newgrounds
{
   import com.newgrounds.crypto.RC4;
   import com.newgrounds.encoders.json.JSON;
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.net.SharedObject;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class API
   {
      
      public static const RELEASE_MODE:String = "releaseMode";
      
      public static const DEBUG_MODE_LOGGED_IN:String = "debugModeLoggedIn";
      
      public static const DEBUG_MODE_LOGGED_OUT:String = "debugModeLoggedOut";
      
      public static const DEBUG_MODE_NEW_VERSION:String = "debugModeNewVersion";
      
      public static const DEBUG_MODE_HOST_BLOCKED:String = "debugModeHostBlocked";
      
      private static var _dispatcher:APIEventDispatcher = new APIEventDispatcher();
      
      private static var _movieName:String;
      
      private static var _movieVersion:String;
      
      private static var _root:DisplayObject;
      
      private static var _connection:APIConnection = new APIConnection();
      
      private static var _debugMode:String = DEBUG_MODE_LOGGED_IN;
      
      public static var redirectOnHostBlocked:Boolean = true;
      
      private static var _medals:Object = new Object();
      
      private static var _medalsArray:Array = [];
      
      private static var _scoreBoards:Object = new Object();
      
      private static var _scoreBoardsArray:Array = [];
      
      private static var _saveGroups:Object = new Object();
      
      private static var _saveGroupsArray:Array = [];
      
      private static var _imageFilePath:String;
      
      private static var _saveFilePath:String;
      
      private static var _sharedObjects:Object = new Object();
      
      public static const VERSION:String = "3.0 beta 2.1 AS3";
       
      
      public function API()
      {
         super();
      }
      
      public static function get connected() : Boolean
      {
         return _connection.connected;
      }
      
      public static function get isNetworkHost() : Boolean
      {
         return _connection.isNetworkHost;
      }
      
      public static function get apiId() : String
      {
         _connection.assertInitialized();
         return _connection.apiId;
      }
      
      public static function get debugMode() : String
      {
         return _debugMode;
      }
      
      public static function set debugMode(param1:String) : void
      {
         _debugMode = param1;
      }
      
      public static function get publisherId() : uint
      {
         _connection.assertInitialized();
         return _connection.publisherId;
      }
      
      public static function get sessionId() : String
      {
         _connection.assertInitialized();
         return _connection.sessionId;
      }
      
      public static function get hostDomain() : String
      {
         _connection.assertInitialized();
         return _connection.hostDomain;
      }
      
      public static function get hostURL() : String
      {
         _connection.assertInitialized();
         return _connection.hostURL;
      }
      
      public static function get isNewgrounds() : Boolean
      {
         return _connection.publisherId == 1;
      }
      
      public static function get hasUserSession() : Boolean
      {
         _connection.assertInitialized();
         return _connection.hasUserSession;
      }
      
      public static function get username() : String
      {
         _connection.assertInitialized();
         return _connection.username;
      }
      
      public static function get userId() : uint
      {
         _connection.assertInitialized();
         return _connection.userId;
      }
      
      private static function assertConnected(param1:String = null) : Boolean
      {
         if(_connection.assertConnected())
         {
            return true;
         }
         if(param1)
         {
            dispatchEvent(param1,null,APIEvent.ERROR_NOT_CONNECTED);
         }
         return false;
      }
      
      public static function get medals() : Array
      {
         return _medalsArray;
      }
      
      public static function get scoreBoards() : Array
      {
         return _scoreBoardsArray;
      }
      
      public static function get saveGroups() : Array
      {
         return _saveGroupsArray;
      }
      
      public static function get officialURL() : String
      {
         if(_connection && _connection.apiId)
         {
            return _connection.apiURL + "?tracker_id=" + _connection.apiId + "&command_id=loadOfficalVersion&seed=" + Math.random();
         }
         return "http://www.newgrounds.com";
      }
      
      public static function connect(param1:DisplayObject, param2:String, param3:String = null, param4:String = "") : void
      {
         if(_connection.initialized)
         {
            Logger.logError("Connection already in progress. Please call API.disconnect() before attempting another connection.");
            dispatchEvent(APIEvent.API_CONNECTED,false,APIEvent.ERROR_NOT_CONNECTED);
            return;
         }
         if(!param2 || param2 == "")
         {
            Logger.logError("No apiId given. Please use the API ID from your API settings page.");
            dispatchEvent(APIEvent.API_CONNECTED,false,APIEvent.ERROR_INVALID_ARGUMENT);
            return;
         }
         Logger.logMessage("====== Newgrounds API v" + VERSION + " ======");
         APIEventDispatcher.globalDispatcher = _dispatcher;
         _root = param1;
         _movieVersion = param4;
         _connection.apiId = param2;
         if(param2.indexOf(":") != -1)
         {
            _connection.trackerId = uint(param2.substring(0,param2.indexOf(":")));
         }
         _connection.encryptionKey = param3;
         _connection.initialized = true;
         if(!_root.loaderInfo)
         {
            Logger.logWarning("The root DisplayObject is currently not on the stage. Connection will be completed once it is added to stage.");
         }
         _root.addEventListener(Event.ENTER_FRAME,checkRootLoaderInfo);
         checkRootLoaderInfo(null);
      }
      
      private static function doConnect(param1:Object) : void
      {
         if(isNetworkHost && _debugMode != RELEASE_MODE)
         {
            Logger.logMessage("Live file detected, turning off debug mode.");
            _debugMode = RELEASE_MODE;
         }
         _connection.connectionState = APIConnection.CONNECTING;
         if(_debugMode == RELEASE_MODE)
         {
            if(param1)
            {
               if(param1.NewgroundsAPI_UserName)
               {
                  _connection.username = param1.NewgroundsAPI_UserName;
               }
               if(param1.NewgroundsAPI_UserID)
               {
                  _connection.userId = param1.NewgroundsAPI_UserID;
               }
               if(param1.NewgroundsAPI_PublisherID)
               {
                  _connection.publisherId = param1.NewgroundsAPI_PublisherID;
               }
               if(param1.NewgroundsAPI_UserpageFormat)
               {
                  _connection.userpageFormat = param1.NewgroundsAPI_UserpageFormat;
               }
               if(param1.NewgroundsAPI_SessionID)
               {
                  _connection.sessionId = param1.NewgroundsAPI_SessionID;
               }
            }
         }
         else
         {
            _connection.debug = true;
            if(_debugMode == DEBUG_MODE_LOGGED_IN || _debugMode == DEBUG_MODE_LOGGED_OUT)
            {
               _connection.publisherId = 1;
            }
            if(_debugMode == DEBUG_MODE_LOGGED_IN)
            {
               _connection.sessionId = "D3bu64p1U53R";
               _connection.userId = 10;
               _connection.username = "API-Debugger";
            }
         }
         _connection.sendSimpleCommand("connectMovie",onConnect,{
            "host":_connection.hostDomain,
            "movie_version":_movieVersion
         });
      }
      
      private static function onConnect(param1:APIEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(!param1.success)
         {
            Logger.logError("Unable to connect to the API.");
            _connection.reset();
            dispatchEvent(APIEvent.API_CONNECTED,param1.data,param1.error);
            return;
         }
         if(!_loc2_.ad_url)
         {
            if(_loc2_.ad_status !== -1)
            {
               if(_loc2_.ad_status === 0)
               {
               }
            }
         }
         if(_debugMode == DEBUG_MODE_HOST_BLOCKED || _loc2_.deny_host)
         {
            Logger.logMessage(_connection.hostDomain + " does not have permission to host this movie!","Update your API configuration to allow this host.");
            dispatchEvent(APIEvent.API_CONNECTED,{"officialURL":unescape(_loc2_.movie_url)},APIEvent.ERROR_HOST_BLOCKED);
            if(redirectOnHostBlocked)
            {
               loadOfficialVersion();
            }
            _connection.reset();
            return;
         }
         _movieName = !!_loc2_.movieName ? _loc2_.movieName : "";
         Logger.logMessage("Connecting to the Newgrounds API Gateway...","----- " + _loc2_.movie_name + " -----");
         if(_debugMode == DEBUG_MODE_NEW_VERSION || _loc2_.movie_version)
         {
            Logger.logMessage("A new version of this movie is available.","Current version:\t" + _movieVersion,"Newest version:\t" + _loc2_.movie_version,"Newest URL:\t" + officialURL);
         }
         if(_loc2_.request_portal_url)
         {
            _connection.sendSimpleCommand("setPortalID",null,{"portal_url":_connection.hostURL});
         }
         _connection.sendSimpleCommand("preloadSettings",onMetadataLoaded,{
            "publisher_id":_connection.publisherId,
            "user_id":_connection.userId
         });
      }
      
      private static function onMetadataLoaded(param1:APIEvent) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc10_:Medal = null;
         var _loc11_:Object = null;
         var _loc12_:ScoreBoard = null;
         var _loc13_:Object = null;
         var _loc14_:Array = null;
         var _loc15_:Array = null;
         var _loc16_:SaveGroup = null;
         var _loc17_:Object = null;
         var _loc18_:Object = null;
         var _loc2_:Object = param1.data;
         if(!param1.success)
         {
            Logger.logWarning("Unable to load movie metadata.");
            disconnect();
            dispatchEvent(APIEvent.API_CONNECTED,null,param1.error);
            return;
         }
         var _loc5_:uint = 0;
         if(_loc2_.medals)
         {
            _loc5_ = _loc2_.medals.length;
            if(hasUserSession)
            {
               _loc6_ = loadLocal("medals_unlocked_" + username);
            }
            else
            {
               _loc6_ = loadLocal("medals_unlocked");
            }
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc8_ = (_loc7_ = _loc2_.medals[_loc3_]).medal_unlocked;
               _loc9_ = _loc6_ && _loc6_[_loc7_.medal_id];
               (_loc10_ = new Medal(_connection,_loc7_.medal_id,_loc7_.medal_name,!!hasUserSession ? Boolean(_loc8_) : Boolean(_loc9_),_loc7_.medal_value,_loc7_.medal_difficulty,_loc7_.medal_icon)).addEventListener(APIEvent.MEDAL_UNLOCKED,onMedalUnlocked,false,0,true);
               _loc10_.addEventListener(APIEvent.MEDAL_UNLOCK_CONFIRMED,onMedalUnlockConfirmed,false,0,true);
               _medals[_loc10_.name] = _loc10_;
               _medalsArray.push(_loc10_);
               Logger.logMessage(_loc10_);
               if(hasUserSession && _loc9_ && !_loc8_)
               {
                  Logger.logMessage("Server missed the \"" + _loc10_.name + "\" unlock. Resending...");
                  _loc10_.unlock();
               }
               _loc3_++;
            }
         }
         Logger.logMessage(_loc5_ + " medal" + (_loc5_ != 1 ? "s" : "") + " initialized.");
         _loc5_ = 0;
         if(_loc2_.score_boards)
         {
            _loc5_ = _loc2_.score_boards.length;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc11_ = _loc2_.score_boards[_loc3_];
               _loc12_ = new ScoreBoard(_connection,_loc11_.name,_loc11_.id);
               _scoreBoards[_loc12_.name] = _loc12_;
               _scoreBoardsArray.push(_loc12_);
               Logger.logMessage(_loc12_);
               _loc3_++;
            }
         }
         Logger.logMessage(_loc5_ + " scoreboard" + (_loc5_ != 1 ? "s" : "") + " initialized.");
         _loc5_ = 0;
         if(_loc2_.save_groups)
         {
            _loc5_ = _loc2_.save_groups.length;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc13_ = _loc2_.save_groups[_loc3_];
               _loc14_ = [];
               if(_loc13_.keys)
               {
                  _loc4_ = 0;
                  while(_loc4_ < _loc13_.keys.length)
                  {
                     _loc17_ = _loc13_.keys[_loc4_];
                     _loc14_.push(new SaveKey(_loc17_.name,_loc17_.id,_loc17_.type));
                     _loc4_++;
                  }
               }
               _loc15_ = [];
               if(_loc13_.ratings)
               {
                  _loc3_ = 0;
                  while(_loc3_ < _loc13_.ratings.length)
                  {
                     _loc18_ = _loc13_.ratings[_loc3_];
                     _loc15_.push(new SaveRating(_loc18_.name,_loc18_.id,_loc18_.float,_loc18_.min,_loc18_.max));
                     _loc3_++;
                  }
               }
               _loc16_ = new SaveGroup(_connection,_loc13_.group_name,_loc13_.group_id,_loc13_.group_type,_loc14_,_loc15_);
               _saveGroups[_loc16_.name] = _loc16_;
               _saveGroupsArray.push(_loc16_);
               Logger.logMessage(_loc16_);
               _loc3_++;
            }
         }
         Logger.logMessage(_loc5_ + " save group" + (_loc5_ != 1 ? "s" : "") + " initialized.");
         if(_loc2_.save_file_path)
         {
            _saveFilePath = _loc2_.save_file_path + "/";
            SaveFile._saveFilePath = _saveFilePath;
            Logger.logInternal("Save file path: " + _saveFilePath);
         }
         if(_loc2_.image_file_path)
         {
            _imageFilePath = _loc2_.image_file_path + "/";
            SaveFile._imageFilePath = _imageFilePath;
            Logger.logInternal("Image file path: " + _imageFilePath);
         }
         Logger.logMessage("Connection complete!");
         _connection.connectionState = APIConnection.CONNECTED;
         dispatchEvent(APIEvent.API_CONNECTED,{"movieName":_movieName});
      }
      
      public static function disconnect() : void
      {
         var _loc1_:Medal = null;
         if(!_connection.connected)
         {
            Logger.logWarning("The Newgrounds API is already disconnected.");
            return;
         }
         _connection.reset();
         for each(_loc1_ in _medals)
         {
            _loc1_.removeEventListener(APIEvent.MEDAL_UNLOCKED,onMedalUnlocked);
            _loc1_.removeEventListener(APIEvent.MEDAL_UNLOCK_CONFIRMED,onMedalUnlockConfirmed);
         }
         _medals = new Object();
         _medalsArray = [];
         _scoreBoards = new Object();
         _scoreBoardsArray = [];
         _saveGroups = new Object();
         _saveGroupsArray = [];
         _sharedObjects = new Object();
         _imageFilePath = null;
         _saveFilePath = null;
         Logger.logMessage("Disconnected from the Newgrounds API.");
      }
      
      public static function loadNewgrounds() : void
      {
         var _loc1_:APICommand = null;
         if(connected)
         {
            _loc1_ = new APICommand("loadNewgrounds");
            _loc1_.openBrowser = true;
            _loc1_.parameters.host = _connection.hostDomain;
            _loc1_.send(_connection);
         }
         else
         {
            navigateToURL(new URLRequest("http://www.newgrounds.com"));
         }
      }
      
      public static function loadOfficialVersion() : void
      {
         navigateToURL(new URLRequest(officialURL));
      }
      
      public static function loadMySite() : void
      {
         if(!assertConnected())
         {
            return;
         }
         var _loc1_:APICommand = new APICommand("loadMySite");
         _loc1_.openBrowser = true;
         _loc1_.parameters.host = _connection.hostDomain;
         _loc1_.send(_connection);
      }
      
      public static function loadCustomLink(param1:String) : void
      {
         if(!assertConnected())
         {
            return;
         }
         var _loc2_:APICommand = new APICommand("loadCustomLink");
         _loc2_.openBrowser = true;
         _loc2_.parameters.link = param1;
         _loc2_.parameters.host = _connection.hostDomain;
         _loc2_.send(_connection);
      }
      
      public static function getMedal(param1:String) : Medal
      {
         return _medals[param1];
      }
      
      public static function unlockMedal(param1:String) : void
      {
         if(!assertConnected())
         {
            return;
         }
         var _loc2_:Medal = _medals[param1];
         if(!_loc2_)
         {
            Logger.logError("No medal named \"" + param1 + "\" was found.");
            return;
         }
         _loc2_.unlock();
      }
      
      private static function onMedalUnlocked(param1:APIEvent) : void
      {
         var _loc2_:Medal = null;
         var _loc3_:Object = null;
         if(param1.success)
         {
            _loc2_ = Medal(param1.data);
            if(hasUserSession)
            {
               _loc3_ = loadLocal("medals_unlocked_" + username);
               if(!_loc3_)
               {
                  _loc3_ = new Object();
               }
               _loc3_[_loc2_.id] = true;
               saveLocal("medals_unlocked_" + username,_loc3_);
            }
            else
            {
               _loc3_ = loadLocal("medals_unlocked");
               if(!_loc3_)
               {
                  _loc3_ = new Object();
               }
               _loc3_[Medal(param1.data).id] = true;
               saveLocal("medals_unlocked",_loc3_);
               Logger.logMessage("User is not logged in. Medal \"" + _loc2_.name + "\" unlocked locally.");
            }
         }
      }
      
      private static function onMedalUnlockConfirmed(param1:APIEvent) : void
      {
         var _loc2_:Object = null;
         if(hasUserSession)
         {
            _loc2_ = loadLocal("medals_unlocked_" + username);
            if(!_loc2_)
            {
               _loc2_ = new Object();
            }
            else
            {
               delete _loc2_[Medal(param1.data).id];
            }
            saveLocal("medals_unlocked_" + username,_loc2_);
         }
      }
      
      public static function getScoreBoard(param1:String) : ScoreBoard
      {
         if(!assertConnected())
         {
            return null;
         }
         return _scoreBoards[param1];
      }
      
      public static function loadScores(param1:String, param2:String = "All-Time", param3:uint = 1, param4:uint = 10, param5:String = null) : ScoreBoard
      {
         if(!assertConnected())
         {
            return null;
         }
         var _loc6_:ScoreBoard;
         if(!(_loc6_ = _scoreBoards[param1]))
         {
            Logger.logError("No scoreboard named \"" + param1 + "\" was found.");
            dispatchEvent(APIEvent.SCORES_LOADED,null,APIEvent.ERROR_INVALID_ARGUMENT);
            return null;
         }
         _loc6_.period = param2;
         _loc6_.firstResult = param3;
         _loc6_.numResults = param4;
         _loc6_.tag = param5;
         _loc6_.loadScores();
         return _loc6_;
      }
      
      public static function postScore(param1:String, param2:Number, param3:String = null) : void
      {
         if(!assertConnected())
         {
            return;
         }
         var _loc4_:ScoreBoard;
         if(!(_loc4_ = _scoreBoards[param1]))
         {
            Logger.logError("No scoreboard named \"" + param1 + "\" was found.");
            dispatchEvent(APIEvent.SCORES_LOADED,null,APIEvent.ERROR_INVALID_ARGUMENT);
            return;
         }
         _loc4_.postScore(param2,param3);
      }
      
      public static function getSaveGroup(param1:String) : SaveGroup
      {
         if(!assertConnected())
         {
            return null;
         }
         return _saveGroups[param1];
      }
      
      private static function getSaveGroupById(param1:uint) : SaveGroup
      {
         var _loc2_:SaveGroup = null;
         for each(_loc2_ in _saveGroups)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function createSaveFile(param1:String) : SaveFile
      {
         if(!assertConnected())
         {
            return null;
         }
         var _loc2_:SaveGroup = getSaveGroup(param1);
         if(!_loc2_)
         {
            Logger.logError("The save group \"" + param1 + "\" was not found.");
            return null;
         }
         return new SaveFile(_loc2_);
      }
      
      public static function loadSaveFile(param1:uint, param2:Boolean = true) : void
      {
         _connection.sendSimpleCommand("loadSaveFile",onFileLoaded,{
            "save_id":param1,
            "get_contents":param2
         });
      }
      
      private static function onFileLoaded(param1:APIEvent) : void
      {
         var _loc2_:SaveFile = null;
         if(param1.success)
         {
            _loc2_ = SaveFile.fromObject(getSaveGroupById(param1.data.group_id),param1.data.file);
            if(param1.data.get_contents)
            {
               _loc2_.load();
            }
            else
            {
               dispatchEvent(APIEvent.FILE_LOADED,_loc2_);
            }
         }
         else
         {
            Logger.logError("Unable to load file:",param1.error);
         }
      }
      
      public static function createSaveQuery(param1:String) : SaveQuery
      {
         if(!assertConnected())
         {
            return null;
         }
         var _loc2_:SaveGroup = getSaveGroup(param1);
         if(!_loc2_)
         {
            Logger.logError("The save group \"" + param1 + "\" was not found.");
            return null;
         }
         return new SaveQuery(_loc2_);
      }
      
      public static function createSaveQueryByDate(param1:String, param2:Boolean = true) : SaveQuery
      {
         var _loc3_:SaveQuery = createSaveQuery(param1);
         if(!_loc3_)
         {
            return null;
         }
         _loc3_.sortOn(SaveQuery.CREATED_ON,param2);
         return _loc3_;
      }
      
      public static function createSaveQueryByName(param1:String, param2:String, param3:Boolean = false, param4:Boolean = true) : SaveQuery
      {
         var _loc5_:SaveQuery;
         (_loc5_ = createSaveQuery(param1)).addCondition(SaveQuery.FILE_NAME,!!param3 ? SaveQuery.OPERATOR_EQUAL : SaveQuery.OPERATOR_CONTAINS,param2);
         return _loc5_;
      }
      
      public static function createSaveQueryByRating(param1:String, param2:String, param3:Boolean = true) : SaveQuery
      {
         var _loc4_:SaveQuery;
         (_loc4_ = createSaveQuery(param1)).sortOn(param2,param3);
         return _loc4_;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = true) : void
      {
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         _dispatcher.removeEventListener(param1,param2);
      }
      
      private static function dispatchEvent(param1:String, param2:* = null, param3:String = null) : void
      {
         _dispatcher.dispatchEvent(new APIEvent(param1,param2,param3));
      }
      
      public static function saveLocal(param1:String, param2:Object) : Boolean
      {
         var sharedObject:SharedObject = null;
         var sharedObjectName:String = null;
         var saveId:String = param1;
         var saveData:Object = param2;
         try
         {
            sharedObjectName = "ng_ap_secure_" + _connection.trackerId + "_" + RC4.encrypt(saveId,_connection.encryptionKey);
            if(!_sharedObjects[saveId])
            {
               _sharedObjects[saveId] = SharedObject.getLocal(sharedObjectName);
            }
            sharedObject = _sharedObjects[saveId];
            sharedObject.data.data = encodeData(saveData);
         }
         catch(error:Error)
         {
            Logger.logError("Unable to save local data.",error);
            return false;
         }
         return true;
      }
      
      public static function loadLocal(param1:String) : Object
      {
         var sharedObject:SharedObject = null;
         var sharedObjectName:String = null;
         var saveId:String = param1;
         try
         {
            sharedObjectName = "ng_ap_secure_" + _connection.trackerId + "_" + RC4.encrypt(saveId,_connection.encryptionKey);
            if(!_sharedObjects[saveId])
            {
               _sharedObjects[saveId] = SharedObject.getLocal(sharedObjectName);
            }
            sharedObject = _sharedObjects[saveId];
            if(sharedObject && sharedObject.data && sharedObject.data.data)
            {
               return decodeData(sharedObject.data.data);
            }
            return null;
         }
         catch(error:Error)
         {
            Logger.logError("Unable to load local data.",error);
            return null;
         }
      }
      
      public static function encodeData(param1:Object) : String
      {
         if(!_connection.assertInitialized())
         {
            return null;
         }
         return RC4.encrypt(com.newgrounds.encoders.json.JSON.encode(param1),_connection.encryptionKey);
      }
      
      public static function decodeData(param1:String) : Object
      {
         if(!_connection.assertInitialized())
         {
            return null;
         }
         try
         {
            return com.newgrounds.encoders.json.JSON.decode(RC4.decrypt(param1,_connection.encryptionKey)) as Object;
         }
         catch(error:Error)
         {
            return null;
         }
      }
      
      public static function stopPendingCommands() : void
      {
         APICommand.stopPendingCommands();
         Logger.logMessage("Pending commands stopped.");
      }
      
      public static function setFont(param1:TextField, param2:String) : void
      {
         var _loc3_:TextFormat = null;
         var _loc4_:Boolean = false;
         var _loc5_:TextFormat = null;
         if(param1 && param2)
         {
            _loc3_ = param1.getTextFormat();
            _loc4_ = param1.embedFonts;
            _loc5_ = new TextFormat(param2);
            param1.defaultTextFormat = _loc5_;
            param1.setTextFormat(_loc5_);
            if(param1.textWidth == 0)
            {
               param1.embedFonts = _loc4_;
               param1.setTextFormat(_loc3_);
               param1.defaultTextFormat = _loc3_;
            }
            else
            {
               param1.antiAliasType = "advanced";
               param1.sharpness = 100;
            }
         }
      }
      
      private static function checkRootLoaderInfo(param1:Event) : void
      {
         var event:Event = param1;
         var loaderInfo:LoaderInfo = _root.loaderInfo;
         if(loaderInfo)
         {
            try
            {
               while(loaderInfo.loader)
               {
                  loaderInfo = loaderInfo.loader.loaderInfo;
               }
            }
            catch(error:Error)
            {
               return;
            }
            _root.removeEventListener(Event.ENTER_FRAME,checkRootLoaderInfo);
            _connection.hostURL = loaderInfo.url;
            doConnect(loaderInfo.parameters);
         }
      }
   }
}
