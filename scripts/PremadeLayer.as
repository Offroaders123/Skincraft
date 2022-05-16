package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class PremadeLayer extends Layer implements IExternalizable
   {
       
      
      public var tempOffsetX:Number;
      
      public var tempOffsetY:Number;
      
      public var targetPieceID:uint;
      
      public function PremadeLayer()
      {
         super();
         type = Layer.PREMADE;
      }
      
      public function attemptToMove(param1:uint) : void
      {
         if(!Main.getPiece(this.targetPieceID).canMove)
         {
            return;
         }
         this.tempOffsetX = offsetX;
         this.tempOffsetY = offsetY;
         var _loc2_:Piece = Main.getPiece(this.targetPieceID);
         switch(param1)
         {
            case Main.UP:
               --this.tempOffsetY;
               break;
            case Main.DOWN:
               ++this.tempOffsetY;
               break;
            case Main.LEFT:
               --this.tempOffsetX;
               break;
            case Main.RIGHT:
               ++this.tempOffsetX;
         }
         var _loc3_:BitmapData = linkedSprite.mainLayerBitmapData;
         var _loc4_:Rectangle = _loc3_.getColorBoundsRect(4294967295,0,false);
         var _loc5_:Rectangle = new Rectangle(_loc4_.x + this.tempOffsetX,_loc4_.y + this.tempOffsetY,_loc4_.width,_loc4_.height);
         if(_loc2_.surfacesContain(_loc5_.topLeft,"top left") && _loc2_.surfacesContain(new Point(_loc5_.right,_loc5_.top),"top right") && _loc2_.surfacesContain(new Point(_loc5_.left,_loc5_.bottom),"bottom left") && _loc2_.surfacesContain(_loc5_.bottomRight,"bottom right"))
         {
            offsetX = this.tempOffsetX;
            offsetY = this.tempOffsetY;
         }
         Main.rootRef.mcPreviewBox.refreshView();
      }
      
      override public function readExternal(param1:IDataInput) : void
      {
         super.readExternal(param1);
         this.targetPieceID = param1.readUnsignedInt();
      }
      
      override public function writeExternal(param1:IDataOutput) : void
      {
         super.writeExternal(param1);
         param1.writeUnsignedInt(this.targetPieceID);
      }
      
      public function setPiece(param1:uint) : void
      {
         this.targetPieceID = param1;
         name = Main.getPiece(this.targetPieceID).name;
      }
      
      override public function getBitmapData() : BitmapData
      {
         return Main.getPiece(this.targetPieceID).generateBitmapData();
      }
      
      override public function copy() : Layer
      {
         var _loc1_:PremadeLayer = new PremadeLayer();
         _loc1_.setPiece(this.targetPieceID);
         copyBaseProperties(_loc1_);
         return _loc1_;
      }
   }
}
