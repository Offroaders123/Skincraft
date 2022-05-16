package
{
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.Medal;
   import com.newgrounds.SaveFile;
   import com.newgrounds.SaveQuery;
   import com.newgrounds.components.APIConnector;
   import com.newgrounds.components.MedalPopup;
   import com.newgrounds.components.SaveBrowser;
   import com.newgrounds.components.VoteBar;
   import fl.containers.ScrollPane;
   import fl.controls.CheckBox;
   import fl.controls.ComboBox;
   import fl.controls.List;
   import fl.controls.ScrollPolicy;
   import fl.controls.Slider;
   import fl.controls.TextInput;
   import fl.data.DataProvider;
   import fl.data.SimpleCollectionItem;
   import fl.events.ListEvent;
   import fl.events.SliderEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.media.Sound;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import flash.net.URLRequest;
   import flash.net.registerClassAlias;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class Main extends MovieClip
   {
      
      public static const RIGHT:uint = 3;
      
      public static var activeDialogBox:DialogBox;
      
      public static const LEFT:uint = 2;
      
      public static var availableBlendModes:Array;
      
      public static var savedBG:uint;
      
      public static const TOOL_ERASER:uint = 2;
      
      public static var GAME_HEIGHT:uint;
      
      public static var GAME_WIDTH:uint;
      
      public static var categories:Array;
      
      public static var cursorMode:uint;
      
      public static const SKIN_HEIGHT:uint = 64;
      
      public static var sfxBtnClick:Sound;
      
      public static var dragDelayFrames:uint;
      
      public static var tempSurface:Surface;
      
      public static var preloadNGSaveFile:com.newgrounds.SaveFile;
      
      public static var hasSeenAd:Boolean;
      
      public static var layerSelection:LayerSelection;
      
      public static var dummySkin:Skin;
      
      public static var oldSkinRect:Rectangle;
      
      public static var pieces:Array;
      
      public static var rootRef:Main;
      
      public static var subcategories:Array;
      
      public static var showAdvancedOptions:Boolean;
      
      public static var mirrorMatrix:Matrix;
      
      public static const SKIN_WIDTH:uint = 64;
      
      public static var surfaces:Vector.<Surface>;
      
      public static var i:int;
      
      public static var j:int;
      
      public static var ngSaveFile:com.newgrounds.SaveFile;
      
      public static var layerToDelete:Layer;
      
      public static const TOOL_BUCKET:uint = 3;
      
      public static var tempPiece:Piece;
      
      public static const TOOL_NONE:uint = 0;
      
      public static const CURSOR_DRAG:uint = 1;
      
      public static var dragStartY:Number;
      
      public static const CURSOR_DRAW:uint = 2;
      
      public static const TOOL_EYEDROPPER:uint = 4;
      
      public static var dragStartX:Number;
      
      public static var destinationSurfaces:Vector.<Surface>;
      
      public static const MAX_LAYERS:uint = 50;
      
      public static var sourceSurfaces:Vector.<Surface>;
      
      public static var newDialogBox:DialogBox;
      
      public static const UP:uint = 0;
      
      public static var tempLayerBox:LayerBox;
      
      public static const DOWN:uint = 1;
      
      public static var stageRef:Stage;
      
      public static const TOOL_PENCIL:uint = 1;
      
      public static const CURSOR_FREE:uint = 0;
      
      public static var tempSubcategory:Subcategory;
      
      public static var savedView:uint;
      
      public static var layerToEdit:Layer;
      
      public static const MAX_LAYER_NAME_LENGTH:uint = 30;
      
      public static var tempLayer:Layer;
      
      public static var curSkin:Skin;
      
      public static var listenForDrag:Boolean;
      
      public static var layerBoxes:Vector.<LayerBox>;
      
      public static var sfxBtnHover:Sound;
      
      public static var importLimitKB:uint;
      
      public static var tempCategory:Category;
      
      public static var medalPopup:MedalPopup;
      
      public static var tempPresetSkin:PresetSkin;
      
      public static var curTool:uint;
      
      public static var importLimitBytes:uint;
      
      public static var presetSkins:Vector.<PresetSkin>;
       
      
      public var btnBrowse:MovieClip;
      
      public var btnEraser:MovieClip;
      
      public var btnShowSelection:MovieClip;
      
      public var mcPanel:MovieClip;
      
      public var sldColorIntensity:Slider;
      
      public var importLoader:Loader;
      
      public var btnBackToLayers:MovieClip;
      
      public var btnDeleteSelection:MovieClip;
      
      public var btnAdvancedOptions:MovieClip;
      
      public var ngIntro:MovieClip;
      
      public var chkShowBase:CheckBox;
      
      public var txtSkinName:TextInput;
      
      public var sldBlur:Slider;
      
      public var importSourceContainer:Sprite;
      
      public var txtLoadingSkin:MovieClip;
      
      public var txtSurfaceName:TextField;
      
      public var btnClearSearch:MovieClip;
      
      public var __setPropDict:Dictionary;
      
      public var layerHolder:Sprite;
      
      public var btnGoPreset:MovieClip;
      
      public var sldOpacity:Slider;
      
      public var btnSkincraftPack:MovieClip;
      
      public var mcLayerDialog:LayerDialog;
      
      public var mcLabelBlur:MovieClip;
      
      public var btnArrowUp:MovieClip;
      
      public var btnPencil:MovieClip;
      
      public var btnBackFromBrowse:MovieClip;
      
      public var txtColorIntensity:TextField;
      
      public var sldTextureIntensity:Slider;
      
      public var sourceContainer:Sprite;
      
      public var mcMovementExtra:MovieClip;
      
      public var btnArrowLeft:MovieClip;
      
      public var cmbBlendModes:ComboBox;
      
      public var txtOpacityValue:TextField;
      
      public var txtBlurValue:TextField;
      
      public var savedLayerScrollPosition:Number;
      
      public var voteBar:VoteBar;
      
      public var __id3_:APIConnector;
      
      public var collProps5:Array;
      
      public var collProps6:Array;
      
      public var collProps7:Array;
      
      public var txtLayerCount:TextField;
      
      public var mcExportDialog:ExportDialog;
      
      public var lstPresets:List;
      
      public var saveBrowser:SaveBrowser;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var editorFirstInit:Boolean;
      
      public var txtLayerName:TextInput;
      
      public var txtMCUsername:TextInput;
      
      public var btnBackFromPresets:MovieClip;
      
      public var j5;
      
      public var j6;
      
      public var j7;
      
      public var cmbEditorView:ComboBox;
      
      public var btnArrowRight:MovieClip;
      
      public var mcPreviewBox:PreviewBox;
      
      public var pixelEditorMask:Bitmap;
      
      public var txtTest:TextField;
      
      public var btnSearch:MovieClip;
      
      public var btnGoImport:MovieClip;
      
      public var collObj5:DataProvider;
      
      public var collObj6:DataProvider;
      
      public var collObj7:DataProvider;
      
      public var mcLabelOpacity:MovieClip;
      
      public var btnExport:MovieClip;
      
      public var sourceBitmap:Bitmap;
      
      public var mcTut1:MovieClip;
      
      public var mcTut2:MovieClip;
      
      public var mcDirtBG:MovieClip;
      
      public var btnImportPNG:MovieClip;
      
      public var btnArrowDown:MovieClip;
      
      public var btnUndo:MovieClip;
      
      public var btnLoad:MovieClip;
      
      public var btnBucket:MovieClip;
      
      public var mcTankLogo:MovieClip;
      
      public var txtDescription:TextField;
      
      public var btnHideSelection:MovieClip;
      
      public var importSourceBitmap:Bitmap;
      
      public var lstLayers:ScrollPane;
      
      public var btnPresets:MovieClip;
      
      public var btnBackFromEditor:MovieClip;
      
      public var mcPreloader:MovieClip;
      
      public var chkFlattenColor:CheckBox;
      
      public var mcGroupIndicator:MovieClip;
      
      public var importFileReference:FileReference;
      
      public var btnImportTXT:MovieClip;
      
      public var pixelEditor:PixelEditor;
      
      public var previewContainer:Sprite;
      
      public var txtSpecialMessage:TextField;
      
      public var mcToolFollow:MovieClip;
      
      public var collProp6:Object;
      
      public var collProp7:Object;
      
      public var btnBrowseUploads:MovieClip;
      
      public var collProp5:Object;
      
      public var btnBackFromImport:MovieClip;
      
      public var btnAddLayer:MovieClip;
      
      public var chkInvertY:CheckBox;
      
      public var chkInvertX:CheckBox;
      
      public var mcSearchDialog:SearchDialog;
      
      public var itemObj5:SimpleCollectionItem;
      
      public var itemObj6:SimpleCollectionItem;
      
      public var itemObj7:SimpleCollectionItem;
      
      public var mcShiftMessage:MovieClip;
      
      public var btnCopyLayer:MovieClip;
      
      public var txtTextureIntensity:TextField;
      
      public var mcNotAvailable:MovieClip;
      
      public var colorGrabber:ColorGrabber;
      
      public var mcAdvancedLabels:MovieClip;
      
      public function Main()
      {
         this.__setPropDict = new Dictionary(true);
         super();
         addFrameScript(1,this.frame2,4,this.frame5,5,this.frame6,6,this.frame7,7,this.frame8,8,this.frame9,9,this.frame10,10,this.frame11,11,this.frame12,0,this.frame1);
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
         this.txtLoadingSkin.visible = false;
         this.mcTankLogo.buttonMode = true;
         this.mcTankLogo.addEventListener(MouseEvent.CLICK,this.clickTank);
         Utilities.mc2Btn(this.btnSkincraftPack);
         this.btnSkincraftPack.addEventListener(MouseEvent.CLICK,this.clickSkincraftPack);
         var _loc1_:String = loaderInfo.loaderURL;
         var _loc2_:RegExp = /(kongregate|addictinggames)/i;
         if(_loc1_.match(_loc2_))
         {
            hasSeenAd = true;
         }
         registerClassAlias("Skin",Skin);
         registerClassAlias("Layer",Layer);
         registerClassAlias("PremadeLayer",PremadeLayer);
         registerClassAlias("CustomLayer",CustomLayer);
         registerClassAlias("Piece",Piece);
         Utilities.setRefs(this,stage);
         contextMenu = Utilities.generateContextMenu();
         addChild(Utilities.createOutsideBounds(GAME_WIDTH,GAME_HEIGHT));
         Utilities.loadSharedObject("SKINCRAFT");
         this.createPresetSkins();
         this.createSurfaces();
         this.createCategories();
         pieces = new Array();
         pieces.push(new Piece("Brow 1",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Brow 2",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Ears 1",Subcategory.FACE,new Array(Surface.HEAD_LEFT,Surface.HEAD_RIGHT),true));
         pieces.push(new Piece("Ears 2",Subcategory.FACE,new Array(Surface.HEAD_LEFT,Surface.HEAD_RIGHT),true));
         pieces.push(new Piece("Ears 3",Subcategory.FACE,new Array(Surface.HEAD_LEFT,Surface.HEAD_RIGHT),true));
         pieces.push(new Piece("Eyes 1",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Eyes 2",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Eyes 3",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Eyes 4",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Eyes 5",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Eyes 6",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Eyes 7",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Mouth 1",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Mouth 2",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Mouth 3",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Nose 1",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Nose 2",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Nose 3",Subcategory.FACE,new Array(Surface.HEAD_FRONT,-1),true));
         pieces.push(new Piece("Face 1",Subcategory.FACE,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true));
         pieces.push(new Piece("Face 2",Subcategory.FACE,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true));
         pieces.push(new Piece("Face 3",Subcategory.FACE,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true));
         pieces.push(new Piece("FaceCreeper",Subcategory.FACE,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true,"Face 4"));
         pieces.push(new Piece("Hair Extra 13",Subcategory.FACE,new Array(Surface.HAT_FRONT,-1),true,"Brow 3"));
         pieces.push(new Piece("Glasses 1",Subcategory.GLASSES,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true));
         pieces.push(new Piece("Glasses 2",Subcategory.GLASSES,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true));
         pieces.push(new Piece("Glasses 3",Subcategory.GLASSES,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true,"Eyepatch"));
         pieces.push(new Piece("Glasses 4",Subcategory.GLASSES,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT),true,"Glasses 3"));
         pieces.push(new Piece("Glasses 5",Subcategory.GLASSES,new Array(Surface.HAT_FRONT,Surface.BODY_FRONT),false,"Monocle"));
         pieces.push(new Piece("Glasses 6",Subcategory.GLASSES,new Array(Surface.HAT_FRONT,Surface.HAT_LEFT,Surface.HAT_RIGHT),true,"Visor"));
         pieces.push(new Piece("Hair 1",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 2",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 3",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 4",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 5",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 6",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 7",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 8",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 9",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 10",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair 11",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Hair Extra 1",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Ponytail"));
         pieces.push(new Piece("Hair Extra 2",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Bangs"));
         pieces.push(new Piece("Hair Extra 3",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Curl"));
         pieces.push(new Piece("Hair Extra 4",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Chops"));
         pieces.push(new Piece("Hair Extra 6",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Shag"));
         pieces.push(new Piece("Hair Extra 7",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Mohawk"));
         pieces.push(new Piece("Hair Extra 8",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Combover"));
         pieces.push(new Piece("Hair Extra 9",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Homer"));
         pieces.push(new Piece("Hair Extra 10",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Afro"));
         pieces.push(new Piece("Hair Extra 11",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Hippie"));
         pieces.push(new Piece("Hair Extra 12",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Long"));
         pieces.push(new Piece("Hair Extra 14",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Loose"));
         pieces.push(new Piece("Hair Extra 15",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Girly"));
         pieces.push(new Piece("Hair Extra 16",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Emo"));
         pieces.push(new Piece("Hair Extra 17",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Hair Extra - Firestarter"));
         pieces.push(new Piece("Beard 1",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Beard 2",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false));
         pieces.push(new Piece("Beard 3",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),true,"Mustache 1"));
         pieces.push(new Piece("Beard 4",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),true,"Mustache 2"));
         pieces.push(new Piece("Beard 5",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Beard 3"));
         pieces.push(new Piece("BeardLong",Subcategory.HAIR,new Array(Surface.HEAD_FRONT,-1),false,"Beard 4"));
         pieces.push(new Piece("Hair Extra 5",Subcategory.HAIR,new Array(Surface.HAT_FRONT,-1),true,"Mustache 3"));
         pieces.push(new Piece("HairChest",Subcategory.HAIR,new Array(Surface.BODY_FRONT,-1),false,"Hair Chest"));
         pieces.push(new Piece("Mask 1",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,Surface.HAT_LEFT,Surface.HAT_RIGHT),true,"Mask - Wolverine"));
         pieces.push(new Piece("Mask 2",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,Surface.HAT_LEFT,Surface.HAT_RIGHT),true,"Mask - Superhero"));
         pieces.push(new Piece("Mask 3",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Mask - Wrestler"));
         pieces.push(new Piece("Mask 4",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Mask - Ninja"));
         pieces.push(new Piece("Mask 5",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Mask - Samurai"));
         pieces.push(new Piece("Mask 5b",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Samurai"));
         pieces.push(new Piece("Mask 6",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,-1),true,"Mask - Subzero"));
         pieces.push(new Piece("Mask 7",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Mask - Ski"));
         pieces.push(new Piece("Mask 8",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true,"Mask - Ball Gag"));
         pieces.push(new Piece("Mask 9",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Mask - Hockey"));
         pieces.push(new Piece("Mask 10",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,-1),true,"Mask - Tankman"));
         pieces.push(new Piece("Mask 11",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,Surface.HAT_LEFT,Surface.HAT_RIGHT),true,"Mask - Minion"));
         pieces.push(new Piece("Mask 12",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,-1),true,"Mask - Vendetta"));
         pieces.push(new Piece("Mask 13",Subcategory.HATS_AND_MASKS,new Array(Surface.HAT_FRONT,-1),true,"Mask - Phantom"));
         pieces.push(new Piece("Hat 1",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Beret"));
         pieces.push(new Piece("Hat 2",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Jayne Cobb"));
         pieces.push(new Piece("Hat 3",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Kettle"));
         pieces.push(new Piece("Hat 4",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Crusader"));
         pieces.push(new Piece("Hat 5",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Basic"));
         pieces.push(new Piece("Hat 6",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Viking"));
         pieces.push(new Piece("Hat 7",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Kenny Hood"));
         pieces.push(new Piece("Hat 8",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Yamaka"));
         pieces.push(new Piece("Hat 9",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Football"));
         pieces.push(new Piece("Hat 10",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Evil Ash"));
         pieces.push(new Piece("Hat 11",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Bag"));
         pieces.push(new Piece("Hat 12",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Astronaut"));
         pieces.push(new Piece("Hat 12b",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Astro Visor"));
         pieces.push(new Piece("Hat 13",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - Miner"));
         pieces.push(new Piece("Hat 14",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Trucker"));
         pieces.push(new Piece("Hat 15",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Bandana"));
         pieces.push(new Piece("Hat 15b",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Bandana Full"));
         pieces.push(new Piece("Hat 16",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Beret 2"));
         pieces.push(new Piece("Outline Head",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Outline"));
         pieces.push(new Piece("Crown1",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Crown 1"));
         pieces.push(new Piece("Crown2",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Crown 2"));
         pieces.push(new Piece("LinkCap",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Fairy"));
         pieces.push(new Piece("PirateHat",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Hat - Pirate"));
         pieces.push(new Piece("WWIIHelmet",Subcategory.HATS_AND_MASKS,new Array(Surface.HEAD_FRONT,-1),false,"Helmet - WWII"));
         pieces.push(new Piece("Accessory Head 1",Subcategory.ACCESSORY_HEAD,new Array(Surface.HEAD_FRONT,Surface.HEAD_LEFT,Surface.HEAD_RIGHT,Surface.HEAD_BACK),true,"Robot"));
         pieces.push(new Piece("Accessory Head 2",Subcategory.ACCESSORY_HEAD,new Array(Surface.HEAD_FRONT,-1),false,"Pinhead"));
         pieces.push(new Piece("Accessory Head 3",Subcategory.ACCESSORY_HEAD,new Array(Surface.HEAD_FRONT,-1),false,"Frankenstein"));
         pieces.push(new Piece("Accessory Head 4",Subcategory.ACCESSORY_HEAD,new Array(Surface.HEAD_FRONT,-1),false,"Wings"));
         pieces.push(new Piece("Accessory Head 5",Subcategory.ACCESSORY_HEAD,new Array(Surface.HAT_LEFT,Surface.HAT_RIGHT),true,"Fins"));
         pieces.push(new Piece("Accessory Head 6",Subcategory.ACCESSORY_HEAD,new Array(Surface.HAT_BACK,-1),true,"Bow"));
         pieces.push(new Piece("Accessory Head 7",Subcategory.ACCESSORY_HEAD,new Array(Surface.HAT_FRONT,Surface.HAT_LEFT,Surface.HAT_RIGHT,Surface.HAT_BACK),true,"Flower"));
         pieces.push(new Piece("AfroPick",Subcategory.ACCESSORY_HEAD,new Array(Surface.HAT_FRONT,Surface.HAT_LEFT,Surface.HAT_RIGHT,Surface.HAT_BACK),true,"Afro Pick"));
         pieces.push(new Piece("Cape 1",Subcategory.CAPES,new Array(Surface.BODY_BACK,-1),false));
         pieces.push(new Piece("Cape 2",Subcategory.CAPES,new Array(Surface.BODY_BACK,-1),false));
         pieces.push(new Piece("Cape 3",Subcategory.CAPES,new Array(Surface.BODY_BACK,-1),false));
         pieces.push(new Piece("HoodCloak",Subcategory.CAPES,new Array(Surface.BODY_FRONT,-1),false,"Cloak 1"));
         pieces.push(new Piece("WizRobe1",Subcategory.CAPES,new Array(Surface.BODY_FRONT,-1),false,"Wizard 1"));
         pieces.push(new Piece("WizRobe2",Subcategory.CAPES,new Array(Surface.BODY_FRONT,-1),false,"Wizard 2"));
         pieces.push(new Piece("WizRobe3",Subcategory.CAPES,new Array(Surface.BODY_FRONT,-1),false,"Wizard 3"));
         pieces.push(new Piece("Coat 1",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Coat 2",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Coat 2b",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Coat 4",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Coat 4b",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("MadMaxCoat",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false,"Coat 5"));
         pieces.push(new Piece("PirateVest",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false,"Vest 1"));
         pieces.push(new Piece("MadMaxVest",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false,"Vest 2"));
         pieces.push(new Piece("Coat 3",Subcategory.COATS,new Array(Surface.BODY_FRONT,-1),false,"Vest 3"));
         pieces.push(new Piece("Glove 1",Subcategory.GLOVES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Glove 2",Subcategory.GLOVES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Glove 3",Subcategory.GLOVES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Glove 4",Subcategory.GLOVES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Glove 5",Subcategory.GLOVES,new Array(Surface.ARM_RIGHT_BACK,Surface.ARM_RIGHT_LEFT,Surface.ARM_RIGHT_RIGHT,Surface.ARM_RIGHT_FRONT),true));
         pieces.push(new Piece("Shirt 1",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Shirt 2",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Shirt 3",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Shirt 4",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Shirt 5",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Overalls 1",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Top 1",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false,"Bikini Top 1"));
         pieces.push(new Piece("Top 2",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false,"Bikini Top 2"));
         pieces.push(new Piece("PirateShirt",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false,"Shirt 6"));
         pieces.push(new Piece("Sweater",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false,"Shirt 7"));
         pieces.push(new Piece("CamoShirt",Subcategory.SHIRTS_AND_TIES,new Array(Surface.BODY_FRONT,-1),false,"Shirt 8"));
         pieces.push(new Piece("Tunic 1",Subcategory.TUNICS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Tunic 1b",Subcategory.TUNICS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Tunic 2",Subcategory.TUNICS,new Array(Surface.BODY_FRONT,-1),false));
         pieces.push(new Piece("Tunic 3",Subcategory.TUNICS,new Array(Surface.BODY_FRONT,-1),false,"Armor 1"));
         pieces.push(new Piece("ArmorChest",Subcategory.TUNICS,new Array(Surface.BODY_FRONT,-1),false,"Armor 2"));
         pieces.push(new Piece("Belt 1",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 2",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 2b",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 3",Subcategory.BELTS,new Array(Surface.BODY_FRONT,Surface.BODY_LEFT,Surface.BODY_BACK,Surface.BODY_RIGHT),true));
         pieces.push(new Piece("Belt 3b",Subcategory.BELTS,new Array(Surface.BODY_FRONT,Surface.BODY_LEFT,Surface.BODY_BACK,Surface.BODY_RIGHT),true));
         pieces.push(new Piece("Belt 4",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 5",Subcategory.BELTS,new Array(Surface.BODY_FRONT,Surface.BODY_LEFT,Surface.BODY_BACK,Surface.BODY_RIGHT),true));
         pieces.push(new Piece("Belt 6",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 7",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 8",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Belt 9",Subcategory.BELTS,new Array(Surface.BODY_FRONT,-1)));
         pieces.push(new Piece("Pack 1",Subcategory.PACKS,new Array(Surface.BODY_BACK,-1),false,"Ghostbusters"));
         pieces.push(new Piece("Pack 2",Subcategory.PACKS,new Array(Surface.BODY_BACK,-1),false,"Backpack"));
         pieces.push(new Piece("Pack 3",Subcategory.PACKS,new Array(Surface.BODY_BACK,-1),false,"Robot"));
         pieces.push(new Piece("Symbol 1",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),true,"Punisher"));
         pieces.push(new Piece("Symbol 2",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),true,"Superman"));
         pieces.push(new Piece("Symbol 3",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),true,"Batman"));
         pieces.push(new Piece("Symbol 4",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),true,"X-men"));
         pieces.push(new Piece("Symbol 5",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),false,"Ranger 1"));
         pieces.push(new Piece("Symbol 6",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),false,"Ranger 2"));
         pieces.push(new Piece("Symbol 7",Subcategory.SYMBOLS,new Array(Surface.BODY_FRONT,-1),true,"Bolt"));
         pieces.push(new Piece("Accessory 1",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Tie 1"));
         pieces.push(new Piece("Accessory 1b",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Tie 2"));
         pieces.push(new Piece("Accessory 1c",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Tie 3"));
         pieces.push(new Piece("Accessory 2",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Buckle 1"));
         pieces.push(new Piece("Accessory 2b",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Buckle 2"));
         pieces.push(new Piece("Accessory 2c",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Buckle 3"));
         pieces.push(new Piece("Accessory 3",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Panel"));
         pieces.push(new Piece("Accessory 4",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),true,"Badge"));
         pieces.push(new Piece("Accessory 5",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),false,"Cowl"));
         pieces.push(new Piece("Accessory 6",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),false,"Tie 4"));
         pieces.push(new Piece("Accessory 7",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_BACK,-1),true,"Sword 1"));
         pieces.push(new Piece("Accessory 8",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_BACK,-1),true,"Sword 2"));
         pieces.push(new Piece("Accessory 9",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_BACK,-1),true,"Shield"));
         pieces.push(new Piece("Accessory 10",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),false,"Necklace"));
         pieces.push(new Piece("Accessory Arm 1",Subcategory.ACCESSORY_UPPER,new Array(Surface.ARM_RIGHT_LEFT,Surface.ARM_RIGHT_FRONT,Surface.ARM_RIGHT_RIGHT,Surface.ARM_RIGHT_BACK),true,"Arm - Pads 1"));
         pieces.push(new Piece("Accessory Arm 2",Subcategory.ACCESSORY_UPPER,new Array(Surface.BODY_FRONT,-1),false,"Arm - Pads 2"));
         pieces.push(new Piece("Accessory Arm 3",Subcategory.ACCESSORY_UPPER,new Array(Surface.ARM_RIGHT_LEFT,Surface.ARM_RIGHT_FRONT,Surface.ARM_RIGHT_RIGHT,Surface.ARM_RIGHT_BACK),true,"Arm - Bracers"));
         pieces.push(new Piece("BowserBracers",Subcategory.ACCESSORY_UPPER,new Array(Surface.ARM_RIGHT_LEFT,Surface.ARM_RIGHT_FRONT,Surface.ARM_RIGHT_RIGHT,Surface.ARM_RIGHT_BACK),true,"Arm - Bracers 2"));
         pieces.push(new Piece("Pants 1",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Pants 2",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Pants 3",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Pants 4",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Bottom 1",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false,"Bikini Bottom 1"));
         pieces.push(new Piece("Bottom 2",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false,"Bikini Bottom 2"));
         pieces.push(new Piece("CamoPants",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false,"Pants 5"));
         pieces.push(new Piece("Speedo",Subcategory.PANTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false,"Speedo"));
         pieces.push(new Piece("Shoes 1",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Shoes 2",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Shoes 3",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Hooves",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Shoes 4",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Shoes 5",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Shoes 6",Subcategory.SHOES,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Skirt 1",Subcategory.SKIRTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Skirt 1b",Subcategory.SKIRTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Skirt 2",Subcategory.SKIRTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Skirt 3",Subcategory.SKIRTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Skirt 4",Subcategory.SKIRTS,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Accessory Leg 1",Subcategory.ACCESSORY_LOWER,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Accessory Leg 2",Subcategory.ACCESSORY_LOWER,new Array(Surface.LEG_RIGHT_FRONT,-1),false));
         pieces.push(new Piece("Full 1",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Rough"));
         pieces.push(new Piece("Full 2",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Outline"));
         pieces.push(new Piece("Full 3",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Muscle"));
         pieces.push(new Piece("Full 4",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Fur"));
         pieces.push(new Piece("Full 5",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Scale"));
         pieces.push(new Piece("BodyCobble",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Cobblestone"));
         pieces.push(new Piece("BodyDIRT",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Dirt"));
         pieces.push(new Piece("BodyStone",Subcategory.TEXTURES,new Array(Surface.BODY_FRONT,-1),false,"Stone"));
         pieces.sortOn("name");
         availableBlendModes = new Array(BlendMode.NORMAL,BlendMode.OVERLAY,BlendMode.MULTIPLY,BlendMode.SCREEN);
         KeyManager.init();
         addEventListener(Event.ENTER_FRAME,this.tick);
         stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUp);
         stage.addEventListener(Event.DEACTIVATE,this.gameLoseFocus);
         savedView = PreviewBox.VIEW_FRONT;
         medalPopup = new MedalPopup();
         medalPopup.x = 225;
         medalPopup.y = 318;
         addChild(medalPopup);
         addEventListener(Event.ENTER_FRAME,this.listenForLoad);
         sfxBtnClick = new button_click();
         sfxBtnHover = new button_hover();
         mirrorMatrix = new Matrix();
         mirrorMatrix.scale(-1,1);
         mirrorMatrix.translate(4,0);
         oldSkinRect = new Rectangle(0,0,64,32);
         sourceSurfaces = new Vector.<Surface>();
         destinationSurfaces = new Vector.<Surface>();
         sourceSurfaces.push(getSurface(Surface.LEG_RIGHT_TOP),getSurface(Surface.LEG_RIGHT_BOTTOM),getSurface(Surface.LEG_RIGHT_LEFT),getSurface(Surface.LEG_RIGHT_FRONT),getSurface(Surface.LEG_RIGHT_RIGHT),getSurface(Surface.LEG_RIGHT_BACK),getSurface(Surface.ARM_RIGHT_TOP),getSurface(Surface.ARM_RIGHT_BOTTOM),getSurface(Surface.ARM_RIGHT_LEFT),getSurface(Surface.ARM_RIGHT_FRONT),getSurface(Surface.ARM_RIGHT_RIGHT),getSurface(Surface.ARM_RIGHT_BACK));
         destinationSurfaces.push(getSurface(Surface.LEG_LEFT_TOP),getSurface(Surface.LEG_LEFT_BOTTOM),getSurface(Surface.LEG_LEFT_RIGHT),getSurface(Surface.LEG_LEFT_FRONT),getSurface(Surface.LEG_LEFT_LEFT),getSurface(Surface.LEG_LEFT_BACK),getSurface(Surface.ARM_LEFT_TOP),getSurface(Surface.ARM_LEFT_BOTTOM),getSurface(Surface.ARM_LEFT_RIGHT),getSurface(Surface.ARM_LEFT_FRONT),getSurface(Surface.ARM_LEFT_LEFT),getSurface(Surface.ARM_LEFT_BACK));
      }
      
      public static function getSubcategory(param1:uint) : Subcategory
      {
         for each(tempSubcategory in subcategories)
         {
            if(tempSubcategory.id == param1)
            {
               return tempSubcategory;
            }
         }
         return null;
      }
      
      public static function getPiece(param1:uint) : Piece
      {
         for each(tempPiece in pieces)
         {
            if(tempPiece.id == param1)
            {
               return tempPiece;
            }
         }
         return null;
      }
      
      public static function getCategory(param1:uint) : Category
      {
         for each(tempCategory in categories)
         {
            if(tempCategory.id == param1)
            {
               return tempCategory;
            }
         }
         return null;
      }
      
      public static function getSurface(param1:uint) : Surface
      {
         for each(tempSurface in surfaces)
         {
            if(tempSurface.id == param1)
            {
               return tempSurface;
            }
         }
         return null;
      }
      
      public static function convertBmpdTo1_8(param1:BitmapData) : BitmapData
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc7_:Rectangle = null;
         var _loc8_:Rectangle = null;
         var _loc9_:uint = 0;
         if(param1.width == 64 && param1.height == 32)
         {
            _loc2_ = new BitmapData(64,64,true,0);
            _loc2_.copyPixels(param1,oldSkinRect,Box3D.ORIGIN);
            _loc3_ = new BitmapData(4,12,true,0);
            _loc4_ = new BitmapData(4,4,true,0);
            _loc6_ = new Matrix();
            _loc9_ = 0;
            while(_loc9_ < sourceSurfaces.length)
            {
               _loc7_ = sourceSurfaces[_loc9_].sourceRect;
               _loc8_ = destinationSurfaces[_loc9_].sourceRect;
               (_loc5_ = _loc7_.height == 12 ? _loc3_ : _loc4_).copyPixels(param1,_loc7_,Box3D.ORIGIN);
               _loc6_.identity();
               _loc6_.scale(-1,1);
               _loc6_.translate(_loc8_.x + 4,_loc8_.y);
               _loc2_.draw(_loc5_,_loc6_);
               _loc9_++;
            }
            return _loc2_;
         }
         return param1;
      }
      
      public static function generateOKDialog(param1:String, param2:Boolean = false, param3:Boolean = false) : void
      {
         newDialogBox = new DialogBox(param1);
         newDialogBox.createAsOk("",param2,param3);
         newDialogBox.display();
      }
      
      public static function showDescription(param1:String) : void
      {
         rootRef.txtDescription.text = param1;
      }
      
      public static function getPresetSkin(param1:uint) : PresetSkin
      {
         for each(tempPresetSkin in presetSkins)
         {
            if(tempPresetSkin.id == param1)
            {
               return tempPresetSkin;
            }
         }
         return null;
      }
      
      public function changeColorIntensity(param1:Event) : void
      {
         layerToEdit.colorIntensity = uint(this.sldColorIntensity.value);
         this.updateSliderDisplays();
         this.mcPreviewBox.refreshView();
      }
      
      public function press_btnImportTXT(param1:MouseEvent) : void
      {
         this.cleanupMenuMain();
         gotoAndStop("import_txt","menu");
      }
      
      public function deselectAllLayers() : void
      {
         for each(tempLayer in curSkin.layers)
         {
            tempLayer.selected = false;
         }
      }
      
      public function enableImportGo() : void
      {
         this.btnGoImport.mouseEnabled = true;
         this.btnGoImport.alpha = 1;
      }
      
      public function initSharedLayerContent() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         this.btnBackToLayers.buttonMode = true;
         this.btnBackToLayers.addEventListener(MouseEvent.CLICK,this.press_btnBackToLayers);
         this.btnBackToLayers.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnBackToLayers.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.txtLayerName.text = layerToEdit.name;
         this.txtLayerName.maxChars = MAX_LAYER_NAME_LENGTH;
         this.sldOpacity.value = layerToEdit.opacity;
         this.sldOpacity.addEventListener(Event.CHANGE,this.opacityChange);
         this.sldBlur.value = layerToEdit.blur;
         this.sldBlur.addEventListener(SliderEvent.CHANGE,this.changeBlur);
         i = 0;
         while(i < availableBlendModes.length)
         {
            _loc1_ = availableBlendModes[i];
            _loc2_ = _loc1_.charAt(0).toUpperCase() + _loc1_.substr(1);
            this.cmbBlendModes.addItem({
               "label":_loc2_,
               "data":_loc1_
            });
            if(layerToEdit.blendMode == _loc1_)
            {
               this.cmbBlendModes.selectedIndex = i;
            }
            ++i;
         }
         this.cmbBlendModes.addEventListener(Event.CHANGE,this.changeBlendMode);
         this.cmbBlendModes.mouseFocusEnabled = false;
         this.updateSliderDisplays();
      }
      
      public function unlockMedal(param1:String) : void
      {
         var _loc2_:Medal = null;
         var _loc3_:Medal = null;
      }
      
      public function press_btnBackToLayers(param1:MouseEvent) : void
      {
         if(this.txtLayerName.text == "")
         {
            generateOKDialog("Layer names must be at least one character long");
            return;
         }
         layerToEdit.name = this.txtLayerName.text.substr(0,MAX_LAYER_NAME_LENGTH);
         if(currentLabel == "edit_custom_layer")
         {
            this.pixelEditor.cleanup();
            removeChild(this.pixelEditor);
            this.pixelEditor = null;
            this.mcToolFollow.visible = false;
            if(this.pixelEditorMask.hasEventListener(Event.ENTER_FRAME))
            {
               this.pixelEditorMask.removeEventListener(Event.ENTER_FRAME,this.checkForScroll);
            }
            this.pixelEditorMask = null;
         }
         this.unloadPreviewBox();
         gotoAndStop("edit_main");
      }
      
      public function press_btnBrowseUploads(param1:MouseEvent) : void
      {
         if(!API.connected)
         {
            generateOKDialog("You are not connected to the Newgrounds API");
            return;
         }
         this.cleanupMenuMain();
         gotoAndStop("browse","menu");
      }
      
      public function mouseUp(param1:MouseEvent) : void
      {
         var _loc2_:LayerBox = null;
         listenForDrag = false;
         if(cursorMode == CURSOR_DRAG)
         {
            _loc2_ = null;
            for each(tempLayerBox in layerBoxes)
            {
               if(tempLayerBox.eligibleForInsertion)
               {
                  _loc2_ = tempLayerBox;
                  break;
               }
            }
            if(_loc2_)
            {
               curSkin.moveLayerSelection(_loc2_);
               this.updateLayers();
               layerSelection.setRange(layerSelection.range);
            }
            this.stopDragLayerSelection();
         }
         if(cursorMode == CURSOR_DRAW)
         {
            cursorMode = CURSOR_FREE;
         }
         if(this.mcShiftMessage)
         {
            this.mcShiftMessage.visible = false;
         }
      }
      
      public function press_btnSearch(param1:MouseEvent) : void
      {
         this.mcSearchDialog.show();
      }
      
      public function press_btnExport(param1:MouseEvent) : void
      {
         this.mcExportDialog.show();
      }
      
      function __setProp_chkFlattenColor_editor_maincontent_10() : *
      {
         try
         {
            this.chkFlattenColor["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.chkFlattenColor.enabled = true;
         this.chkFlattenColor.label = "";
         this.chkFlattenColor.labelPlacement = "right";
         this.chkFlattenColor.selected = false;
         this.chkFlattenColor.visible = true;
         try
         {
            this.chkFlattenColor["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function createCategories() : void
      {
         categories = new Array();
         categories.push(new Category(Category.HEAD,"Head"));
         categories.push(new Category(Category.UPPER_BODY,"Upper Body"));
         categories.push(new Category(Category.LOWER_BODY,"Lower Body"));
         categories.push(new Category(Category.FULL,"Full Character"));
         subcategories = new Array();
         subcategories.push(new Subcategory(Subcategory.FACE,"Face",Category.HEAD));
         subcategories.push(new Subcategory(Subcategory.HAIR,"Hair",Category.HEAD));
         subcategories.push(new Subcategory(Subcategory.HATS_AND_MASKS,"Hats and Masks",Category.HEAD));
         subcategories.push(new Subcategory(Subcategory.GLASSES,"Glasses",Category.HEAD));
         subcategories.push(new Subcategory(Subcategory.ACCESSORY_HEAD,"Accessories",Category.HEAD));
         subcategories.push(new Subcategory(Subcategory.SHIRTS_AND_TIES,"Shirts and Tops",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.COATS,"Coats",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.GLOVES,"Gloves",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.TUNICS,"Tunics",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.CAPES,"Capes and Cloaks",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.BELTS,"Belts",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.PACKS,"Packs",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.SYMBOLS,"Symbols",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.ACCESSORY_UPPER,"Accessories",Category.UPPER_BODY));
         subcategories.push(new Subcategory(Subcategory.PANTS,"Pants and Bottoms",Category.LOWER_BODY));
         subcategories.push(new Subcategory(Subcategory.SHOES,"Shoes",Category.LOWER_BODY));
         subcategories.push(new Subcategory(Subcategory.SKIRTS,"Skirts",Category.LOWER_BODY));
         subcategories.push(new Subcategory(Subcategory.ACCESSORY_LOWER,"Accessories",Category.LOWER_BODY));
         subcategories.push(new Subcategory(Subcategory.TEXTURES,"Textures",Category.FULL));
      }
      
      public function voteComplete(param1:APIEvent) : *
      {
         if(param1.success)
         {
            this.unlockMedal("Passing Judgement");
         }
         else
         {
            generateOKDialog("You have already voted on this skin today");
         }
      }
      
      public function press_btnTool(param1:MouseEvent) : void
      {
         this.dehighlightTools();
         this.changeTool(uint(param1.currentTarget.toolID));
         param1.currentTarget.mcHighlight.visible = true;
      }
      
      public function changeBlur(param1:Event) : void
      {
         layerToEdit.blur = uint(this.sldBlur.value);
         this.updateSliderDisplays();
         this.mcPreviewBox.refreshView();
      }
      
      function frame10() : *
      {
         if(this.__setPropDict[this.lstLayers] == undefined || int(this.__setPropDict[this.lstLayers]) != 10)
         {
            this.__setPropDict[this.lstLayers] = 10;
            this.__setProp_lstLayers_editor_maincontent_9();
         }
         this.initEditor();
      }
      
      function frame11() : *
      {
         if(this.__setPropDict[this.sldBlur] == undefined || int(this.__setPropDict[this.sldBlur]) != 11)
         {
            this.__setPropDict[this.sldBlur] = 11;
            this.__setProp_sldBlur_editor_maincontent_10();
         }
         if(this.__setPropDict[this.sldTextureIntensity] == undefined || int(this.__setPropDict[this.sldTextureIntensity]) != 11)
         {
            this.__setPropDict[this.sldTextureIntensity] = 11;
            this.__setProp_sldTextureIntensity_editor_maincontent_10();
         }
         if(this.__setPropDict[this.sldColorIntensity] == undefined || int(this.__setPropDict[this.sldColorIntensity]) != 11)
         {
            this.__setPropDict[this.sldColorIntensity] = 11;
            this.__setProp_sldColorIntensity_editor_maincontent_10();
         }
         if(this.__setPropDict[this.chkFlattenColor] == undefined || int(this.__setPropDict[this.chkFlattenColor]) != 11)
         {
            this.__setPropDict[this.chkFlattenColor] = 11;
            this.__setProp_chkFlattenColor_editor_maincontent_10();
         }
         if(this.__setPropDict[this.cmbBlendModes] == undefined || int(this.__setPropDict[this.cmbBlendModes]) != 11)
         {
            this.__setPropDict[this.cmbBlendModes] = 11;
            this.__setProp_cmbBlendModes_editor_maincontent_10();
         }
         if(this.__setPropDict[this.chkInvertY] == undefined || int(this.__setPropDict[this.chkInvertY]) != 11)
         {
            this.__setPropDict[this.chkInvertY] = 11;
            this.__setProp_chkInvertY_editor_maincontent_10();
         }
         if(this.__setPropDict[this.chkInvertX] == undefined || int(this.__setPropDict[this.chkInvertX]) != 11)
         {
            this.__setPropDict[this.chkInvertX] = 11;
            this.__setProp_chkInvertX_editor_maincontent_10();
         }
         if(this.__setPropDict[this.sldOpacity] == undefined || int(this.__setPropDict[this.sldOpacity]) != 11)
         {
            this.__setPropDict[this.sldOpacity] = 11;
            this.__setProp_sldOpacity_editor_maincontent_10();
         }
         this.initLayerEditor();
      }
      
      function frame12() : *
      {
         if(this.__setPropDict[this.sldBlur] == undefined || int(this.__setPropDict[this.sldBlur]) != 12)
         {
            this.__setPropDict[this.sldBlur] = 12;
            this.__setProp_sldBlur_editor_maincontent_11();
         }
         if(this.__setPropDict[this.cmbBlendModes] == undefined || int(this.__setPropDict[this.cmbBlendModes]) != 12)
         {
            this.__setPropDict[this.cmbBlendModes] = 12;
            this.__setProp_cmbBlendModes_editor_maincontent_11();
         }
         if(this.__setPropDict[this.cmbEditorView] == undefined || int(this.__setPropDict[this.cmbEditorView]) != 12)
         {
            this.__setPropDict[this.cmbEditorView] = 12;
            this.__setProp_cmbEditorView_editor_maincontent_11();
         }
         if(this.__setPropDict[this.chkShowBase] == undefined || int(this.__setPropDict[this.chkShowBase]) != 12)
         {
            this.__setPropDict[this.chkShowBase] = 12;
            this.__setProp_chkShowBase_editor_maincontent_11();
         }
         if(this.__setPropDict[this.sldOpacity] == undefined || int(this.__setPropDict[this.sldOpacity]) != 12)
         {
            this.__setPropDict[this.sldOpacity] = 12;
            this.__setProp_sldOpacity_editor_maincontent_11();
         }
         this.initCustomLayerEditor();
      }
      
      public function rollOutDeleteSelection(param1:MouseEvent) : void
      {
         showDescription("");
      }
      
      public function transitionToMenu() : void
      {
         gotoAndStop("main","menu");
      }
      
      function __setProp_chkInvertY_editor_maincontent_10() : *
      {
         try
         {
            this.chkInvertY["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.chkInvertY.enabled = true;
         this.chkInvertY.label = "";
         this.chkInvertY.labelPlacement = "right";
         this.chkInvertY.selected = false;
         this.chkInvertY.visible = true;
         try
         {
            this.chkInvertY["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function dehighlightTools() : void
      {
         this.btnPencil.mcHighlight.visible = this.btnEraser.mcHighlight.visible = this.btnBucket.mcHighlight.visible = false;
      }
      
      public function press_btnCopyLayer(param1:MouseEvent) : void
      {
         if(!layerSelection)
         {
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
         var _loc2_:String = new String("[copy]" + layerSelection.layers[0].name).substr(0,MAX_LAYER_NAME_LENGTH);
         var _loc3_:Layer = layerSelection.layers[0];
         var _loc4_:Layer;
         (_loc4_ = _loc3_.copy()).name = _loc2_;
         this.deselectAllLayers();
         curSkin.addLayer(_loc4_);
         layerSelection = new LayerSelection(_loc4_,0);
         this.updateLayers();
      }
      
      function __setProp___id3__loader_main_0() : *
      {
         try
         {
            this.__id3_["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.__id3_.apiId = "17500:7T83u8oj";
         this.__id3_.encryptionKey = "vD9dfdOksou4zWbkhx9vOYqGpoKmh01V";
         this.__id3_.debugMode = "Off";
         this.__id3_.movieVersion = "";
         this.__id3_.connectorType = "Invisible";
         try
         {
            this.__id3_["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_lstLayers_editor_maincontent_9() : *
      {
         try
         {
            this.lstLayers["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.lstLayers.enabled = true;
         this.lstLayers.horizontalLineScrollSize = 4;
         this.lstLayers.horizontalPageScrollSize = 0;
         this.lstLayers.horizontalScrollPolicy = "off";
         this.lstLayers.scrollDrag = false;
         this.lstLayers.source = "";
         this.lstLayers.verticalLineScrollSize = 4;
         this.lstLayers.verticalPageScrollSize = 0;
         this.lstLayers.verticalScrollPolicy = "on";
         this.lstLayers.visible = true;
         try
         {
            this.lstLayers["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function createPresetSkins() : void
      {
         presetSkins = new Vector.<PresetSkin>();
         presetSkins.push(new PresetSkin(0,"Blank"));
         presetSkins.push(new PresetSkin(1,"Steve"));
         presetSkins.push(new PresetSkin(2,"Skin 1"));
         presetSkins.push(new PresetSkin(3,"Skin 2"));
         presetSkins.push(new PresetSkin(4,"Skin 3"));
         presetSkins.push(new PresetSkin(5,"Robot"));
      }
      
      function frame2() : *
      {
         if(this.__setPropDict[this.__id3_] == undefined || !(int(this.__setPropDict[this.__id3_]) >= 1 && int(this.__setPropDict[this.__id3_]) <= 2))
         {
            this.__setPropDict[this.__id3_] = currentFrame;
            this.__setProp___id3__loader_main_0();
         }
         this.finishLoadScreen();
      }
      
      public function loadPreviewBox(param1:int, param2:int, param3:Number = 1) : void
      {
         this.mcPreviewBox = new PreviewBox();
         this.mcPreviewBox.x = param1;
         this.mcPreviewBox.y = param2;
         this.mcPreviewBox.scaleX = this.mcPreviewBox.scaleY = param3;
         if(curSkin)
         {
            this.mcPreviewBox.skin = curSkin;
            this.mcPreviewBox.loadBase(curSkin.baseBitmapData);
            this.mcPreviewBox.refreshView();
         }
         if(currentLabel == "edit_custom_layer")
         {
            addChildAt(this.mcPreviewBox,getChildIndex(this.mcPanel) + 1);
         }
         else
         {
            addChildAt(this.mcPreviewBox,getChildIndex(this.mcDirtBG) + 1);
         }
      }
      
      public function changeChkShowBase(param1:Event) : void
      {
         stage.focus = null;
         if(this.chkShowBase.selected)
         {
            this.pixelEditor.showBase();
         }
         else
         {
            this.pixelEditor.hideBase();
         }
      }
      
      public function press_btnGoPreset(param1:MouseEvent) : void
      {
         curSkin = new Skin();
         curSkin.baseBitmapData = this.mcPreviewBox.sourceBitmapData.clone();
         this.editorFirstInit = true;
         this.cleanupMenuPresets();
         sfxBtnClick.play();
         gotoAndStop("edit_main","editor");
      }
      
      public function rollOutHideSelection(param1:MouseEvent) : void
      {
         showDescription("");
      }
      
      function frame8() : *
      {
         this.initMenuImportTXT();
      }
      
      function frame9() : *
      {
         if(this.__setPropDict[this.voteBar] == undefined || int(this.__setPropDict[this.voteBar]) != 9)
         {
            this.__setPropDict[this.voteBar] = 9;
            this.__setProp_voteBar_menu_Layer1_8();
         }
         if(this.__setPropDict[this.saveBrowser] == undefined || int(this.__setPropDict[this.saveBrowser]) != 9)
         {
            this.__setPropDict[this.saveBrowser] = 9;
            this.__setProp_saveBrowser_menu_Layer1_8();
         }
         this.initMenuBrowse();
      }
      
      public function initMenuImportPNG() : void
      {
         this.btnGoImport.buttonMode = true;
         this.btnGoImport.addEventListener(MouseEvent.CLICK,this.press_btnGoImport);
         this.disableImportGo();
         this.btnBackFromImport.buttonMode = true;
         this.btnBackFromImport.addEventListener(MouseEvent.CLICK,this.press_btnBackFromImport);
         this.btnBrowse.addEventListener(MouseEvent.CLICK,this.press_btnBrowse);
         this.btnBrowse.buttonMode = true;
         this.importFileReference = new FileReference();
         this.importFileReference.addEventListener(Event.SELECT,this.referenceBrowse);
         this.importFileReference.addEventListener(Event.COMPLETE,this.referenceLoaded);
         this.importFileReference.addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.btnLoad.addEventListener(MouseEvent.CLICK,this.press_btnLoad);
         this.btnLoad.buttonMode = true;
         this.importLoader = new Loader();
         this.importLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.fileLoaded);
         this.importLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.importLoader.addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
      }
      
      function frame5() : *
      {
         this.initMenuMain();
      }
      
      function frame6() : *
      {
         this.initMenuPresets();
      }
      
      function frame7() : *
      {
         this.initMenuImportPNG();
      }
      
      public function cleanupMenuMain() : void
      {
         this.mcTankLogo.removeEventListener(MouseEvent.CLICK,this.clickTank);
         this.btnPresets.removeEventListener(MouseEvent.CLICK,this.press_btnPresets);
         this.btnImportPNG.removeEventListener(MouseEvent.CLICK,this.press_btnImportPNG);
         this.btnImportTXT.removeEventListener(MouseEvent.CLICK,this.press_btnImportTXT);
         Utilities.cleanupMCBtn(this.btnPresets);
         Utilities.cleanupMCBtn(this.btnImportPNG);
         Utilities.cleanupMCBtn(this.btnImportTXT);
         Utilities.cleanupMCBtn(this.btnBrowseUploads);
      }
      
      public function press_btnBackFromEditor(param1:MouseEvent) : void
      {
         Main.newDialogBox = new DialogBox("Are you sure you want to return to the menu? Unsaved progress will be lost");
         Main.newDialogBox.createAsYesNo("BACKTOMENU");
         Main.newDialogBox.display();
      }
      
      function frame1() : *
      {
         if(this.__setPropDict[this.__id3_] == undefined || !(int(this.__setPropDict[this.__id3_]) >= 1 && int(this.__setPropDict[this.__id3_]) <= 2))
         {
            this.__setPropDict[this.__id3_] = currentFrame;
            this.__setProp___id3__loader_main_0();
         }
      }
      
      public function press_btnBackFromPresets(param1:MouseEvent) : void
      {
         this.cleanupMenuPresets();
         gotoAndStop("main","menu");
      }
      
      function __setProp_sldOpacity_editor_maincontent_10() : *
      {
         try
         {
            this.sldOpacity["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldOpacity.direction = "horizontal";
         this.sldOpacity.enabled = true;
         this.sldOpacity.liveDragging = true;
         this.sldOpacity.maximum = 100;
         this.sldOpacity.minimum = 0;
         this.sldOpacity.snapInterval = 0;
         this.sldOpacity.tickInterval = 0;
         this.sldOpacity.value = 0;
         this.sldOpacity.visible = true;
         try
         {
            this.sldOpacity["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      function __setProp_sldOpacity_editor_maincontent_11() : *
      {
         try
         {
            this.sldOpacity["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldOpacity.direction = "horizontal";
         this.sldOpacity.enabled = true;
         this.sldOpacity.liveDragging = true;
         this.sldOpacity.maximum = 100;
         this.sldOpacity.minimum = 0;
         this.sldOpacity.snapInterval = 0;
         this.sldOpacity.tickInterval = 0;
         this.sldOpacity.value = 0;
         this.sldOpacity.visible = true;
         try
         {
            this.sldOpacity["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function disableImportGo() : void
      {
         this.btnGoImport.mouseEnabled = false;
         this.btnGoImport.alpha = 0.2;
      }
      
      public function press_btnShowSelection(param1:MouseEvent) : void
      {
         if(layerSelection == null)
         {
            return;
         }
         var _loc2_:Boolean = false;
         for each(tempLayer in layerSelection.layers)
         {
            if(tempLayer.hidden)
            {
               _loc2_ = true;
               break;
            }
         }
         if(_loc2_)
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
         this.updateLayers();
      }
      
      public function createSurfaces() : void
      {
         surfaces = new Vector.<Surface>();
         surfaces.push(new Surface(Surface.HEAD_LEFT,"Head Left",new Rectangle(0,8,8,8),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.HEAD_FRONT,"Head Front",new Rectangle(8,8,8,8),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.HEAD_RIGHT,"Head Right",new Rectangle(16,8,8,8),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.HEAD_BACK,"Head Back",new Rectangle(24,8,8,8),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.HEAD_TOP,"Head Top",new Rectangle(8,0,8,8),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.HEAD_BOTTOM,"Head Bottom",new Rectangle(16,0,8,8),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.ARM_RIGHT_LEFT,"Right Arm Outside",new Rectangle(40,20,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.ARM_RIGHT_FRONT,"Right Arm Front",new Rectangle(44,20,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.ARM_RIGHT_RIGHT,"Right Arm Inside",new Rectangle(48,20,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.ARM_RIGHT_BACK,"Right Arm Back",new Rectangle(52,20,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.ARM_RIGHT_TOP,"Right Arm Top",new Rectangle(44,16,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.ARM_RIGHT_BOTTOM,"Right Arm Bottom",new Rectangle(48,16,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.BODY_LEFT,"Body Left",new Rectangle(16,20,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.BODY_FRONT,"Body Front",new Rectangle(20,20,8,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.BODY_RIGHT,"Body Right",new Rectangle(28,20,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.BODY_BACK,"Body Back",new Rectangle(32,20,8,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.BODY_TOP,"Body Top",new Rectangle(20,16,8,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.BODY_BOTTOM,"Body Bottom",new Rectangle(28,16,8,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.LEG_RIGHT_LEFT,"Right Leg Outside",new Rectangle(0,20,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.LEG_RIGHT_FRONT,"Right Leg Front",new Rectangle(4,20,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.LEG_RIGHT_RIGHT,"Right Leg Inside",new Rectangle(8,20,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.LEG_RIGHT_BACK,"Right Leg Back",new Rectangle(12,20,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.LEG_RIGHT_TOP,"Right Leg Top",new Rectangle(4,16,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.LEG_RIGHT_BOTTOM,"Right Leg Bottom",new Rectangle(8,16,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.HAT_LEFT,"Hat Left",new Rectangle(32,8,8,8),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.HAT_FRONT,"Hat Front",new Rectangle(40,8,8,8),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.HAT_RIGHT,"Hat Right",new Rectangle(48,8,8,8),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.HAT_BACK,"Hat Back",new Rectangle(56,8,8,8),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.HAT_TOP,"Hat Top",new Rectangle(40,0,8,8),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.HAT_BOTTOM,"Hat Bottom",new Rectangle(48,0,8,8),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.ARM_LEFT_LEFT,"Left Arm Inside",new Rectangle(32,52,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.ARM_LEFT_FRONT,"Left Arm Front",new Rectangle(36,52,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.ARM_LEFT_RIGHT,"Left Arm Outside",new Rectangle(40,52,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.ARM_LEFT_BACK,"Left Arm Back",new Rectangle(44,52,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.ARM_LEFT_TOP,"Left Arm Top",new Rectangle(36,48,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.ARM_LEFT_BOTTOM,"Left Arm Bottom",new Rectangle(40,48,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.LEG_LEFT_LEFT,"Left Leg Inside",new Rectangle(16,52,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.LEG_LEFT_FRONT,"Left Leg Front",new Rectangle(20,52,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.LEG_LEFT_RIGHT,"Left Leg Outside",new Rectangle(24,52,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.LEG_LEFT_BACK,"Left Leg Back",new Rectangle(28,52,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.LEG_LEFT_TOP,"Left Leg Top",new Rectangle(20,48,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.LEG_LEFT_BOTTOM,"Left Leg Bottom",new Rectangle(24,48,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.BODY_LEFT_JACKET,"Body Jacket Left",new Rectangle(16,36,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.BODY_FRONT_JACKET,"Body Jacket Front",new Rectangle(20,36,8,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.BODY_RIGHT_JACKET,"Body Jacket Right",new Rectangle(28,36,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.BODY_BACK_JACKET,"Body Jacket Back",new Rectangle(32,36,8,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.BODY_TOP_JACKET,"Body Jacket Top",new Rectangle(20,32,8,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.BODY_BOTTOM_JACKET,"Body Jacket Bottom",new Rectangle(28,32,8,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.ARM_RIGHT_LEFT_JACKET,"Right Arm Jacket Outside",new Rectangle(40,36,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.ARM_RIGHT_FRONT_JACKET,"Right Arm Jacket Front",new Rectangle(44,36,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.ARM_RIGHT_RIGHT_JACKET,"Right Arm Jacket Inside",new Rectangle(48,36,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.ARM_RIGHT_BACK_JACKET,"Right Arm Jacket Back",new Rectangle(52,36,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.ARM_RIGHT_TOP_JACKET,"Right Arm Jacket Top",new Rectangle(44,32,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.ARM_RIGHT_BOTTOM_JACKET,"Right Arm Jacket Bottom",new Rectangle(48,32,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.LEG_RIGHT_LEFT_JACKET,"Right Leg Jacket Outside",new Rectangle(0,36,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.LEG_RIGHT_FRONT_JACKET,"Right Leg Jacket Front",new Rectangle(4,36,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.LEG_RIGHT_RIGHT_JACKET,"Right Leg Jacket Inside",new Rectangle(8,36,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.LEG_RIGHT_BACK_JACKET,"Right Leg Jacket Back",new Rectangle(12,36,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.LEG_RIGHT_TOP_JACKET,"Right Leg Jacket Top",new Rectangle(4,32,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.LEG_RIGHT_BOTTOM_JACKET,"Right Leg Jacket Bottom",new Rectangle(8,32,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.ARM_LEFT_LEFT_JACKET,"Left Arm Jacket Inside",new Rectangle(48,52,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.ARM_LEFT_FRONT_JACKET,"Left Arm Jacket Front",new Rectangle(52,52,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.ARM_LEFT_RIGHT_JACKET,"Left Arm Jacket Outside",new Rectangle(56,52,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.ARM_LEFT_BACK_JACKET,"Left Arm Jacket Back",new Rectangle(60,52,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.ARM_LEFT_TOP_JACKET,"Left Arm Jacket Top",new Rectangle(52,48,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.ARM_LEFT_BOTTOM_JACKET,"Left Arm Jacket Bottom",new Rectangle(56,48,4,4),PreviewBox.VIEW_BOTTOM));
         surfaces.push(new Surface(Surface.LEG_LEFT_LEFT_JACKET,"Left Leg Jacket Inside",new Rectangle(0,52,4,12),PreviewBox.VIEW_LEFT));
         surfaces.push(new Surface(Surface.LEG_LEFT_FRONT_JACKET,"Left Leg Jacket Front",new Rectangle(4,52,4,12),PreviewBox.VIEW_FRONT));
         surfaces.push(new Surface(Surface.LEG_LEFT_RIGHT_JACKET,"Left Leg Jacket Outside",new Rectangle(8,52,4,12),PreviewBox.VIEW_RIGHT));
         surfaces.push(new Surface(Surface.LEG_LEFT_BACK_JACKET,"Left Leg Jacket Back",new Rectangle(12,52,4,12),PreviewBox.VIEW_BACK));
         surfaces.push(new Surface(Surface.LEG_LEFT_TOP_JACKET,"Left Leg Jacket Top",new Rectangle(4,48,4,4),PreviewBox.VIEW_TOP));
         surfaces.push(new Surface(Surface.LEG_LEFT_BOTTOM_JACKET,"Left Leg Jacket Bottom",new Rectangle(8,48,4,4),PreviewBox.VIEW_BOTTOM));
      }
      
      public function cleanupMenuBrowse() : void
      {
         ngSaveFile = null;
         this.mcPreviewBox.cleanup();
         removeChild(this.mcPreviewBox);
         API.removeEventListener(APIEvent.FILE_LOADED,this.skinLoaded);
         API.removeEventListener(APIEvent.VOTE_COMPLETE,this.voteComplete);
         this.btnBackFromBrowse.removeEventListener(MouseEvent.CLICK,this.press_btnBackFromBrowse);
         this.btnSearch.removeEventListener(MouseEvent.CLICK,this.press_btnSearch);
         this.btnClearSearch.removeEventListener(MouseEvent.CLICK,this.press_btnClearSearch);
         removeChild(this.saveBrowser);
         removeChild(this.voteBar);
         this.saveBrowser = null;
         this.voteBar = null;
      }
      
      public function clickTank(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://newgrounds.com");
      }
      
      public function ioError(param1:IOErrorEvent) : void
      {
         generateOKDialog("There was an error opening the file");
         this.enableBack();
      }
      
      public function initEditor() : void
      {
         if(this.editorFirstInit)
         {
            this.editorFirstInit = false;
            showAdvancedOptions = false;
            curTool = TOOL_NONE;
            savedView = PreviewBox.VIEW_FRONT;
            layerSelection = null;
            this.savedLayerScrollPosition = 0;
            this.mcToolFollow = new ToolFollow();
            this.mcToolFollow.mouseEnabled = this.mcToolFollow.mouseChildren = false;
            this.mcToolFollow.visible = false;
            this.mcToolFollow.cacheAsBitmap = true;
            addChild(this.mcToolFollow);
            i = 0;
            while(i < 1)
            {
               ++i;
            }
            dummySkin = new Skin();
            dummySkin.baseBitmapData = curSkin.baseBitmapData.clone();
         }
         this.mcTut1.visible = Utilities.saveFile.firstTime;
         if(this.mcTut1.visible)
         {
            this.btnAddLayer.filters = new Array(new GlowFilter(4294967295,1,12,12,3,2));
         }
         this.checkForSecondTutorialClip();
         this.loadPreviewBox(413,67,1);
         this.txtSkinName.text = curSkin.name;
         this.txtSkinName.maxChars = MAX_LAYER_NAME_LENGTH;
         this.txtSkinName.addEventListener(Event.CHANGE,this.changeSkinName);
         this.btnBackFromEditor.buttonMode = true;
         this.btnAddLayer.buttonMode = true;
         this.btnCopyLayer.buttonMode = true;
         this.btnExport.buttonMode = true;
         this.btnCopyLayer.addEventListener(MouseEvent.CLICK,this.press_btnCopyLayer);
         this.btnCopyLayer.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnCopyLayer.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnAddLayer.addEventListener(MouseEvent.CLICK,this.press_btnAddLayer);
         this.btnAddLayer.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnAddLayer.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnBackFromEditor.addEventListener(MouseEvent.CLICK,this.press_btnBackFromEditor);
         this.btnBackFromEditor.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnBackFromEditor.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnExport.addEventListener(MouseEvent.CLICK,this.press_btnExport);
         this.btnExport.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnExport.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnShowSelection.buttonMode = true;
         this.btnDeleteSelection.buttonMode = true;
         this.btnShowSelection.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnDeleteSelection.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnDeleteSelection.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnShowSelection.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnShowSelection.addEventListener(MouseEvent.CLICK,this.press_btnShowSelection);
         this.btnDeleteSelection.addEventListener(MouseEvent.CLICK,this.press_btnDeleteSelection);
         this.lstLayers.horizontalScrollPolicy = ScrollPolicy.OFF;
         this.lstLayers.tabEnabled = false;
         this.lstLayers.mouseFocusEnabled = false;
         layerBoxes = new Vector.<LayerBox>();
         this.updateLayers();
         cursorMode = CURSOR_FREE;
         this.mcGroupIndicator.mouseEnabled = this.mcGroupIndicator.mouseChildren = false;
      }
      
      public function fileLoaded(param1:Event) : void
      {
         var importBitmap:Bitmap = null;
         var e:Event = param1;
         this.enableBack();
         if(!(this.importLoader.width == SKIN_WIDTH && this.importLoader.height == SKIN_HEIGHT) && !(this.importLoader.width == SKIN_WIDTH && this.importLoader.height == SKIN_HEIGHT / 2))
         {
            generateOKDialog("PNG must be exactly " + SKIN_WIDTH + "x" + SKIN_HEIGHT + " or 64x32");
            return;
         }
         try
         {
            importBitmap = this.importLoader.content as Bitmap;
            savedView = PreviewBox.VIEW_FRONT;
            importBitmap.bitmapData = convertBmpdTo1_8(importBitmap.bitmapData);
            this.mcPreviewBox.loadBase(importBitmap.bitmapData);
         }
         catch(e:Error)
         {
            ioError(null);
            return;
         }
         this.mcPreviewBox.refreshView();
         this.enableImportGo();
      }
      
      public function selectAllLayers() : void
      {
         if(curSkin.layers.length == 0)
         {
            return;
         }
         for each(tempLayer in curSkin.layers)
         {
            tempLayer.selected = true;
         }
         layerSelection = new LayerSelection(curSkin.layers[0],curSkin.layers.length);
      }
      
      public function startListeningForGroupDrag() : void
      {
         dragDelayFrames = 0;
         dragStartX = mouseX;
         dragStartY = mouseY;
         listenForDrag = true;
      }
      
      function __setProp_chkShowBase_editor_maincontent_11() : *
      {
         try
         {
            this.chkShowBase["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.chkShowBase.enabled = true;
         this.chkShowBase.label = "";
         this.chkShowBase.labelPlacement = "right";
         this.chkShowBase.selected = false;
         this.chkShowBase.visible = true;
         try
         {
            this.chkShowBase["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function listenForAPIConnected(param1:Event) : void
      {
         if(API.connected)
         {
            removeEventListener(Event.ENTER_FRAME,this.listenForAPIConnected);
            API.loadSaveFile(loaderInfo.parameters.NewgroundsAPI_SaveFileID);
            API.addEventListener(APIEvent.FILE_LOADED,this.preskinLoaded);
         }
      }
      
      public function initMenuImportTXT() : void
      {
         this.btnGoImport.buttonMode = true;
         this.btnGoImport.addEventListener(MouseEvent.CLICK,this.press_btnGoImport);
         this.disableImportGo();
         this.btnBackFromImport.buttonMode = true;
         this.btnBackFromImport.addEventListener(MouseEvent.CLICK,this.press_btnBackFromImport);
         this.btnBrowse.addEventListener(MouseEvent.CLICK,this.press_btnBrowse);
         this.btnBrowse.buttonMode = true;
         this.importFileReference = new FileReference();
         this.importFileReference.addEventListener(Event.SELECT,this.referenceBrowse);
         this.importFileReference.addEventListener(Event.COMPLETE,this.referenceLoadedTXT);
         this.importFileReference.addEventListener(IOErrorEvent.IO_ERROR,this.ioError);
      }
      
      public function showCurPreset(param1:Event = null) : void
      {
         savedView = PreviewBox.VIEW_FRONT;
         var _loc2_:PresetSkin = getPresetSkin(this.lstPresets.selectedItem.data);
         this.mcPreviewBox.loadBase(_loc2_.getBitmapData());
         this.mcPreviewBox.refreshView();
      }
      
      function __setProp_saveBrowser_menu_Layer1_8() : *
      {
         try
         {
            this.saveBrowser["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.saveBrowser.saveGroupName = "skins";
         this.saveBrowser.title = "User Created Skins";
         this.saveBrowser.sortDescending = true;
         this.saveBrowser.sortField = "createdOn";
         this.saveBrowser.customSortField = "";
         try
         {
            this.saveBrowser["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function preskinLoaded(param1:APIEvent) : *
      {
         if(param1.success)
         {
            preloadNGSaveFile = SaveFile(param1.data);
            gotoAndStop("browse","menu");
         }
         API.removeEventListener(APIEvent.FILE_LOADED,this.preskinLoaded);
      }
      
      public function clickSkincraftPack(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://afro-ninja.com/skincraft");
      }
      
      public function checkForScroll(param1:Event) : *
      {
         if(this.pixelEditorMask.getRect(Main.rootRef).contains(mouseX,mouseY))
         {
            if(this.pixelEditorMask.mouseY < 50)
            {
               this.pixelEditor.y += 2;
            }
            else if(this.pixelEditorMask.mouseY > this.pixelEditorMask.height - 50)
            {
               this.pixelEditor.y -= 2;
            }
         }
         if(this.pixelEditor.y > this.pixelEditorMask.y)
         {
            this.pixelEditor.y = this.pixelEditorMask.y;
         }
         else if(this.pixelEditor.y + this.pixelEditor.height < this.pixelEditorMask.y + this.pixelEditorMask.height)
         {
            this.pixelEditor.y = this.pixelEditorMask.y + this.pixelEditorMask.height - this.pixelEditor.height;
         }
      }
      
      public function initCustomLayerEditor() : void
      {
         this.initSharedLayerContent();
         var _loc1_:uint = CustomLayer(layerToEdit).targetView;
         this.pixelEditor = new PixelEditor(10,65);
         addChild(this.pixelEditor);
         this.pixelEditor.drawView(_loc1_);
         if(_loc1_ == PixelEditor.VIEW_ARM_RIGHT || _loc1_ == PixelEditor.VIEW_ARM_LEFT || _loc1_ == PixelEditor.VIEW_LEG_RIGHT || _loc1_ == PixelEditor.VIEW_LEG_LEFT || _loc1_ == PixelEditor.VIEW_ARM_LEFT_JACKET || _loc1_ == PixelEditor.VIEW_ARM_RIGHT_JACKET || _loc1_ == PixelEditor.VIEW_LEG_LEFT_JACKET || _loc1_ == PixelEditor.VIEW_LEG_RIGHT_JACKET)
         {
            this.loadPreviewBox(400,105,0.7);
         }
         else if(_loc1_ == PixelEditor.VIEW_BODY || _loc1_ == PixelEditor.VIEW_BODY_JACKET)
         {
            this.loadPreviewBox(450,105,0.7);
         }
         else
         {
            this.loadPreviewBox(535,115,0.6);
         }
         if(_loc1_ == PixelEditor.VIEW_ALL)
         {
            this.pixelEditorMask = new Bitmap(new BitmapData(1 + PixelEditor.PIXEL_SCALE * 64,1 + PixelEditor.PIXEL_SCALE * 32,false,16711680));
         }
         else
         {
            this.pixelEditorMask = new Bitmap(new BitmapData(1 + PixelEditor.PIXEL_SCALE * this.pixelEditor.curViewRect.width,1 + PixelEditor.PIXEL_SCALE * this.pixelEditor.curViewRect.height,false,16711680));
         }
         this.pixelEditorMask.x = this.pixelEditor.x;
         this.pixelEditorMask.y = this.pixelEditor.y;
         this.pixelEditor.mask = this.pixelEditorMask;
         if(_loc1_ == PixelEditor.VIEW_ALL)
         {
            this.pixelEditorMask.addEventListener(Event.ENTER_FRAME,this.checkForScroll);
         }
         this.txtSpecialMessage.text = "";
         if(_loc1_ == PixelEditor.VIEW_HAT || _loc1_ == PixelEditor.VIEW_BODY_JACKET || _loc1_ == PixelEditor.VIEW_ARM_LEFT_JACKET || _loc1_ == PixelEditor.VIEW_ARM_RIGHT_JACKET || _loc1_ == PixelEditor.VIEW_LEG_LEFT_JACKET || _loc1_ == PixelEditor.VIEW_LEG_RIGHT_JACKET)
         {
            this.sldBlur.mouseEnabled = this.sldBlur.visible = false;
            this.sldOpacity.mouseEnabled = this.sldOpacity.visible = false;
            this.txtBlurValue.text = this.txtOpacityValue.text = "";
            this.mcLabelBlur.visible = this.mcLabelOpacity.visible = false;
            this.txtSpecialMessage.text = "*Content in Hat/Jacket layers will always appear above other layers";
         }
         else if(_loc1_ == PixelEditor.VIEW_ALL)
         {
            this.txtSpecialMessage.text = "*Minecraft does not support transparent pixels in Hat surfaces";
         }
         this.mcShiftMessage.visible = false;
         this.chkShowBase.selected = true;
         this.chkShowBase.addEventListener(Event.CHANGE,this.changeChkShowBase);
         this.chkShowBase.mouseFocusEnabled = false;
         this.btnPencil.toolID = TOOL_PENCIL;
         this.btnEraser.toolID = TOOL_ERASER;
         this.btnBucket.toolID = TOOL_BUCKET;
         this.btnBucket.buttonMode = this.btnPencil.buttonMode = this.btnEraser.buttonMode = true;
         this.btnUndo.buttonMode = true;
         this.btnUndo.mouseChildren = false;
         this.btnPencil.mcHighlight.visible = this.btnEraser.mcHighlight.visible = this.btnBucket.mcHighlight.visible = false;
         this.btnPencil.mouseChildren = this.btnEraser.mouseChildren = this.btnBucket.mouseChildren = false;
         this.btnPencil.addEventListener(MouseEvent.CLICK,this.press_btnTool);
         this.btnEraser.addEventListener(MouseEvent.CLICK,this.press_btnTool);
         this.btnBucket.addEventListener(MouseEvent.CLICK,this.press_btnTool);
         this.btnUndo.addEventListener(MouseEvent.CLICK,this.press_btnUndo);
         this.mcToolFollow.visible = false;
         setChildIndex(this.mcToolFollow,numChildren - 1);
         curTool = TOOL_NONE;
         this.updateUndoButton();
         i = 0;
         while(i < PixelEditor.viewNames.length)
         {
            this.cmbEditorView.addItem({
               "label":PixelEditor.viewNames[i],
               "data":i
            });
            ++i;
         }
         this.cmbEditorView.addEventListener(Event.CHANGE,this.changeEditorView);
         this.cmbEditorView.mouseFocusEnabled = false;
         this.txtSurfaceName.text = "";
         this.changeTool(TOOL_PENCIL);
         this.btnPencil.mcHighlight.visible = true;
      }
      
      function __setProp_sldColorIntensity_editor_maincontent_10() : *
      {
         try
         {
            this.sldColorIntensity["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldColorIntensity.direction = "horizontal";
         this.sldColorIntensity.enabled = true;
         this.sldColorIntensity.liveDragging = true;
         this.sldColorIntensity.maximum = 100;
         this.sldColorIntensity.minimum = 0;
         this.sldColorIntensity.snapInterval = 0;
         this.sldColorIntensity.tickInterval = 0;
         this.sldColorIntensity.value = 0;
         this.sldColorIntensity.visible = true;
         try
         {
            this.sldColorIntensity["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function press_btnBackFromImport(param1:MouseEvent) : void
      {
         if(currentLabel == "import_png")
         {
            this.cleanupMenuImportPNG();
         }
         else if(currentLabel == "import_txt")
         {
            if(curSkin)
            {
               curSkin.cleanup();
               curSkin = null;
            }
            this.cleanupMenuImportTXT();
         }
         gotoAndStop("main","menu");
      }
      
      public function updateUndoButton() : void
      {
         if(this.pixelEditor.undoLog.length > 0)
         {
            this.btnUndo.mouseEnabled = true;
            this.btnUndo.alpha = 1;
         }
         else
         {
            this.btnUndo.mouseEnabled = false;
            this.btnUndo.alpha = 0.3;
         }
      }
      
      public function initMenuMain() : void
      {
         this.mcTankLogo.buttonMode = true;
         this.mcTankLogo.addEventListener(MouseEvent.CLICK,this.clickTank);
         this.btnPresets.addEventListener(MouseEvent.CLICK,this.press_btnPresets);
         this.btnImportPNG.addEventListener(MouseEvent.CLICK,this.press_btnImportPNG);
         this.btnImportTXT.addEventListener(MouseEvent.CLICK,this.press_btnImportTXT);
         this.btnBrowseUploads.addEventListener(MouseEvent.CLICK,this.press_btnBrowseUploads);
         Utilities.mc2Btn(this.btnPresets);
         Utilities.mc2Btn(this.btnImportPNG);
         Utilities.mc2Btn(this.btnImportTXT);
         Utilities.mc2Btn(this.btnBrowseUploads);
      }
      
      public function checkForSecondTutorialClip() : void
      {
         if(curSkin.layers.length == 1 && Utilities.saveFile.firstLayer)
         {
            this.mcTut2.visible = true;
         }
         else
         {
            this.mcTut2.visible = false;
         }
      }
      
      public function gameLoseFocus(param1:Event) : void
      {
         listenForDrag = false;
         if(cursorMode == CURSOR_DRAG)
         {
            this.stopDragLayerSelection();
         }
         if(cursorMode == CURSOR_DRAW)
         {
            cursorMode = CURSOR_FREE;
         }
         KeyManager.releaseAllKeys();
      }
      
      public function initLayerEditor() : void
      {
         this.initSharedLayerContent();
         this.loadPreviewBox(413,67,1);
         this.mcPreviewBox.mcBGLabel.visible = false;
         if(getPiece(PremadeLayer(layerToEdit).targetPieceID).canMove)
         {
            this.chkInvertX.selected = layerToEdit.invertX;
            this.chkInvertY.selected = layerToEdit.invertY;
            this.chkInvertX.addEventListener(Event.CHANGE,this.changeEitherInversion);
            this.chkInvertY.addEventListener(Event.CHANGE,this.changeEitherInversion);
            this.btnArrowUp.buttonMode = this.btnArrowDown.buttonMode = this.btnArrowLeft.buttonMode = this.btnArrowRight.buttonMode = true;
            this.btnArrowUp.direction = UP;
            this.btnArrowDown.direction = DOWN;
            this.btnArrowLeft.direction = LEFT;
            this.btnArrowRight.direction = RIGHT;
            this.btnArrowUp.addEventListener(MouseEvent.CLICK,this.press_btnArrow);
            this.btnArrowUp.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
            this.btnArrowUp.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
            this.btnArrowDown.addEventListener(MouseEvent.CLICK,this.press_btnArrow);
            this.btnArrowDown.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
            this.btnArrowDown.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
            this.btnArrowLeft.addEventListener(MouseEvent.CLICK,this.press_btnArrow);
            this.btnArrowLeft.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
            this.btnArrowLeft.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
            this.btnArrowRight.addEventListener(MouseEvent.CLICK,this.press_btnArrow);
            this.btnArrowRight.addEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
            this.btnArrowRight.addEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
            this.mcNotAvailable.visible = false;
         }
         else
         {
            this.chkInvertX.mouseEnabled = this.chkInvertY.mouseEnabled = false;
            this.chkInvertX.alpha = this.chkInvertY.alpha = 0.2;
            this.btnArrowDown.alpha = this.btnArrowUp.alpha = this.btnArrowLeft.alpha = this.btnArrowRight.alpha = 0.2;
            this.mcMovementExtra.alpha = 0.2;
         }
         this.chkFlattenColor.selected = layerToEdit.flattenColor;
         this.chkFlattenColor.addEventListener(Event.CHANGE,this.changeFlattenColor);
         this.colorGrabber.setColor(layerToEdit.tintColor,false);
         this.colorGrabber.addEventListener(Event.CHANGE,this.changeColor);
         this.btnAdvancedOptions.buttonMode = true;
         this.btnAdvancedOptions.addEventListener(MouseEvent.CLICK,this.press_btnAdvancedOptions);
         if(showAdvancedOptions)
         {
            this.btnAdvancedOptions.gotoAndStop(2);
         }
         this.sldColorIntensity.value = layerToEdit.colorIntensity;
         this.sldTextureIntensity.value = layerToEdit.textureIntensity;
         this.sldColorIntensity.addEventListener(SliderEvent.CHANGE,this.changeColorIntensity);
         this.sldTextureIntensity.addEventListener(SliderEvent.CHANGE,this.changeTextureIntensity);
      }
      
      function __setProp_chkInvertX_editor_maincontent_10() : *
      {
         try
         {
            this.chkInvertX["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.chkInvertX.enabled = true;
         this.chkInvertX.label = "";
         this.chkInvertX.labelPlacement = "right";
         this.chkInvertX.selected = false;
         this.chkInvertX.visible = true;
         try
         {
            this.chkInvertX["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function rollOverDeleteSelection(param1:MouseEvent) : void
      {
         if(cursorMode == CURSOR_FREE)
         {
            showDescription("Delete selected layers");
         }
      }
      
      public function rollOverHideSelection(param1:MouseEvent) : void
      {
         if(cursorMode == CURSOR_FREE)
         {
            showDescription("Hide selected layers");
         }
      }
      
      public function rollOutShowSelection(param1:MouseEvent) : void
      {
         showDescription("");
      }
      
      public function genericMouseOver(param1:MouseEvent) : void
      {
         sfxBtnHover.play();
         MovieClip(param1.currentTarget).gotoAndStop(2);
      }
      
      public function press_btnPresets(param1:MouseEvent) : void
      {
         this.cleanupMenuMain();
         gotoAndStop("presets","menu");
      }
      
      public function changeEitherInversion(param1:Event) : void
      {
         layerToEdit.invertX = this.chkInvertX.selected;
         layerToEdit.invertY = this.chkInvertY.selected;
         this.mcPreviewBox.refreshView();
      }
      
      function __setProp_voteBar_menu_Layer1_8() : *
      {
         try
         {
            this.voteBar["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.voteBar.title = "";
         this.voteBar.ratingName = "score";
         this.voteBar.fileMode = "Manually Set File";
         try
         {
            this.voteBar["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function updateSliderDisplays() : void
      {
         if(this.txtOpacityValue)
         {
            this.txtOpacityValue.text = layerToEdit.opacity.toString();
         }
         if(this.txtColorIntensity)
         {
            this.txtColorIntensity.text = layerToEdit.colorIntensity.toString();
         }
         if(this.txtTextureIntensity)
         {
            this.txtTextureIntensity.text = layerToEdit.textureIntensity.toString();
         }
         if(this.txtBlurValue)
         {
            this.txtBlurValue.text = layerToEdit.blur.toString();
         }
      }
      
      public function referenceLoadedTXT(param1:Event) : void
      {
         var e:Event = param1;
         try
         {
            this.importFileReference.data.uncompress();
            curSkin = this.importFileReference.data.readObject();
            this.mcPreviewBox.loadBase(curSkin.baseBitmapData);
            this.mcPreviewBox.skin = curSkin;
         }
         catch(e:Error)
         {
            ioError(null);
            return;
         }
         this.mcPreviewBox.refreshView();
         this.enableBack();
         this.enableImportGo();
      }
      
      public function changeTextureIntensity(param1:Event) : void
      {
         layerToEdit.textureIntensity = uint(this.sldTextureIntensity.value);
         this.updateSliderDisplays();
         this.mcPreviewBox.refreshView();
      }
      
      public function stopDragLayerSelection() : void
      {
         cursorMode = CURSOR_FREE;
         layerSelection.unfadeAll();
         this.updateLayers();
         this.mcGroupIndicator.x = this.mcGroupIndicator.y = 0;
         this.mcGroupIndicator.visible = false;
         for each(tempLayerBox in layerBoxes)
         {
            tempLayerBox.voidEligibleInsertion();
         }
      }
      
      function __setProp_sldBlur_editor_maincontent_11() : *
      {
         try
         {
            this.sldBlur["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldBlur.direction = "horizontal";
         this.sldBlur.enabled = true;
         this.sldBlur.liveDragging = true;
         this.sldBlur.maximum = 4;
         this.sldBlur.minimum = 0;
         this.sldBlur.snapInterval = 0;
         this.sldBlur.tickInterval = 0;
         this.sldBlur.value = 0;
         this.sldBlur.visible = true;
         try
         {
            this.sldBlur["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function referenceLoaded(param1:Event) : void
      {
         var e:Event = param1;
         this.importLoader.unload();
         try
         {
            this.importLoader.loadBytes(this.importFileReference.data);
         }
         catch(e:Error)
         {
            ioError(null);
         }
      }
      
      function __setProp_sldBlur_editor_maincontent_10() : *
      {
         try
         {
            this.sldBlur["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldBlur.direction = "horizontal";
         this.sldBlur.enabled = true;
         this.sldBlur.liveDragging = true;
         this.sldBlur.maximum = 4;
         this.sldBlur.minimum = 0;
         this.sldBlur.snapInterval = 0;
         this.sldBlur.tickInterval = 0;
         this.sldBlur.value = 0;
         this.sldBlur.visible = true;
         try
         {
            this.sldBlur["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function press_btnBrowse(param1:MouseEvent) : void
      {
         var pngFilter:FileFilter = null;
         var txtFilter:FileFilter = null;
         var e:MouseEvent = param1;
         var fileFilters:Array = new Array();
         if(currentLabel == "import_png")
         {
            pngFilter = new FileFilter("PNG Images","*.png");
            fileFilters.push(pngFilter);
         }
         else if(currentLabel == "import_txt")
         {
            txtFilter = new FileFilter("Text Files","*.txt");
            fileFilters.push(txtFilter);
         }
         try
         {
            this.importFileReference.browse(fileFilters);
         }
         catch(e:Error)
         {
            generateOKDialog("There was an error opening the file window");
         }
      }
      
      public function press_btnGoImport(param1:MouseEvent) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:CustomLayer = null;
         if(currentLabel == "import_png")
         {
            _loc2_ = this.importLoader.content as Bitmap;
            curSkin = new Skin();
            curSkin.baseBitmapData = presetSkins[0].getBitmapData();
            _loc3_ = new CustomLayer();
            _loc3_.name = "Imported Skin";
            _loc3_.customBitmapData = _loc2_.bitmapData.clone();
            curSkin.addLayer(_loc3_,true);
            this.cleanupMenuImportPNG();
            this.editorFirstInit = true;
            gotoAndStop("edit_main","editor");
         }
         else if(currentLabel == "import_txt")
         {
            this.cleanupMenuImportTXT();
            this.editorFirstInit = true;
            gotoAndStop("edit_main","editor");
         }
         sfxBtnClick.play();
      }
      
      public function unloadPreviewBox() : void
      {
         if(this.mcPreviewBox)
         {
            this.mcPreviewBox.cleanup();
            removeChild(this.mcPreviewBox);
            this.mcPreviewBox = null;
         }
      }
      
      public function enableBack() : void
      {
         this.btnBackFromImport.mouseEnabled = true;
         this.btnBackFromImport.alpha = 1;
         if(this.btnLoad)
         {
            this.btnLoad.mouseEnabled = true;
            this.btnLoad.alpha = 1;
         }
      }
      
      public function cleanupMenuImportPNG() : void
      {
         this.mcPreviewBox.cleanup();
         this.importFileReference.removeEventListener(Event.SELECT,this.referenceBrowse);
         this.importFileReference.removeEventListener(Event.COMPLETE,this.referenceLoaded);
         this.importFileReference.removeEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.importLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.fileLoaded);
         this.importFileReference = null;
         this.importLoader = null;
         this.btnBrowse.removeEventListener(MouseEvent.CLICK,this.press_btnBrowse);
         this.btnGoImport.removeEventListener(MouseEvent.CLICK,this.press_btnImportPNG);
         this.btnBackFromImport.removeEventListener(MouseEvent.CLICK,this.press_btnBackFromImport);
      }
      
      public function genericMouseOut(param1:MouseEvent) : void
      {
         MovieClip(param1.currentTarget).gotoAndStop(1);
      }
      
      public function cleanupEditor() : void
      {
         this.unloadPreviewBox();
         this.mcLayerDialog.cleanup();
         this.mcExportDialog.cleanup();
         removeChild(this.mcToolFollow);
         this.mcToolFollow = null;
         curSkin.cleanup();
         dummySkin.cleanup();
         curSkin = dummySkin = null;
         this.btnAddLayer.removeEventListener(MouseEvent.CLICK,this.press_btnAddLayer);
         this.btnAddLayer.removeEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnAddLayer.removeEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnCopyLayer.removeEventListener(MouseEvent.CLICK,this.press_btnCopyLayer);
         this.btnCopyLayer.removeEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnCopyLayer.removeEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnBackFromEditor.removeEventListener(MouseEvent.CLICK,this.press_btnBackFromEditor);
         this.btnBackFromEditor.removeEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnBackFromEditor.removeEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnExport.removeEventListener(MouseEvent.CLICK,this.press_btnExport);
         this.btnExport.removeEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnExport.removeEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.txtSkinName.removeEventListener(Event.CHANGE,this.changeSkinName);
         this.btnShowSelection.removeEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnDeleteSelection.removeEventListener(MouseEvent.ROLL_OVER,this.genericMouseOver);
         this.btnDeleteSelection.removeEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnShowSelection.removeEventListener(MouseEvent.ROLL_OUT,this.genericMouseOut);
         this.btnShowSelection.removeEventListener(MouseEvent.CLICK,this.press_btnShowSelection);
         this.btnDeleteSelection.removeEventListener(MouseEvent.CLICK,this.press_btnDeleteSelection);
      }
      
      public function press_btnLoad(param1:Event) : void
      {
         var name:String = null;
         var request:URLRequest = null;
         var e:Event = param1;
         this.disableImportGo();
         this.disableBack();
         this.importLoader.unload();
         try
         {
            name = this.txtMCUsername.text;
            request = new URLRequest("http://www.minecraft.net/skin/" + name + ".png");
            this.importLoader.load(request);
         }
         catch(e:Error)
         {
            ioError(null);
         }
      }
      
      public function updateLayers() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         this.mcPreviewBox.clearSourceBitmaps();
         if(this.savedLayerScrollPosition == 0)
         {
            this.savedLayerScrollPosition = this.lstLayers.verticalScrollPosition;
         }
         for each(tempLayerBox in layerBoxes)
         {
            tempLayerBox.cleanup();
            this.layerHolder.removeChild(tempLayerBox);
         }
         this.layerHolder = new Sprite();
         layerBoxes = new Vector.<LayerBox>();
         this.lstLayers.source = null;
         _loc1_ = -1;
         _loc2_ = 1;
         i = curSkin.layers.length - 1;
         while(i >= 0)
         {
            tempLayer = curSkin.layers[i];
            tempLayerBox = new LayerBox(tempLayer);
            tempLayerBox.y = _loc2_;
            if(tempLayer.isNew)
            {
               tempLayer.isNew = false;
               _loc1_ = _loc2_;
            }
            if(tempLayer.faded)
            {
               tempLayerBox.alpha = 0.3;
            }
            _loc2_ += tempLayerBox.mcOutline.height - 1;
            this.layerHolder.addChild(tempLayerBox);
            layerBoxes.push(tempLayerBox);
            --i;
         }
         for each(tempLayerBox in layerBoxes)
         {
            if(tempLayerBox.targetLayer.selected)
            {
               this.layerHolder.setChildIndex(tempLayerBox,this.layerHolder.numChildren - 1);
            }
         }
         if(layerBoxes.length > 0 && this.layerHolder.height + 2 < this.lstLayers.height)
         {
            layerBoxes[layerBoxes.length - 1].addBottomSpacer(this.lstLayers.height - (this.layerHolder.height + 2));
         }
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.drawRect(0,0,20,2);
         _loc3_.mouseEnabled = _loc3_.visible = false;
         _loc3_.y = _loc2_;
         this.layerHolder.addChild(_loc3_);
         this.lstLayers.source = this.layerHolder;
         this.lstLayers.refreshPane();
         this.lstLayers.update();
         if(_loc1_ > -1)
         {
            this.lstLayers.verticalScrollPosition = _loc1_;
         }
         else
         {
            this.lstLayers.verticalScrollPosition = this.savedLayerScrollPosition;
         }
         this.savedLayerScrollPosition = 0;
         this.updateLayerCount();
         this.mcPreviewBox.refreshView();
      }
      
      public function changeTool(param1:uint) : void
      {
         curTool = param1;
         this.mcToolFollow.gotoAndStop(curTool);
         setChildIndex(this.mcToolFollow,numChildren - 1);
      }
      
      public function press_btnUndo(param1:MouseEvent) : void
      {
         this.pixelEditor.undo();
      }
      
      function __setProp_cmbBlendModes_editor_maincontent_10() : *
      {
         try
         {
            this.cmbBlendModes["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.collObj5 = new DataProvider();
         this.collProps5 = [];
         this.i5 = 0;
         while(this.i5 < this.collProps5.length)
         {
            this.itemObj5 = new SimpleCollectionItem();
            this.collProp5 = this.collProps5[this.i5];
            for(this.j5 in this.collProp5)
            {
               this.itemObj5[this.j5] = this.collProp5[this.j5];
            }
            this.collObj5.addItem(this.itemObj5);
            ++this.i5;
         }
         this.cmbBlendModes.dataProvider = this.collObj5;
         this.cmbBlendModes.editable = false;
         this.cmbBlendModes.enabled = true;
         this.cmbBlendModes.prompt = "";
         this.cmbBlendModes.restrict = "";
         this.cmbBlendModes.rowCount = 5;
         this.cmbBlendModes.visible = true;
         try
         {
            this.cmbBlendModes["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function takeToEditor() : void
      {
         curSkin = new Skin();
         curSkin.baseBitmapData = this.mcPreviewBox.sourceBitmapData.clone();
         this.editorFirstInit = true;
         this.cleanupMenuBrowse();
         gotoAndStop("edit_main","editor");
      }
      
      public function changeEditorView(param1:Event) : void
      {
      }
      
      public function listenForLoad(param1:Event) : void
      {
         if(framesLoaded == totalFrames)
         {
            removeEventListener(Event.ENTER_FRAME,this.listenForLoad);
            if(loaderInfo.parameters.NewgroundsAPI_SaveFileID)
            {
               this.mcPreloader.visible = false;
               this.txtLoadingSkin.visible = true;
               addEventListener(Event.ENTER_FRAME,this.listenForAPIConnected);
            }
         }
      }
      
      public function press_btnArrow(param1:MouseEvent) : void
      {
         PremadeLayer(layerToEdit).attemptToMove(param1.target.direction);
      }
      
      public function clickNgIntro(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://newgrounds.com");
      }
      
      public function changeSkinName(param1:Event) : void
      {
         curSkin.name = this.txtSkinName.text.substr(0,MAX_LAYER_NAME_LENGTH);
      }
      
      function __setProp_cmbEditorView_editor_maincontent_11() : *
      {
         try
         {
            this.cmbEditorView["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.collObj6 = new DataProvider();
         this.collProps6 = [];
         this.i6 = 0;
         while(this.i6 < this.collProps6.length)
         {
            this.itemObj6 = new SimpleCollectionItem();
            this.collProp6 = this.collProps6[this.i6];
            for(this.j6 in this.collProp6)
            {
               this.itemObj6[this.j6] = this.collProp6[this.j6];
            }
            this.collObj6.addItem(this.itemObj6);
            ++this.i6;
         }
         this.cmbEditorView.dataProvider = this.collObj6;
         this.cmbEditorView.editable = false;
         this.cmbEditorView.enabled = true;
         this.cmbEditorView.prompt = "";
         this.cmbEditorView.restrict = "";
         this.cmbEditorView.rowCount = 6;
         this.cmbEditorView.visible = true;
         try
         {
            this.cmbEditorView["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function dragLayerSelection() : void
      {
         cursorMode = CURSOR_DRAG;
         layerSelection.fadeAll();
         this.updateLayers();
         this.mcGroupIndicator.visible = true;
         this.mcGroupIndicator.txtLayersNum.text = layerSelection.layers.length + " Layer(s)";
      }
      
      public function changeColor(param1:Event) : void
      {
         layerToEdit.tintColor = this.colorGrabber.actualColor;
         this.mcPreviewBox.refreshView();
      }
      
      public function press_btnBackFromBrowse(param1:MouseEvent) : void
      {
         this.cleanupMenuBrowse();
         gotoAndStop("main","menu");
      }
      
      public function tick(param1:Event) : void
      {
         KeyManager.detectKeys();
         if(listenForDrag)
         {
            ++dragDelayFrames;
            if(dragDelayFrames > 7 && (mouseX != dragStartX || mouseY != dragStartY))
            {
               listenForDrag = false;
               this.dragLayerSelection();
               stage.focus = null;
            }
         }
         if(cursorMode == CURSOR_DRAG)
         {
            if(this.lstLayers && this.lstLayers.hitTestPoint(mouseX,mouseY))
            {
               if(this.lstLayers.mouseY < 25)
               {
                  this.lstLayers.verticalScrollPosition -= 5;
               }
               else if(this.lstLayers.mouseY > this.lstLayers.height - 25)
               {
                  this.lstLayers.verticalScrollPosition += 5;
               }
            }
            this.mcGroupIndicator.x = mouseX;
            this.mcGroupIndicator.y = mouseY;
         }
         if(currentLabel == "edit_custom_layer")
         {
            if(this.pixelEditorMask && this.pixelEditor && curTool != TOOL_NONE && curTool != TOOL_EYEDROPPER)
            {
               if(this.pixelEditorMask.hitTestPoint(mouseX,mouseY))
               {
                  this.mcToolFollow.visible = true;
               }
               else
               {
                  this.mcToolFollow.visible = false;
               }
            }
            if(KeyManager.singlePress(KeyManager.LTR_Z))
            {
               this.pixelEditor.undo();
            }
         }
         if(this.mcToolFollow)
         {
            this.mcToolFollow.x = mouseX;
            this.mcToolFollow.y = mouseY;
         }
      }
      
      public function press_btnDeleteSelection(param1:MouseEvent) : void
      {
         if(layerSelection == null)
         {
            return;
         }
         Main.newDialogBox = new DialogBox("Are you sure you want to delete " + layerSelection.layers.length + " layer(s)?");
         Main.newDialogBox.createAsYesNo("DELLAYERGROUP");
         Main.newDialogBox.display();
      }
      
      public function press_btnAdvancedOptions(param1:MouseEvent) : void
      {
         if(showAdvancedOptions)
         {
            showAdvancedOptions = false;
            this.btnAdvancedOptions.gotoAndStop(1);
         }
         else
         {
            showAdvancedOptions = true;
            this.btnAdvancedOptions.gotoAndStop(2);
         }
      }
      
      public function rollOverShowSelection(param1:MouseEvent) : void
      {
         if(cursorMode == CURSOR_FREE)
         {
            showDescription("Show selected layers");
         }
      }
      
      public function opacityChange(param1:Event) : void
      {
         layerToEdit.opacity = uint(this.sldOpacity.value);
         this.updateSliderDisplays();
         this.mcPreviewBox.refreshView();
      }
      
      public function cleanupMenuImportTXT() : void
      {
         this.mcPreviewBox.cleanup();
         this.importFileReference.removeEventListener(Event.SELECT,this.referenceBrowse);
         this.importFileReference.removeEventListener(Event.COMPLETE,this.referenceLoadedTXT);
         this.importFileReference.removeEventListener(IOErrorEvent.IO_ERROR,this.ioError);
         this.importFileReference = null;
         this.btnBrowse.removeEventListener(MouseEvent.CLICK,this.press_btnBrowse);
         this.btnGoImport.removeEventListener(MouseEvent.CLICK,this.press_btnImportPNG);
         this.btnBackFromImport.removeEventListener(MouseEvent.CLICK,this.press_btnBackFromImport);
      }
      
      public function press_btnAddLayer(param1:MouseEvent) : void
      {
         if(curSkin.layers.length == MAX_LAYERS)
         {
            generateOKDialog("You cannot exceed " + MAX_LAYERS + " layers");
            return;
         }
         if(Utilities.saveFile.firstTime)
         {
            Utilities.saveFile.firstTime = false;
            Utilities.saveGame();
            this.mcTut1.visible = false;
            this.btnAddLayer.filters = null;
         }
         this.mcLayerDialog.show();
      }
      
      public function changeFlattenColor(param1:Event) : void
      {
         layerToEdit.flattenColor = this.chkFlattenColor.selected;
         this.mcPreviewBox.refreshView();
      }
      
      public function press_btnImportPNG(param1:MouseEvent) : void
      {
         this.cleanupMenuMain();
         gotoAndStop("import_png","menu");
      }
      
      public function changeBlendMode(param1:Event) : void
      {
         layerToEdit.blendMode = this.cmbBlendModes.selectedItem.data;
         this.mcPreviewBox.refreshView();
      }
      
      public function referenceBrowse(param1:Event) : void
      {
         var e:Event = param1;
         if(this.importFileReference.size > importLimitBytes)
         {
            generateOKDialog("Filesize cannot exceed " + importLimitKB + "kb (" + importLimitBytes + " bytes)");
            return;
         }
         this.disableImportGo();
         this.disableBack();
         try
         {
            this.importFileReference.load();
         }
         catch(e:Error)
         {
            ioError(null);
         }
      }
      
      public function press_btnClearSearch(param1:MouseEvent) : void
      {
         this.btnClearSearch.visible = false;
         this.saveBrowser.title = "User Created Skins";
         this.saveBrowser.sortField = SaveQuery.CREATED_ON;
         this.saveBrowser.loadFiles();
      }
      
      function __setProp_sldTextureIntensity_editor_maincontent_10() : *
      {
         try
         {
            this.sldTextureIntensity["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.sldTextureIntensity.direction = "horizontal";
         this.sldTextureIntensity.enabled = true;
         this.sldTextureIntensity.liveDragging = true;
         this.sldTextureIntensity.maximum = 100;
         this.sldTextureIntensity.minimum = 0;
         this.sldTextureIntensity.snapInterval = 0;
         this.sldTextureIntensity.tickInterval = 0;
         this.sldTextureIntensity.value = 0;
         this.sldTextureIntensity.visible = true;
         try
         {
            this.sldTextureIntensity["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function skinLoaded(param1:APIEvent) : *
      {
         if(param1.success)
         {
            ngSaveFile = SaveFile(param1.data);
            this.mcPreviewBox.loadBase(BitmapData(ngSaveFile.data));
            this.mcPreviewBox.refreshView();
            this.voteBar.saveFile = ngSaveFile;
            this.voteBar.start();
         }
      }
      
      public function finishLoadScreen() : void
      {
         stop();
         this.ngIntro.buttonMode = true;
         this.ngIntro.mouseChildren = false;
         this.ngIntro.addEventListener(MouseEvent.CLICK,this.clickNgIntro);
      }
      
      public function cleanupMenuPresets() : void
      {
         this.unloadPreviewBox();
         this.lstPresets.removeEventListener(Event.CHANGE,this.showCurPreset);
         this.lstPresets.removeEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.doubleClickPreset);
         this.btnGoPreset.removeEventListener(MouseEvent.CLICK,this.press_btnGoPreset);
         this.btnBackFromPresets.removeEventListener(MouseEvent.CLICK,this.press_btnBackFromPresets);
      }
      
      public function press_btnHideSelection(param1:MouseEvent) : void
      {
         if(layerSelection == null)
         {
            return;
         }
         for each(tempLayer in layerSelection.layers)
         {
            tempLayer.hidden = true;
         }
         this.updateLayers();
      }
      
      function __setProp_cmbBlendModes_editor_maincontent_11() : *
      {
         try
         {
            this.cmbBlendModes["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.collObj7 = new DataProvider();
         this.collProps7 = [];
         this.i7 = 0;
         while(this.i7 < this.collProps7.length)
         {
            this.itemObj7 = new SimpleCollectionItem();
            this.collProp7 = this.collProps7[this.i7];
            for(this.j7 in this.collProp7)
            {
               this.itemObj7[this.j7] = this.collProp7[this.j7];
            }
            this.collObj7.addItem(this.itemObj7);
            ++this.i7;
         }
         this.cmbBlendModes.dataProvider = this.collObj7;
         this.cmbBlendModes.editable = false;
         this.cmbBlendModes.enabled = true;
         this.cmbBlendModes.prompt = "";
         this.cmbBlendModes.restrict = "";
         this.cmbBlendModes.rowCount = 5;
         this.cmbBlendModes.visible = true;
         try
         {
            this.cmbBlendModes["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      public function initMenuPresets() : void
      {
         var _loc1_:PresetSkin = null;
         this.loadPreviewBox(355,63);
         for each(_loc1_ in presetSkins)
         {
            this.lstPresets.addItem({
               "label":_loc1_.name,
               "data":_loc1_.id
            });
         }
         this.lstPresets.selectedIndex = 0;
         this.lstPresets.addEventListener(Event.CHANGE,this.showCurPreset);
         this.lstPresets.addEventListener(ListEvent.ITEM_DOUBLE_CLICK,this.doubleClickPreset);
         this.lstPresets.doubleClickEnabled = true;
         this.showCurPreset();
         this.btnGoPreset.buttonMode = true;
         this.btnGoPreset.addEventListener(MouseEvent.CLICK,this.press_btnGoPreset);
         Utilities.mc2Btn(this.btnBackFromPresets);
         this.btnBackFromPresets.addEventListener(MouseEvent.CLICK,this.press_btnBackFromPresets);
      }
      
      public function doubleClickPreset(param1:ListEvent) : void
      {
         this.press_btnGoPreset(null);
      }
      
      public function initMenuBrowse() : void
      {
         Utilities.mc2Btn(this.btnBackFromBrowse);
         this.btnBackFromBrowse.addEventListener(MouseEvent.CLICK,this.press_btnBackFromBrowse);
         Utilities.mc2Btn(this.btnSearch);
         this.btnSearch.addEventListener(MouseEvent.CLICK,this.press_btnSearch);
         Utilities.mc2Btn(this.btnClearSearch);
         this.btnClearSearch.addEventListener(MouseEvent.CLICK,this.press_btnClearSearch);
         this.btnClearSearch.visible = false;
         this.loadPreviewBox(420,63,1);
         this.mcPreviewBox.initBrowseMode();
         setChildIndex(this.voteBar,numChildren - 1);
         API.addEventListener(APIEvent.FILE_LOADED,this.skinLoaded);
         API.addEventListener(APIEvent.VOTE_COMPLETE,this.voteComplete);
         if(preloadNGSaveFile)
         {
            this.mcPreviewBox.loadBase(BitmapData(preloadNGSaveFile.data));
            this.mcPreviewBox.refreshView();
            this.voteBar.saveFile = preloadNGSaveFile;
            this.voteBar.start();
            preloadNGSaveFile = null;
         }
      }
      
      public function disableBack() : void
      {
         this.btnBackFromImport.mouseEnabled = false;
         this.btnBackFromImport.alpha = 0.2;
         if(this.btnLoad)
         {
            this.btnLoad.mouseEnabled = false;
            this.btnLoad.alpha = 0.2;
         }
      }
      
      public function updateLayerCount() : void
      {
         this.txtLayerCount.text = curSkin.layers.length + "/" + MAX_LAYERS;
      }
   }
}
