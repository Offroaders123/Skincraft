package
{
  import com.adobe.protocols.dict.events.ConnectedEvent;
  import com.newgrounds.components.VoteBar;
  import fl.accessibility.CheckBoxAccImpl;
  import fl.containers.ScrollPane;
  import fl.controls.Button;
  import fl.controls.CheckBox;
  import fl.controls.ComboBox;
  import fl.controls.List;
  import fl.controls.Slider;
  import fl.controls.TextArea;
  import fl.controls.TextInput;
  import fl.events.ListEvent;
  import fl.events.SliderEvent;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Loader;
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.filters.BlurFilter;
  import flash.filters.GlowFilter;
  import flash.media.Sound;
  
  import flash.display.BlendMode;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;
  import flash.net.FileFilter;
  import flash.net.FileReference;
  import flash.text.TextField;
  import flash.ui.Mouse;
  import flash.utils.ByteArray;
  import fl.controls.ScrollPolicy;
  import flash.utils.getDefinitionByName;
  import flash.net.registerClassAlias;
  import flash.events.IOErrorEvent;
  
  import com.newgrounds.components.SaveBrowser;
  import com.newgrounds.components.MedalPopup;
  import com.newgrounds.API;
  import com.newgrounds.APIEvent;
  import com.newgrounds.Medal;
  import com.newgrounds.SaveQuery;
  
  public class Main extends MovieClip
  {
    public static var rootRef:Main;
    public static var stageRef:Stage;
    public static var GAME_WIDTH:uint;
    public static var GAME_HEIGHT:uint;
    public static var curSkin:Skin;
    public static var dummySkin:Skin; //used for previewing single layers
    public static var activeDialogBox:DialogBox;
    public static var newDialogBox:DialogBox;
    public static var importLimitBytes:uint;
    public static var importLimitKB:uint;
    public static var surfaces:Vector.<Surface>;
    public static var presetSkins:Vector.<PresetSkin>;
    public static var tempSurface:Surface;
    public static var categories:Array;
    public static var subcategories:Array;
    public static var tempCategory:Category;
    public static var tempSubcategory:Subcategory;
    public static var pieces:Array;
    public static var tempPiece:Piece;
    public static var tempLayer:Layer;
    public static var tempLayerBox:LayerBox;
    public static var tempPresetSkin:PresetSkin;
    public static var layerBoxes:Vector.<LayerBox>;
    public static var layerToDelete:Layer;
    public static var layerToEdit:Layer;
    public static var cursorMode:uint;
    public static var availableBlendModes:Array;
    public static var savedView:uint; //for the mc preview box
    public static var showAdvancedOptions:Boolean;
    public static var hasSeenAd:Boolean;
    public static var savedBG:uint;
    public static var i:int, j:int;
    public static var medalPopup:MedalPopup;
    public var ngIntro:MovieClip;
    public var txtTest:TextField;
    public var txtLoadingSkin:MovieClip;
    public var mcPreloader:MovieClip;
    public var btnSkincraftPack:MovieClip;
    
    public static var dragDelayFrames:uint;
    public static var dragStartX:Number;
    public static var dragStartY:Number;
    public static var listenForDrag:Boolean;
    
    //sfx
    public static var sfxBtnHover:Sound;
    public static var sfxBtnClick:Sound;
    
    //menus
    public var btnPresets:MovieClip;
    public var btnImportPNG:MovieClip;
    public var btnImportTXT:MovieClip;
    public var btnBrowseUploads:MovieClip;
    public var mcTankLogo:MovieClip;
    
    public var btnBackFromPresets:MovieClip;
    public var btnGoPreset:MovieClip;
    public var lstPresets:List;
    
    public var btnBrowse:MovieClip;
    public var btnBackFromImport:MovieClip;
    public var btnGoImport:MovieClip;
    public var importSourceContainer:Sprite;
    public var importSourceBitmap:Bitmap;
    public var importFileReference:FileReference;
    public var importLoader:Loader;
    
    public var btnBackFromBrowse:MovieClip;
    public var saveBrowser:SaveBrowser;
    public static var ngSaveFile:com.newgrounds.SaveFile;
    public static var preloadNGSaveFile:com.newgrounds.SaveFile;
    public var voteBar:VoteBar;
    public var btnSearch:MovieClip;
    public var btnClearSearch:MovieClip;
    public var mcSearchDialog:SearchDialog;
    
    //editor
    public var mcDirtBG:MovieClip;
    public var mcPanel:MovieClip;
    public var savedLayerScrollPosition:Number;
    public var editorFirstInit:Boolean;
    public var btnBackFromEditor:MovieClip;
    public var sourceContainer:Sprite;
    public var sourceBitmap:Bitmap;
    public var previewContainer:Sprite;
    public var btnExport:MovieClip;
    public var mcPreviewBox:PreviewBox;
    public var txtLayerCount:TextField;
    public var txtDescription:TextField;
    public var btnAddLayer:MovieClip;
    public var lstLayers:ScrollPane;
    public var txtSkinName:TextInput;
    public var mcLayerDialog:LayerDialog;
    public var mcExportDialog:ExportDialog;
    public var layerHolder:Sprite;
    public var btnCopyLayer:MovieClip;
    public var btnShowSelection:MovieClip;
    public var btnHideSelection:MovieClip;
    public var btnDeleteSelection:MovieClip;
    public var mcGroupIndicator:MovieClip;
    public static var layerSelection:LayerSelection;
    
    //tutorial
    public var mcTut1:MovieClip;
    public var mcTut2:MovieClip;
    
    //edit layer
    public var txtLayerName:TextInput;
    public var btnBackToLayers:MovieClip;
    public var sldOpacity:Slider;
    public var txtOpacityValue:TextField;
    public var colorGrabber:ColorGrabber;
    public var btnArrowUp:MovieClip, btnArrowRight:MovieClip, btnArrowDown:MovieClip, btnArrowLeft:MovieClip;
    public var chkInvertX:CheckBox;
    public var chkInvertY:CheckBox;
    public var btnAdvancedOptions:MovieClip;
    public var sldColorIntensity:Slider;
    public var sldTextureIntensity:Slider;
    public var txtColorIntensity:TextField;
    public var txtTextureIntensity:TextField;
    public var mcAdvancedLabels:MovieClip;
    public var sldBlur:Slider;
    public var txtBlurValue:TextField;
    public var chkFlattenColor:CheckBox;
    public var mcNotAvailable:MovieClip;
    public var mcMovementExtra:MovieClip;
    
    //edit custom layer
    public var pixelEditor:PixelEditor;
    public var btnPencil:MovieClip;
    public var btnEraser:MovieClip;
    public var btnBucket:MovieClip;
    public var btnUndo:MovieClip;
    public var mcToolFollow:MovieClip;
    public var chkShowBase:CheckBox;
    public var cmbEditorView:ComboBox;
    public var txtSurfaceName:TextField;
    public var txtSpecialMessage:TextField;
    public var mcLabelBlur:MovieClip;
    public var mcLabelOpacity:MovieClip;
    public var cmbBlendModes:ComboBox;
    public var mcShiftMessage:MovieClip;
    public static var curTool:uint;
    
    //consts
    public static const SKIN_WIDTH:uint = 64;
    public static const SKIN_HEIGHT:uint = 32;
    public static const MAX_LAYERS:uint = 50;
    public static const MAX_LAYER_NAME_LENGTH:uint = 30;
    public static const UP:uint = 0; //these are used for changing the arrow
    public static const DOWN:uint = 1;
    public static const LEFT:uint = 2;
    public static const RIGHT:uint = 3;
    public static const CURSOR_FREE:uint = 0;
    public static const CURSOR_DRAG:uint = 1;
    public static const CURSOR_DRAW:uint = 2;
    public static const TOOL_NONE:uint = 0;
    public static const TOOL_PENCIL:uint = 1;
    public static const TOOL_ERASER:uint = 2;
    public static const TOOL_BUCKET:uint = 3;
    public static const TOOL_EYEDROPPER:uint = 4;
    
    public function Main():void
    {			
      //stop on first frame, let preloader take over, set main vars
      stop();
      rootRef = this;
      stageRef = stage;
      GAME_WIDTH = stage.stageWidth;
      GAME_HEIGHT = stage.stageHeight;
      importLimitKB = 50;
      importLimitBytes = importLimitKB * 1024;
      tabEnabled = tabChildren = false;
      hasSeenAd = false;
      savedBG = 1;
      txtLoadingSkin.visible = false;
      
      mcTankLogo.buttonMode = true;
      mcTankLogo.addEventListener(MouseEvent.CLICK, clickTank);
      
      Utilities.mc2Btn(btnSkincraftPack);
      btnSkincraftPack.addEventListener(MouseEvent.CLICK, clickSkincraftPack);
      
      //if on kongregate, set seen ad to true
      var siteURL:String = loaderInfo.loaderURL;
      var adFreeSites:RegExp = /(kongregate|addictinggames)/i;
      //if(siteURL.search(adFreeSites) == -1) adSwitcher.nextFrame();
      if(siteURL.match(adFreeSites)) hasSeenAd = true;
      
      registerClassAlias("Skin", Skin);
      registerClassAlias("Layer", Layer);
      registerClassAlias("PremadeLayer", PremadeLayer);
      registerClassAlias("CustomLayer", CustomLayer);
      registerClassAlias("Piece", Piece);
      
      //context menu and bounds
      Utilities.setRefs(this, stage);
      contextMenu = Utilities.generateContextMenu();
      addChild(Utilities.createOutsideBounds(GAME_WIDTH, GAME_HEIGHT));
      
      Utilities.loadSharedObject("SKINCRAFT");
      //Utilities.createNewSaveFile();
      
      //create stuff
      createPresetSkins();
      createSurfaces();
      createCategories();
      
      //pieces are done in separate file
      pieces = new Array();
      include "create_pieces.as";
      //pieces.push(new Piece("Hair 1", Subcategory.HAIR, new Array(Surface.HEAD_FRONT,-1), false ));
      pieces.sortOn("name");
      
      //blend modes
      availableBlendModes = new Array(BlendMode.NORMAL, BlendMode.OVERLAY, BlendMode.MULTIPLY, BlendMode.SCREEN);
      
      //start up key manager and global tick
      KeyManager.init();
      addEventListener(Event.ENTER_FRAME, tick);
      
      //set up listener for mouse up and lose focus to assist with layer dragging
      stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
      stage.addEventListener(Event.DEACTIVATE, gameLoseFocus);
      
      //default saved view
      savedView = PreviewBox.VIEW_FRONT;
      
      //keep a medal popup handy on the stage
      medalPopup = new MedalPopup();
      medalPopup.x = 225;
      medalPopup.y = 318;
      addChild(medalPopup);
      
      //listen for the load
      addEventListener(Event.ENTER_FRAME, listenForLoad);
      
      //sound objects
      sfxBtnClick = new button_click();
      sfxBtnHover = new button_hover();
    }
    
    public function listenForLoad(e:Event):void
    {
      if(framesLoaded == totalFrames)
      {
        removeEventListener(Event.ENTER_FRAME, listenForLoad);
        
        //if(true)
        if(loaderInfo.parameters.NewgroundsAPI_SaveFileID)
        {
          mcPreloader.visible = false;
          txtLoadingSkin.visible = true;
          addEventListener(Event.ENTER_FRAME, listenForAPIConnected);
        }
      }
    }
    
    public function listenForAPIConnected(e:Event):void
    {
      if(API.connected)
      {
        removeEventListener(Event.ENTER_FRAME, listenForAPIConnected);
        API.loadSaveFile(loaderInfo.parameters.NewgroundsAPI_SaveFileID);
        //API.loadSaveFile(54680);
        API.addEventListener(APIEvent.FILE_LOADED, preskinLoaded);
      }
    }
    
    public function preskinLoaded(event:APIEvent) 
    {
      if(event.success) 
      {
        //this is for taking it to the browse/vote area
        preloadNGSaveFile = com.newgrounds.SaveFile(event.data);
        gotoAndStop("browse", "menu");
        
        /* this is for taking a preloaded skin to the editor
        curSkin = new Skin();
        curSkin.baseBitmapData = BitmapData(preloadNGSaveFile.data);
        editorFirstInit = true;
        gotoAndStop("edit_main", "editor");
        */
      }
      
      API.removeEventListener(APIEvent.FILE_LOADED, preskinLoaded);
    }
    
    public function clickTank(e:MouseEvent):void
    {
      Utilities.clickLink("http://newgrounds.com");
    }
    
    public function clickSkincraftPack(e:MouseEvent):void
    {
      Utilities.clickLink("http://afro-ninja.com/skincraft");
    }
    
    public function tick(e:Event):void
    {
      KeyManager.detectKeys();
      
      //listening to start drag?
      if(listenForDrag)
      {
        dragDelayFrames++;
        
        if(dragDelayFrames > 7 && (mouseX != dragStartX || mouseY != dragStartY))
        {
          listenForDrag = false;
          dragLayerSelection();
          stage.focus = null;
        }
      }
      
      //actually dragging?
      if(cursorMode == CURSOR_DRAG)
      {
        //auto scroll the layer list
        if(lstLayers && lstLayers.hitTestPoint(mouseX,mouseY))
        {
          if(lstLayers.mouseY < 25) lstLayers.verticalScrollPosition -= 5;
          else if(lstLayers.mouseY > lstLayers.height - 25) lstLayers.verticalScrollPosition += 5;
        }
        
        //move the layer group indication box with the mouse
        mcGroupIndicator.x = mouseX;
        mcGroupIndicator.y = mouseY;
      }
      
      //special functionality for pixel editor
      if(currentLabel == "edit_custom_layer")
      {
        //hide the mouse if it's over top of the editor window and we have a tool
        if(pixelEditor && curTool != TOOL_NONE && curTool != TOOL_EYEDROPPER)
        {
          if(pixelEditor.hitTestPoint(mouseX, mouseY)){
            //Mouse.hide();
            mcToolFollow.visible = true;
          }
          else {
            //Mouse.show();
            mcToolFollow.visible = false;
          }
        }
        
        //if they pressed z, attempt an undo
        if(KeyManager.singlePress(KeyManager.LTR_Z))
        {
          pixelEditor.undo();
        }
      }
      
      //tool always follows the mouse
      if(mcToolFollow)
      {
        mcToolFollow.x = mouseX;
        mcToolFollow.y = mouseY;
      }
      
      //if in the main editor, listen for a ctrl+a for select all
      return;
      if(currentLabel == "edit_main")
      {
        if(KeyManager.pressingCTRL)
        {
          if(KeyManager.singlePress(KeyManager.LTR_A))
          {
            selectAllLayers();
            updateLayers();
          }
        }
      }
    }
    
    //mouse up is used for detecting layer drag
    public function mouseUp(e:MouseEvent):void
    {
      //cancel drag listen, see if we have a selection to change
      listenForDrag = false;
      if(cursorMode == CURSOR_DRAG)
      {
        //is there a layer box that is eligible for insertion?
        var boxEligibleForInsertion:LayerBox = null;
        for each(tempLayerBox in layerBoxes)
        {
          if(tempLayerBox.eligibleForInsertion)
          {
            boxEligibleForInsertion = tempLayerBox;
            break;
          }
        }
        
        //if so, move the selection.
        if(boxEligibleForInsertion)
        {
          //move, update layers, update layer range (layer indexes have change)
          curSkin.moveLayerSelection(boxEligibleForInsertion);
          updateLayers();
          layerSelection.setRange(layerSelection.range);
        }
        
        //stop the drag regardless, this will reset everything
        stopDragLayerSelection();
      }
      
      //if we were drawing, cancel it
      if(cursorMode == CURSOR_DRAW) cursorMode = CURSOR_FREE;
      
      //always try to hide the "shift for straight lines" message if it exists
      if(mcShiftMessage) mcShiftMessage.visible = false;
    }
    
    public function gameLoseFocus(e:Event):void
    {
      //cancel the drag
      listenForDrag = false;
      if(cursorMode == CURSOR_DRAG)
      {
        stopDragLayerSelection();
      }
      
      //if we were drawing, cancel it
      if(cursorMode == CURSOR_DRAW) cursorMode = CURSOR_FREE;
      
      //cancel all keys
      KeyManager.releaseAllKeys();
    }
    
    public function startListeningForGroupDrag():void
    {
      dragDelayFrames = 0;
      dragStartX = mouseX;
      dragStartY = mouseY;
      listenForDrag = true;
    }
    
    public function finishLoadScreen():void
    {
      /*
      ngIntro.stop();
      transitionToMenu();
      return;*/
      
      stop();
      ngIntro.buttonMode = true;
      ngIntro.mouseChildren = false;
      ngIntro.addEventListener(MouseEvent.CLICK, clickNgIntro);
    }
    
    public function clickNgIntro(e:MouseEvent):void
    {
      Utilities.clickLink("http://newgrounds.com");
    }
    
    public function transitionToMenu():void
    {
      gotoAndStop("main","menu");
    }
    
    public function createPresetSkins():void 
    {
      presetSkins = new Vector.<PresetSkin>;
      presetSkins.push(new PresetSkin(0, "Blank"));
      presetSkins.push(new PresetSkin(1, "Minecraft Guy"));
      presetSkins.push(new PresetSkin(2, "Skin 1"));
      presetSkins.push(new PresetSkin(3, "Skin 2"));
      presetSkins.push(new PresetSkin(4, "Skin 3"));
      presetSkins.push(new PresetSkin(5, "Robot"));
    }
    
    public function createSurfaces():void
    {
      surfaces = new Vector.<Surface>;
      surfaces.push(new Surface(Surface.HEAD_LEFT, "Head Left", new Rectangle(0,8,8,8), PreviewBox.VIEW_LEFT));
      surfaces.push(new Surface(Surface.HEAD_FRONT, "Head Front", new Rectangle(8,8,8,8), PreviewBox.VIEW_FRONT));
      surfaces.push(new Surface(Surface.HEAD_RIGHT, "Head Right", new Rectangle(16,8,8,8), PreviewBox.VIEW_RIGHT));
      surfaces.push(new Surface(Surface.HEAD_BACK, "Head Back", new Rectangle(24,8,8,8), PreviewBox.VIEW_BACK));
      surfaces.push(new Surface(Surface.HEAD_TOP, "Head Top", new Rectangle(8,0,8,8), PreviewBox.VIEW_TOP));
      surfaces.push(new Surface(Surface.HEAD_BOTTOM, "Head Bottom", new Rectangle(16,0,8,8), PreviewBox.VIEW_BOTTOM));
      
      surfaces.push(new Surface(Surface.ARM_LEFT, "Arm Outside", new Rectangle(40,20,4,12), PreviewBox.VIEW_LEFT));
      surfaces.push(new Surface(Surface.ARM_FRONT, "Arm Front", new Rectangle(44,20,4,12), PreviewBox.VIEW_FRONT));
      surfaces.push(new Surface(Surface.ARM_RIGHT, "Arm Inside", new Rectangle(48,20,4,12), PreviewBox.VIEW_RIGHT));
      surfaces.push(new Surface(Surface.ARM_BACK, "Arm Back", new Rectangle(52,20,4,12), PreviewBox.VIEW_BACK));
      surfaces.push(new Surface(Surface.ARM_TOP, "Arm Top", new Rectangle(44,16,4,4), PreviewBox.VIEW_TOP));
      surfaces.push(new Surface(Surface.ARM_BOTTOM, "Arm Bottom", new Rectangle(48,16,4,4), PreviewBox.VIEW_BOTTOM));
      
      surfaces.push(new Surface(Surface.BODY_LEFT, "Body Left", new Rectangle(16,20,4,12), PreviewBox.VIEW_LEFT));
      surfaces.push(new Surface(Surface.BODY_FRONT, "Body Front", new Rectangle(20,20,8,12), PreviewBox.VIEW_FRONT));
      surfaces.push(new Surface(Surface.BODY_RIGHT, "Body Right", new Rectangle(28,20,4,12), PreviewBox.VIEW_RIGHT));
      surfaces.push(new Surface(Surface.BODY_BACK, "Body Back", new Rectangle(32,20,8,12), PreviewBox.VIEW_BACK));
      surfaces.push(new Surface(Surface.BODY_TOP, "Body Top", new Rectangle(20,16,8,4), PreviewBox.VIEW_TOP));
      surfaces.push(new Surface(Surface.BODY_BOTTOM, "Body Bottom", new Rectangle(28,16,8,4), PreviewBox.VIEW_BOTTOM));
      
      surfaces.push(new Surface(Surface.LEG_LEFT, "Leg Outside", new Rectangle(0,20,4,12), PreviewBox.VIEW_LEFT));
      surfaces.push(new Surface(Surface.LEG_FRONT, "Leg Front", new Rectangle(4,20,4,12), PreviewBox.VIEW_FRONT));
      surfaces.push(new Surface(Surface.LEG_RIGHT, "Leg Inside", new Rectangle(8,20,4,12), PreviewBox.VIEW_RIGHT));
      surfaces.push(new Surface(Surface.LEG_BACK, "Leg Back", new Rectangle(12,20,4,12), PreviewBox.VIEW_BACK));
      surfaces.push(new Surface(Surface.LEG_TOP, "Leg Top", new Rectangle(4,16,4,4), PreviewBox.VIEW_TOP));
      surfaces.push(new Surface(Surface.LEG_BOTTOM, "Leg Bottom", new Rectangle(8,16,4,4), PreviewBox.VIEW_BOTTOM));
      
      surfaces.push(new Surface(Surface.HAT_LEFT, "Hat Left", new Rectangle(32,8,8,8), PreviewBox.VIEW_LEFT));
      surfaces.push(new Surface(Surface.HAT_FRONT, "Hat Front", new Rectangle(40,8,8,8), PreviewBox.VIEW_FRONT));
      surfaces.push(new Surface(Surface.HAT_RIGHT, "Hat Right", new Rectangle(48,8,8,8), PreviewBox.VIEW_RIGHT));
      surfaces.push(new Surface(Surface.HAT_BACK, "Hat Back", new Rectangle(56,8,8,8), PreviewBox.VIEW_BACK));
      surfaces.push(new Surface(Surface.HAT_TOP, "Hat Top", new Rectangle(40,0,8,8), PreviewBox.VIEW_TOP));
      surfaces.push(new Surface(Surface.HAT_BOTTOM, "Hat Bottom", new Rectangle(48,0,8,8), PreviewBox.VIEW_BOTTOM));
    }
    
    public function createCategories():void
    {
      //main categories
      categories = new Array();
      categories.push(new Category(Category.HEAD, "Head"));
      categories.push(new Category(Category.UPPER_BODY, "Upper Body"));
      categories.push(new Category(Category.LOWER_BODY, "Lower Body"));
      categories.push(new Category(Category.FULL, "Full Character"));
      
      //categories.sortOn("name");
      
      //sub categories
      subcategories = new Array();
      subcategories.push(new Subcategory(Subcategory.FACE, "Face", Category.HEAD));
      subcategories.push(new Subcategory(Subcategory.HAIR, "Hair", Category.HEAD));
      subcategories.push(new Subcategory(Subcategory.HATS_AND_MASKS, "Hats and Masks", Category.HEAD));
      subcategories.push(new Subcategory(Subcategory.GLASSES, "Glasses", Category.HEAD));
      subcategories.push(new Subcategory(Subcategory.ACCESSORY_HEAD, "Accessories", Category.HEAD));
      //subcategories.push(new Subcategory(Subcategory.HEAD_SHAPES, "Shapes", Category.HEAD));
      
      subcategories.push(new Subcategory(Subcategory.SHIRTS_AND_TIES, "Shirts and Tops", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.COATS, "Coats", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.GLOVES, "Gloves", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.TUNICS, "Tunics", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.CAPES, "Capes and Cloaks", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.BELTS, "Belts", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.PACKS, "Packs", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.SYMBOLS, "Symbols", Category.UPPER_BODY));
      subcategories.push(new Subcategory(Subcategory.ACCESSORY_UPPER, "Accessories", Category.UPPER_BODY));
      
      subcategories.push(new Subcategory(Subcategory.PANTS, "Pants and Bottoms", Category.LOWER_BODY));
      subcategories.push(new Subcategory(Subcategory.SHOES, "Shoes", Category.LOWER_BODY));
      subcategories.push(new Subcategory(Subcategory.SKIRTS, "Skirts", Category.LOWER_BODY));
      subcategories.push(new Subcategory(Subcategory.ACCESSORY_LOWER, "Accessories", Category.LOWER_BODY));
      
      subcategories.push(new Subcategory(Subcategory.TEXTURES, "Textures", Category.FULL));
      
      //subcategories.sortOn("name");
    }
    
    public static function getSurface(surfaceID:uint):Surface
    {
      for each(tempSurface in surfaces)
      {
        if(tempSurface.id == surfaceID) return tempSurface;
      }
      return null;
    }
    
    public static function getCategory(categoryID:uint):Category
    {
      for each(tempCategory in categories)
      {
        if(tempCategory.id == categoryID) return tempCategory;
      }
      return null;
    }
    
    public static function getSubcategory(subcategoryID:uint):Subcategory
    {
      for each(tempSubcategory in subcategories)
      {
        if(tempSubcategory.id == subcategoryID) return tempSubcategory;
      }
      return null;
    }
    
    public static function getPiece(pieceID:uint):Piece
    {
      for each(tempPiece in pieces)
      {
        if(tempPiece.id == pieceID) return tempPiece;
      }
      return null;
    }
    
    public static function getPresetSkin(skinID:uint):PresetSkin
    {
      for each(tempPresetSkin in presetSkins)
      {
        if(tempPresetSkin.id == skinID) return tempPresetSkin;
      }
      return null;
    }
    
/**************************************************************************************************************
 *  MENUS
 * ***********************************************************************************************************/

    //MAIN MENU
    public function initMenuMain():void
    {
      //API.debugMode = API.DEBUG_MODE_LOGGED_IN;
      mcTankLogo.buttonMode = true;
      mcTankLogo.addEventListener(MouseEvent.CLICK, clickTank);
      
      btnPresets.addEventListener(MouseEvent.CLICK, press_btnPresets);
      btnImportPNG.addEventListener(MouseEvent.CLICK, press_btnImportPNG);
      btnImportTXT.addEventListener(MouseEvent.CLICK, press_btnImportTXT);
      btnBrowseUploads.addEventListener(MouseEvent.CLICK, press_btnBrowseUploads);
      
      Utilities.mc2Btn(btnPresets);
      Utilities.mc2Btn(btnImportPNG);
      Utilities.mc2Btn(btnImportTXT);
      Utilities.mc2Btn(btnBrowseUploads);
    }
    
    public function cleanupMenuMain():void
    {
      mcTankLogo.removeEventListener(MouseEvent.CLICK, clickTank);
      
      btnPresets.removeEventListener(MouseEvent.CLICK, press_btnPresets);
      btnImportPNG.removeEventListener(MouseEvent.CLICK, press_btnImportPNG);
      btnImportTXT.removeEventListener(MouseEvent.CLICK, press_btnImportTXT);
      
      Utilities.cleanupMCBtn(btnPresets);
      Utilities.cleanupMCBtn(btnImportPNG);
      Utilities.cleanupMCBtn(btnImportTXT);
      Utilities.cleanupMCBtn(btnBrowseUploads);
    }
    
    public function genericMouseOver(e:MouseEvent):void { sfxBtnHover.play(); MovieClip(e.currentTarget).gotoAndStop(2); }
    public function genericMouseOut(e:MouseEvent):void{MovieClip(e.currentTarget).gotoAndStop(1);}
    
    public function press_btnPresets(e:MouseEvent):void
    {
      cleanupMenuMain();
      gotoAndStop("presets","menu");
    }
    
    public function press_btnImportPNG(e:MouseEvent):void
    {
      cleanupMenuMain();
      gotoAndStop("import_png","menu");
    }
    
    public function press_btnImportTXT(e:MouseEvent):void
    {
      cleanupMenuMain();
      gotoAndStop("import_txt","menu");
    }
    
    public function press_btnBrowseUploads(e:MouseEvent):void
    {
      //make sure they're connected to the api
      if(!API.connected)
      {
        generateOKDialog("You are not connected to the Newgrounds API");
        return;
      }
      
      cleanupMenuMain();
      gotoAndStop("browse","menu");
    }
    
/**************************************************************************************************************
 *  PRESETS MENU
 * ***********************************************************************************************************/

    public function initMenuPresets():void
    {
      //load preview box
      loadPreviewBox(355,63);
      
      //populate from vector of presets
      for each(var presetSkin:PresetSkin in presetSkins)
      {
        lstPresets.addItem({label:presetSkin.name, data:presetSkin.id});
      }
      
      lstPresets.selectedIndex = 0;
      lstPresets.addEventListener(Event.CHANGE, showCurPreset);
      lstPresets.addEventListener(ListEvent.ITEM_DOUBLE_CLICK, doubleClickPreset);
      lstPresets.doubleClickEnabled = true;
      showCurPreset();
      
      btnGoPreset.buttonMode = true;
      btnGoPreset.addEventListener(MouseEvent.CLICK, press_btnGoPreset);
      Utilities.mc2Btn(btnBackFromPresets);
      btnBackFromPresets.addEventListener(MouseEvent.CLICK, press_btnBackFromPresets);
    }
    
    public function doubleClickPreset(e:ListEvent):void
    {
      press_btnGoPreset(null);
    }
    
    public function showCurPreset(e:Event=null):void
    {
      savedView = PreviewBox.VIEW_FRONT;
      var curSkin:PresetSkin = getPresetSkin(lstPresets.selectedItem.data);
      mcPreviewBox.loadBase(curSkin.getBitmapData());
      mcPreviewBox.refreshView();
    }
    
    public function press_btnBackFromPresets(e:MouseEvent):void
    {
      cleanupMenuPresets();
      gotoAndStop("main","menu");
    }
    
    public function press_btnGoPreset(e:MouseEvent):void
    {
      //grab the bitmapdata that's in the preview box
      curSkin = new Skin();
      curSkin.baseBitmapData = mcPreviewBox.sourceBitmapData.clone();
      editorFirstInit = true;
      
      cleanupMenuPresets();
      sfxBtnClick.play();
      gotoAndStop("edit_main","editor");
    }
    
    public function cleanupMenuPresets():void
    {
      //mcPreviewBox.cleanup();
      unloadPreviewBox();
      lstPresets.removeEventListener(Event.CHANGE, showCurPreset);
      lstPresets.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK, doubleClickPreset);
      btnGoPreset.removeEventListener(MouseEvent.CLICK, press_btnGoPreset);
      btnBackFromPresets.removeEventListener(MouseEvent.CLICK, press_btnBackFromPresets);
    }
    
/**************************************************************************************************************
 *  IMPORT PNG MENU
 * ***********************************************************************************************************/

    public function initMenuImportPNG():void
    {
      btnGoImport.buttonMode = true;
      btnGoImport.addEventListener(MouseEvent.CLICK, press_btnGoImport);
      disableImportGo();
      
      btnBackFromImport.buttonMode = true;
      btnBackFromImport.addEventListener(MouseEvent.CLICK, press_btnBackFromImport);
      
      btnBrowse.addEventListener(MouseEvent.CLICK, press_btnBrowse);
      btnBrowse.buttonMode = true;
      importFileReference = new FileReference();
      importFileReference.addEventListener(Event.SELECT, referenceBrowse);
      importFileReference.addEventListener(Event.COMPLETE, referenceLoaded);
      importFileReference.addEventListener(IOErrorEvent.IO_ERROR, ioError);
      
      importLoader = new Loader();
      importLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoaded);
    }
    
    public function press_btnBrowse(e:MouseEvent):void
    {
      var fileFilters:Array = new Array();
      if(currentLabel == "import_png")
      {
        var pngFilter:FileFilter = new FileFilter("PNG Images", "*.png");
        fileFilters.push(pngFilter);
      }
      else if(currentLabel == "import_txt")
      {
        var txtFilter:FileFilter = new FileFilter("Text Files", "*.txt");
        fileFilters.push(txtFilter);
      }
      
      try
      {
        importFileReference.browse(fileFilters);
      }
      catch(e:Error)
      {
        generateOKDialog("There was an error opening the file window");
      }
    }
    
    public function referenceBrowse(e:Event):void 
    {
      //file was selected. check file type and size here
      /*
      if(currentLabel == "import_png" && importFileReference.type != ".png")
      {
        generateOKDialog("File must be of type .png");
        return;
      }
      else if(currentLabel =="import_txt" && importFileReference.type != ".txt")
      {
        generateOKDialog("File must be of type .txt");
        return;
      }
      */
      //txtTest.text = "extension: " + importFileReference.type;
      
      if(importFileReference.size > importLimitBytes)
      {
        generateOKDialog("Filesize cannot exceed "+importLimitKB+"kb ("+importLimitBytes+" bytes)");
        return;
      }
      
      disableImportGo();
      disableBack();
      
      //load it
      try{
        importFileReference.load();
      }
      catch(e:Error)
      {
        ioError(null);
      }
    }
    
    public function referenceLoaded(e:Event):void
    {	
      //get it with a loader
      importLoader.unload();
      try{
        importLoader.loadBytes(importFileReference.data);
      }
      catch(e:Error)
      {
        ioError(null);
      }
    }
    
    public function fileLoaded(e:Event):void
    {
      //cleanup any existing preview regardless, re-enable the back button
      enableBack();
      
      //now fully loaded! check width and height first
      if(importLoader.width != SKIN_WIDTH || importLoader.height != SKIN_HEIGHT)
      {
        generateOKDialog("PNG must be exactly "+SKIN_WIDTH+"x"+SKIN_HEIGHT);
        return;
      }
      
      //checks out, continue with import/display
      try
      {
        var importBitmap:Bitmap = importLoader.content as Bitmap;
        savedView = PreviewBox.VIEW_FRONT;
        mcPreviewBox.loadBase(importBitmap.bitmapData);
      }
      catch(e:Error)
      {
        ioError(null);
        return;
      }
      
      //refresh view and let them proceed
      mcPreviewBox.refreshView();
      enableImportGo();
    }
    
    public function press_btnBackFromImport(e:MouseEvent):void
    {
      if(currentLabel == "import_png") cleanupMenuImportPNG();
      else if(currentLabel == "import_txt")
      {
        if(curSkin)
        {
          curSkin.cleanup();
          curSkin = null;
        }
        cleanupMenuImportTXT();
      }
      gotoAndStop("main","menu");
    }
    
    public function press_btnGoImport(e:MouseEvent):void
    {
      //see if we're importing a png or text file
      if(currentLabel == "import_png")
      {
        //grab the bitmapdata from our loader
        var importBitmap:Bitmap = importLoader.content as Bitmap;
        curSkin = new Skin();
        curSkin.baseBitmapData = importBitmap.bitmapData;
        
        //cleanup and leave
        cleanupMenuImportPNG();
        editorFirstInit = true;
        gotoAndStop("edit_main","editor");
      }
      else if(currentLabel == "import_txt")
      {
        //cur skin is already set up, go into the editor
        cleanupMenuImportTXT();
        editorFirstInit = true;
        gotoAndStop("edit_main","editor");
      }
      
      sfxBtnClick.play();
    }
    
    public function enableImportGo():void
    {
      btnGoImport.mouseEnabled = true;
      btnGoImport.alpha = 1;
    }
    
    public function enableBack():void
    {
      btnBackFromImport.mouseEnabled = true;
      btnBackFromImport.alpha = 1;
    }
    
    public function disableImportGo():void
    {
      btnGoImport.mouseEnabled = false;
      btnGoImport.alpha = .2;
    }
    
    public function disableBack():void
    {
      btnBackFromImport.mouseEnabled = false;
      btnBackFromImport.alpha = .2;
    }
    
    public function cleanupMenuImportPNG():void
    {
      mcPreviewBox.cleanup();
      
      importFileReference.removeEventListener(Event.SELECT, referenceBrowse);
      importFileReference.removeEventListener(Event.COMPLETE, referenceLoaded);
      importFileReference.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
      importLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, fileLoaded);
      importFileReference = null;
      importLoader = null;
      
      btnBrowse.removeEventListener(MouseEvent.CLICK, press_btnBrowse);
      btnGoImport.removeEventListener(MouseEvent.CLICK, press_btnImportPNG);
      btnBackFromImport.removeEventListener(MouseEvent.CLICK, press_btnBackFromImport);
    }
    
    public function ioError(e:IOErrorEvent):void
    {
      generateOKDialog("There was an error opening the file");
      enableBack();
    }
    
