package
{
   import flash.geom.Matrix3D;
   
   public class RenderState
   {
       
      
      public var screenHeight:uint;
      
      public var matrixStack:MatrixStack;
      
      public var screenWidth:uint;
      
      public var objects:Array;
      
      public function RenderState(param1:uint, param2:uint)
      {
         super();
         this.screenWidth = param1;
         this.screenHeight = param2;
         this.matrixStack = new MatrixStack();
      }
      
      public function get matrix() : Matrix3D
      {
         return this.matrixStack.matrix;
      }
      
      public function get worldMatrix() : Matrix3D
      {
         return this.matrixStack.worldMatrix;
      }
   }
}
