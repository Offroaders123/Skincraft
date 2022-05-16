package
{
   import flash.geom.Matrix3D;
   
   public class MatrixStack
   {
      
      private static const MAX_MATRICES:uint = 8;
       
      
      private var _curMatrix:uint = 0;
      
      private var _matrix:Matrix3D;
      
      private var _matrixStack:Vector.<Matrix3D>;
      
      private var _projectionMatrix:Matrix3D;
      
      public function MatrixStack()
      {
         this._matrix = new Matrix3D();
         super();
         this._matrixStack = new Vector.<Matrix3D>(MAX_MATRICES,true);
         var _loc1_:uint = 0;
         while(_loc1_ < MAX_MATRICES)
         {
            this._matrixStack[_loc1_] = new Matrix3D();
            _loc1_++;
         }
      }
      
      public function set projectionMatrix(param1:Matrix3D) : void
      {
         this._projectionMatrix = param1;
      }
      
      public function get matrix() : Matrix3D
      {
         return this._matrix;
      }
      
      public function popMatrix() : void
      {
         --this._curMatrix;
      }
      
      public function get projectionMatrix() : Matrix3D
      {
         return this._projectionMatrix;
      }
      
      public function get worldMatrix() : Matrix3D
      {
         return this._matrixStack[this._curMatrix];
      }
      
      public function pushMatrix(param1:Matrix3D) : void
      {
         ++this._curMatrix;
         this._matrixStack[this._curMatrix] = this._matrixStack[this._curMatrix - 1].clone();
         this._matrixStack[this._curMatrix].prepend(param1);
         this._matrix.rawData = this._matrixStack[this._curMatrix].rawData;
         this._matrix.append(this._projectionMatrix);
      }
   }
}
