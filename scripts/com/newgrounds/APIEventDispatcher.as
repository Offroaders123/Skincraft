package com.newgrounds
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   class APIEventDispatcher extends EventDispatcher
   {
      
      private static var _globalDispatcher:EventDispatcher;
      
      private static var _eventQueue:Array = initEventQueue();
      
      private static var _ticker:Sprite;
       
      
      function APIEventDispatcher()
      {
         super();
      }
      
      public static function get globalDispatcher() : EventDispatcher
      {
         return _globalDispatcher;
      }
      
      public static function set globalDispatcher(param1:EventDispatcher) : void
      {
         _globalDispatcher = param1;
      }
      
      private static function initEventQueue() : Array
      {
         _ticker = new Sprite();
         _ticker.addEventListener(Event.ENTER_FRAME,runEventQueue);
         return [];
      }
      
      private static function runEventQueue(param1:*) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:Object = null;
         var _loc2_:uint = _eventQueue.length;
         if(_loc2_)
         {
            _loc3_ = _eventQueue;
            _eventQueue = [];
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               (_loc5_ = _loc3_[_loc4_]).dispatcher.actualDispatchEvent(_loc5_.event);
               _loc4_++;
            }
         }
      }
      
      override public function dispatchEvent(param1:Event) : Boolean
      {
         _eventQueue.push({
            "dispatcher":this,
            "event":param1
         });
         return true;
      }
      
      private function actualDispatchEvent(param1:Event) : void
      {
         var _loc2_:Boolean = super.dispatchEvent(param1);
         if(_globalDispatcher && this != _globalDispatcher)
         {
            _globalDispatcher.dispatchEvent(param1);
         }
      }
   }
}
