package
{
   import flash.display.BitmapData;
   import flash.utils.getDefinitionByName;
   
   public class PresetSkin
   {
       
      
      public var id:uint;
      
      public var textureLinkage:String;
      
      public var name:String;
      
      public function PresetSkin(param1:uint, param2:String, param3:String = "")
      {
         super();
         this.id = param1;
         this.name = param2;
         this.textureLinkage = param3;
      }
      
      public function getBitmapData() : BitmapData
      {
         var _loc1_:Object = null;
         if(this.textureLinkage == "")
         {
            _loc1_ = getDefinitionByName("preset_" + this.id);
         }
         else
         {
            _loc1_ = getDefinitionByName(this.textureLinkage);
         }
         return new _loc1_(Main.SKIN_WIDTH,Main.SKIN_HEIGHT) as BitmapData;
      }
   }
}
