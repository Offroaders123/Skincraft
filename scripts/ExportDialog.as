package
{
   import com.adobe.images.PNGEncoder;
   import com.newgrounds.API;
   import com.newgrounds.APIEvent;
   import com.newgrounds.SaveFile;
   import com.newgrounds.components.FlashAd;
   import fl.controls.TextInput;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Matrix;
   import flash.net.FileReference;
   import flash.net.registerClassAlias;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class ExportDialog extends MovieClip
   {
      
      public static const AD_TIME:uint = 20;
      
      public static const TXT:String = ".txt";
      
      public static const MAX_TAGS_LENGTH:uint = 50;
      
      public static const PNG:String = ".png";
      
      public static const MAX_DESC_LENGTH:uint = 50;
      
      public static const MAX_NAME_LENGTH:uint = 20;
       
      
      public var saveIcon:BitmapData;
      
      public var uploadedToServer:Boolean;
      
      public var btnExportTXT:MovieClip;
      
      public var btnContinue:MovieClip;
      
      public var fileReference:FileReference;
      
      public var flashAd:FlashAd;
      
      public var skinByteArray:ByteArray;
      
      public var txtTimer:TextField;
      
      public var txtSkinDescription:TextInput;
      
      public var mcExportInfo:MovieClip;
      
      public var txtSkinName:TextInput;
      
      public var txtSkinTags:TextInput;
      
      public var btnExportPNG:MovieClip;
      
      public var requiredExtension:String;
      
      public var adTimer:Timer;
      
      public var btnBack:MovieClip;
      
      public var btnShare:MovieClip;
      
      public var btnGo:MovieClip;
      
      public var mcFakeLoadbar:MovieClip;
      
      public var ngSaveFile:com.newgrounds.SaveFile;
      
      public var btnCancel:MovieClip;
      
      public var saveIconMatrix:Matrix;
      
      public function ExportDialog()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
         this.hide();
         stop();
         x = y = 0;
         Main.stageRef.focus = null;
         registerClassAlias("Skin",Skin);
         registerClassAlias("Layer",Layer);
         registerClassAlias("PremadeLayer",PremadeLayer);
         registerClassAlias("CustomLayer",CustomLayer);
         registerClassAlias("BitmapSprite",BitmapSprite);
         registerClassAlias("Piece",Piece);
         this.fileReference = new FileReference();
         this.fileReference.addEventListener(Event.SELECT,this.fileSelect);
         this.fileReference.addEventListener(Event.COMPLETE,this.fileComplete);
         this.fileReference.addEventListener(IOErrorEvent.IO_ERROR,this.fileError);
         this.fileReference.addEventListener(Event.OPEN,this.checkFilename);
         this.adTimer = new Timer(1000,AD_TIME);
         this.adTimer.addEventListener(TimerEvent.TIMER,this.timerTick);
         this.saveIconMatrix = new Matrix();
      }
      
      public function press_btnGo(param1:MouseEvent) : void
      {
         if(this.txtSkinName.text.length < 3)
         {
            Main.generateOKDialog("Skin name must be at least three characters long");
            return;
         }
         this.disableShareButtons();
         Main.curSkin.shareName = this.txtSkinName.text.substr(0,MAX_NAME_LENGTH);
         Main.curSkin.shareDescription = this.txtSkinDescription.text.substr(0,MAX_DESC_LENGTH);
         Main.curSkin.shareTags = this.txtSkinTags.text.substr(0,MAX_TAGS_LENGTH);
         var _loc2_:* = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT,true,0);
         _loc2_.draw(Main.rootRef.mcPreviewBox.sourceContainer);
         Main.rootRef.mcPreviewBox.minecraftViewer.setDefaultPosition(true);
         var _loc3_:uint = 170 + Math.random() * 60;
         this.saveIconMatrix = new Matrix();
         this.saveIconMatrix.translate(-225 + _loc3_ / 2,-215 + _loc3_ / 2 + (230 - _loc3_) * 0.4);
         this.saveIcon = new BitmapData(_loc3_,_loc3_,true,0);
         this.saveIcon.draw(Main.rootRef.mcPreviewBox.minecraftViewer,this.saveIconMatrix,null,null,null,true);
         this.ngSaveFile = API.createSaveFile("skins");
         this.ngSaveFile.name = Main.curSkin.shareName;
         this.ngSaveFile.description = Main.curSkin.shareDescription;
         this.ngSaveFile.data = _loc2_;
         this.ngSaveFile.createIcon(this.saveIcon);
         this.ngSaveFile.keys["tags"] = Main.curSkin.shareTags;
         this.ngSaveFile.save();
         this.ngSaveFile.addEventListener(APIEvent.FILE_SAVED,this.ngFileSaved);
      }
      
      public function timerTick(param1:TimerEvent) : void
      {
         this.txtTimer.text = (AD_TIME - this.adTimer.currentCount).toString();
         if(this.adTimer.currentCount == AD_TIME)
         {
            this.adTimer.stop();
            this.adTimer.removeEventListener(TimerEvent.TIMER,this.timerTick);
            this.btnContinue.visible = true;
            this.txtTimer.visible = false;
         }
      }
      
      public function enableButtons() : void
      {
         this.btnCancel.mouseEnabled = true;
         this.btnCancel.alpha = 1;
         this.btnExportPNG.mouseEnabled = true;
         this.btnExportPNG.alpha = 1;
         this.btnExportTXT.mouseEnabled = true;
         this.btnExportTXT.alpha = 1;
         this.btnShare.mouseEnabled = true;
         this.btnShare.alpha = 1;
      }
      
      public function disableButtons() : void
      {
         this.btnCancel.mouseEnabled = false;
         this.btnCancel.alpha = 0.3;
         this.btnExportPNG.mouseEnabled = false;
         this.btnExportPNG.alpha = 0.3;
         this.btnExportTXT.mouseEnabled = false;
         this.btnExportTXT.alpha = 0.3;
         this.btnShare.mouseEnabled = false;
         this.btnShare.alpha = 0.3;
      }
      
      public function exitUploadScreen() : void
      {
         this.btnBack.removeEventListener(MouseEvent.CLICK,this.press_btnBack);
         this.btnGo.addEventListener(MouseEvent.CLICK,this.press_btnGo);
         Utilities.cleanupMCBtn(this.btnBack);
         Utilities.cleanupMCBtn(this.btnGo);
         gotoAndStop(1);
      }
      
      public function press_btnExportPNG(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         var skinBitmapData:* = new BitmapData(Main.SKIN_WIDTH,Main.SKIN_HEIGHT,true,0);
         skinBitmapData.draw(Main.rootRef.mcPreviewBox.sourceContainer);
         this.skinByteArray = PNGEncoder.encode(skinBitmapData);
         this.requiredExtension = PNG;
         try
         {
            this.fileReference.save(this.skinByteArray,"my_skin.png");
         }
         catch(e:Error)
         {
            fileError(null);
         }
         skinBitmapData.dispose();
         this.skinByteArray = null;
      }
      
      public function finishFileComplete() : void
      {
         var _loc1_:* = false;
         var _loc2_:String = null;
         this.close();
         this.enableButtons();
         if(this.uploadedToServer)
         {
            this.uploadedToServer = false;
            Main.generateOKDialog("Your skin file was uploaded to the server");
            Main.rootRef.unlockMedal("Show and Tell");
         }
         else
         {
            _loc1_ = this.requiredExtension == PNG;
            _loc2_ = this.fileReference.name.substr(this.fileReference.name.length - 4).toLowerCase();
            if(_loc2_ != this.requiredExtension)
            {
               Main.generateOKDialog("The " + this.requiredExtension + " is malformed or missing, but your skin file was still saved successfully",_loc1_);
            }
            else
            {
               Main.generateOKDialog("Your skin file was saved successfully",_loc1_);
            }
            if(_loc1_)
            {
               Main.rootRef.unlockMedal("Mining in Style");
            }
         }
      }
      
      public function fileSelect(param1:Event) : void
      {
         this.disableButtons();
      }
      
      public function press_btnExportTXT(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         this.skinByteArray = new ByteArray();
         this.skinByteArray.writeObject(Main.curSkin);
         this.skinByteArray.compress();
         this.requiredExtension = TXT;
         try
         {
            this.fileReference.save(this.skinByteArray,"my_skin.txt");
         }
         catch(e:Error)
         {
            fileError(null);
         }
         this.skinByteArray = null;
      }
      
      public function mouseOutExportBtn(param1:MouseEvent) : void
      {
         MovieClip(param1.target).gotoAndStop(1);
      }
      
      public function cleanup() : void
      {
         this.btnCancel.removeEventListener(MouseEvent.CLICK,this.press_btnCancel);
         Utilities.cleanupMCBtn(this.btnCancel);
         this.btnExportPNG.removeEventListener(MouseEvent.CLICK,this.press_btnExportPNG);
         this.btnExportPNG.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOverExportBtn);
         this.btnExportPNG.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOutExportBtn);
         this.btnExportTXT.removeEventListener(MouseEvent.CLICK,this.press_btnExportTXT);
         this.btnExportTXT.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOverExportBtn);
         this.btnExportTXT.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOutExportBtn);
         this.btnShare.removeEventListener(MouseEvent.CLICK,this.press_btnShare);
         this.btnShare.removeEventListener(MouseEvent.ROLL_OVER,this.mouseOverExportBtn);
         this.btnShare.removeEventListener(MouseEvent.ROLL_OUT,this.mouseOutExportBtn);
         this.fileReference.removeEventListener(Event.SELECT,this.fileSelect);
         this.fileReference.removeEventListener(Event.COMPLETE,this.fileComplete);
         this.fileReference.removeEventListener(IOErrorEvent.IO_ERROR,this.fileError);
         this.fileReference.removeEventListener(Event.OPEN,this.checkFilename);
      }
      
      public function monitorFakeLoadbar(param1:Event) : void
      {
         if(this.mcFakeLoadbar.currentLabel == "end")
         {
            this.mcFakeLoadbar.removeEventListener(Event.ENTER_FRAME,this.monitorFakeLoadbar);
            this.finishFileComplete();
         }
      }
      
      public function press_btnContinue(param1:MouseEvent) : void
      {
         removeChild(this.flashAd);
         this.flashAd = null;
         this.btnContinue.removeEventListener(MouseEvent.CLICK,this.press_btnContinue);
         this.finishFileComplete();
      }
      
      public function disableShareButtons() : void
      {
         this.btnBack.mouseEnabled = this.btnGo.mouseEnabled = false;
         this.btnBack.alpha = this.btnGo.alpha = 0.3;
      }
      
      public function initUpload() : void
      {
         this.txtSkinName.text = Main.curSkin.shareName;
         this.txtSkinDescription.text = Main.curSkin.shareDescription;
         this.txtSkinTags.text = Main.curSkin.shareTags;
         this.txtSkinName.maxChars = MAX_NAME_LENGTH;
         this.txtSkinDescription.maxChars = MAX_DESC_LENGTH;
         this.txtSkinTags.maxChars = MAX_TAGS_LENGTH;
         Utilities.mc2Btn(this.btnBack);
         Utilities.mc2Btn(this.btnGo);
         this.btnBack.addEventListener(MouseEvent.CLICK,this.press_btnBack);
         this.btnGo.addEventListener(MouseEvent.CLICK,this.press_btnGo);
         this.txtSkinName.tabIndex = 1;
         this.txtSkinDescription.tabIndex = 2;
         this.txtSkinTags.tabIndex = 3;
         this.mcFakeLoadbar.visible = false;
      }
      
      public function ngFileSaved(param1:APIEvent) : void
      {
         this.ngSaveFile.removeEventListener(APIEvent.FILE_SAVED,this.ngFileSaved);
         if(param1.success)
         {
            this.uploadedToServer = true;
            this.fileComplete(null);
         }
         else
         {
            this.fileError(null);
         }
      }
      
      public function checkFilename(param1:Event) : void
      {
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function enableShareButtons() : void
      {
         this.btnBack.mouseEnabled = this.btnGo.mouseEnabled = true;
         this.btnBack.alpha = this.btnGo.alpha = 1;
      }
      
      public function initAd() : void
      {
         this.txtTimer.text = AD_TIME.toString();
         this.txtTimer.mouseEnabled = false;
         this.adTimer.reset();
         this.adTimer.start();
         this.btnContinue.buttonMode = true;
         this.btnContinue.visible = false;
         this.btnContinue.addEventListener(MouseEvent.CLICK,this.press_btnContinue);
         this.flashAd = new FlashAd();
         this.flashAd.showBorder = false;
         this.flashAd.apiId = "17500:7T83u8oj";
         this.flashAd.x = 200;
         this.flashAd.y = 20;
         addChild(this.flashAd);
      }
      
      public function fileComplete(param1:Event) : void
      {
         if(!Main.hasSeenAd)
         {
            Main.hasSeenAd = true;
            gotoAndStop(2);
         }
         else if(this.uploadedToServer)
         {
            this.mcFakeLoadbar.visible = true;
            this.mcFakeLoadbar.addEventListener(Event.ENTER_FRAME,this.monitorFakeLoadbar);
            this.mcFakeLoadbar.gotoAndPlay(2);
         }
         else
         {
            this.finishFileComplete();
         }
      }
      
      public function press_btnShare(param1:MouseEvent) : void
      {
         if(!API.connected)
         {
            Main.generateOKDialog("You are not connected to the Newgrounds API");
            return;
         }
         if(!API.isNewgrounds || !API.hasUserSession)
         {
            Main.generateOKDialog("You must be logged into an account on Newgrounds.com to access the Share feature",false,true);
            return;
         }
         gotoAndStop(3);
      }
      
      public function press_btnBack(param1:MouseEvent) : void
      {
         this.exitUploadScreen();
      }
      
      public function initMain() : void
      {
         this.btnCancel.tabEnabled = false;
         Utilities.mc2Btn(this.btnCancel);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.press_btnCancel);
         this.btnExportPNG.addEventListener(MouseEvent.CLICK,this.press_btnExportPNG);
         this.btnExportPNG.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverExportBtn);
         this.btnExportPNG.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutExportBtn);
         this.btnExportTXT.addEventListener(MouseEvent.CLICK,this.press_btnExportTXT);
         this.btnExportTXT.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverExportBtn);
         this.btnExportTXT.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutExportBtn);
         this.btnShare.addEventListener(MouseEvent.CLICK,this.press_btnShare);
         this.btnShare.addEventListener(MouseEvent.ROLL_OVER,this.mouseOverExportBtn);
         this.btnShare.addEventListener(MouseEvent.ROLL_OUT,this.mouseOutExportBtn);
         this.btnExportPNG.tabEnabled = this.btnExportTXT.tabEnabled = this.btnShare.tabEnabled = false;
         this.btnExportPNG.buttonMode = this.btnExportTXT.buttonMode = this.btnShare.buttonMode = true;
         this.btnExportPNG.infoFrame = 1;
         this.btnExportTXT.infoFrame = 2;
         this.btnShare.infoFrame = 3;
      }
      
      public function mouseOverExportBtn(param1:MouseEvent) : void
      {
         Main.sfxBtnHover.play();
         MovieClip(param1.target).gotoAndStop(2);
         this.mcExportInfo.gotoAndStop(MovieClip(param1.target).infoFrame);
      }
      
      public function fileError(param1:IOErrorEvent) : void
      {
         this.close();
         this.enableButtons();
         this.uploadedToServer = false;
         Main.generateOKDialog("There was an error saving your file");
      }
      
      function frame2() : *
      {
         this.initAd();
      }
      
      function frame3() : *
      {
         this.initUpload();
      }
      
      public function close() : void
      {
         this.hide();
         gotoAndStop(1);
      }
      
      public function press_btnCancel(param1:MouseEvent) : void
      {
         this.close();
      }
      
      function frame1() : *
      {
         this.initMain();
      }
      
      public function show() : void
      {
         this.mcExportInfo.gotoAndStop(1);
         visible = true;
      }
   }
}
