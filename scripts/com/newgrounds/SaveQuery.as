package com.newgrounds
{
   public class SaveQuery extends APIEventDispatcher
   {
      
      public static const FILE_ID:String = "fileId";
      
      public static const AUTHOR_ID:String = "authorId";
      
      public static const AUTHOR_NAME:String = "authorName";
      
      public static const FILE_NAME:String = "fileName";
      
      public static const CREATED_ON:String = "createdOn";
      
      public static const UPDATED_ON:String = "updatedOn";
      
      public static const FILE_VIEWS:String = "fileViews";
      
      public static const FILE_STATUS:String = "fileStatus";
      
      private static const FILE_FIELDS:Array = [FILE_ID,AUTHOR_ID,AUTHOR_NAME,FILE_NAME,CREATED_ON,UPDATED_ON,FILE_VIEWS,FILE_STATUS];
      
      public static const OPERATOR_EQUAL:String = "=";
      
      public static const OPERATOR_LESS_THAN:String = "<";
      
      public static const OPERATOR_GREATER_THAN:String = ">";
      
      public static const OPERATOR_NOT_EQUAL:String = "!=";
      
      public static const OPERATOR_LESS_OR_EQUAL:String = "<=";
      
      public static const OPERATOR_GREATER_OR_EQUAL:String = ">=";
      
      public static const OPERATOR_CONTAINS:String = "*";
      
      public static const OPERATOR_NOT_CONTAINS:String = "!*";
      
      public static const OPERATOR_NOT_BEGINS_WITH:String = "!*=";
      
      public static const OPERATOR_NOT_ENDS_WITH:String = "!=*";
      
      public static const OPERATOR_BEGINS_WITH:String = "*=";
      
      public static const OPERATOR_ENDS_WITH:String = "=*";
      
      private static const TABLE_FILES:uint = 1;
      
      private static const TABLE_KEYS:uint = 2;
      
      private static const TABLE_RATINGS:uint = 3;
       
      
      private var _connection:APIConnection;
      
      private var _group:SaveGroup;
      
      private var _page:uint = 1;
      
      private var _resultsPerPage:uint = 10;
      
      private var _isRandomized:Boolean = false;
      
      private var _files:Array;
      
      private var _totalResults:uint;
      
      private var _lookupKeys:Array;
      
      private var _lookupRatings:Array;
      
      private var _fileConditions:Array;
      
      private var _keyConditions:Array;
      
      private var _ratingConditions:Array;
      
      private var _sortFields:Array;
      
      public function SaveQuery(param1:SaveGroup)
      {
         this._files = [];
         this._lookupKeys = [];
         this._lookupRatings = [];
         this._fileConditions = [];
         this._keyConditions = [];
         this._ratingConditions = [];
         this._sortFields = [];
         super();
         this._group = param1;
         this._connection = param1.connection;
         this.includeAllFields();
      }
      
      public function get group() : SaveGroup
      {
         return this._group;
      }
      
      public function get resultsPerPage() : uint
      {
         return this._resultsPerPage;
      }
      
      public function set resultsPerPage(param1:uint) : void
      {
         this._resultsPerPage = Math.min(Math.max(param1,1),100);
      }
      
      public function get page() : uint
      {
         return this._page;
      }
      
      public function set page(param1:uint) : void
      {
         this._page = Math.max(param1,1);
      }
      
      public function prevPage() : void
      {
         --this.page;
      }
      
      public function nextPage() : void
      {
         ++this.page;
      }
      
      public function get isRandomized() : Boolean
      {
         return this._isRandomized;
      }
      
      public function set isRandomized(param1:Boolean) : void
      {
         this._isRandomized = param1;
      }
      
      public function get files() : Array
      {
         return this._files;
      }
      
      public function reset() : void
      {
         this._page = 1;
         this._resultsPerPage = 10;
         this._isRandomized = false;
         this._lookupKeys = [];
         this._lookupRatings = [];
         this._fileConditions = [];
         this._keyConditions = [];
         this._ratingConditions = [];
         this._files = [];
         this.includeAllFields();
      }
      
      private function includeAllFields() : void
      {
         var _loc1_:SaveKey = null;
         var _loc2_:SaveRating = null;
         for each(_loc1_ in this._group.keys)
         {
            this._lookupKeys.push(_loc1_.id);
         }
         for each(_loc2_ in this._group.ratings)
         {
            this._lookupRatings.push(_loc2_.id);
         }
      }
      
      public function addCondition(param1:String, param2:String, param3:*) : void
      {
         var _loc4_:int = 0;
         var _loc5_:SaveKey = null;
         var _loc6_:Array = null;
         var _loc7_:SaveRating = null;
         if((_loc4_ = FILE_FIELDS.indexOf(param1)) >= 0)
         {
            this._fileConditions.push({
               "field":_loc4_,
               "operator":param2,
               "value":param3
            });
         }
         else
         {
            if(_loc5_ = this._group.getKey(param1))
            {
               param3 = _loc5_.validateValue(param3);
               this._keyConditions.push({
                  "key_id":_loc5_.id,
                  "operator":param2,
                  "value":param3
               });
               return;
            }
            _loc6_ = param1.split(".");
            if(_loc7_ = this._group.getRating(_loc6_[0]))
            {
               param3 = _loc7_.validateValue(param3);
               this._ratingConditions.push({
                  "rating_id":_loc7_.id,
                  "operator":param2,
                  "value":param3,
                  "column":(!!_loc6_[1] ? _loc6_[1] : "score")
               });
               return;
            }
            Logger.logError("The save group \"" + this._group.name + "\" does not have a field named \"" + param1 + "\".");
         }
      }
      
      public function sortOn(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:SaveKey = null;
         var _loc5_:Array = null;
         var _loc6_:SaveRating = null;
         _loc3_ = FILE_FIELDS.indexOf(param1);
         if(_loc3_ >= 0)
         {
            this._sortFields.push({
               "table":TABLE_FILES,
               "field":_loc3_,
               "desc":param2
            });
         }
         else
         {
            if(_loc4_ = this._group.getKey(param1))
            {
               this._sortFields.push({
                  "table":TABLE_KEYS,
                  "field":_loc4_.id,
                  "desc":param2
               });
               return;
            }
            _loc5_ = param1.split(".");
            if(_loc6_ = this._group.getRating(_loc5_[0]))
            {
               this._sortFields.push({
                  "table":TABLE_RATINGS,
                  "field":_loc6_.id,
                  "desc":param2,
                  "extra":(!!_loc5_[1] ? _loc5_[1] : "score")
               });
               return;
            }
            Logger.logError("The save group \"" + this._group.name + "\" does not have a field named \"" + param1 + "\".");
         }
      }
      
      public function execute() : void
      {
         var _loc1_:Object = {};
         _loc1_.page = this._page;
         _loc1_.num_results = this._resultsPerPage;
         if(this._isRandomized)
         {
            _loc1_.randomize = 1;
         }
         if(this._lookupKeys && this._lookupKeys.length)
         {
            _loc1_.lookup_keys = this._lookupKeys;
         }
         if(this._lookupRatings && this._lookupRatings.length)
         {
            _loc1_.lookup_ratings = this._lookupRatings;
         }
         if(this._fileConditions && this._fileConditions.length)
         {
            _loc1_.file_conditions = this._fileConditions;
         }
         if(this._keyConditions && this._keyConditions.length)
         {
            _loc1_.key_conditions = this._keyConditions;
         }
         if(this._ratingConditions && this._ratingConditions.length)
         {
            _loc1_.rating_conditions = this._ratingConditions;
         }
         if(this._sortFields && this._sortFields.length)
         {
            _loc1_.sort_conditions = this._sortFields;
         }
         this._connection.sendSimpleCommand("lookupSaveFiles",this.onQueryComplete,{
            "publisher_id":this._connection.publisherId,
            "group_id":this._group.id,
            "query":_loc1_
         });
      }
      
      private function onQueryComplete(param1:APIEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:uint = 0;
         var _loc4_:SaveFile = null;
         if(param1.success)
         {
            _loc2_ = param1.data;
            this._files = [];
            if(_loc2_.files)
            {
               _loc3_ = 0;
               while(_loc3_ < _loc2_.files.length)
               {
                  if(_loc4_ = SaveFile.fromObject(this._group,_loc2_.files[_loc3_]))
                  {
                     this._files.push(_loc4_);
                  }
                  _loc3_++;
               }
            }
            dispatchEvent(new APIEvent(APIEvent.QUERY_COMPLETE,this));
         }
         else
         {
            Logger.logError("Query failed: " + param1.error);
            dispatchEvent(new APIEvent(APIEvent.QUERY_COMPLETE,this,param1.error));
         }
      }
   }
}
