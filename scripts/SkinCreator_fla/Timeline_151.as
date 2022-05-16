package SkinCreator_fla
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public dynamic class Timeline_151 extends MovieClip
   {
       
      
      public var label:TextField;
      
      public function Timeline_151()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         buttonMode = true;
         mouseChildren = false;
      }
   }
}
