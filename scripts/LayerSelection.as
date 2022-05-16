package
{
   public class LayerSelection
   {
       
      
      public var layers:Vector.<Layer>;
      
      private var i:int;
      
      public var range:int;
      
      public var anchorLayer:Layer;
      
      public var tempLayer:Layer;
      
      public function LayerSelection(param1:Layer, param2:int)
      {
         super();
         this.anchorLayer = param1;
         this.anchorLayer.selected = true;
         this.range = param2;
         this.layers = new Vector.<Layer>();
         this.layers.push(this.anchorLayer);
      }
      
      public function fadeAll() : void
      {
         for each(this.tempLayer in this.layers)
         {
            this.tempLayer.faded = true;
         }
      }
      
      public function unfadeAll() : void
      {
         for each(this.tempLayer in this.layers)
         {
            this.tempLayer.faded = false;
         }
      }
      
      public function getBottomLayer() : uint
      {
         var _loc1_:int = 10000000;
         for each(this.tempLayer in this.layers)
         {
            if(this.tempLayer.index < _loc1_)
            {
               _loc1_ = this.tempLayer.index;
            }
         }
         return _loc1_ as uint;
      }
      
      public function getTopLayer() : uint
      {
         var _loc1_:int = -1;
         for each(this.tempLayer in this.layers)
         {
            if(this.tempLayer.index > _loc1_)
            {
               _loc1_ = this.tempLayer.index;
            }
         }
         return _loc1_ as uint;
      }
      
      public function setRange(param1:int) : void
      {
         this.range = param1;
         this.layers = new Vector.<Layer>();
         Main.rootRef.deselectAllLayers();
         var _loc2_:int = this.anchorLayer.index + this.range;
         if(this.range >= 0)
         {
            this.i = this.anchorLayer.index;
            while(this.i <= _loc2_)
            {
               Main.curSkin.layers[this.i].selected = true;
               this.layers.push(Main.curSkin.layers[this.i]);
               ++this.i;
            }
         }
         else if(this.range < 0)
         {
            this.i = this.anchorLayer.index;
            while(this.i >= _loc2_)
            {
               Main.curSkin.layers[this.i].selected = true;
               this.layers.push(Main.curSkin.layers[this.i]);
               --this.i;
            }
         }
      }
   }
}
