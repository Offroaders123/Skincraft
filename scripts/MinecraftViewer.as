package
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.PerspectiveProjection;
   
   public class MinecraftViewer extends Sprite
   {
       
      
      private var _root:Object3D;
      
      private var _display:Shape;
      
      private var _prevMouseX:Number = 0;
      
      private var _prevMouseY:Number = 0;
      
      public var _canRotate:Boolean;
      
      private var _renderState:RenderState;
      
      private var _tempBox:Box3D;
      
      private var _model:MinecraftGuy;
      
      private var _t:Number = 0;
      
      public function MinecraftViewer(param1:BitmapData, param2:uint, param3:uint)
      {
         super();
         this._display = new Shape();
         addChild(this._display);
         this._renderState = new RenderState(param2,param3);
         var _loc4_:PerspectiveProjection;
         (_loc4_ = new PerspectiveProjection()).fieldOfView = 90;
         _loc4_.focalLength = 1;
         this._renderState.matrixStack.projectionMatrix = _loc4_.toMatrix3D();
         this._root = new Object3D();
         this._model = new MinecraftGuy(param1);
         this._model.z = 4;
         this._root.addChild(this._model);
         mouseEnabled = mouseChildren = false;
         this.setDefaultPosition();
      }
      
      public function setDefaultPosition(param1:Boolean = false) : void
      {
         this._model.rotationX = 0;
         this._model.rotationZ = 0;
         if(param1)
         {
            this._model.rotationY = -25 + int(Math.random() * 50);
         }
         else
         {
            this._model.rotationY = -25;
         }
         this.render();
      }
      
      public function mouseMove(param1:MouseEvent) : void
      {
         var _loc2_:Number = mouseX - this._prevMouseX;
         var _loc3_:Number = mouseY - this._prevMouseY;
         if(param1.buttonDown && this._canRotate)
         {
            this._model.rotationY -= _loc2_;
            this._model.rotationX -= _loc3_;
         }
         else
         {
            this._canRotate = false;
         }
         this._prevMouseX = mouseX;
         this._prevMouseY = mouseY;
         this.render();
      }
      
      public function render() : void
      {
         var _loc1_:Object3D = null;
         this._display.graphics.clear();
         this._t += 1 / 30;
         this._renderState.objects = [];
         this._root.transform(this._renderState);
         this._renderState.objects.sortOn("depth");
         for each(_loc1_ in this._renderState.objects)
         {
            _loc1_.draw(this._display.graphics);
         }
      }
      
      public function joinModel() : *
      {
         this._model.joinBoxes();
         this.render();
      }
      
      public function cleanup() : void
      {
         for each(this._tempBox in this._model.boxes)
         {
            this._tempBox.cleanup();
         }
         this._model.boxes = null;
      }
      
      public function updateSkin(param1:BitmapData) : void
      {
         for each(this._tempBox in this._model.boxes)
         {
            this._tempBox.updateTexture(param1);
         }
      }
      
      public function splitModel() : *
      {
         this._model.splitBoxes();
         this.render();
      }
      
      private function enterFrame(param1:Event) : void
      {
         this.render();
      }
   }
}