/**************************************************************************************************************
 *  IMPORT TXT MENU
 * ***********************************************************************************************************/

    public function initMenuImportTXT():void
    {
      btnGoImport.buttonMode = true;
      btnGoImport.addEventListener(MouseEvent.CLICK, press_btnGoImport);
      disableImportGo();
      
      btnBackFromImport.buttonMode = true;
      btnBackFromImport.addEventListener(MouseEvent.CLICK, press_btnBackFromImport);
      
      btnBrowse.addEventListener(MouseEvent.CLICK, press_btnBrowse);
      btnBrowse.buttonMode = true;
      importFileReference = new FileReference();
      importFileReference.addEventListener(Event.SELECT, referenceBrowse);
      importFileReference.addEventListener(Event.COMPLETE, referenceLoadedTXT);
      importFileReference.addEventListener(IOErrorEvent.IO_ERROR, ioError);
    }
    
    public function referenceLoadedTXT(e:Event):void
    {
      try
      {
        importFileReference.data.uncompress();
        curSkin = importFileReference.data.readObject();
        mcPreviewBox.loadBase(curSkin.baseBitmapData);
        mcPreviewBox.skin = curSkin;
      }
      catch(e:Error)
      {
        ioError(null);
        return;
      }
      
      mcPreviewBox.refreshView();
      enableBack();
      enableImportGo();
    }
    
    public function cleanupMenuImportTXT():void
    {
      mcPreviewBox.cleanup();
      
      importFileReference.removeEventListener(Event.SELECT, referenceBrowse);
      importFileReference.removeEventListener(Event.COMPLETE, referenceLoadedTXT);
      importFileReference.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
      importFileReference = null;
      
      btnBrowse.removeEventListener(MouseEvent.CLICK, press_btnBrowse);
      btnGoImport.removeEventListener(MouseEvent.CLICK, press_btnImportPNG);
      btnBackFromImport.removeEventListener(MouseEvent.CLICK, press_btnBackFromImport);
    }
    
