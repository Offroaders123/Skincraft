package
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getDefinitionByName;
   
   public class Piece
   {
      
      public static var uniqueID:int = -1;
       
      
      public var canMove:Boolean;
      
      public var defaultView:uint;
      
      public var name:String;
      
      public var allowedSurfaces:Vector.<Surface>;
      
      public var tempSurface:Surface;
      
      public var id:uint;
      
      public var subcategory:uint;
      
      public var exportName:String;
      
      public function Piece(param1:String, param2:uint, param3:Array, param4:Boolean = true, param5:String = "")
      {
         var _loc6_:int = 0;
         super();
         this.id = this.generateUniqueID();
         this.name = param1;
         this.subcategory = param2;
         this.canMove = param4;
         this.exportName = this.name.split(" ").join("") + ".png";
         this.allowedSurfaces = new Vector.<Surface>();
         for each(_loc6_ in param3)
         {
            if(_loc6_ != -1)
            {
               this.allowedSurfaces.push(Main.getSurface(_loc6_));
            }
         }
         this.defaultView = this.allowedSurfaces[0].viewableFrom;
         if(param5 != "")
         {
            this.name = param5;
         }
      }
      
      public function generateUniqueID() : int
      {
         ++uniqueID;
         return uniqueID;
      }
      
      public function rectContains(param1:Rectangle, param2:*) : Boolean
      {
         if(param2.x <= param1.right && param2.x >= param1.left && (param2.y <= param1.bottom && param2.y >= param1.top))
         {
            return true;
         }
         return false;
      }
      
      public function surfacesContain(param1:Point, param2:String = "") : Boolean
      {
         for each(this.tempSurface in this.allowedSurfaces)
         {
            if(this.rectContains(this.tempSurface.sourceRect,param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function generateBitmapData() : BitmapData
      {
         var _loc1_:Class = getDefinitionByName(this.exportName) as Class;
         return Main.convertBmpdTo1_8(new _loc1_(64,32));
      }
   }
}
