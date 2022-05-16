package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MinecraftGuy extends Object3D
   {
       
      
      public var boxes:Vector.<Box3D>;
      
      public function MinecraftGuy(param1:BitmapData)
      {
         var _loc4_:Box3D = null;
         super();
         var _loc2_:uint = param1.width;
         var _loc3_:uint = param1.height;
         this.boxes = new Vector.<Box3D>();
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(8 / _loc2_,0 / _loc3_),new Point(16 / _loc2_,8 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(16 / _loc2_,0 / _loc3_),new Point(24 / _loc2_,8 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(8 / _loc2_,8 / _loc3_),new Point(16 / _loc2_,16 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(24 / _loc2_,8 / _loc3_),new Point(32 / _loc2_,16 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(16 / _loc2_,8 / _loc3_),new Point(24 / _loc2_,16 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(0 / _loc2_,8 / _loc3_),new Point(8 / _loc2_,16 / _loc3_));
         _loc4_.y = 1.25;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(0,1.8);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(40 / _loc2_,0 / _loc3_),new Point(48 / _loc2_,8 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(48 / _loc2_,0 / _loc3_),new Point(56 / _loc2_,8 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(40 / _loc2_,8 / _loc3_),new Point(48 / _loc2_,16 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(56 / _loc2_,8 / _loc3_),new Point(64 / _loc2_,16 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(48 / _loc2_,8 / _loc3_),new Point(56 / _loc2_,16 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(32 / _loc2_,8 / _loc3_),new Point(40 / _loc2_,16 / _loc3_));
         _loc4_.y = 1.3;
         _loc4_.scaleX = _loc4_.scaleY = _loc4_.scaleZ = 1.125;
         _loc4_.depthFactor = 8.2 / 8;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(0,1.85);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(20 / _loc2_,16 / _loc3_),new Point(28 / _loc2_,20 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(28 / _loc2_,16 / _loc3_),new Point(36 / _loc2_,20 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(20 / _loc2_,20 / _loc3_),new Point(28 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(32 / _loc2_,20 / _loc3_),new Point(40 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(28 / _loc2_,20 / _loc3_),new Point(32 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(16 / _loc2_,20 / _loc3_),new Point(20 / _loc2_,32 / _loc3_));
         _loc4_.setFaceVisible(Box3D.BOTTOM,false);
         _loc4_.scaleY = 1.5;
         _loc4_.scaleZ = 0.5;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(0,0);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(20 / _loc2_,32 / _loc3_),new Point(28 / _loc2_,36 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(28 / _loc2_,32 / _loc3_),new Point(36 / _loc2_,36 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(20 / _loc2_,36 / _loc3_),new Point(28 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(32 / _loc2_,36 / _loc3_),new Point(40 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(28 / _loc2_,36 / _loc3_),new Point(32 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(16 / _loc2_,36 / _loc3_),new Point(20 / _loc2_,48 / _loc3_));
         _loc4_.scaleX = 1.1;
         _loc4_.scaleY = 1.6;
         _loc4_.scaleZ = 0.6;
         _loc4_.depthFactor = 8.4 / 8;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(0,0);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(44 / _loc2_,16 / _loc3_),new Point(48 / _loc2_,20 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(48 / _loc2_,16 / _loc3_),new Point(52 / _loc2_,20 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(44 / _loc2_,20 / _loc3_),new Point(48 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(52 / _loc2_,20 / _loc3_),new Point(56 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(48 / _loc2_,20 / _loc3_),new Point(52 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(40 / _loc2_,20 / _loc3_),new Point(44 / _loc2_,32 / _loc3_));
         _loc4_.scaleX = 0.5;
         _loc4_.scaleY = 1.5;
         _loc4_.scaleZ = 0.5;
         _loc4_.x = -0.75;
         _loc4_.y = 0;
         _loc4_.setFaceVisible(Box3D.LEFT,false);
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(-1.3,0);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(44 / _loc2_,32 / _loc3_),new Point(48 / _loc2_,36 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(48 / _loc2_,32 / _loc3_),new Point(52 / _loc2_,36 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(44 / _loc2_,36 / _loc3_),new Point(48 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(52 / _loc2_,36 / _loc3_),new Point(56 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(48 / _loc2_,36 / _loc3_),new Point(52 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(40 / _loc2_,36 / _loc3_),new Point(44 / _loc2_,48 / _loc3_));
         _loc4_.scaleX = 0.6;
         _loc4_.scaleY = 1.6;
         _loc4_.scaleZ = 0.6;
         _loc4_.x = -0.75;
         _loc4_.y = 0;
         _loc4_.depthFactor = 8.2 / 8;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(-1.3,0);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(36 / _loc2_,48 / _loc3_),new Point(40 / _loc2_,52 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(40 / _loc2_,48 / _loc3_),new Point(44 / _loc2_,52 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(36 / _loc2_,52 / _loc3_),new Point(40 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(44 / _loc2_,52 / _loc3_),new Point(48 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(32 / _loc2_,52 / _loc3_),new Point(36 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(40 / _loc2_,52 / _loc3_),new Point(44 / _loc2_,64 / _loc3_));
         _loc4_.scaleX = 0.5;
         _loc4_.scaleY = 1.5;
         _loc4_.scaleZ = 0.5;
         _loc4_.x = 0.75;
         _loc4_.y = 0;
         _loc4_.setFaceVisible(Box3D.RIGHT,false);
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(1.3,0);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(52 / _loc2_,48 / _loc3_),new Point(56 / _loc2_,52 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(56 / _loc2_,48 / _loc3_),new Point(60 / _loc2_,52 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(52 / _loc2_,52 / _loc3_),new Point(56 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(60 / _loc2_,52 / _loc3_),new Point(64 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(48 / _loc2_,52 / _loc3_),new Point(52 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(56 / _loc2_,52 / _loc3_),new Point(60 / _loc2_,64 / _loc3_));
         _loc4_.scaleX = 0.6;
         _loc4_.scaleY = 1.6;
         _loc4_.scaleZ = 0.6;
         _loc4_.x = 0.75;
         _loc4_.y = 0;
         _loc4_.depthFactor = 8.2 / 8;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(1.3,0);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(4 / _loc2_,16 / _loc3_),new Point(8 / _loc2_,20 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(8 / _loc2_,16 / _loc3_),new Point(12 / _loc2_,20 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(4 / _loc2_,20 / _loc3_),new Point(8 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(12 / _loc2_,20 / _loc3_),new Point(16 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(8 / _loc2_,20 / _loc3_),new Point(12 / _loc2_,32 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(0 / _loc2_,20 / _loc3_),new Point(4 / _loc2_,32 / _loc3_));
         _loc4_.scaleX = 0.5;
         _loc4_.scaleY = 1.5;
         _loc4_.scaleZ = 0.5;
         _loc4_.x = -0.25;
         _loc4_.y = -1.5;
         _loc4_.setFaceVisible(Box3D.TOP,false);
         _loc4_.setFaceVisible(Box3D.LEFT,false);
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(-0.5,-2);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(4 / _loc2_,32 / _loc3_),new Point(8 / _loc2_,36 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(8 / _loc2_,32 / _loc3_),new Point(12 / _loc2_,36 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(4 / _loc2_,36 / _loc3_),new Point(8 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(12 / _loc2_,36 / _loc3_),new Point(16 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(8 / _loc2_,36 / _loc3_),new Point(12 / _loc2_,48 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(0 / _loc2_,36 / _loc3_),new Point(4 / _loc2_,48 / _loc3_));
         _loc4_.scaleX = 0.6;
         _loc4_.scaleY = 1.6;
         _loc4_.scaleZ = 0.6;
         _loc4_.x = -0.25;
         _loc4_.y = -1.5;
         _loc4_.depthFactor = 8.2 / 8;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(-0.5,-2);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(20 / _loc2_,48 / _loc3_),new Point(24 / _loc2_,52 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(24 / _loc2_,48 / _loc3_),new Point(28 / _loc2_,52 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(20 / _loc2_,52 / _loc3_),new Point(24 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(28 / _loc2_,52 / _loc3_),new Point(32 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(16 / _loc2_,52 / _loc3_),new Point(20 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(24 / _loc2_,52 / _loc3_),new Point(28 / _loc2_,64 / _loc3_));
         _loc4_.scaleX = 0.5;
         _loc4_.scaleY = 1.5;
         _loc4_.scaleZ = 0.5;
         _loc4_.x = 0.25;
         _loc4_.y = -1.5;
         _loc4_.setFaceVisible(Box3D.TOP,false);
         _loc4_.setFaceVisible(Box3D.RIGHT,false);
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(0.5,-2);
         (_loc4_ = new Box3D(param1)).setUv(Box3D.TOP,new Point(4 / _loc2_,48 / _loc3_),new Point(8 / _loc2_,52 / _loc3_));
         _loc4_.setUv(Box3D.BOTTOM,new Point(8 / _loc2_,48 / _loc3_),new Point(12 / _loc2_,52 / _loc3_),false,true);
         _loc4_.setUv(Box3D.FRONT,new Point(4 / _loc2_,52 / _loc3_),new Point(8 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.BACK,new Point(12 / _loc2_,52 / _loc3_),new Point(16 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.RIGHT,new Point(0 / _loc2_,52 / _loc3_),new Point(4 / _loc2_,64 / _loc3_));
         _loc4_.setUv(Box3D.LEFT,new Point(8 / _loc2_,52 / _loc3_),new Point(12 / _loc2_,64 / _loc3_));
         _loc4_.scaleX = 0.6;
         _loc4_.scaleY = 1.6;
         _loc4_.scaleZ = 0.6;
         _loc4_.x = 0.25;
         _loc4_.y = -1.5;
         _loc4_.depthFactor = 8.2 / 8;
         addChild(_loc4_);
         this.boxes.push(_loc4_);
         _loc4_.storeSplitPosition(0.5,-2);
      }
      
      public function joinBoxes() : *
      {
         var _loc1_:Box3D = null;
         for each(_loc1_ in this.boxes)
         {
            _loc1_.setToDefaultPosition();
         }
      }
      
      public function splitBoxes() : *
      {
         var _loc1_:Box3D = null;
         for each(_loc1_ in this.boxes)
         {
            _loc1_.setToSplitPosition();
         }
      }
   }
}