/**************************************************************************************************************
 *  BROWSE UPLOADS
 * ***********************************************************************************************************/

    public function initMenuBrowse():void
    {
      Utilities.mc2Btn(btnBackFromBrowse);
      btnBackFromBrowse.addEventListener(MouseEvent.CLICK, press_btnBackFromBrowse);
      Utilities.mc2Btn(btnSearch);
      btnSearch.addEventListener(MouseEvent.CLICK, press_btnSearch);
      Utilities.mc2Btn(btnClearSearch);
      btnClearSearch.addEventListener(MouseEvent.CLICK, press_btnClearSearch);
      btnClearSearch.visible = false;
      
      //create preview box and set to browse mode
      loadPreviewBox(420, 63,1);
      mcPreviewBox.initBrowseMode();
      
      //create the browser
      /*
      saveBrowser = new SaveBrowser();
      saveBrowser.x = 21;
      saveBrowser.y = 10;
      saveBrowser.scaleX = saveBrowser.scaleY = .95;
      saveBrowser.saveGroup = "skins";
      addChild(saveBrowser);
      saveBrowser.title = "User Created Skins";
      //saveBrowser.sortField = SaveQuery.FILE_NAME;
      saveBrowser.loadFiles();
      */
      
      //create vote bar
      /*
      voteBar = new VoteBar();
      voteBar.scaleX = voteBar.scaleY = .75;
      voteBar.x = 442;
      voteBar.y = 318;
      voteBar.rating = "score";
      addChildAt(voteBar, numChildren);
      */
      
      setChildIndex(voteBar, numChildren - 1);
      
      //listen for file load, and for vote processed
      API.addEventListener(APIEvent.FILE_LOADED, skinLoaded);
      API.addEventListener(APIEvent.VOTE_COMPLETE, voteComplete);
      
      //did we come here with a preloaded skin?
      if(preloadNGSaveFile)
      {
        mcPreviewBox.loadBase(BitmapData(preloadNGSaveFile.data));
        mcPreviewBox.refreshView();
        voteBar.saveFile = preloadNGSaveFile;
        voteBar.start();
        preloadNGSaveFile = null;
      }
    }
    
    public function skinLoaded(event:APIEvent) 
    {
      if(event.success) 
      {
        ngSaveFile = com.newgrounds.SaveFile(event.data);
        mcPreviewBox.loadBase(BitmapData(ngSaveFile.data));
        mcPreviewBox.refreshView();
        
        voteBar.saveFile = ngSaveFile;
        voteBar.start();
      }
    }
    
    public function voteComplete(event:APIEvent) 
    {
      if(event.success) 
      {
        unlockMedal("Passing Judgement");
      }
      else
      {
        generateOKDialog("You have already voted on this skin today");
      }
    }
    
    public function press_btnBackFromBrowse(e:MouseEvent):void
    {
      cleanupMenuBrowse();
      gotoAndStop("main","menu");
    }
    
    public function press_btnSearch(e:MouseEvent):void
    {
      mcSearchDialog.show();
    }
    
    public function press_btnClearSearch(e:MouseEvent):void
    {
      btnClearSearch.visible = false;
      saveBrowser.title = "User Created Skins";
      saveBrowser.sortField = SaveQuery.CREATED_ON;
      saveBrowser.loadFiles();
    }
    
    public function takeToEditor():void
    {
      //grab the bitmapdata that's in the preview box
      curSkin = new Skin();
      curSkin.baseBitmapData = mcPreviewBox.sourceBitmapData.clone();
      editorFirstInit = true;
      
      cleanupMenuBrowse();
      gotoAndStop("edit_main","editor");
    }
    
    public function cleanupMenuBrowse():void
    {
      //com.newgrounds.SaveFile.currentFile = null;
      ngSaveFile = null;
      
      mcPreviewBox.cleanup();
      removeChild(mcPreviewBox);
      API.removeEventListener(APIEvent.FILE_LOADED, skinLoaded);
      API.removeEventListener(APIEvent.VOTE_COMPLETE, voteComplete);
      btnBackFromBrowse.removeEventListener(MouseEvent.CLICK, press_btnBackFromBrowse);
      btnSearch.removeEventListener(MouseEvent.CLICK, press_btnSearch);
      btnClearSearch.removeEventListener(MouseEvent.CLICK, press_btnClearSearch);
      removeChild(saveBrowser);
      removeChild(voteBar);
      saveBrowser = null;
      voteBar = null;
    }
 
