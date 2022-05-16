package
{
   import flash.geom.Vector3D;
   
   public class Vertex3D
   {
       
      
      public var position:Vector3D;
      
      public var transformedPosition:Vector3D;
      
      public function Vertex3D(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super();
         this.position = new Vector3D(param1,param2,param3);
      }
      
      public function transform(param1:RenderState) : void
      {
         var _loc2_:Number = NaN;
         this.transformedPosition = param1.matrix.transformVector(this.position);
         _loc2_ = 1 / this.transformedPosition.w;
         this.transformedPosition.project();
         this.transformedPosition.z = _loc2_;
         this.transformedPosition.x = (this.transformedPosition.x + 1) * param1.screenWidth / 2;
         this.transformedPosition.y = (1 - this.transformedPosition.y) * param1.screenHeight / 2;
      }
   }
}
