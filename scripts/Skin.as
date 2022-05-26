package
{
  import flash.display.BitmapData;
  import flash.geom.Rectangle;
  import flash.utils.ByteArray;
  import flash.utils.IExternalizable;
  import flash.utils.IDataInput;
  import flash.utils.IDataOutput;
  import flash.net.registerClassAlias;
  import com.adobe.images.PNGEncoder;
  
  public class Skin implements IExternalizable
  {
    public var name:String;
    public var baseBitmapData:BitmapData;
    public var tempLayer:Layer;
    public var layers:Vector.<Layer>;
    private var i:uint, j:uint;
    
    //for when the skin is shared
    public var shareName:String;
    public var shareDescription:String;
    public var shareTags:String;
    
    public function writeExternal(output:IDataOutput):void 
    {
      output.writeUTF(name);
      output.writeObject(layers);
      output.writeBytes(baseBitmapData.getPixels(baseBitmapData.rect));
      output.writeUTF(shareName);
      output.writeUTF(shareDescription);
      output.writeUTF(shareTags);
    }
    
    public function readExternal(input:IDataInput):void 
      {
      name = input.readUTF();
      layers = input.readObject();
      
      baseBitmapData = new BitmapData(Main.SKIN_WIDTH, Main.SKIN_HEIGHT);
      var pixelData:ByteArray = new ByteArray();
      input.readBytes(pixelData, 0, baseBitmapData.width * baseBitmapData.height * 4);
      baseBitmapData.setPixels(baseBitmapData.rect, pixelData);
      
      shareName = input.readUTF();
      shareDescription = input.readUTF();
      shareTags = input.readUTF();
      }
    
    public function Skin():void
    {
      registerClassAlias("Layer", Layer);
      registerClassAlias("PremadeLayer", PremadeLayer);
      registerClassAlias("CustomLayer", CustomLayer);
      registerClassAlias("Piece", Piece);
      registerClassAlias("BitmapSprite", BitmapSprite);
      registerClassAlias("Surface", Surface);
      
      layers = new Vector.<Layer>;
      name = "My Skin";
      
      shareName = "";
      shareDescription = "";
      shareTags = "";
    }
    
    public function addLayer(inLayer:Layer):void
    {
      //if there is an active layer selection, grab the top layer and put the new layer above it. otherwise just send to the top
      /*
      if(Main.layerSelection)
      {
        var highestLayerIndex:uint = Main.layerSelection.getTopLayer();
        layers.splice(highestLayerIndex+1, 0, inLayer);
      }
      else
      {
        layers.push(inLayer);
      }*/
      
      layers.push(inLayer);
      updateLayerIndicies();
      
      //show tut clip 2?
      Main.rootRef.checkForSecondTutorialClip();
      
      //if we now have two layers and the save file still has "firstLayer" set to true, set it to false and save
      if(layers.length == 2 && Utilities.saveFile.firstLayer)
      {
        Utilities.saveFile.firstLayer = false;
        Utilities.saveGame();
        Main.rootRef.mcTut2.visible = false;
      }
    }
    
    public function deleteLayer(inLayer:Layer):void
    {
      for(i = 0; i < layers.length; i++)
      {
        if(inLayer == layers[i])
        {
          if(inLayer is CustomLayer) CustomLayer(inLayer).customBitmapData.dispose();
          inLayer.linkedSprite = null;
          layers.splice(i,1);
          break;
        }
      }
      
      updateLayerIndicies();
    }
    
    public function moveLayerSelection(destinationBox:LayerBox):void
    {
      //make sure the layer selection is active, and that we have the correct destination box
      if(!Main.layerSelection) return;
      if(!destinationBox.eligibleForInsertion) return;
      
      //splice out the selection
      var lowestLayerSelectionIndex:uint = Main.layerSelection.getBottomLayer();
      var removedSection:Vector.<Layer> = layers.splice(lowestLayerSelectionIndex, Main.layerSelection.layers.length);
      
      //update indicies so that our destination layer has the correct index
      updateLayerIndicies();
      
      //figure out destination index
      var destinationIndex:uint;
      if(destinationBox.insertLocation == LayerBox.INSERT_TOP) destinationIndex = destinationBox.targetLayer.index + 1;
      else if(destinationBox.insertLocation == LayerBox.INSERT_BOTTOM) destinationIndex = destinationBox.targetLayer.index;
      
      //split the remaining layers vector in half, one for beginning and one for end
      var beginningChunk:Vector.<Layer> = layers.splice(0, destinationIndex);
      //trace("beginning " + beginningChunk.length);
      //trace("removed section " + removedSection.length);
      //trace("the rest "+layers.length);
      
      //concat the three chunks together
      var updatedLayers:Vector.<Layer> = beginningChunk.concat(removedSection);
      updatedLayers = updatedLayers.concat(layers);
      layers = updatedLayers;
      removedSection = null;
      updatedLayers = null;
      
      //update those indicies one last time
      updateLayerIndicies();
    }
    
    public function updateLayerIndicies():void
    {
      //loop through layers and make sure they know their own index
      for(i = 0; i < layers.length; i++)
      {
        layers[i].index = i;
      }
    }
    
    public function previewPiece(inPiece:Piece, inColor:uint=0xFF0000):void
    {
      //when showing something as a preview piece, we can only have one layer which is the piece itself
      while(layers.length > 0)
      {
        deleteLayer(layers[0]);
      }
      
      var newLayer:PremadeLayer = new PremadeLayer();
      newLayer.setPiece(inPiece.id);
      newLayer.tintColor = inColor;
      addLayer(newLayer);
      
      //also keep the base skin to a low alpha so they understand it's just a preview
      
    }
    
    public function cleanup():void
    {
      baseBitmapData.dispose();
      while(layers.length > 0)
      {
        deleteLayer(layers[0]);
      }
      layers = null;
    }
  }
}