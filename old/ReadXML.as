package com.notulator 
{
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;

    public class ReadXML extends EventDispatcher{
        public var file:XML;
        public var loader:URLLoader;
        private var _loaded:Boolean = false;

    	public function ReadXML(fileName:String):void{
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, _loadComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, _loadError);

            var path:String = "data/" + fileName;
            loader.load(new URLRequest(path));
        }

        private function _loadComplete(e:Event):void{
            file = new XML(loader.data);
            loader.removeEventListener(Event.COMPLETE, _loadComplete);
            loader.removeEventListener(IOErrorEvent.IO_ERROR, _loadError)
            _loaded = true;
            this.dispatchEvent(new Event('XMLLoadComplete'));
        }

        private function _loadError(e:IOErrorEvent):void{
            trace("you failed ;c");
        }

        //public function getNodeValueBySibling(siblingNode:String, siblingValue:String, node:String):String{
            //return file;
        //}
    }
}
