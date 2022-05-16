package
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.TriangleCulling;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Triangle3D
   {
      
      private static var _dtVerts:Vector.<Number> = new Vector.<Number>();
      
      private static var _dtUvt:Vector.<Number> = new Vector.<Number>();
      
      private static var _dtIndices:Vector.<int> = Vector.<int>([0,1,2]);
       
      
      public var depth:Number;
      
      public var _flipX:Boolean;
      
      public var _flipY:Boolean;
      
      public var flipMatrix:Matrix;
      
      public var texture:BitmapData;
      
      public var vert1:Vertex3D;
      
      public var vert2:Vertex3D;
      
      public var vert0:Vertex3D;
      
      public var _texRect:Rectangle;
      
      public var uv0:Point;
      
      public var uv1:Point;
      
      public var uv2:Point;
      
      public var visible:Boolean = true;
      
      private var tempTex:BitmapData;
      
      public function Triangle3D(param1:Vertex3D, param2:Vertex3D, param3:Vertex3D)
      {
         super();
         this.vert0 = param1;
         this.vert1 = param2;
         this.vert2 = param3;
         this.uv0 = new Point();
         this.uv1 = new Point();
         this.uv2 = new Point();
      }
      
      public function draw(param1:Graphics, param2:Number) : void
      {
         if(!this.visible)
         {
            return;
         }
         _dtVerts[0] = this.vert0.transformedPosition.x;
         _dtVerts[1] = this.vert0.transformedPosition.y;
         _dtVerts[2] = this.vert1.transformedPosition.x;
         _dtVerts[3] = this.vert1.transformedPosition.y;
         _dtVerts[4] = this.vert2.transformedPosition.x;
         _dtVerts[5] = this.vert2.transformedPosition.y;
         _dtUvt[0] = this.uv0.x;
         _dtUvt[1] = this.uv0.y;
         _dtUvt[2] = this.vert0.transformedPosition.z;
         _dtUvt[3] = this.uv1.x;
         _dtUvt[4] = this.uv1.y;
         _dtUvt[5] = this.vert1.transformedPosition.z;
         _dtUvt[6] = this.uv2.x;
         _dtUvt[7] = this.uv2.y;
         _dtUvt[8] = this.vert2.transformedPosition.z;
         param1.beginBitmapFill(this.texture,null,false);
         param1.drawTriangles(_dtVerts,_dtIndices,_dtUvt,param2 < 0 ? TriangleCulling.NEGATIVE : TriangleCulling.POSITIVE);
         param1.endFill();
      }
      
      public function updateTexture(param1:BitmapData) : *
      {
         if(this._flipX || this._flipY)
         {
            if(!this.flipMatrix)
            {
               this.flipMatrix = new Matrix();
               this.flipMatrix.scale(!!this._flipX ? Number(-1) : Number(1),!!this._flipY ? Number(-1) : Number(1));
               this.flipMatrix.translate(!!this._flipX ? Number(this._texRect.width) : Number(0),!!this._flipY ? Number(this._texRect.height) : Number(0));
            }
            if(!this.tempTex)
            {
               this.tempTex = new BitmapData(this._texRect.width,this._texRect.height,true,0);
            }
            this.tempTex.copyPixels(param1,this._texRect,Box3D.ORIGIN);
            this.texture.fillRect(this.texture.rect,16777215);
            this.texture.draw(this.tempTex,this.flipMatrix);
         }
         else
         {
            this.texture.copyPixels(param1,this._texRect,Box3D.ORIGIN);
         }
      }
   }
}
