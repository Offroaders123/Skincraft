package SkinCreator_fla
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public dynamic class trademark_7 extends MovieClip
   {
       
      
      public var btnMike:MovieClip;
      
      public var btnSwain:MovieClip;
      
      public var btnAfro:MovieClip;
      
      public function trademark_7()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      public function press_btnSwain(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://theswain.com");
      }
      
      public function press_btnAfro(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://afro-ninja.com");
      }
      
      function frame1() : *
      {
         this.btnAfro.buttonMode = true;
         this.btnSwain.buttonMode = true;
         this.btnMike.buttonMode = true;
         this.btnAfro.addEventListener(MouseEvent.CLICK,this.press_btnAfro);
         this.btnSwain.addEventListener(MouseEvent.CLICK,this.press_btnSwain);
         this.btnMike.addEventListener(MouseEvent.CLICK,this.press_btnMike);
      }
      
      public function press_btnMike(param1:MouseEvent) : void
      {
         Utilities.clickLink("http://gingerbinger.com");
      }
   }
}
