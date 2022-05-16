package SkinCreator_fla
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public dynamic class Timeline_150 extends MovieClip
   {
       
      
      public var item3:MovieClip;
      
      public var item4:MovieClip;
      
      public var item5:MovieClip;
      
      public var _listItems:Array;
      
      public var itemClip:MovieClip;
      
      public var item2:MovieClip;
      
      public var i:uint;
      
      public var currentItem:MovieClip;
      
      public var _selectedItem:Object;
      
      public var listButton:SimpleButton;
      
      public var item0:MovieClip;
      
      public var item1:MovieClip;
      
      public var _listDown:Boolean;
      
      public function Timeline_150()
      {
         super();
         addFrameScript(0,this.frame1,9,this.frame10);
      }
      
      function frame10() : *
      {
         this.i = 0;
         this.itemClip = this.item0;
         while(this.itemClip)
         {
            if(this.i < this._listItems.length)
            {
               this.itemClip.item = this._listItems[this.i];
               this.itemClip.label.text = this._listItems[this.i].label;
               this.itemClip.addEventListener(MouseEvent.CLICK,this._onItemClick);
            }
            else
            {
               this.itemClip.visible = false;
            }
            ++this.i;
            this.itemClip = this["item" + this.i];
         }
      }
      
      public function setListItems(param1:Array) : void
      {
         if(!param1)
         {
            this._listItems = [];
         }
         else
         {
            this._listItems = param1.concat();
         }
         var _loc2_:uint = 0;
         while(_loc2_ < this._listItems.length)
         {
            if(typeof this._listItems[_loc2_] == "string")
            {
               this._listItems[_loc2_] = {
                  "label":this._listItems[_loc2_],
                  "data":this._listItems[_loc2_]
               };
            }
            _loc2_++;
         }
         this.setSelectedIndex(0);
      }
      
      public function setSelectedItem(param1:*) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._listItems.length)
         {
            if(this._listItems[_loc2_].data == param1)
            {
               this.setSelectedIndex(_loc2_);
               return;
            }
            _loc2_++;
         }
      }
      
      public function _onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_loc2_.item)
         {
            this.setSelectedItem(_loc2_.item.data);
         }
         if(_loc2_ && parent && parent is MovieClip && MovieClip(parent)._onListChange)
         {
            MovieClip(parent)._onListChange(_loc2_.item.data);
         }
      }
      
      public function hideList() : void
      {
         this._listDown = false;
         gotoAndStop("sortUP");
      }
      
      function frame1() : *
      {
         stop();
         if(this.listButton)
         {
            this.listButton.addEventListener(MouseEvent.CLICK,this._onListClick);
         }
         if(this.currentItem)
         {
            this.currentItem.addEventListener(MouseEvent.CLICK,this._onListClick);
         }
         if(!this._listItems)
         {
            this._listItems = [];
         }
      }
      
      public function _onListClick(param1:MouseEvent) : void
      {
         this._listDown = !this._listDown;
         if(this._listDown)
         {
            gotoAndStop("sortDOWN");
         }
         else
         {
            gotoAndStop("sortUP");
         }
      }
      
      public function setSelectedIndex(param1:uint) : void
      {
         if(param1 < this._listItems.length)
         {
            this._selectedItem = this._listItems[param1];
            if(this.currentItem && this.currentItem.label)
            {
               this.currentItem.label.text = this._selectedItem.label;
            }
         }
      }
   }
}