/**************************************************************************************************************
 *  EDITOR
 * ***********************************************************************************************************/

    public function initEditor():void 
    {	
      if(editorFirstInit)
      {
        editorFirstInit = false;
        
        showAdvancedOptions = false;
        curTool = TOOL_NONE;
        savedView = PreviewBox.VIEW_FRONT;
        layerSelection = null;
        savedLayerScrollPosition = 0;
        mcToolFollow = new ToolFollow();
        mcToolFollow.mouseEnabled = mcToolFollow.mouseChildren = false;
        mcToolFollow.visible = false;
        mcToolFollow.cacheAsBitmap = true;
        addChild(mcToolFollow);
        
        //test layers
        for(i = 0; i < 1; i++)
        {
          //curSkin.addLayer(new PremadeLayer(pieces[0]));
        }
        
        //get dummy skin ready
        dummySkin = new Skin();
        dummySkin.baseBitmapData = curSkin.baseBitmapData.clone();
      }
      
      //first tutorial clip?
      mcTut1.visible = Utilities.saveFile.firstTime;
      if(mcTut1.visible)
      {
        btnAddLayer.filters = new Array(new GlowFilter(0xFFFFFFFF, 1, 12, 12, 3, 2));
      }
      
      //second
      checkForSecondTutorialClip();
      
      //link preview box
      loadPreviewBox(413, 67, 1);
      
      //skin name
      txtSkinName.text = curSkin.name;
      txtSkinName.maxChars = MAX_LAYER_NAME_LENGTH;
      txtSkinName.addEventListener(Event.CHANGE, changeSkinName);
      
      //buttons
      btnBackFromEditor.buttonMode = true;
      btnAddLayer.buttonMode = true;
      btnCopyLayer.buttonMode = true;
      btnExport.buttonMode = true;
      btnCopyLayer.addEventListener(MouseEvent.CLICK, press_btnCopyLayer);
      btnCopyLayer.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnCopyLayer.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnAddLayer.addEventListener(MouseEvent.CLICK, press_btnAddLayer);
      btnAddLayer.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnAddLayer.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnBackFromEditor.addEventListener(MouseEvent.CLICK, press_btnBackFromEditor);
      btnBackFromEditor.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnBackFromEditor.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnExport.addEventListener(MouseEvent.CLICK, press_btnExport);
      btnExport.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnExport.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      
      btnShowSelection.buttonMode = true;
      btnDeleteSelection.buttonMode = true;
      btnShowSelection.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnDeleteSelection.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnDeleteSelection.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnShowSelection.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnShowSelection.addEventListener(MouseEvent.CLICK, press_btnShowSelection);
      btnDeleteSelection.addEventListener(MouseEvent.CLICK, press_btnDeleteSelection);
      //btnHideSelection.buttonMode = true;
      //btnHideSelection.addEventListener(MouseEvent.ROLL_OVER, rollOverHideSelection);
      //btnHideSelection.addEventListener(MouseEvent.ROLL_OUT, rollOutHideSelection);
      //btnHideSelection.addEventListener(MouseEvent.CLICK, press_btnHideSelection);
      
      lstLayers.horizontalScrollPolicy = ScrollPolicy.OFF;
      lstLayers.tabEnabled = false;
      lstLayers.mouseFocusEnabled = false;
      layerBoxes = new Vector.<LayerBox>;
      
      //load layers (if there are any)
      updateLayers();
      
      //cursor, group indicator
      cursorMode = CURSOR_FREE;
      mcGroupIndicator.mouseEnabled = mcGroupIndicator.mouseChildren = false;
    }
    
    public function checkForSecondTutorialClip():void
    {
      //second tutorial? if one layer is present and the save file says first layer is still true, show the message
      if(curSkin.layers.length == 1 && Utilities.saveFile.firstLayer) mcTut2.visible = true;
      else mcTut2.visible = false;
    }
    
    public function changeSkinName(e:Event):void
    {
      //just update the skin object's name
      curSkin.name = txtSkinName.text.substr(0,MAX_LAYER_NAME_LENGTH);
    }
    
    public function loadPreviewBox(inX:int, inY:int, inScale:Number=1):void
    {
      mcPreviewBox = new PreviewBox();
      mcPreviewBox.x = inX;
      mcPreviewBox.y = inY;
      mcPreviewBox.scaleX = mcPreviewBox.scaleY = inScale;
      
      //do we have a curskin to load in? (skip if dummy)
      if(curSkin)
      {
        mcPreviewBox.skin = curSkin;
        mcPreviewBox.loadBase(curSkin.baseBitmapData);
        mcPreviewBox.refreshView();
      }
      
      if(currentLabel == "edit_custom_layer")addChildAt(mcPreviewBox,getChildIndex(mcPanel) + 1);
      else addChildAt(mcPreviewBox,getChildIndex(mcDirtBG) + 1);
    }
    
    public function unloadPreviewBox():void
    {
      if(mcPreviewBox)
      {
        mcPreviewBox.cleanup();
        removeChild(mcPreviewBox);
        mcPreviewBox = null;
      }
    }
    
    public function updateLayerCount():void
    {
      txtLayerCount.text = curSkin.layers.length + "/" + MAX_LAYERS;
    }
    
    public function updateLayers():void
    {
      //cleanup existing stuff before re-populating
      mcPreviewBox.clearSourceBitmaps();
      
      //if there is already a saved position, leave it alone. otherwise save the current
      if(savedLayerScrollPosition == 0)savedLayerScrollPosition = lstLayers.verticalScrollPosition;
      
      for each(tempLayerBox in layerBoxes)
      {
        tempLayerBox.cleanup();
        layerHolder.removeChild(tempLayerBox);
      }
      
      layerHolder = new Sprite();
      layerBoxes = new Vector.<LayerBox>;
      lstLayers.source = null;
      var newLayerScrollPosition:int = -1;
      
      //loop through the skin's layers and add layer boxes for them, also add to the source/preview
      var boxY:Number = 1;
      for (i = curSkin.layers.length-1; i >=0; i--)
      {
        tempLayer = curSkin.layers[i];
        tempLayerBox = new LayerBox(tempLayer);
        tempLayerBox.y = boxY;
        
        //if we found a new layer, save the scroll position
        if(tempLayer.isNew)
        {
          tempLayer.isNew = false;
          newLayerScrollPosition = boxY;
        }
        
        //if the layer is faded, draw with low alpha (for group drag)
        if(tempLayer.faded) tempLayerBox.alpha = .3;
        
        //update y position for next box, add current one 
        boxY += (tempLayerBox.mcOutline.height-1);
        layerHolder.addChild(tempLayerBox);
        layerBoxes.push(tempLayerBox);
      }
      
      //loop through again and pop up layer boxes with selected layers
      for each(tempLayerBox in layerBoxes)
      {
        if(tempLayerBox.targetLayer.selected)
        {
          layerHolder.setChildIndex(tempLayerBox, layerHolder.numChildren - 1);
        }
      }
      
      //add a spacer to the bottom layer box if layerholder is shorter than the list itself. also make sure there is at LEAST ONE LAYER BOX
      if(layerBoxes.length>0 && layerHolder.height+2 < lstLayers.height)
      {
        layerBoxes[layerBoxes.length-1].addBottomSpacer(lstLayers.height - (layerHolder.height+2))
      }
      
      //add a small, empty 1px sprite so that the insert bar on the bottom layer wont get messed up
      var spacer:Sprite = new Sprite();
      spacer.graphics.drawRect(0,0, 20, 2);
      spacer.mouseEnabled = spacer.visible = false;
      spacer.y = boxY;
      layerHolder.addChild(spacer);
      
      lstLayers.source = layerHolder;
      lstLayers.refreshPane();
      lstLayers.update();
      
      //if there was a new layer inserted, use its scroll position. otherwise stick with the saved one
      if(newLayerScrollPosition > -1) lstLayers.verticalScrollPosition = newLayerScrollPosition;
      else lstLayers.verticalScrollPosition = savedLayerScrollPosition;
      
      savedLayerScrollPosition = 0;
      
      //show how many layers total, update preview
      updateLayerCount();
      mcPreviewBox.refreshView();
    }
    
    public static function showDescription(inDescription:String):void
    {
      rootRef.txtDescription.text = inDescription;
    }
    
    public function deselectAllLayers():void
    {
      for each(tempLayer in curSkin.layers){tempLayer.selected = false;}
    }
    
    public function selectAllLayers():void
    {
      if(curSkin.layers.length == 0) return;
      for each(tempLayer in curSkin.layers){tempLayer.selected = true;}
      layerSelection = new LayerSelection(curSkin.layers[0], curSkin.layers.length);
    }
    
    public function dragLayerSelection():void
    {
      cursorMode = CURSOR_DRAG;
      layerSelection.fadeAll();
      updateLayers();
      mcGroupIndicator.visible = true;
      mcGroupIndicator.txtLayersNum.text = layerSelection.layers.length + " Layer(s)";
    }
    
    public function stopDragLayerSelection():void
    {
      cursorMode = CURSOR_FREE;
      layerSelection.unfadeAll();
      updateLayers();
      mcGroupIndicator.x = mcGroupIndicator.y = 0;
      mcGroupIndicator.visible = false;
      
      //void all insert locations
      for each(tempLayerBox in layerBoxes)
      {
        tempLayerBox.voidEligibleInsertion();
      }
    }
    
    public function rollOverShowSelection(e:MouseEvent):void{if(cursorMode==CURSOR_FREE)showDescription("Show selected layers");}
    public function rollOverHideSelection(e:MouseEvent):void{if(cursorMode==CURSOR_FREE)showDescription("Hide selected layers");}
    public function rollOverDeleteSelection(e:MouseEvent):void{if(cursorMode==CURSOR_FREE)showDescription("Delete selected layers");}
    public function rollOutShowSelection(e:MouseEvent):void{showDescription("");}
    public function rollOutHideSelection(e:MouseEvent):void{showDescription("");}
    public function rollOutDeleteSelection(e:MouseEvent):void{showDescription("");}
    
    public function press_btnShowSelection(e:MouseEvent):void
    {
      if(layerSelection == null) return;
      
      //if at least one layer is invisible, make all visible
      var atLeastOneHidden:Boolean = false;
      for each(tempLayer in layerSelection.layers)
      {
        if(tempLayer.hidden)
        {
          atLeastOneHidden = true;
          break;
        }
      }
      
      if(atLeastOneHidden)
      {
        for each(tempLayer in layerSelection.layers)
        {
          tempLayer.hidden = false;
        }
      }
      else
      {
        for each(tempLayer in layerSelection.layers)
        {
          tempLayer.hidden = true;
        }
      }
      
      updateLayers();
    }
    
    public function press_btnHideSelection(e:MouseEvent):void
    {
      if(layerSelection == null) return;
      
      //set all layers in the selection to hidden
      for each(tempLayer in layerSelection.layers)
      {
        tempLayer.hidden = true;
      }
      updateLayers();
    }
    
    public function press_btnDeleteSelection(e:MouseEvent):void
    {
      if(layerSelection == null) return;
      
      //pop up a special dialog
      Main.newDialogBox = new DialogBox('Are you sure you want to delete '+layerSelection.layers.length+' layer(s)?');
      Main.newDialogBox.createAsYesNo("DELLAYERGROUP");
      Main.newDialogBox.display();
    }
    
    public function press_btnBackFromEditor(e:MouseEvent):void
    {
      //show yes/no prompt
      Main.newDialogBox = new DialogBox('Are you sure you want to return to the menu? Unsaved progress will be lost');
      Main.newDialogBox.createAsYesNo("BACKTOMENU");
      Main.newDialogBox.display();
    }
    
    public function press_btnExport(e:MouseEvent):void
    {
      mcExportDialog.show();
    }
    
    public function press_btnAddLayer(e:MouseEvent):void
    {
      //check and make sure they're not at the max yet
      if(curSkin.layers.length == MAX_LAYERS)
      {
        generateOKDialog("You cannot exceed " + MAX_LAYERS + " layers");
        return;
      }
      
      if(Utilities.saveFile.firstTime)
      {
        Utilities.saveFile.firstTime = false;
        Utilities.saveGame();
        mcTut1.visible = false;
        btnAddLayer.filters = null;
      }
      
      //show the dialog
      mcLayerDialog.show();
    }
    
    public function press_btnCopyLayer(e:MouseEvent):void
    {
      //make sure that exactly one layer is selected, and that they're not at the max
      if(!layerSelection)
      {
        //generateOKDialog("you must select a layer to copy");
        return;
      }
      if(layerSelection.layers.length > 1)
      {
        generateOKDialog("only one layer can be copied at a time");
        return;
      }
      if(curSkin.layers.length == MAX_LAYERS)
      {
        generateOKDialog("You cannot exceed " + MAX_LAYERS + " layers");
        return;
      }
      
      var copyName:String = new String("[copy]" + layerSelection.layers[0].name).substr(0, MAX_LAYER_NAME_LENGTH);
      var layerToCopy:Layer = layerSelection.layers[0];
      var newLayer:Layer = layerToCopy.copy();
      newLayer.name = copyName;
      deselectAllLayers();
      curSkin.addLayer(newLayer);
      layerSelection = new LayerSelection(newLayer,0);
      updateLayers();
    }
    
