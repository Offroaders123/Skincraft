package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.getTimer;
   
   public class LayerBox extends MovieClip
   {
      
      public static const INSERT_BOTTOM:uint = 1;
      
      public static const INSERT_NONE:int = -1;
      
      public static const INSERT_TOP:uint = 0;
       
      
      public var btnToggleVisible:MovieClip;
      
      public var btnEdit:MovieClip;
      
      public var mcBase:MovieClip;
      
      public var insertLocation:int;
      
      public var selected:Boolean;
      
      public var btnDelete:MovieClip;
      
      public var hidden:Boolean;
      
      public var mcHighlight:MovieClip;
      
      public var targetLayer:Layer;
      
      public var mcSelectionArea:MovieClip;
      
      public var mcOutline:MovieClip;
      
      public var eligibleForInsertion:Boolean;
      
      public var mcHidden:MovieClip;
      
      public var mcInsertTop:MovieClip;
      
      public var txtLayerName:TextField;
      
      public var mcInsertBottom:MovieClip;
      
      public function LayerBox(param1:Layer)
      {
         super();
         this.targetLayer = param1;
         this.txtLayerName.text = this.targetLayer.name;
         tabChildren = false;
         tabEnabled = false;
         this.mcOutline.mouseEnabled = false;
         this.txtLayerName.mouseEnabled = false;
         addEventListener(MouseEvent.ROLL_OVER,this.rollOver);
         addEventListener(MouseEvent.ROLL_OUT,this.rollOut);
         addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this.mcSelectionArea.addEventListener(MouseEvent.CLICK,this.selectClick);
         this.mcSelectionArea.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         this.btnToggleVisible.addEventListener(MouseEvent.ROLL_OVER,this.rollOverToggleVisible);
         this.btnToggleVisible.addEventListener(MouseEvent.ROLL_OUT,this.rollOutOptionGeneric);
         this.btnToggleVisible.addEventListener(MouseEvent.CLICK,this.press_btnToggleVisible);
         this.btnEdit.addEventListener(MouseEvent.ROLL_OVER,this.rollOverEdit);
         this.btnEdit.addEventListener(MouseEvent.ROLL_OUT,this.rollOutOptionGeneric);
         this.btnEdit.addEventListener(MouseEvent.CLICK,this.press_btnEdit);
         this.btnDelete.addEventListener(MouseEvent.ROLL_OVER,this.rollOverDelete);
         this.btnDelete.addEventListener(MouseEvent.ROLL_OUT,this.rollOutOptionGeneric);
         this.btnDelete.addEventListener(MouseEvent.CLICK,this.press_btnDelete);
         this.btnDelete.buttonMode = this.btnEdit.buttonMode = this.btnToggleVisible.buttonMode = true;
         this.btnEdit.mcHighlight.visible = false;
         this.dehighlight();
         if(this.targetLayer.hidden)
         {
            this.hide();
         }
         else
         {
            this.show();
         }
         if(this.targetLayer.selected)
         {
            this.select();
         }
         else
         {
            this.deselect();
         }
         this.voidEligibleInsertion();
      }
      
      public function press_btnEdit(param1:MouseEvent) : void
      {
         if(!this.hidden)
         {
            this.selectUnique();
            Main.layerToEdit = this.targetLayer;
            Main.rootRef.savedLayerScrollPosition = Main.rootRef.lstLayers.verticalScrollPosition;
            Main.rootRef.unloadPreviewBox();
            if(this.targetLayer is PremadeLayer)
            {
               Main.rootRef.gotoAndStop("edit_layer");
            }
            else if(this.targetLayer is CustomLayer)
            {
               Main.rootRef.gotoAndStop("edit_custom_layer");
            }
         }
      }
      
      public function rollOverDelete(param1:MouseEvent) : void
      {
         if(Main.cursorMode == Main.CURSOR_DRAG)
         {
            return;
         }
         if(!this.hidden)
         {
            Main.showDescription("Delete \"" + this.targetLayer.name + "\"");
         }
      }
      
      public function rollOut(param1:MouseEvent) : void
      {
         this.dehighlight();
         this.voidEligibleInsertion();
      }
      
      public function rollOverToggleVisible(param1:MouseEvent) : void
      {
         if(Main.cursorMode == Main.CURSOR_DRAG)
         {
            return;
         }
         if(this.hidden)
         {
            Main.showDescription("Show \"" + this.targetLayer.name + "\"");
         }
         else
         {
            Main.showDescription("Hide \"" + this.targetLayer.name + "\"");
         }
      }
      
      public function mouseMove(param1:MouseEvent) : void
      {
         if(Main.cursorMode == Main.CURSOR_DRAG && !this.targetLayer.selected)
         {
            this.eligibleForInsertion = true;
            parent.setChildIndex(this,parent.numChildren - 1);
            if(mouseY <= this.mcOutline.height / 2)
            {
               this.insertLocation = INSERT_TOP;
               this.mcInsertTop.visible = true;
               this.mcInsertBottom.visible = false;
            }
            else
            {
               this.insertLocation = INSERT_BOTTOM;
               this.mcInsertBottom.visible = true;
               this.mcInsertTop.visible = false;
            }
         }
      }
      
      public function rollOutOptionGeneric(param1:MouseEvent) : void
      {
         Main.showDescription("");
      }
      
      public function rollOverEdit(param1:MouseEvent) : void
      {
         if(Main.cursorMode == Main.CURSOR_DRAG)
         {
            return;
         }
         if(!this.hidden)
         {
            Main.showDescription("Edit \"" + this.targetLayer.name + "\"");
         }
      }
      
      public function cleanup() : void
      {
         this.targetLayer = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.rollOver);
         removeEventListener(MouseEvent.ROLL_OUT,this.rollOut);
         removeEventListener(MouseEvent.MOUSE_MOVE,this.mouseMove);
         this.mcSelectionArea.removeEventListener(MouseEvent.CLICK,this.selectClick);
         this.mcSelectionArea.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDown);
         this.btnToggleVisible.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverToggleVisible);
         this.btnToggleVisible.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutOptionGeneric);
         this.btnToggleVisible.removeEventListener(MouseEvent.CLICK,this.press_btnToggleVisible);
         this.btnEdit.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverEdit);
         this.btnEdit.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutOptionGeneric);
         this.btnEdit.removeEventListener(MouseEvent.CLICK,this.press_btnEdit);
         this.btnDelete.removeEventListener(MouseEvent.ROLL_OVER,this.rollOverDelete);
         this.btnDelete.removeEventListener(MouseEvent.ROLL_OUT,this.rollOutOptionGeneric);
         this.btnDelete.removeEventListener(MouseEvent.CLICK,this.press_btnDelete);
      }
      
      public function press_btnDelete(param1:MouseEvent) : void
      {
         Main.layerToDelete = this.targetLayer;
         Main.newDialogBox = new DialogBox("Are you sure you want to delete layer \"" + this.targetLayer.name + "\"?");
         Main.newDialogBox.createAsYesNo("DELLAYER");
         Main.newDialogBox.display();
         this.selectUnique();
         Main.rootRef.updateLayers();
      }
      
      public function highlight() : void
      {
         this.mcHighlight.visible = true;
      }
      
      public function doubleClick() : void
      {
         this.press_btnEdit(null);
      }
      
      public function deselect() : void
      {
         this.mcOutline.gotoAndStop(1);
         this.mcBase.gotoAndStop(1);
         this.selected = false;
      }
      
      public function hide() : void
      {
         this.btnToggleVisible.gotoAndStop(2);
         this.hidden = true;
         this.targetLayer.hidden = true;
         this.mcHidden.visible = true;
      }
      
      public function dehighlight() : void
      {
         this.mcHighlight.visible = false;
      }
      
      public function voidEligibleInsertion() : void
      {
         this.mcInsertBottom.visible = this.mcInsertTop.visible = false;
         this.eligibleForInsertion = false;
         this.insertLocation = INSERT_NONE;
      }
      
      public function mouseDown(param1:MouseEvent) : void
      {
         if(this.targetLayer.selected)
         {
            Main.rootRef.startListeningForGroupDrag();
         }
      }
      
      public function selectClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Main.cursorMode == Main.CURSOR_DRAG)
         {
            return;
         }
         if(getTimer() - this.targetLayer.timeOfLastClick < 250)
         {
            this.doubleClick();
            return;
         }
         this.targetLayer.timeOfLastClick = getTimer();
         if(KeyManager.pressing(KeyManager.SHIFT))
         {
            if(Main.layerSelection)
            {
               if(Main.layerSelection.anchorLayer == this.targetLayer)
               {
                  this.selectUnique();
               }
               else
               {
                  _loc2_ = this.targetLayer.index - Main.layerSelection.anchorLayer.index;
                  Main.layerSelection.setRange(_loc2_);
               }
            }
            else
            {
               this.selectUnique();
            }
         }
         else
         {
            this.selectUnique();
         }
         Main.rootRef.updateLayers();
      }
      
      public function selectUnique() : void
      {
         Main.rootRef.deselectAllLayers();
         Main.layerSelection = new LayerSelection(this.targetLayer,0);
         if(this.targetLayer is PremadeLayer)
         {
            Main.savedView = Main.getPiece(PremadeLayer(this.targetLayer).targetPieceID).defaultView;
         }
      }
      
      public function rollOver(param1:MouseEvent) : void
      {
      }
      
      public function addBottomSpacer(param1:uint) : void
      {
         var _loc2_:Sprite = new Sprite();
         _loc2_.y = this.mcOutline.height;
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,width,param1);
         addChild(_loc2_);
      }
      
      public function select() : void
      {
         this.mcOutline.gotoAndStop(2);
         this.mcBase.gotoAndStop(2);
         this.selected = true;
      }
      
      public function show() : void
      {
         this.btnToggleVisible.gotoAndStop(1);
         this.hidden = false;
         this.targetLayer.hidden = false;
         this.mcHidden.visible = false;
      }
      
      public function press_btnToggleVisible(param1:MouseEvent) : void
      {
         if(this.hidden)
         {
            this.show();
         }
         else
         {
            this.hide();
         }
         Main.rootRef.updateLayers();
      }
   }
}
