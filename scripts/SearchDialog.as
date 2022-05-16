package
{
   import com.newgrounds.API;
   import com.newgrounds.SaveQuery;
   import fl.controls.TextInput;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class SearchDialog extends MovieClip
   {
       
      
      public var btnGo:MovieClip;
      
      private var i:uint;
      
      private var j:uint;
      
      public var txtSearchQuery:TextInput;
      
      public var btnCancel:MovieClip;
      
      public var searchTerms:String;
      
      public function SearchDialog()
      {
         super();
         addFrameScript(0,this.frame1);
         stop();
         this.hide();
         x = y = 0;
         this.txtSearchQuery.maxChars = 50;
         Main.stageRef.focus = null;
      }
      
      public function initMain() : void
      {
         Utilities.mc2Btn(this.btnCancel);
         Utilities.mc2Btn(this.btnGo);
         this.btnCancel.addEventListener(MouseEvent.CLICK,this.press_btnCancel);
         this.btnGo.addEventListener(MouseEvent.CLICK,this.press_btnGo);
      }
      
      public function hide() : void
      {
         visible = false;
      }
      
      public function listenForEnter(param1:Event) : void
      {
         if(KeyManager.singlePress(KeyManager.ENTER))
         {
            this.press_btnGo(null);
         }
      }
      
      function frame1() : *
      {
         this.initMain();
      }
      
      public function press_btnGo(param1:MouseEvent) : void
      {
         var _loc2_:SaveQuery = null;
         this.searchTerms = this.txtSearchQuery.text;
         if(this.searchTerms.length == 0)
         {
            Main.generateOKDialog("You didn\'t enter any search terms");
         }
         else
         {
            _loc2_ = API.createSaveQuery("skins");
            _loc2_.addCondition("tags",SaveQuery.OPERATOR_CONTAINS,this.searchTerms);
            Main.rootRef.saveBrowser.title = "Search results for \'" + this.searchTerms + "\'";
            Main.rootRef.saveBrowser.loadFiles(_loc2_);
            Main.rootRef.btnClearSearch.visible = true;
            this.close();
         }
      }
      
      public function close() : void
      {
         removeEventListener(Event.ENTER_FRAME,this.listenForEnter);
         gotoAndStop(1);
         this.hide();
         Main.stageRef.focus = null;
      }
      
      public function press_btnCancel(param1:MouseEvent) : void
      {
         this.close();
      }
      
      public function show() : void
      {
         parent.setChildIndex(this,parent.numChildren - 1);
         addEventListener(Event.ENTER_FRAME,this.listenForEnter);
         this.txtSearchQuery.setFocus();
         this.txtSearchQuery.setSelection(0,999);
         visible = true;
      }
   }
}