/**************************************************************************************************************
 *  PREMADE LAYER EDITOR
 * ***********************************************************************************************************/

    public function initSharedLayerContent():void
    {
      btnBackToLayers.buttonMode = true;
      btnBackToLayers.addEventListener(MouseEvent.CLICK, press_btnBackToLayers);
      btnBackToLayers.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnBackToLayers.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      
      txtLayerName.text = layerToEdit.name;
      txtLayerName.maxChars = MAX_LAYER_NAME_LENGTH;
      
      //opacity slider
      sldOpacity.value = layerToEdit.opacity;
      sldOpacity.addEventListener(Event.CHANGE, opacityChange);
      
      //blur slider 
      sldBlur.value = layerToEdit.blur;
      sldBlur.addEventListener(SliderEvent.CHANGE, changeBlur);
      
      //blend mode
      for(i = 0; i < availableBlendModes.length; i++)
      {
        var blend:String = availableBlendModes[i];
        var capitalBlend:String = blend.charAt(0).toUpperCase() + blend.substr(1);
        cmbBlendModes.addItem({label:capitalBlend,data:blend});
        
        //is this blend currently selected for this layer?
        if(layerToEdit.blendMode == blend) cmbBlendModes.selectedIndex = i;
      }
      cmbBlendModes.addEventListener(Event.CHANGE, changeBlendMode);
      cmbBlendModes.mouseFocusEnabled = false;
      
      updateSliderDisplays();
    }
    
    public function changeBlendMode(e:Event):void
    {
      //set the layer to the new blend mode and re-draw
      layerToEdit.blendMode = cmbBlendModes.selectedItem.data;
      mcPreviewBox.refreshView();
    }
    
    public function initLayerEditor():void
    {
      //shared
      initSharedLayerContent();
      
      //preview box
      loadPreviewBox(413, 67, 1);
      mcPreviewBox.mcBGLabel.visible = false;
      
      //movement stuff, but only if the piece in this layer can move
      if(getPiece(PremadeLayer(layerToEdit).targetPieceID).canMove)
      {
        chkInvertX.selected = layerToEdit.invertX;
        chkInvertY.selected = layerToEdit.invertY;
        chkInvertX.addEventListener(Event.CHANGE, changeEitherInversion);
        chkInvertY.addEventListener(Event.CHANGE, changeEitherInversion);
        
        btnArrowUp.buttonMode = btnArrowDown.buttonMode = btnArrowLeft.buttonMode = btnArrowRight.buttonMode = true;
        btnArrowUp.direction = UP;
        btnArrowDown.direction = DOWN;
        btnArrowLeft.direction = LEFT;
        btnArrowRight.direction = RIGHT;
        btnArrowUp.addEventListener(MouseEvent.CLICK, press_btnArrow);
        btnArrowUp.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
        btnArrowUp.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
        btnArrowDown.addEventListener(MouseEvent.CLICK, press_btnArrow);
        btnArrowDown.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
        btnArrowDown.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
        btnArrowLeft.addEventListener(MouseEvent.CLICK, press_btnArrow);
        btnArrowLeft.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
        btnArrowLeft.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
        btnArrowRight.addEventListener(MouseEvent.CLICK, press_btnArrow);
        btnArrowRight.addEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
        btnArrowRight.addEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
        
        mcNotAvailable.visible = false;
      }
      else
      {
        chkInvertX.mouseEnabled = chkInvertY.mouseEnabled = false;
        chkInvertX.alpha = chkInvertY.alpha = .2;
        btnArrowDown.alpha = btnArrowUp.alpha = btnArrowLeft.alpha = btnArrowRight.alpha = .2;
        mcMovementExtra.alpha = .2;
      }
      
      //flatten checkboxes
      chkFlattenColor.selected = layerToEdit.flattenColor;
      chkFlattenColor.addEventListener(Event.CHANGE, changeFlattenColor);
      
      //color grabber
      colorGrabber.setColor(layerToEdit.tintColor, false);
      colorGrabber.addEventListener(Event.CHANGE, changeColor);
      
      //advanced options
      btnAdvancedOptions.buttonMode = true;
      btnAdvancedOptions.addEventListener(MouseEvent.CLICK, press_btnAdvancedOptions);
      if(showAdvancedOptions) btnAdvancedOptions.gotoAndStop(2);
      
      sldColorIntensity.value = layerToEdit.colorIntensity;
      sldTextureIntensity.value = layerToEdit.textureIntensity;
      sldColorIntensity.addEventListener(SliderEvent.CHANGE, changeColorIntensity);
      sldTextureIntensity.addEventListener(SliderEvent.CHANGE, changeTextureIntensity);
    }
    
    public function press_btnAdvancedOptions(e:MouseEvent):void
    {
      if(showAdvancedOptions)
      {
        showAdvancedOptions = false;
        btnAdvancedOptions.gotoAndStop(1);
      }
      else
      {
        showAdvancedOptions = true;
        btnAdvancedOptions.gotoAndStop(2);
      }
    }
    
    public function changeColor(e:Event):void
    {
      layerToEdit.tintColor = colorGrabber.actualColor;
      mcPreviewBox.refreshView();
    }
    
    public function changeEitherInversion(e:Event):void
    {
      layerToEdit.invertX = chkInvertX.selected;
      layerToEdit.invertY = chkInvertY.selected;
      mcPreviewBox.refreshView();
    }
    
    public function changeFlattenColor(e:Event):void
    {
      layerToEdit.flattenColor = chkFlattenColor.selected;
      mcPreviewBox.refreshView();
    }
    
    public function updateSliderDisplays():void
    {
      if(txtOpacityValue) txtOpacityValue.text = layerToEdit.opacity.toString();
      if(txtColorIntensity) txtColorIntensity.text = layerToEdit.colorIntensity.toString();
      if(txtTextureIntensity) txtTextureIntensity.text = layerToEdit.textureIntensity.toString();
      if(txtBlurValue) txtBlurValue.text = layerToEdit.blur.toString();
    }
    
    public function press_btnArrow(e:MouseEvent):void
    {
      //re-cast our layer as a premade one so we can access the attempt move function
      PremadeLayer(layerToEdit).attemptToMove(e.target.direction);
    }
    
    public function press_btnBackToLayers(e:MouseEvent):void
    {
      //make sure they specified a layer name
      if(txtLayerName.text == "")
      {
        generateOKDialog("Layer names must be at least one character long");
        return;
      }
      layerToEdit.name = txtLayerName.text.substr(0,MAX_LAYER_NAME_LENGTH);
      
      //special clean up if in the pixel editor
      if(currentLabel == "edit_custom_layer")
      {
        pixelEditor.cleanup();
        removeChild(pixelEditor);
        pixelEditor = null;
        mcToolFollow.visible = false;
      }
      
      //go back to layer list
      unloadPreviewBox();
      gotoAndStop("edit_main");
    }
    
    public function opacityChange(e:Event):void
    {
      //update the layer object with new opacity, redraw the character
      layerToEdit.opacity = uint(sldOpacity.value);
      updateSliderDisplays();
      mcPreviewBox.refreshView();
    }
    
    public function changeColorIntensity(e:Event):void
    {
      //update the layer object with new value, redraw the character
      layerToEdit.colorIntensity = uint(sldColorIntensity.value);
      updateSliderDisplays();
      mcPreviewBox.refreshView();
    }
    
    public function changeTextureIntensity(e:Event):void
    {
      //update the layer object with new value, redraw the character
      layerToEdit.textureIntensity = uint(sldTextureIntensity.value);
      updateSliderDisplays();
      mcPreviewBox.refreshView();
    }
    
    public function changeBlur(e:Event):void
    {
      //update the layer object with new value, redraw the character
      layerToEdit.blur = uint(sldBlur.value);
      updateSliderDisplays();
      mcPreviewBox.refreshView();
    }
    
