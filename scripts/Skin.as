package
{
   import flash.display.BitmapData;
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class Skin implements IExternalizable
   {
       
      
      public var layers:Vector.<Layer>;
      
      public var name:String;
      
      public var shareName:String;
      
      public var shareTags:String;
      
      public var shareDescription:String;
      
      public var tempLayer:Layer;
      
      private var i:uint;
      
      public var baseBitmapData:BitmapData;
      
      private var j:uint;
      
      public function Skin()
      {
         super();
         registerClassAlias("Layer",Layer);
         registerClassAlias("PremadeLayer",PremadeLayer);
         registerClassAlias("CustomLayer",CustomLayer);
         registerClassAlias("Piece",Piece);
         registerClassAlias("BitmapSprite",BitmapSprite);
         registerClassAlias("Surface",Surface);
         this.layers = new Vector.<Layer>();
         this.name = "My Skin";
         this.shareName = "";
         this.shareDescription = "";
         this.shareTags = "";
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.name = param1.readUTF();
         this.layers = param1.readObject();
         this.baseBitmapData = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT);
         var _loc2_:ByteArray = new ByteArray();
         param1.readBytes(_loc2_,0,this.baseBitmapData.width * this.baseBitmapData.height * 4);
         this.baseBitmapData.setPixels(this.baseBitmapData.rect,_loc2_);
         this.shareName = param1.readUTF();
         this.shareDescription = param1.readUTF();
         this.shareTags = param1.readUTF();
      }
      
      public function previewPiece(param1:Piece, param2:uint = 16711680) : void
      {
         while(this.layers.length > 0)
         {
            this.deleteLayer(this.layers[0]);
         }
         var _loc3_:PremadeLayer = new PremadeLayer();
         _loc3_.setPiece(param1.id);
         _loc3_.tintColor = param2;
         this.addLayer(_loc3_);
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeUTF(this.name);
         param1.writeObject(this.layers);
         param1.writeBytes(this.baseBitmapData.getPixels(this.baseBitmapData.rect));
         param1.writeUTF(this.shareName);
         param1.writeUTF(this.shareDescription);
         param1.writeUTF(this.shareTags);
      }
      
      public function deleteLayer(param1:Layer) : void
      {
         this.i = 0;
         while(this.i < this.layers.length)
         {
            if(param1 == this.layers[this.i])
            {
               if(param1 is CustomLayer)
               {
                  CustomLayer(param1).customBitmapData.dispose();
               }
               param1.linkedSprite = null;
               this.layers.splice(this.i,1);
               break;
            }
            ++this.i;
         }
         this.updateLayerIndicies();
      }
      
      public function cleanup() : void
      {
         this.baseBitmapData.dispose();
         while(this.layers.length > 0)
         {
            this.deleteLayer(this.layers[0]);
         }
         this.layers = null;
      }
      
      public function moveLayerSelection(param1:LayerBox) : void
      {
         var _loc4_:uint = 0;
         if(!Main.layerSelection)
         {
            return;
         }
         if(!param1.eligibleForInsertion)
         {
            return;
         }
         var _loc2_:uint = Main.layerSelection.getBottomLayer();
         var _loc3_:Vector.<Layer> = this.layers.splice(_loc2_,Main.layerSelection.layers.length);
         this.updateLayerIndicies();
         if(param1.insertLocation == LayerBox.INSERT_TOP)
         {
            _loc4_ = param1.targetLayer.index + 1;
         }
         else if(param1.insertLocation == LayerBox.INSERT_BOTTOM)
         {
            _loc4_ = param1.targetLayer.index;
         }
         var _loc5_:Vector.<Layer>;
         var _loc6_:Vector.<Layer> = (_loc6_ = (_loc5_ = this.layers.splice(0,_loc4_)).concat(_loc3_)).concat(this.layers);
         this.layers = _loc6_;
         _loc3_ = null;
         _loc6_ = null;
         this.updateLayerIndicies();
      }
      
      public function updateLayerIndicies() : void
      {
         this.i = 0;
         while(this.i < this.layers.length)
         {
            this.layers[this.i].index = this.i;
            ++this.i;
         }
      }
      
      public function addLayer(param1:Layer, param2:Boolean = false) : void
      {
         this.layers.push(param1);
         this.updateLayerIndicies();
         if(param2)
         {
            return;
         }
         Main.rootRef.checkForSecondTutorialClip();
         if(this.layers.length == 2 && Utilities.saveFile.firstLayer)
         {
            Utilities.saveFile.firstLayer = false;
            Utilities.saveGame();
            Main.rootRef.mcTut2.visible = false;
         }
      }
   }
}
