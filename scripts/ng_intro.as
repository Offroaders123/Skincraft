package
{
   import flash.display.MovieClip;
   
   public dynamic class ng_intro extends MovieClip
   {
       
      
      public var mcNGLogo:MovieClip;
      
      public function ng_intro()
      {
         super();
         addFrameScript(269,this.frame270);
      }
      
      function frame270() : *
      {
         stop();
         MovieClip(root).transitionToMenu();
      }
   }
}
