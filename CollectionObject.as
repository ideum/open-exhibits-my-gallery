package  {
	import id.core.TouchComponent;
	import flash.display.Shape;
	import flash.display.Stage;
	import id.element.Graphic;
	import ScrollerThumb;
	
	public class CollectionObject extends TouchComponent{
		private var backdrop:Shape;
		private var infoBar:Graphic;
		private var titleDisplay:TextDisplay;
		private var nameDisplay:TextDisplay;
		private var display:Array;
		
		private var titleInfo:String;
		private var nameInfo:String;
		private var input:Array;
		private var _id:int;
		
		public function CollectionObject(t:String, n:String, i:Array, iD:int) {
			titleInfo = t;
			nameInfo = n;
			input = i;
			_id = iD;

			createUI();
			commitUI();
			
		}
		
		public function get title():String{
			return titleInfo;
		}
		
		override public function get name():String{
			return nameInfo;
		}
		
		public function get images():Array{
			return input;
		}
		
		override public function get id():int{
			return _id;
		}
		
		override public function Dispose():void{
			infoBar.removeChild(titleDisplay);
			titleDisplay.Dispose();
			titleDisplay = null;
			
			infoBar.removeChild(nameDisplay);
			nameDisplay.Dispose();
			nameDisplay = null;
			
			removeChild(infoBar);
			infoBar.graphics.clear();
			infoBar = null;
			
			removeChild(backdrop);
			backdrop.graphics.clear();
			backdrop = null;
			
			for each(var i:ScrollerThumb in display){
				i.Dispose();
				i = null;
			}
			
			display = null;
		}
		
		override protected function createUI():void{
			backdrop = new Shape();
			infoBar = new Graphic();
			titleDisplay = new TextDisplay();
			nameDisplay = new TextDisplay();
			display = new Array();
			
			addChild(backdrop);
			infoBar.addChild(titleDisplay);
			infoBar.addChild(nameDisplay);
			addChild(infoBar);
			
			for(var i:int = 0; i < input.length; ++i){
				var thumb:ScrollerThumb = new ScrollerThumb();
				thumb.blobContainerEnabled = false;
				thumb.scaleX = .83;
				thumb.scaleY = .83;
				display.push(thumb);
				addChild(thumb);
			}
			
		}
		
		override protected function commitUI():void{
			for(var i:int = 0; i < display.length; ++i){
				display[i].id = input[i];
			}
			
			titleDisplay.styleList = {fontColor:0xFFFFFF,fontSize:16};
			titleDisplay.text = titleInfo;
			titleDisplay.multilined = false;
			
			nameDisplay.styleList = {fontColor:0xFFFFFF,fontSize:12};
			nameDisplay.text = nameInfo;
			nameDisplay.multilined = false;
			
			infoBar.alpha = .8;
			infoBar.fillColor1 = 0x232323;
		}
		
		override protected function layoutUI():void{
			try{
				var padding:int = 5;
				
				backdrop.alpha = .8;
				backdrop.graphics.beginFill(0x232323);
				backdrop.graphics.drawRect(0,0, stage.stageWidth, 100 + padding * 2);
				backdrop.graphics.endFill();
	
				var biggest:Number = 0;
				if(titleDisplay.width > biggest){
					biggest = titleDisplay.width;
					infoBar.width = padding * 2 + biggest;
				}
				if(nameDisplay.width > biggest){
					infoBar.width = padding * 2 + nameDisplay.width;
				}
	
				infoBar.height = titleDisplay.height + nameDisplay.height + padding * 2;
				infoBar.x = stage.stageWidth/2 - infoBar.width/2;
				
				titleDisplay.x = infoBar.width/2 - titleDisplay.width/2 - 2;
				titleDisplay.y = padding;
				nameDisplay.x = infoBar.width/2 - nameDisplay.width/2 - 2;
				nameDisplay.y = titleDisplay.y + titleDisplay.height;
				
				backdrop.y = infoBar.height;
				
				var startPos = stage.stageWidth/2 - (((display.length * 100) + (padding * (display.length -1)))/2);
				display[0].y = backdrop.y + padding;
				display[0].x = startPos;
				
				for(var i:int = 1; i < display.length; ++i){
					display[i].y = display[i-1].y;
					display[i].x = display[i-1].x + display[i-1].width*.83 + padding;
				}
			}
			catch(e:Error){
				
			}
			
			
		}

	}
	
}
