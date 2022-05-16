package SkinCreator_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public dynamic class text_213 extends MovieClip
   {
       
      
      public var btnPortalLink:MovieClip;
      
      public function text_213()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         Utilities.mc2Btn(this.btnPortalLink);
         this.btnPortalLink.addEventListener(MouseEvent.CLICK,this.clickBtnPortalLink);
      }
      
      public function clickBtnPortalLink(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://www.newgrounds.com/portal/view/571250");
      }
   }
}
