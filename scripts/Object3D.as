package
{
   import flash.display.Graphics;
   import flash.geom.Matrix3D;
   import flash.geom.Vector3D;
   
   public class Object3D
   {
      
      private static const ZERO:Vector3D = new Vector3D();
       
      
      private var _x:Number = 0;
      
      private var _z:Number = 0;
      
      private var _rotationX:Number = 0;
      
      private var _rotationY:Number = 0;
      
      private var _rotationZ:Number = 0;
      
      protected var _depthFactor:Number = 1;
      
      private var _depth:Number;
      
      protected var _matrixNeedsUpdate:Boolean;
      
      protected var _children:Vector.<Object3D>;
      
      protected var _vertices:Vector.<Vertex3D>;
      
      protected var _matrix:Matrix3D;
      
      protected var _triangles:Vector.<Triangle3D>;
      
      private var _scaleX:Number = 1.0;
      
      private var _scaleY:Number = 1.0;
      
      private var _scaleZ:Number = 1.0;
      
      private var _y:Number = 0;
      
      public function Object3D()
      {
         super();
         this._triangles = new Vector.<Triangle3D>();
         this._vertices = new Vector.<Vertex3D>();
         this._matrix = new Matrix3D();
         this._matrix.identity();
         this._children = new Vector.<Object3D>();
      }
      
      public function get z() : Number
      {
         return this._z;
      }
      
      public function addChild(param1:Object3D) : void
      {
         this._children.push(param1);
      }
      
      public function get depthFactor() : Number
      {
         return this._depthFactor;
      }
      
      public function get rotationX() : Number
      {
         return this._rotationX;
      }
      
      public function set scaleY(param1:Number) : void
      {
         this._scaleY = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function set scaleZ(param1:Number) : void
      {
         this._scaleZ = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function get rotationY() : Number
      {
         return this._rotationY;
      }
      
      public function set scaleX(param1:Number) : void
      {
         this._scaleX = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function get rotationZ() : Number
      {
         return this._rotationZ;
      }
      
      public function set rotationX(param1:Number) : void
      {
         this._rotationX = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function set rotationY(param1:Number) : void
      {
         this._rotationY = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function set rotationZ(param1:Number) : void
      {
         this._rotationZ = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function get matrix() : Matrix3D
      {
         return this._matrix;
      }
      
      public function get depth() : Number
      {
         return this._depth;
      }
      
      public function draw(param1:Graphics) : void
      {
         var _loc2_:Triangle3D = null;
         for each(_loc2_ in this._triangles)
         {
            _loc2_.draw(param1,this.scaleX);
         }
      }
      
      public function get scaleX() : Number
      {
         return this._scaleX;
      }
      
      public function get scaleY() : Number
      {
         return this._scaleY;
      }
      
      public function get scaleZ() : Number
      {
         return this._scaleZ;
      }
      
      public function set depthFactor(param1:Number) : void
      {
         this._depthFactor = param1;
      }
      
      public function set x(param1:Number) : void
      {
         this._x = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function set y(param1:Number) : void
      {
         this._y = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function transform(param1:RenderState) : void
      {
         var _loc2_:Vertex3D = null;
         var _loc3_:Triangle3D = null;
         var _loc4_:Object3D = null;
         if(this._matrixNeedsUpdate)
         {
            this._matrix.identity();
            this._matrix.appendScale(this._scaleX,this._scaleY,this._scaleZ);
            this._matrix.appendRotation(this._rotationY,Vector3D.Y_AXIS);
            this._matrix.appendRotation(this._rotationX,Vector3D.X_AXIS);
            this._matrix.appendRotation(this._rotationZ,Vector3D.Z_AXIS);
            this._matrix.appendTranslation(this._x,this._y,this._z);
            this._matrixNeedsUpdate = false;
         }
         param1.matrixStack.pushMatrix(this._matrix);
         for each(_loc2_ in this._vertices)
         {
            _loc2_.transform(param1);
         }
         param1.objects.push(this);
         this._depth = Number.POSITIVE_INFINITY;
         for each(_loc3_ in this._triangles)
         {
            if(_loc3_.vert0.transformedPosition.z < this._depth)
            {
               this._depth = _loc3_.vert0.transformedPosition.z;
            }
            if(_loc3_.vert1.transformedPosition.z < this._depth)
            {
               this._depth = _loc3_.vert1.transformedPosition.z;
            }
            if(_loc3_.vert2.transformedPosition.z < this._depth)
            {
               this._depth = _loc3_.vert2.transformedPosition.z;
            }
         }
         this._depth *= this._depthFactor;
         for each(_loc4_ in this._children)
         {
            _loc4_.transform(param1);
         }
         param1.matrixStack.popMatrix();
      }
      
      public function set z(param1:Number) : void
      {
         this._z = param1;
         this._matrixNeedsUpdate = true;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
   }
}
