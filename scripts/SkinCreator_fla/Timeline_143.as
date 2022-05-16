package SkinCreator_fla
{
   import com.newgrounds.SaveFile;
   import flash.display.MovieClip;
   
   public dynamic class Timeline_143 extends MovieClip
   {
       
      
      public var iconContainer:MovieClip;
      
      public var file:SaveFile;
      
      public function Timeline_143()
      {
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame7() : *
      {
         if(this.file && this.iconContainer)
         {
            this.file.attachIcon(this.iconContainer);
            buttonMode = true;
         }
      }
   }
}
