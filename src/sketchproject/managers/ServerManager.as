package sketchproject.managers
{	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class ServerManager extends EventDispatcher {
		
		/** constant server configuration */
		public static const SERVER_HOST:String = "../";//"http://localhost/businesscareer/";
		public static const NO_SESSION:String = "no_session";
		public static const READY_SESSION:String = "ready_session";
		
		/** constant dispatch event type */
		public static const READY:String = "ready";
		public static const PROGRESS:String = "progress";
		public static const ERROR:String = "error";
		
		/** public variable from server */
		public var received:URLVariables;
		public var progress:Number;
		public var error:String;
		
		/** assign a variable name for our URLVariables object; */
		private var variables:URLVariables;	
		
		/** build the request variable */ 
		private var request:URLRequest;		
		
		/** build the varLoader variable */
		private var loader:URLLoader;
		
		/** data carrier variable */
		private var data:Object;
		private var url:String;
		
		/**
		 * Server manager constructor
		 */
		public function ServerManager(dest:String = "", dataVars:Object = null) {
			url = ServerManager.SERVER_HOST + dest;				
			data = dataVars;
		}
		
		public function sendRequest():void
		{
			request = new URLRequest(url);
			variables = new URLVariables();
			loader = new URLLoader();
			parseVariables();
		}
		
		public function set urlDestination(url:String):void
		{
			this.url = url;
			this.request = new URLRequest(url);
		}
		
		public function get urlDestination():String
		{
			return this.url;
		}
		
		public function set objectData(data:Object):void
		{
			this.data = data;
		}
		
		public function get objectData():Object
		{
			return this.data;
		}
		
		/**
		 * parse variable to be send
		 * @params $event passing Added to Stage event
		 * @return void
		 */
		private function parseVariables():void {			
			for (var item:* in data) {				
				variables[item] = data[item];             
			}			
			serverRequest();
		}
		
		/**
		 * Initializing server request and load data
		 * @return void
		 */
		private function serverRequest():void {	
			request.method = URLRequestMethod.POST;
			request.data = variables;
			
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;           
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(request);
		}
		
		/**
		 * Handler when communication complete
		 * @params $event passing Complete event
		 * @return void
		 */
		public function completeHandler(event:Event):void {
			received = new URLVariables(loader.data);
			dispatchEvent(new Event(ServerManager.READY)); 
		}
		
		/**
		 * Handler when communication work in progress
		 * @params $event passing Progress event
		 * @return void
		 */
		public function progressHandler(event:ProgressEvent):void {
			progress = Math.ceil(Math.floor(event.bytesLoaded / 1024) / Math.floor(event.bytesTotal / 1024) * 100);
			dispatchEvent(new Event(ServerManager.PROGRESS)); 
		}
		
		/**
		 * Handler when error occured
		 * @params $event passing IO Error event
		 * @return void
		 */
		public function errorHandler(event:IOErrorEvent):void {
			error = event.toString();
			dispatchEvent(new Event(ServerManager.ERROR)); 
		}
	}
}