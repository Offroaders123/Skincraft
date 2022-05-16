package
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class DialogBox extends MovieClip
   {
       
      
      public var btnPortalLink:MovieClip;
      
      public var actionYes:String;
      
      public var actionNo:String;
      
      public var btnOk:MovieClip;
      
      public var actionParams:Array;
      
      public var btnYes:MovieClip;
      
      public var btnJustContinue:MovieClip;
      
      public var actionOk:String;
      
      public var btnNo:MovieClip;
      
      public var txtMessage:TextField;
      
      public var btnMinecraftProfile:MovieClip;
      
      public function DialogBox(param1:String)
      {
         super();
         if(Main.activeDialogBox)
         {
            Main.activeDialogBox.cleanup();
            Main.activeDialogBox.close();
            Main.activeDialogBox = null;
         }
         Main.stageRef.focus = null;
         tabEnabled = tabChildren = false;
         this.txtMessage.text = param1;
         Main.activeDialogBox = this;
         this.btnMinecraftProfile.visible = false;
         this.btnJustContinue.visible = false;
         this.btnPortalLink.visible = false;
      }
      
      public function press_btnPortalLink(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://www.newgrounds.com/portal/view/571250");
      }
      
      public function close() : void
      {
         Main.stageRef.focus = null;
         Main.activeDialogBox = null;
         Main.rootRef.removeChild(this);
      }
      
      public function display() : void
      {
         Main.rootRef.addChild(this);
      }
      
      public function createAsOk(param1:String = "", param2:Boolean = false, param3:Boolean = false) : void
      {
         gotoAndStop(1);
         this.actionOk = param1;
         this.btnOk.buttonMode = true;
         this.btnOk.addEventListener(MouseEvent.CLICK,this.invokeOk);
         this.btnOk.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnOk.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         if(param2)
         {
            this.btnOk.visible = false;
            this.btnOk.mouseEnabled = false;
            this.btnMinecraftProfile.visible = true;
            this.btnJustContinue.visible = true;
            Utilities.mc2Btn(this.btnMinecraftProfile);
            Utilities.mc2Btn(this.btnJustContinue);
            this.btnMinecraftProfile.addEventListener(MouseEvent.CLICK,this.press_btnMinecraftProfile);
            this.btnJustContinue.addEventListener(MouseEvent.CLICK,this.invokeOk);
         }
         if(param3)
         {
            this.btnPortalLink.visible = true;
            Utilities.mc2Btn(this.btnPortalLink);
            this.btnPortalLink.addEventListener(MouseEvent.CLICK,this.press_btnPortalLink);
         }
      }
      
      public function invokeYes(param1:MouseEvent) : void
      {
         var _loc2_:Layer = null;
         Main.sfxBtnClick.play();
         this.cleanup();
         if(this.actionYes != "")
         {
            this.actionParams = this.actionYes.split("_");
            if(this.actionParams[0] == "DELLAYER")
            {
               Main.rootRef.deselectAllLayers();
               Main.layerSelection = null;
               Main.curSkin.deleteLayer(Main.layerToDelete);
               Main.rootRef.updateLayers();
            }
            else if(this.actionParams[0] == "DELLAYERGROUP")
            {
               Main.rootRef.deselectAllLayers();
               for each(_loc2_ in Main.layerSelection.layers)
               {
                  Main.curSkin.deleteLayer(_loc2_);
               }
               Main.layerSelection = null;
               Main.rootRef.updateLayers();
            }
            else if(this.actionParams[0] == "BACKTOMENU")
            {
               Main.rootRef.cleanupEditor();
               Main.rootRef.gotoAndStop("main","menu");
            }
            else if(this.actionParams[0] == "TAKESKINTOEDITOR")
            {
               Main.rootRef.takeToEditor();
            }
         }
         this.close();
      }
      
      public function invokeNo(param1:MouseEvent) : void
      {
         Main.sfxBtnClick.play();
         this.cleanup();
         this.close();
      }
      
      public function createAsYesNo(param1:String = "", param2:String = "") : void
      {
         gotoAndStop(2);
         this.actionYes = param1;
         this.actionNo = param2;
         this.btnYes.buttonMode = true;
         this.btnYes.addEventListener(MouseEvent.CLICK,this.invokeYes);
         this.btnYes.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnYes.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         this.btnNo.buttonMode = true;
         this.btnNo.addEventListener(MouseEvent.CLICK,this.invokeNo);
         this.btnNo.addEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
         this.btnNo.addEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
      }
      
      public function cleanup() : void
      {
         if(this.btnOk)
         {
            this.btnOk.removeEventListener(MouseEvent.CLICK,this.invokeOk);
            this.btnOk.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
            this.btnOk.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         }
         if(this.btnNo)
         {
            this.btnNo.removeEventListener(MouseEvent.CLICK,this.invokeNo);
            this.btnNo.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
            this.btnNo.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         }
         if(this.btnYes)
         {
            this.btnYes.removeEventListener(MouseEvent.CLICK,this.invokeYes);
            this.btnYes.removeEventListener(MouseEvent.ROLL_OVER,Main.rootRef.genericMouseOver);
            this.btnYes.removeEventListener(MouseEvent.ROLL_OUT,Main.rootRef.genericMouseOut);
         }
      }
      
      public function invokeOk(param1:MouseEvent) : void
      {
         Main.sfxBtnClick.play();
         this.cleanup();
         this.close();
      }
      
      public function press_btnMinecraftProfile(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://www.minecraft.net/profile");
      }
   }
}
