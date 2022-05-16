package
{
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class Layer implements IExternalizable
   {
      
      public static const PREMADE:uint = 0;
      
      public static const CUSTOM:uint = 1;
       
      
      public var opacity:uint;
      
      public var colorIntensity:uint;
      
      public var name:String;
      
      public var blendMode:String;
      
      public var selected:Boolean;
      
      public var offsetX:int;
      
      public var offsetY:int;
      
      public var hidden:Boolean;
      
      public var isNew:Boolean;
      
      public var tintColor:int;
      
      public var type:uint;
      
      public var linkedSprite:BitmapSprite;
      
      public var flattenColor:Boolean;
      
      public var invertX:Boolean;
      
      public var invertY:Boolean;
      
      public var index:uint;
      
      public var textureIntensity:uint;
      
      public var blur:uint;
      
      public var faded:Boolean;
      
      protected var i:int;
      
      protected var j:int;
      
      public var timeOfLastClick:uint;
      
      public function Layer()
      {
         super();
         this.hidden = false;
         this.opacity = 100;
         this.tintColor = ColorGrabber.DEFAULT_COLOR;
         this.offsetX = this.offsetY = 0;
         this.invertX = this.invertY = false;
         this.blendMode = BlendMode.NORMAL;
         this.timeOfLastClick = 0;
         this.colorIntensity = 100;
         this.textureIntensity = 100;
         this.blur = 0;
         this.flattenColor = false;
         this.linkedSprite = null;
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.name = param1.readUTF();
         this.hidden = param1.readBoolean();
         this.opacity = param1.readUnsignedInt();
         this.blendMode = param1.readUTF();
         this.tintColor = param1.readInt();
         this.offsetX = param1.readInt();
         this.offsetY = param1.readInt();
         this.invertX = param1.readBoolean();
         this.invertY = param1.readBoolean();
         this.colorIntensity = param1.readUnsignedInt();
         this.textureIntensity = param1.readUnsignedInt();
         this.blur = param1.readUnsignedInt();
         this.flattenColor = param1.readBoolean();
         this.index = param1.readUnsignedInt();
      }
      
      public function copyBaseProperties(param1:Layer) : *
      {
         param1.opacity = this.opacity;
         param1.tintColor = this.tintColor;
         param1.offsetX = this.offsetX;
         param1.offsetY = this.offsetY;
         param1.invertX = this.invertX;
         param1.invertY = this.invertY;
         param1.blendMode = this.blendMode;
         param1.colorIntensity = this.colorIntensity;
         param1.textureIntensity = this.textureIntensity;
         param1.blur = this.blur;
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         param1.writeUTF(this.name);
         param1.writeBoolean(this.hidden);
         param1.writeUnsignedInt(this.opacity);
         param1.writeUTF(this.blendMode);
         param1.writeInt(this.tintColor);
         param1.writeInt(this.offsetX);
         param1.writeInt(this.offsetY);
         param1.writeBoolean(this.invertX);
         param1.writeBoolean(this.invertY);
         param1.writeUnsignedInt(this.colorIntensity);
         param1.writeUnsignedInt(this.textureIntensity);
         param1.writeUnsignedInt(this.blur);
         param1.writeBoolean(this.flattenColor);
         param1.writeUnsignedInt(this.index);
      }
      
      public function getBitmapData() : BitmapData
      {
         return null;
      }
      
      public function copy() : Layer
      {
         return null;
      }
   }
}
