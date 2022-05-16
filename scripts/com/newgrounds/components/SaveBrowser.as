package com.newgrounds.components
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.Logger;
   import com.newgrounds.SaveFile;
   import com.newgrounds.SaveGroup;
   import com.newgrounds.SaveQuery;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public dynamic class SaveBrowser extends MovieClip
   {
       
      
      public var _saveGroup:SaveGroup;
      
      public var nextButton:SimpleButton;
      
      public var customSortField:String;
      
      public var _numIcons:uint;
      
      public var sortField:String;
      
      public var orderText:TextField;
      
      public var orderButton:MovieClip;
      
      public var titleText:TextField;
      
      public var reloadButton:SimpleButton;
      
      public var saveGroupName:String;
      
      public var sortDescending:Boolean;
      
      public var iconList:MovieClip;
      
      public var infoBox:MovieClip;
      
      public var prevButton:SimpleButton;
      
      public var _query:SaveQuery;
      
      public var listBox:MovieClip;
      
      public var title:String;
      
      public var pageText:TextField;
      
      public var i:uint;
      
      public var iconClip:MovieClip;
      
      public var _page:uint;
      
      public var file:SaveFile;
      
      public var _loading:Boolean;
      
      public function SaveBrowser()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10,19,this.frame20,27,this.frame28,28,this.frame29,36,this.frame37);
      }
      
      public function _onListChange(param1:*) : void
      {
         if(this._saveGroup)
         {
            this.sortField = param1;
            this.loadFiles();
         }
      }
      
      public function _onFileOver(param1:MouseEvent) : void
      {
         var _loc3_:SaveFile = null;
         var _loc4_:* = null;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         var _loc7_:* = null;
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(_loc2_)
         {
            _loc3_ = _loc2_.file as SaveFile;
            _loc2_.gotoAndStop("fileHover");
            if(!this._loading && this.infoBox && this._saveGroup)
            {
               this.infoBox.visible = true;
               if(this.infoBox.filenameText)
               {
                  this.infoBox.filenameText.text = _loc3_.name;
               }
               _loc4_ = "by " + _loc3_.authorName + "\n";
               _loc5_ = "";
               _loc4_ += _loc3_.description;
               _loc6_ = 0;
               for(_loc7_ in _loc3_.ratings)
               {
                  _loc5_ += _loc7_ + ": " + _loc3_.ratings[_loc7_] + "\n";
               }
               if(this.infoBox.infoText)
               {
                  this.infoBox.infoText.text = _loc4_;
               }
               if(this.infoBox.txtScore)
               {
                  this.infoBox.txtScore.text = _loc5_;
               }
            }
         }
      }
      
      public function _onFileClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!this._loading && _loc2_ && _loc2_.file)
         {
            this._loading = true;
            _loc2_.file.addEventListener(APIEvent.FILE_LOADED,this._onFileLoaded);
            gotoAndStop("loading");
            _loc2_.file.load();
         }
      }
      
      public function _onReloadClick(param1:MouseEvent) : void
      {
         this.loadFiles();
      }
      
      function frame37() : *
      {
         stop();
      }
      
      public function loadFiles(param1:SaveQuery = null) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         this._saveGroup = API.getSaveGroup(this.saveGroupName);
         if(!this._saveGroup)
         {
            if(!API.saveGroups[0])
            {
               Logger.logError("No save group created for this movie. You can create save groups on your API Settings page at http://www.newgrounds.com/account/flashapi");
               gotoAndPlay("error");
               return;
            }
            this._saveGroup = API.saveGroups[0];
            this.saveGroupName = this._saveGroup.name;
            Logger.logWarning("No save group name set in the Save Browser component. Defaulting to save group \"" + this._saveGroup.name + "\".");
         }
         if(param1)
         {
            this._query = param1;
         }
         else
         {
            this._query = API.createSaveQuery(this.saveGroupName);
         }
         if(!this._query)
         {
            gotoAndPlay("error");
            return;
         }
         this._query.resultsPerPage = this._numIcons;
         this._query.page = this._page;
         this._query.addEventListener(APIEvent.QUERY_COMPLETE,this._onQueryComplete);
         if(this.sortField)
         {
            this._query.sortOn(this.sortField,this.sortDescending);
         }
         if(this.pageText)
         {
            this.pageText.text = "Page " + this._query.page;
         }
         if(this.listBox)
         {
            this.listBox.mouseChildren = false;
            this.listBox.hideList();
            _loc2_ = [{
               "label":"Date",
               "data":SaveQuery.CREATED_ON
            },{
               "label":"Name",
               "data":SaveQuery.FILE_NAME
            }];
            _loc3_ = 0;
            while(_loc3_ < this._saveGroup.ratings.length)
            {
               _loc2_.push(this._saveGroup.ratings[_loc3_].name);
               _loc3_++;
            }
            this.listBox.setListItems(_loc2_);
            this.listBox.setSelectedItem(this.sortField);
         }
         if(this.orderText)
         {
            this.orderText.text = "Sorted by " + this.listBox.currentItem.label.text + ", " + (!!this.sortDescending ? "Descending" : "Ascending");
         }
         if(this.orderButton)
         {
            if(this.sortDescending)
            {
               this.orderButton.gotoAndStop("sortDESC");
            }
            else
            {
               this.orderButton.gotoAndStop("sortASC");
            }
         }
         this._loading = true;
         gotoAndStop("loading");
         this._clearFiles();
         this._query.execute();
      }
      
      public function _onFileLoaded(param1:APIEvent) : void
      {
         this._loading = false;
         gotoAndStop("files");
      }
      
      public function _onQueryComplete(param1:APIEvent) : void
      {
         this._loading = false;
         if(this.listBox)
         {
            this.listBox.mouseChildren = true;
         }
         if(param1.success)
         {
            this._query.removeEventListener(APIEvent.QUERY_COMPLETE,this._onQueryComplete);
            if(this._query.files.length)
            {
               gotoAndStop("files");
            }
            else
            {
               gotoAndPlay("noResults");
            }
         }
         else
         {
            gotoAndPlay("error");
         }
      }
      
      function frame10() : *
      {
         if(this.infoBox)
         {
            this.infoBox.startDrag(true);
            this.infoBox.mouseEnabled = false;
            this.infoBox.visible = false;
         }
         if(this.iconList && this._query)
         {
            this.i = 0;
            while(this.i < this._numIcons)
            {
               this.iconClip = this.iconList["icon" + this.i];
               this.file = this._query.files[this.i] as SaveFile;
               if(this.iconClip && this.file && !this.iconClip.file)
               {
                  this.iconClip.file = this.file;
                  this.iconClip.gotoAndStop("file");
                  this.iconClip.addEventListener(MouseEvent.ROLL_OVER,this._onFileOver);
                  this.iconClip.addEventListener(MouseEvent.ROLL_OUT,this._onFileOut);
                  this.iconClip.addEventListener(MouseEvent.CLICK,this._onFileClick);
               }
               ++this.i;
            }
         }
      }
      
      public function _clearFiles() : void
      {
         var _loc2_:MovieClip = null;
         if(!this.iconList)
         {
            return;
         }
         var _loc1_:uint = 0;
         while(_loc1_ < this._numIcons)
         {
            _loc2_ = this.iconList["icon" + _loc1_];
            if(_loc2_)
            {
               _loc2_.gotoAndStop("empty");
               _loc2_.file = null;
               _loc2_.removeEventListener(MouseEvent.CLICK,this._onFileClick);
               _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this._onFileOver);
               _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this._onFileOut);
            }
            _loc1_++;
         }
      }
      
      public function _onFileOut(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         if(!this._loading && _loc2_)
         {
            _loc2_.gotoAndStop("file");
         }
         if(this.infoBox)
         {
            this.infoBox.visible = false;
         }
      }
      
      public function _onPageClick(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.currentTarget;
         if(this._saveGroup && this._query && !this._loading)
         {
            if(_loc2_ == this.prevButton)
            {
               --this._page;
            }
            else
            {
               ++this._page;
            }
            if(this._page < 1)
            {
               this._page = 1;
            }
            this.loadFiles();
         }
      }
      
      function frame1() : *
      {
         if(!this.title)
         {
            this.title = "Select a file:";
         }
         if(this.customSortField)
         {
            this.sortField = this.customSortField;
         }
         else if(!this.sortField)
         {
            this.sortField = "Date";
         }
         this._numIcons = 12;
         this._page = 1;
         x = int(x);
         y = int(y);
         if(this.titleText)
         {
            this.titleText.text = this.title;
         }
         if(this.prevButton)
         {
            this.prevButton.addEventListener(MouseEvent.CLICK,this._onPageClick);
         }
         if(this.nextButton)
         {
            this.nextButton.addEventListener(MouseEvent.CLICK,this._onPageClick);
         }
         if(this.orderButton)
         {
            this.orderButton.addEventListener(MouseEvent.CLICK,this._onOrderClick);
         }
         gotoAndPlay("error");
         if(parent)
         {
            this.loadFiles();
         }
      }
      
      function frame20() : *
      {
         if(this.reloadButton)
         {
            this.reloadButton.addEventListener(MouseEvent.CLICK,this._onReloadClick);
         }
      }
      
      function frame28() : *
      {
         stop();
      }
      
      function frame29() : *
      {
         if(this.reloadButton)
         {
            this.reloadButton.addEventListener(MouseEvent.CLICK,this._onReloadClick);
         }
      }
      
      public function _onOrderClick(param1:MouseEvent) : void
      {
         this.sortDescending = !this.sortDescending;
         this.loadFiles();
      }
   }
}