/**************************************************************************************************************
 *  CUSTOM LAYER EDITOR
 * ***********************************************************************************************************/

    public function initCustomLayerEditor():void
    {
      //shared
      initSharedLayerContent();
      
      //set up pixel editor stuff
      var targetView:uint = CustomLayer(layerToEdit).targetView;
      pixelEditor = new PixelEditor(10,65);
      addChild(pixelEditor);
      pixelEditor.drawView(targetView);
      
      //preview box positioning
      if(targetView == PixelEditor.VIEW_ARM || targetView == PixelEditor.VIEW_LEG)
      {
        loadPreviewBox(400, 105, .7);
      }
      else if(targetView == PixelEditor.VIEW_BODY)
      {
        loadPreviewBox(450, 105, .7);
      }
      else
      {
        loadPreviewBox(535, 115, .6);
      }
      
      //if on a dedicated hat layer, hide blur and opacity tools. show special messages
      txtSpecialMessage.text = "";
      if(targetView == PixelEditor.VIEW_HAT)
      {
        sldBlur.mouseEnabled = sldBlur.visible = false;
        sldOpacity.mouseEnabled = sldOpacity.visible = false;
        txtBlurValue.text = txtOpacityValue.text = "";
        mcLabelBlur.visible = mcLabelOpacity.visible = false;
        
        txtSpecialMessage.text = "*Content in Hat Layers will always appear above other layers";
      }
      else if(targetView == PixelEditor.VIEW_ALL)
      {
        //if on the all layer, show a warning about hat pixels
        txtSpecialMessage.text = "*Minecraft does not support transparent pixels in Hat surfaces";
      }
      
      //hide shift+draw message
      mcShiftMessage.visible = false;
      
      //show base checkbox
      chkShowBase.selected = true;
      chkShowBase.addEventListener(Event.CHANGE, changeChkShowBase);
      chkShowBase.mouseFocusEnabled = false;
      
      //tools
      btnPencil.toolID = TOOL_PENCIL;
      btnEraser.toolID = TOOL_ERASER;
      btnBucket.toolID = TOOL_BUCKET;
      btnBucket.buttonMode = btnPencil.buttonMode = btnEraser.buttonMode = true;
      btnUndo.buttonMode = true;
      btnUndo.mouseChildren = false;
      btnPencil.mcHighlight.visible = btnEraser.mcHighlight.visible = btnBucket.mcHighlight.visible = false;
      btnPencil.mouseChildren = btnEraser.mouseChildren = btnBucket.mouseChildren = false;
      btnPencil.addEventListener(MouseEvent.CLICK, press_btnTool);
      btnEraser.addEventListener(MouseEvent.CLICK, press_btnTool);
      btnBucket.addEventListener(MouseEvent.CLICK, press_btnTool);
      btnUndo.addEventListener(MouseEvent.CLICK, press_btnUndo);
      mcToolFollow.visible = false;
      setChildIndex(mcToolFollow, numChildren - 1);
      curTool = TOOL_NONE;
      
      updateUndoButton();
      
      //change view cmb
      for(i = 0; i < PixelEditor.viewNames.length; i++)
      {
        cmbEditorView.addItem({label:PixelEditor.viewNames[i],data:i});
      }
      cmbEditorView.addEventListener(Event.CHANGE, changeEditorView);
      cmbEditorView.mouseFocusEnabled = false;
      
      //surface name
      txtSurfaceName.text = "";
      
      //always start with pencil
      changeTool(TOOL_PENCIL);
      btnPencil.mcHighlight.visible = true;
    }
    
    public function updateUndoButton():void
    {
      //if there are no undo levels in the editor, set button to inactive/transparent
      if(pixelEditor.undoLog.length > 0)
      {
        btnUndo.mouseEnabled = true;
        btnUndo.alpha = 1;
      }
      else
      {
        btnUndo.mouseEnabled = false;
        btnUndo.alpha = .3;
      }
    }
    
    public function press_btnUndo(e:MouseEvent):void
    {
      pixelEditor.undo();
    }
    
    public function changeEditorView(e:Event):void
    {
      //disabled now
      //pixelEditor.drawView(cmbEditorView.selectedIndex);
    }
    
    public function changeChkShowBase(e:Event):void
    {
      stage.focus = null;
      if(chkShowBase.selected) pixelEditor.showBase();
      else pixelEditor.hideBase();
    }
    
    public function dehighlightTools():void
    {
      btnPencil.mcHighlight.visible = btnEraser.mcHighlight.visible = btnBucket.mcHighlight.visible=false;
    }
    
    public function changeTool(newTool:uint):void
    {
      curTool = newTool;
      mcToolFollow.gotoAndStop(curTool);
      setChildIndex(mcToolFollow, numChildren - 1);
    }
    
    public function press_btnTool(e:MouseEvent):void
    {
      dehighlightTools();
      changeTool(uint(e.currentTarget.toolID));
      e.currentTarget.mcHighlight.visible = true;
    }
    
    public function cleanupEditor():void
    {
      unloadPreviewBox();
      mcLayerDialog.cleanup();
      mcExportDialog.cleanup();
      removeChild(mcToolFollow);
      mcToolFollow = null;
      curSkin.cleanup();
      dummySkin.cleanup();
      curSkin = dummySkin = null;
      btnAddLayer.removeEventListener(MouseEvent.CLICK, press_btnAddLayer);
      btnAddLayer.removeEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnAddLayer.removeEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnCopyLayer.removeEventListener(MouseEvent.CLICK, press_btnCopyLayer);
      btnCopyLayer.removeEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnCopyLayer.removeEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnBackFromEditor.removeEventListener(MouseEvent.CLICK, press_btnBackFromEditor);
      btnBackFromEditor.removeEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnBackFromEditor.removeEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnExport.removeEventListener(MouseEvent.CLICK, press_btnExport);
      btnExport.removeEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnExport.removeEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      
      txtSkinName.removeEventListener(Event.CHANGE, changeSkinName);
      
      btnShowSelection.removeEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnDeleteSelection.removeEventListener(MouseEvent.ROLL_OVER, genericMouseOver);
      btnDeleteSelection.removeEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnShowSelection.removeEventListener(MouseEvent.ROLL_OUT, genericMouseOut);
      btnShowSelection.removeEventListener(MouseEvent.CLICK, press_btnShowSelection);
      btnDeleteSelection.removeEventListener(MouseEvent.CLICK, press_btnDeleteSelection);
      //btnHideSelection.removeEventListener(MouseEvent.ROLL_OVER, rollOverHideSelection);
      //btnHideSelection.removeEventListener(MouseEvent.ROLL_OUT, rollOutHideSelection);
      //btnHideSelection.removeEventListener(MouseEvent.CLICK, press_btnHideSelection);
    }
    
    public static function generateOKDialog(inMessage:String, showProfileLink:Boolean = false, showNGLink:Boolean=false):void
    {
      newDialogBox = new DialogBox(inMessage);
      newDialogBox.createAsOk("", showProfileLink, showNGLink);
      newDialogBox.display();
    }
    
    public function unlockMedal(medalName:String):void
    {
      return;
      //find the medal object
      var medal:Medal;
      for each(var tempMedal:Medal in API.medals)
      {
        if(tempMedal.name == medalName)
        {
          medal = tempMedal;
          break;
        }
      }
      
      //check for unlock
      if(medal && !medal.unlocked)
      {
        setChildIndex(medalPopup, numChildren - 1);
        API.unlockMedal(medalName);
      }
    }
  }
}