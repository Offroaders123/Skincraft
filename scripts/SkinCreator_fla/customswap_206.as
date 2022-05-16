package SkinCreator_fla
{
   import flash.display.MovieClip;
   
   public dynamic class customswap_206 extends MovieClip
   {
       
      
      public function customswap_206()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
         if(Math.random() > 0.5)
         {
            nextFrame();
         }
      }
   }
}
