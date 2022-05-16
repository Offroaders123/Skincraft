package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Box3D extends Object3D
   {
      
      private static const RECT:Rectangle = new Rectangle();
      
      public static var FACES:Vector.<uint>;
      
      public static const ORIGIN:Point = new Point();
      
      public static const LEFT:uint = 6;
      
      public static const FRONT:uint = 4;
      
      public static const BOTTOM:uint = 2;
      
      public static const TOP:uint = 0;
      
      public static const RIGHT:uint = 10;
      
      public static const BACK:uint = 8;
       
      
      private var splitY:Number;
      
      private var defaultHiddenFaces:Vector.<uint>;
      
      private var defaultX:Number;
      
      private var defaultY:Number;
      
      public var _tempTriangle:Triangle3D;
      
      public var _texture:BitmapData;
      
      private var splitX:Number;
      
      public function Box3D(param1:BitmapData)
      {
         super();
         if(!FACES)
         {
            FACES = new Vector.<uint>();
            FACES.push(TOP,BOTTOM,FRONT,LEFT,BACK,RIGHT);
         }
         this._texture = param1;
         _vertices.push(new Vertex3D(-0.5,-0.5,-0.5),new Vertex3D(0.5,-0.5,-0.5),new Vertex3D(0.5,-0.5,0.5),new Vertex3D(-0.5,-0.5,0.5),new Vertex3D(-0.5,0.5,-0.5),new Vertex3D(0.5,0.5,-0.5),new Vertex3D(0.5,0.5,0.5),new Vertex3D(-0.5,0.5,0.5),new Vertex3D(0,0,0));
         _triangles[TOP] = new Triangle3D(_vertices[7],_vertices[4],_vertices[6]);
         _triangles[TOP + 1] = new Triangle3D(_vertices[6],_vertices[4],_vertices[5]);
         _triangles[BOTTOM] = new Triangle3D(_vertices[0],_vertices[3],_vertices[1]);
         _triangles[BOTTOM + 1] = new Triangle3D(_vertices[1],_vertices[3],_vertices[2]);
         _triangles[FRONT] = new Triangle3D(_vertices[4],_vertices[0],_vertices[5]);
         _triangles[FRONT + 1] = new Triangle3D(_vertices[5],_vertices[0],_vertices[1]);
         _triangles[LEFT] = new Triangle3D(_vertices[5],_vertices[1],_vertices[6]);
         _triangles[LEFT + 1] = new Triangle3D(_vertices[6],_vertices[1],_vertices[2]);
         _triangles[BACK] = new Triangle3D(_vertices[6],_vertices[2],_vertices[7]);
         _triangles[BACK + 1] = new Triangle3D(_vertices[7],_vertices[2],_vertices[3]);
         _triangles[RIGHT] = new Triangle3D(_vertices[7],_vertices[3],_vertices[4]);
         _triangles[RIGHT + 1] = new Triangle3D(_vertices[4],_vertices[3],_vertices[0]);
      }
      
      public function storeSplitPosition(param1:Number, param2:Number) : *
      {
         var _loc3_:uint = 0;
         this.defaultX = x;
         this.defaultY = y;
         this.splitX = param1;
         this.splitY = param2;
         this.defaultHiddenFaces = new Vector.<uint>();
         for each(_loc3_ in FACES)
         {
            if(!_triangles[_loc3_].visible)
            {
               this.defaultHiddenFaces.push(_loc3_);
            }
         }
      }
      
      public function cleanup() : void
      {
         this._texture.dispose();
         this._texture = null;
         for each(this._tempTriangle in _triangles)
         {
            if(this._tempTriangle.texture)
            {
               this._tempTriangle.texture.dispose();
               this._tempTriangle.texture = null;
            }
            this._tempTriangle._texRect = null;
         }
         _triangles = null;
         _vertices = null;
         _children = null;
      }
      
      public function setUv(param1:uint, param2:Point, param3:Point, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc6_:Number = param3.x - param2.x;
         var _loc7_:Number = param3.y - param2.y;
         RECT.x = param2.x * this._texture.width;
         RECT.y = param2.y * this._texture.height;
         RECT.width = _loc6_ * this._texture.width;
         RECT.height = _loc7_ * this._texture.height;
         var _loc8_:BitmapData = new BitmapData(RECT.width,RECT.height,true,0);
         var _loc9_:Number = 0.5 / RECT.width;
         var _loc10_:Number = 0.5 / RECT.height;
         _triangles[param1].texture = _loc8_;
         _triangles[param1]._texRect = RECT.clone();
         _triangles[param1]._flipX = param4;
         _triangles[param1]._flipY = param5;
         _triangles[param1].uv0.x = 0 - _loc9_;
         _triangles[param1].uv0.y = 0 - _loc10_;
         _triangles[param1].uv1.x = 0 - _loc9_;
         _triangles[param1].uv1.y = 1 + _loc10_;
         _triangles[param1].uv2.x = 1 + _loc9_;
         _triangles[param1].uv2.y = 0 - _loc10_;
         _triangles[param1 + 1].texture = _loc8_;
         _triangles[param1 + 1]._texRect = RECT.clone();
         _triangles[param1 + 1]._flipX = param4;
         _triangles[param1 + 1]._flipY = param5;
         _triangles[param1 + 1].uv0.x = 1 + _loc9_;
         _triangles[param1 + 1].uv0.y = 0 - _loc10_;
         _triangles[param1 + 1].uv1.x = 0 - _loc9_;
         _triangles[param1 + 1].uv1.y = 1 + _loc10_;
         _triangles[param1 + 1].uv2.x = 1 + _loc9_;
         _triangles[param1 + 1].uv2.y = 1 + _loc10_;
      }
      
      public function setToSplitPosition() : *
      {
         var _loc1_:uint = 0;
         x = this.splitX;
         y = this.splitY;
         for each(_loc1_ in FACES)
         {
            this.setFaceVisible(_loc1_,true);
         }
      }
      
      public function updateTexture(param1:BitmapData) : void
      {
         var _loc2_:uint = 0;
         this._texture = param1;
         for each(_loc2_ in FACES)
         {
            _triangles[_loc2_].updateTexture(param1);
         }
      }
      
      public function setToDefaultPosition() : *
      {
         var _loc1_:uint = 0;
         x = this.defaultX;
         y = this.defaultY;
         for each(_loc1_ in this.defaultHiddenFaces)
         {
            this.setFaceVisible(_loc1_,false);
         }
      }
      
      public function setFaceVisible(param1:uint, param2:Boolean) : void
      {
         _triangles[param1].visible = param2;
         _triangles[param1 + 1].visible = param2;
      }
   }
}
