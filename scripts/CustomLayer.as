package
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class CustomLayer extends Layer implements IExternalizable
   {
       
      
      public var customBitmapData:BitmapData;
      
      public var targetView:uint;
      
      public function CustomLayer()
      {
         super();
         type = Layer.CUSTOM;
         name = "Custom Layer";
         this.customBitmapData = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT,true,0);
      }
      
      override public function copy() : Layer
      {
         var _loc1_:CustomLayer = new CustomLayer();
         _loc1_.customBitmapData = this.customBitmapData.clone();
         _loc1_.targetView = this.targetView;
         copyBaseProperties(_loc1_);
         return _loc1_;
      }
      
      override public function readExternal(param1:IDataInput) : void
      {
         super.readExternal(param1);
         this.customBitmapData = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT,true,0);
         var _loc2_:ByteArray = new ByteArray();
         param1.readBytes(_loc2_,0,this.customBitmapData.width * this.customBitmapData.height * 4);
         this.customBitmapData.setPixels(this.customBitmapData.rect,_loc2_);
         this.targetView = param1.readUnsignedInt();
      }
      
      override public function writeExternal(param1:IDataOutput) : void
      {
         super.writeExternal(param1);
         param1.writeBytes(this.customBitmapData.getPixels(this.customBitmapData.rect));
         param1.writeUnsignedInt(this.targetView);
      }
      
      override public function getBitmapData() : BitmapData
      {
         return this.customBitmapData.clone();
      }
      
      public function setTargetView(param1:uint) : void
      {
         this.targetView = param1;
         name = "Custom " + PixelEditor.viewNames[this.targetView];
      }
   }
}
