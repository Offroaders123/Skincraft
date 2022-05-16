package
{
   import flash.display.MovieClip;
   
   public dynamic class ToolFollow extends MovieClip
   {
       
      
      public function ToolFollow()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
