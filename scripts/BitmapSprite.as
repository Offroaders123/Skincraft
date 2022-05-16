package
{
   import fl.motion.Color;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   
   public class BitmapSprite extends Sprite
   {
       
      
      public var mainLayerBitmap:Bitmap;
      
      public var mainLayerBitmapData:BitmapData;
      
      public var secondaryLayerBitmap:Bitmap;
      
      public var secondaryLayerBitmapData:BitmapData;
      
      public var mainLayer:Sprite;
      
      public var secondaryLayer:Sprite;
      
      public function BitmapSprite()
      {
         super();
      }
      
      public function cleanup() : void
      {
         if(this.mainLayerBitmapData)
         {
            this.mainLayerBitmapData.dispose();
         }
         if(this.secondaryLayerBitmapData)
         {
            this.secondaryLayerBitmapData.dispose();
         }
         this.mainLayerBitmap = this.secondaryLayerBitmap = null;
         this.mainLayer = this.secondaryLayer = null;
      }
      
      public function init(param1:Layer) : void
      {
         var _loc2_:Color = null;
         if(param1 is PremadeLayer)
         {
            this.mainLayerBitmapData = param1.getBitmapData();
            this.mainLayerBitmap = new Bitmap(this.mainLayerBitmapData);
            this.mainLayer = new Sprite();
            this.mainLayer.alpha = param1.textureIntensity / 100;
            this.mainLayer.addChild(this.mainLayerBitmap);
            this.secondaryLayerBitmapData = param1.getBitmapData();
            this.secondaryLayerBitmap = new Bitmap(this.secondaryLayerBitmapData);
            this.secondaryLayer = new Sprite();
            this.secondaryLayer.addChild(this.secondaryLayerBitmap);
            if(!param1.flattenColor)
            {
               this.secondaryLayer.blendMode = BlendMode.OVERLAY;
            }
            _loc2_ = new Color();
            _loc2_.setTint(param1.tintColor,1);
            this.secondaryLayer.transform.colorTransform = _loc2_;
            this.secondaryLayer.alpha = param1.colorIntensity / 100;
            addChild(this.mainLayer);
            addChild(this.secondaryLayer);
         }
         else if(param1 is CustomLayer)
         {
            this.mainLayerBitmapData = param1.getBitmapData();
            this.mainLayerBitmap = new Bitmap(this.mainLayerBitmapData);
            addChild(this.mainLayerBitmap);
         }
      }
   }
}
