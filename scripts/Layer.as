package
{
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.utils.ByteArray;
  import flash.net.registerClassAlias;
  import flash.display.BlendMode;
  import flash.utils.IExternalizable;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;
  
  public class Layer implements IExternalizable
  {
    //instance vars
    public var name:String;
    public var type:uint; //premade or custom
    public var isNew:Boolean; //used to determine the auto scroll after the layer is created
    public var hidden:Boolean;
    public var opacity:uint;
    public var blendMode:String;
    public var tintColor:int;
    public var offsetX:int;
    public var offsetY:int;
    public var invertX:Boolean;
    public var invertY:Boolean;
    public var colorIntensity:uint;
    public var textureIntensity:uint;
    public var blur:uint;
    public var flattenColor:Boolean;
    public var faded:Boolean; //this doesn't affect the layer, only for the layerbox to show we're dragging the layers
    public var index:uint; //our position in the layer list collection (used for ranges and moving)
    public var selected:Boolean; //whether or not our layer box should appear as selected
    
    protected var i:int;
    protected var j:int;
    
    public var linkedSprite:BitmapSprite; //the sprite in the preview box that corresponds to this layer
    public var timeOfLastClick:uint; //used with layer boxes for registering a double click
    
    public static const PREMADE:uint = 0;
    public static const CUSTOM:uint = 1;
    
    public function writeExternal(output:IDataOutput):void 
    {
      output.writeUTF(name);
      output.writeBoolean(hidden);
      output.writeUnsignedInt(opacity);
      output.writeUTF(blendMode);
      output.writeInt(tintColor);
      output.writeInt(offsetX);
      output.writeInt(offsetY);
      output.writeBoolean(invertX);
      output.writeBoolean(invertY);
      output.writeUnsignedInt(colorIntensity);
      output.writeUnsignedInt(textureIntensity);
      output.writeUnsignedInt(blur);
      output.writeBoolean(flattenColor);
      output.writeUnsignedInt(index);
    }
    
    public function readExternal(input:IDataInput):void
      {
      name = input.readUTF();
      hidden = input.readBoolean();
      opacity = input.readUnsignedInt();
      blendMode = input.readUTF();
      tintColor = input.readInt();
      offsetX = input.readInt();
      offsetY = input.readInt();
      invertX = input.readBoolean();
      invertY = input.readBoolean();
      colorIntensity = input.readUnsignedInt();
      textureIntensity = input.readUnsignedInt();
      blur = input.readUnsignedInt();
      flattenColor = input.readBoolean();
      index = input.readUnsignedInt();
      }
    
    public function Layer():void
    {
      hidden = false;
      opacity = 100;
      tintColor = ColorGrabber.DEFAULT_COLOR;
      offsetX = offsetY = 0;
      invertX = invertY = false;
      blendMode = BlendMode.NORMAL;
      timeOfLastClick = 0;
      colorIntensity = 100;
      textureIntensity = 100;
      blur = 0;
      flattenColor = false;
      linkedSprite = null;
    }
    
    //subclasses must implement this
    public function getBitmapData():BitmapData{return null;}
    
    public function copy():Layer
    {
      return null;
    }
    
    public function copyBaseProperties(inCopy:Layer)
    {
      inCopy.opacity = opacity;
      inCopy.tintColor = tintColor;
      inCopy.offsetX = offsetX;
      inCopy.offsetY = offsetY;
      inCopy.invertX = invertX;
      inCopy.invertY = invertY;
      inCopy.blendMode = blendMode;
      inCopy.colorIntensity = colorIntensity;
      inCopy.textureIntensity = textureIntensity;
      inCopy.blur = blur;
    }
  }
}