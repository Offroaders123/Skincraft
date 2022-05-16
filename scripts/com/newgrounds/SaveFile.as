package com.newgrounds
{
   import com.newgrounds.assets.DefaultSaveIcon;
   import com.newgrounds.encoders.PNGEncoder;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   public class SaveFile extends APIEventDispatcher
   {
      
      public static const ICON_WIDTH:uint = 90;
      
      public static const ICON_HEIGHT:uint = 90;
      
      private static var _currentFile:SaveFile;
      
      private static const STATUS_PRIVATE:uint = 0;
      
      private static const STATUS_SHARED:uint = 1;
      
      private static const STATUS_UNAPPROVED:uint = 2;
      
      private static const STATUS_APPROVED:uint = 3;
      
      static var _imageFilePath:String = "";
      
      static var _saveFilePath:String = "";
      
      public static const DEFAULT_ICON:BitmapData = new DefaultSaveIcon(ICON_WIDTH,ICON_HEIGHT);
       
      
      private var _group:SaveGroup;
      
      private var _name:String;
      
      private var _id:uint;
      
      private var _description:String;
      
      private var _authorId:uint;
      
      private var _authorName:String;
      
      private var _createdOn:String;
      
      private var _modifiedOn:String;
      
      private var _views:uint;
      
      private var _readOnly:Boolean;
      
      private var _public:Boolean;
      
      private var _approved:Boolean;
      
      private var _draft:Boolean;
      
      private var _iconLoader:BitmapLoader;
      
      private var _keys:Object;
      
      private var _ratings:Object;
      
      private var _dataURL:String;
      
      private var _data;
      
      private var _encodedData;
      
      private var _encoderQueue:Array;
      
      private var _encoding:Boolean;
      
      private var _encodingParent:Object;
      
      private var _encodingProperty:String;
      
      private var _fileSize:uint;
      
      private var _dataLoader:URLLoader;
      
      public function SaveFile(param1:SaveGroup)
      {
         this._keys = new Object();
         this._ratings = new Object();
         super();
         this._iconLoader = new BitmapLoader(DEFAULT_ICON,null);
         this._group = param1;
      }
      
      public static function get currentFile() : SaveFile
      {
         return _currentFile;
      }
      
      static function fromObject(param1:SaveGroup, param2:Object) : SaveFile
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:SaveKey = null;
         var _loc7_:SaveRating = null;
         var _loc3_:SaveFile = new SaveFile(param1);
         _loc3_._name = param2.filename;
         _loc3_._description = param2.description;
         _loc3_._id = param2.save_id;
         _loc3_._authorId = param2.user_id;
         _loc3_._authorName = param2.user_name;
         _loc3_._createdOn = param2.created;
         _loc3_._modifiedOn = param2.last_update;
         _loc3_._views = param2.views;
         if(param2.thumb && param2.thumb != "")
         {
            _loc3_._iconLoader.url = _imageFilePath + param2.thumb;
         }
         _loc3_._dataURL = _saveFilePath + param2.file;
         _loc3_._fileSize = param2.file_size;
         _loc3_._approved = param2.status != STATUS_UNAPPROVED;
         _loc3_._readOnly = !param2.readOnly;
         _loc3_._public = param2.status != STATUS_PRIVATE && param2.status != STATUS_UNAPPROVED;
         for each(_loc4_ in param2.keys)
         {
            if(_loc6_ = param1.getKeyById(_loc4_.id))
            {
               _loc3_._keys[_loc6_.name] = _loc6_.validateValue(_loc4_.value);
            }
         }
         for each(_loc5_ in param2.ratings)
         {
            if(_loc7_ = param1.getRatingById(_loc5_.id))
            {
               _loc3_._ratings[_loc7_.name] = _loc7_.validateValue(_loc5_.score);
            }
         }
         return _loc3_;
      }
      
      public function get group() : SaveGroup
      {
         return this._group;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         this._name = param1;
      }
      
      public function get description() : String
      {
         return this._description;
      }
      
      public function set description(param1:String) : void
      {
         this._description = param1;
      }
      
      public function get id() : uint
      {
         return this._id;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set data(param1:Object) : void
      {
         this._data = param1;
      }
      
      public function get bytesLoaded() : uint
      {
         return 0;
      }
      
      public function get bytesTotal() : uint
      {
         return 0;
      }
      
      public function get readOnly() : Boolean
      {
         return this._readOnly;
      }
      
      public function get draft() : Boolean
      {
         return this._draft;
      }
      
      public function set draft(param1:Boolean) : void
      {
         this._draft = param1;
      }
      
      public function get authorId() : uint
      {
         return this._authorId;
      }
      
      public function get authorName() : String
      {
         return this._authorName;
      }
      
      public function get keys() : Object
      {
         return this._keys;
      }
      
      public function get ratings() : Object
      {
         return this._ratings;
      }
      
      override public function toString() : String
      {
         return "Save File: " + this._name;
      }
      
      public function get icon() : BitmapData
      {
         return this._iconLoader.bitmapData;
      }
      
      public function set icon(param1:BitmapData) : void
      {
         this.createIcon(param1);
      }
      
      public function createIcon(param1:IBitmapDrawable) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Rectangle = null;
         var _loc2_:BitmapData = new BitmapData(ICON_WIDTH,ICON_HEIGHT,false,0);
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         _loc3_ = Object(param1).width;
         _loc4_ = Object(param1).height;
         if(param1 is DisplayObject)
         {
            _loc5_ = (_loc9_ = DisplayObject(param1).getBounds(null)).left;
            _loc6_ = _loc9_.top;
         }
         var _loc7_:Matrix = new Matrix();
         _loc8_ = Math.min(ICON_WIDTH / _loc3_,ICON_HEIGHT / _loc4_);
         _loc7_.translate(-_loc5_,-_loc6_);
         _loc7_.scale(_loc8_,_loc8_);
         _loc7_.translate((ICON_WIDTH - _loc3_ * _loc8_) / 2,(ICON_HEIGHT - _loc4_ * _loc8_) / 2);
         _loc2_.draw(param1,_loc7_);
         this._iconLoader.bitmapData = _loc2_;
      }
      
      public function attachIcon(param1:DisplayObjectContainer) : Sprite
      {
         if(this._iconLoader)
         {
            return this._iconLoader.attachBitmap(param1);
         }
         Logger.logError("No icon available for this sumbission.");
         return null;
      }
      
      public function save() : void
      {
         _currentFile = this;
         this.encodeData(true);
      }
      
      private function doSave() : void
      {
         var _loc3_:* = null;
         var _loc4_:Array = null;
         var _loc5_:* = null;
         var _loc6_:SaveKey = null;
         var _loc7_:SaveRating = null;
         var _loc8_:ByteArray = null;
         var _loc1_:APICommand = new APICommand("saveFile");
         _loc1_.secureParameters.group = this._group.id;
         _loc1_.secureParameters.user_name = this._group.connection.username;
         _loc1_.secureParameters.filename = this._name;
         _loc1_.secureParameters.description = this._description;
         if(this._draft)
         {
            _loc1_.secureParameters.draft = true;
         }
         if(this._id && !this._readOnly)
         {
            _loc1_.secureParameters.overwrite = 1;
            _loc1_.secureParameters.save_id = this._id;
         }
         var _loc2_:Array = [];
         for(_loc3_ in this._keys)
         {
            if(_loc6_ = this._group.getKey(_loc3_))
            {
               _loc2_.push({
                  "id":_loc6_.id,
                  "value":_loc6_.validateValue(this._keys[_loc3_])
               });
            }
            else
            {
               Logger.logError("No key named \"" + _loc3_ + "\" in save group \"" + this._group.name + "\".");
            }
         }
         _loc1_.secureParameters.keys = _loc2_;
         _loc4_ = [];
         for(_loc5_ in this._ratings)
         {
            if(_loc7_ = this._group.getRating(_loc5_))
            {
               _loc4_.push({
                  "id":_loc7_.id,
                  "value":_loc7_.validateValue(this._ratings[_loc5_])
               });
            }
            else
            {
               Logger.logError("No rating named \"" + _loc5_ + "\" in save group \"" + this._group.name + "\".");
            }
         }
         _loc1_.secureParameters.ratings = _loc4_;
         (_loc8_ = new ByteArray()).writeObject(this._encodedData);
         _loc8_.compress();
         _loc1_.addFile("file",_loc8_,"file");
         if(this.icon)
         {
            _loc1_.addFile("thumbnail",PNGEncoder.encode(this.icon),"thumbnail");
         }
         _loc1_.addEventListener(APIEvent.COMMAND_COMPLETE,this.onSaveComplete);
         this._group.connection.sendCommand(_loc1_);
      }
      
      private function encodeData(param1:Boolean) : void
      {
         this._encoderQueue = [];
         this._encoding = param1;
         if(param1)
         {
            this._encodedData = this._data;
            this.preEncodeObject(this,"_encodedData");
         }
         else
         {
            this.preEncodeObject(this,"_data");
         }
         this.encodeObject();
      }
      
      private function preEncodeObject(param1:Object, param2:String) : void
      {
         var _loc4_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = null;
         var _loc3_:Object = param1[param2];
         try
         {
            if(this._encoding)
            {
               _loc4_ = _loc3_ is BitmapData;
            }
            else
            {
               _loc4_ = _loc3_.type == "__bitmap";
            }
         }
         catch(error:*)
         {
         }
         var _loc5_:Object = _loc3_;
         _loc6_ = _loc3_ is ByteArray;
         if(_loc4_)
         {
            this._encoderQueue.push({
               "parent":param1,
               "property":param2
            });
         }
         else if(typeof _loc3_ == "object" && !_loc6_)
         {
            if(this._encoding)
            {
               if(_loc3_ is Array)
               {
                  _loc5_ = [];
               }
               else
               {
                  _loc5_ = {};
               }
               for(_loc7_ in _loc3_)
               {
                  _loc5_[_loc7_] = _loc3_[_loc7_];
               }
               param1[param2] = _loc5_;
            }
            for(_loc7_ in _loc5_)
            {
               this.preEncodeObject(_loc5_,_loc7_);
            }
         }
      }
      
      private function encodeObject() : void
      {
         var _loc5_:Object = null;
         if(!this._encoderQueue.length)
         {
            if(this._encoding)
            {
               this.doSave();
            }
            else
            {
               Logger.logMessage("Data loaded.");
               dispatchEvent(new APIEvent(APIEvent.FILE_LOADED,this));
            }
            return;
         }
         var _loc1_:Object = this._encoderQueue.pop();
         var _loc2_:Object = _loc1_.parent;
         var _loc3_:String = _loc1_.property;
         var _loc4_:Object = _loc2_[_loc3_];
         if(this._encoding)
         {
            _loc5_ = {
               "type":"__bitmap",
               "width":_loc4_.width,
               "height":_loc4_.height,
               "transparent":_loc4_.transparent
            };
            _loc2_[_loc3_] = _loc5_;
            _loc5_.data = new ByteArray();
            _loc5_.data.writeBytes(_loc4_.getPixels(_loc4_.rect));
            _loc5_.data.position = 0;
         }
         else
         {
            _loc5_ = new BitmapData(_loc4_.width,_loc4_.height,_loc4_.transparent);
            _loc5_.setPixels(_loc5_.rect,_loc4_.data);
            _loc2_[_loc3_] = _loc5_;
         }
         this.encodeObject();
      }
      
      private function onDataLoaded(param1:*) : void
      {
         var byteArray:ByteArray = null;
         var data:* = param1;
         try
         {
            if(data)
            {
               byteArray = data;
               byteArray.uncompress();
               this._data = byteArray.readObject();
               this.encodeData(false);
            }
         }
         catch(error:Error)
         {
            Logger.logError("Error while loading data:",error);
            dispatchEvent(new APIEvent(APIEvent.FILE_LOADED,this,APIEvent.ERROR_BAD_FILE));
         }
      }
      
      private function onDataError(param1:String) : void
      {
         Logger.logError("Unable to load data:",param1);
         dispatchEvent(new APIEvent(APIEvent.FILE_LOADED,this,APIEvent.ERROR_BAD_FILE));
      }
      
      private function onSaveComplete(param1:APIEvent) : void
      {
         if(param1.success)
         {
            Logger.logMessage("File \"" + this._name + "\" saved!");
            if(param1.data)
            {
               this._id = param1.data.save_id;
               this._dataURL = unescape(param1.data.file_url);
            }
            dispatchEvent(new APIEvent(APIEvent.FILE_SAVED,this));
         }
         else
         {
            Logger.logError("Error saving file \"" + this._name + "\":",param1.error);
            dispatchEvent(new APIEvent(APIEvent.FILE_SAVED,this,param1.error));
         }
      }
      
      public function sendVote(param1:String, param2:Number) : void
      {
         var _loc3_:SaveRating = this._group.getRating(param1);
         if(!_loc3_)
         {
            Logger.logError("No save rating named \"" + param1 + "\" exists for this save group.");
            dispatchEvent(new APIEvent(APIEvent.VOTE_COMPLETE,{},APIEvent.ERROR_INVALID_ARGUMENT));
            return;
         }
         param2 = _loc3_.validateValue(param2);
         if(isNaN(param2))
         {
            Logger.logError("Invalid vote (" + param2 + "). " + param1 + " allows a range of " + _loc3_.minimum + "-" + _loc3_.maximum + ".");
            dispatchEvent(new APIEvent(APIEvent.VOTE_COMPLETE,{},APIEvent.ERROR_INVALID_ARGUMENT));
            return;
         }
         Logger.logMessage("Voting " + param2 + " for " + param1 + " on " + this._name + "...");
         this._group.connection.sendSimpleCommand("rateSaveFile",this.onVoteComplete,null,{
            "group":this._group.id,
            "save_id":this._id,
            "rating_id":_loc3_.id,
            "vote":param2
         });
      }
      
      private function onVoteComplete(param1:APIEvent) : void
      {
         var _loc3_:SaveRating = null;
         var _loc2_:String = param1.error;
         if(param1.data.already_voted)
         {
            Logger.logError("Vote failed. You\'ve already voted on this rating today.");
            _loc2_ = APIEvent.ERROR_ALREADY_VOTED;
         }
         if(_loc2_ == APIEvent.ERROR_NONE)
         {
            _loc3_ = this._group.getRatingById(param1.data.rating_id);
            if(_loc3_)
            {
               this._ratings[_loc3_.name] = _loc3_.validateValue(param1.data.score);
            }
         }
         dispatchEvent(new APIEvent(APIEvent.VOTE_COMPLETE,this,_loc2_));
      }
      
      public function clone() : SaveFile
      {
         var _loc2_:* = null;
         var _loc1_:SaveFile = new SaveFile(this._group);
         _loc1_._data = this._data;
         _loc1_._description = this._description;
         _loc1_._draft = this._draft;
         _loc1_._fileSize = this._fileSize;
         _loc1_._iconLoader.bitmapData = this._iconLoader.bitmapData;
         for(_loc2_ in this._keys)
         {
            _loc1_._keys[_loc2_] = this._keys[_loc2_];
         }
         for(_loc2_ in this._ratings)
         {
            _loc1_._ratings[_loc2_] = this._ratings[_loc2_];
         }
         _loc1_._name = this._name;
         return _loc1_;
      }
      
      public function load() : void
      {
         _currentFile = this;
         this._iconLoader.load();
         this._dataLoader = new URLLoader();
         this._dataLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this._dataLoader.addEventListener(Event.COMPLETE,this.as3DataLoaded);
         this._dataLoader.addEventListener(IOErrorEvent.IO_ERROR,this.as3DataError);
         this._dataLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.as3DataError);
         this._dataLoader.load(new URLRequest(this._dataURL));
      }
      
      private function as3DataLoaded(param1:Event) : void
      {
         this.onDataLoaded(this._dataLoader.data);
      }
      
      private function as3DataError(param1:Event) : void
      {
         this.onDataError(param1.toString());
      }
      
      private function decodeObject(param1:Object) : Object
      {
         var _loc2_:BitmapData = null;
         var _loc3_:* = null;
         if(getQualifiedClassName(param1) == "Object")
         {
            if(param1.type == "__bitmap")
            {
               _loc2_ = new BitmapData(param1.width,param1.height,param1.transparent);
               _loc2_.setPixels(_loc2_.rect,param1.data);
               param1 = _loc2_;
            }
            else
            {
               for(_loc3_ in param1)
               {
                  param1[_loc3_] = this.decodeObject(param1[_loc3_]);
               }
            }
         }
         return param1;
      }
   }
}
