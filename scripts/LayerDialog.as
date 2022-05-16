package
{
   import fl.controls.List;
   import fl.events.ListEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class LayerDialog extends MovieClip
   {
       
      
      public var selectedPiece:Piece;
      
      public var mcPreviewBox:PreviewBox;
      
      public var mcViewPics:MovieClip;
      
      public var curPieceID:uint;
      
      public var txtCategoryName:TextField;
      
      public var btnPremade:MovieClip;
      
      public var btnCustomView0:MovieClip;
      
      public var btnCustomView1:MovieClip;
      
      public var btnCustomView2:MovieClip;
      
      public var btnCustomView3:MovieClip;
      
      public var btnCustomView4:MovieClip;
      
      public var btnCustomView5:MovieClip;
      
      public var btnCustomView6:MovieClip;
      
      public var btnCustomView7:MovieClip;
      
      public var btnCustomView8:MovieClip;
      
      public var btnCustomView9:MovieClip;
      
      public var btnAddPiece:MovieClip;
      
      public var mcCanMove:MovieClip;
      
      public var btnBackFromPieces:MovieClip;
      
      private var i:uint;
      
      private var j:uint;
      
      public var lstPieces:List;
      
      public var lstSubcategories:List;
      
      public var curSubcategoryID:uint;
      
      public var btnBackFromCustomChoices:MovieClip;
      
      public var btnBackFromCategories:MovieClip;
      
      public var btnBackFromSubcategories:MovieClip;
      
      public var lstCategories:List;
      
      public var btnCustomView10:MovieClip;
      
      public var btnCustomView11:MovieClip;
      
      public var btnCustomView12:MovieClip;
      
      public var colorGrabber:ColorGrabber;
      
      public var btnCustom:MovieClip;
      
      public var btnCancel:MovieClip;
      
      public var curCategoryID:uint;
      
      public function LayerDialog()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5);
         stop();
         this.hide();
         x = y = 0;
         Main.stageRef.focus = null;
      }
      
      public function press_btnBackFromCustomChoices(param1:MouseEvent) : void
      {
         gotoAndStop("main");
      }
      
      public function initCustomChoices() : void
      {
         var _loc1_:MovieClip = null;
         this.btnBackFromCustomChoices.buttonMode = true;
         this.btnBackFromCustomChoices.addEventListener(MouseEvent.CLICK,this.press_btnBackFromCustomChoices);
         this.i = 0;
         while(this.i < 13)
         {
            _loc1_ = this["btnCustomView" + this.i];
            _loc1_.addEventListener(MouseEvent.CLICK,this.press_btnCustomView);
            _loc1_.buttonMode = true;
            _loc1_.stop();
            _loc1_.mouseChildren = false;
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverCustomView);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutCustomView);
            _loc1_.viewNum = this.i + 2;
            ++this.i;
         }
         this.mcViewPics.stop();
      }
      
      public function press_btnBackFromSubcategories(param1:MouseEvent) : void
      {
         gotoAndStop("premade_categories");
      }
      
      public function initPremadeSubcategories() : void
      {
         var _loc1_:Subcategory = null;
         this.btnBackFromSubcategories.buttonMode = true;
         this.btnBackFromSubcategories.addEventListener(MouseEvent.CLICK,this.press_btnBackFromSubcategories);
         for each(_loc1_ in Main.subcategories)
         {
            if(_loc1_.parentCategory.id == this.curCategoryID)
            {
               this.lstSubcategories.addItem({
                  "label":_loc1_.name,
                  "data":_loc1_.id
               });
            }
         }
         this.lstSubcategories.addEventListener(ListEvent.ITEM_CLICK,this.clickSubcategory);
      }
      
      public function chooseCategory(param1:uint) : void
      {
         this.curCategoryID = param1;
         gotoAndStop("premade_subcategories");
      }
      
      public function press_btnCustomView(param1:MouseEvent) : void
      {
         var _loc2_:uint = uint(param1.currentTarget.name.substring(13));
         Main.rootRef.deselectAllLayers();
         var _loc3_:CustomLayer = new CustomLayer();
         _loc3_.isNew = true;
         _loc3_.setTargetView(_loc2_);
         Main.curSkin.addLayer(_loc3_);
         Main.layerSelection = new LayerSelection(_loc3_,0);
         Main.rootRef.updateLayers();
         this.close();
         Main.layerToEdit = _loc3_;
         Main.savedView = PreviewBox.VIEW_FRONT;
         Main.rootRef.unloadPreviewBox();
         Main.rootRef.gotoAndStop("edit_custom_layer");
      }
      
      public function press_btnAddPiece(param1:MouseEvent) : void
      {
         if(this.lstPieces.selectedIndex == -1 || this.selectedPiece == null)
         {
            return;
         }
         Main.savedView = this.selectedPiece.defaultView;
         Main.rootRef.deselectAllLayers();
         var _loc2_:PremadeLayer = new PremadeLayer();
         _loc2_.tintColor = this.colorGrabber.actualColor;
         _loc2_.setPiece(this.selectedPiece.id);
         _loc2_.isNew = true;
         Main.curSkin.addLayer(_loc2_);
         Main.layerSelection = new LayerSelection(_loc2_,0);
         Main.rootRef.updateLayers();
         this.cleanupPremadePieces();
         this.close();
         Main.sfxBtnClick.play();
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function initPremadeCategories() : void
      {
         var _loc1_:Category = null;
         this.btnBackFromCategories.buttonMode = true;
         this.btnBackFromCategories.addEventListener(MouseEvent.CLICK,this.press_btnBackFromCategories);
         for each(_loc1_ in Main.categories)
         {
            this.lstCategories.addItem({
               "label":_loc1_.name,
               "data":_loc1_.id
            });
         }
         this.lstCategories.addEventListener(ListEvent.ITEM_CLICK,this.clickCategory);
      }
      
      public function press_btnBackFromPieces(param1:MouseEvent) : void
      {
         this.cleanupPremadePieces();
         gotoAndStop("premade_subcategories");
      }
      
      public function cleanupPremadePieces() : void
      {
         this.mcPreviewBox.cleanup();
         removeChild(this.mcPreviewBox);
         this.mcPreviewBox = null;
         this.lstPieces.removeEventListener(Event.CHANGE,this.showPiecePreview);
         this.lstPieces.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.doubleClickItem);
         this.btnBackFromPieces.removeEventListener(MouseEvent.CLICK,this.press_btnBackFromPieces);
         this.btnAddPiece.removeEventListener(MouseEvent.CLICK,this.press_btnAddPiece);
         this.colorGrabber.removeEventListener(Event.CHANGE,this.changeColor);
         if(Main.dummySkin.layers.length > 0)
         {
            Main.dummySkin.deleteLayer(Main.dummySkin.layers[0]);
         }
      }
      
      function frame1() : *
      {
         this.initMain();
      }
      
      function frame2() : *
      {
         this.initPremadeCategories();
      }
      
      function frame3() : *
      {
         this.initPremadeSubcategories();
      }
      
      function frame4() : *
      {
         this.initPremadePieces();
      }
      
      function frame5() : *
      {
         this.initCustomChoices();
      }
      
      public function initPremadePieces() : void
      {
         var _loc1_:Piece = null;
         this.btnBackFromPieces.buttonMode = true;
         this.btnAddPiece.buttonMode = true;
         this.btnBackFromPieces.addEventListener(MouseEvent.CLICK,this.press_btnBackFromPieces);
         this.btnAddPiece.addEventListener(MouseEvent.CLICK,this.press_btnAddPiece);
         this.txtCategoryName.text = "Browsing: " + Main.getSubcategory(this.curSubcategoryID).name + "";
         for each(_loc1_ in Main.pieces)
         {
            if(_loc1_.subcategory == this.curSubcategoryID)
            {
               this.lstPieces.addItem({
                  "label":_loc1_.name,
                  "data":_loc1_.id
               });
            }
         }
         this.lstPieces.selectedIndex = 0;
         this.lstPieces.addEventListener(Event.CHANGE,this.showPiecePreview);
         this.lstPieces.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.doubleClickItem);
         this.lstPieces.doubleClickEnabled = true;
         this.mcPreviewBox = new PreviewBox();
         this.mcPreviewBox.x = 413;
         this.mcPreviewBox.y = 67;
         this.mcPreviewBox.showingDummySkin = true;
         this.mcPreviewBox.mcBGLabel.visible = false;
         this.mcPreviewBox.skin = Main.dummySkin;
         this.mcPreviewBox.loadBase(Main.dummySkin.baseBitmapData);
         this.mcPreviewBox.refreshView();
         addChildAt(this.mcPreviewBox,getChildIndex(this.colorGrabber));
         this.mcPreviewBox.mcModelMessage.visible = Utilities.saveFile.firstRotate;
         this.mcCanMove.visible = false;
         this.showPiecePreview();
         this.colorGrabber.addEventListener(Event.CHANGE,this.changeColor);
      }
      
      public function changeColor(param1:Event) : void
      {
         if(Main.dummySkin.layers.length > 0)
         {
            Main.dummySkin.layers[0].tintColor = this.colorGrabber.actualColor;
            this.mcPreviewBox.refreshView();
         }
      }
      
      public function showPiecePreview(param1:Event = null) : void
      {
         if(this.lstPieces.selectedIndex == -1)
         {
            return;
         }
         this.curPieceID = uint(this.lstPieces.selectedItem.data);
         this.selectedPiece = Main.getPiece(this.curPieceID);
         if(this.selectedPiece == null)
         {
            return;
         }
         this.mcCanMove.visible = this.selectedPiece.canMove;
         Main.dummySkin.previewPiece(this.selectedPiece,this.colorGrabber.actualColor);
         Main.savedView = this.selectedPiece.defaultView;
         this.mcPreviewBox.refreshView();
      }
      
      public function clickSubcategory(param1:ListEvent) : void
      {
         this.chooseSubcategory(param1.item.data);
      }
      
      public function cleanup() : void
      {
         this.btnCancel.removeEventListener(MouseEvent.CLICK,this.press_btnCancel);
         this.btnPremade.removeEventListener(MouseEvent.CLICK,this.press_btnPremade);
         this.btnCustom.removeEventListener(MouseEvent.CLICK,this.press_btnCustom);
         this.btnPremade.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnPremade.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnCustom.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnCustom.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         Utilities.cleanupMCBtn(this.btnCancel);
      }
      
      public function chooseSubcategory(param1:uint) : void
      {
         this.curSubcategoryID = param1;
         gotoAndStop("premade_pieces");
      }
      
      public function clickCategory(param1:ListEvent) : void
      {
         this.chooseCategory(param1.item.data);
      }
      
      public function press_btnBackFromCategories(param1:MouseEvent) : void
      {
         gotoAndStop("main");
      }
      
      public function mouseOverCustomView(param1:MouseEvent) : void
      {
         Main.sfxBtnHover.play();
         MovieClip(param1.target).gotoAndStop(2);
         this.mcViewPics.gotoAndStop(MovieClip(param1.target).viewNum);
      }
      
      public function press_btnPremade(param1:MouseEvent) : void
      {
         gotoAndStop("premade_categories");
      }
      
      public function initMain() : void
      {
         this.btnPremade.buttonMode = true;
         this.btnCustom.buttonMode = true;
         Utilities.mc2Btn(this.btnCancel);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.press_btnCancel);
         this.btnPremade.addEventListener(MouseEvent.CLICK,this.press_btnPremade);
         this.btnCustom.addEventListener(MouseEvent.CLICK,this.press_btnCustom);
         this.btnPremade.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnPremade.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnCustom.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnCustom.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
      }
      
      public function doubleClickItem(param1:ListEvent) : void
      {
         this.press_btnAddPiece(null);
      }
      
      public function press_btnCustom(param1:MouseEvent) : void
      {
         gotoAndStop("custom_choices");
      }
      
      public function close() : void
      {
         gotoAndStop("main");
         this.hide();
         Main.stageRef.focus = null;
      }
      
      public function press_btnCancel(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function mouseOutCustomView(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
      }
   }
}
