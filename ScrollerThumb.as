package  {
	//Import all used classes that aren't already in the default package
	import gl.events.*;
	import id.element.ThumbLoader;
	import id.core.TouchComponent;
	import id.element.Outline;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	
	public class ScrollerThumb extends TouchComponent{
		//Empty pointers to the objects this class is comprised of 
		public var thumbnail:ThumbLoader;
		private var outline:Outline;
		private var container:TouchComponent;
		private var matte:Shape;
		
		private var _id:int;
		private var thumbUrl:String;
		
		private var frameWidth:int;
		private var frameHeight:int;
		private var dropInPC:Boolean; //determines whether to drop into personal collection
		public var position:int = 0; //thumbnail's current ARRAY index in personal collection.  Defaults to 0.  Always 0-9.
		public var dragging = false;
		public var picTouched = false;
		
		private var fromCollection:Boolean = false;
		
		//Constructor
		public function ScrollerThumb(collection:Boolean=false) {
			super();
			blobContainerEnabled=true;
			visible=false;
			fromCollection = collection;
		}
		
		//Getter method for this object's id
		override public function get id():int{
			return _id;
		}
		
		//Setter method for this object's id
		override public function set id(value:int):void{
			_id = value;
			createUI();
			commitUI();
		}
		
		//Setter method for position
		public function setPos(pos:int):void {
			position = pos;
		}
		
		public function getPos():int {
			return position;
		}
		
		//Switches between the outline and the photo
		public function makeVisible(value:Boolean){
			if(value){
				thumbnail.visible=true;
			}
			else{
				thumbnail.visible=false;
			}
		}
		
		override public function Dispose():void{
			container.removeChild(outline);
			outline.Dispose();
			outline = null;
			
			removeChild(container);
			container.Dispose();
			container = null;
			
			removeChild(matte);
			matte.graphics.clear();
			matte = null;
			
			removeChild(thumbnail);
			thumbnail.Dispose();
			thumbnail = null;
			
			parent.removeChild(this);

		}


		//Instantiate objects, add children to the stage
		override protected function createUI():void{
			if(!fromCollection){
				thumbUrl = ImageParser.settings.Content.Source[id].url[1];
			}
			else{
				thumbUrl = ImageParser.settings.Content.Source[id].url[2];
			}
			thumbnail = new ThumbLoader();
			thumbnail.blobContainerEnabled = false;
			container = new TouchComponent();
			container.blobContainerEnabled = false;
			outline = new Outline();
			outline.blobContainerEnabled = false;
			matte = new Shape();
			
			container.addChild(outline);
			
			addChild(matte);
			addChild(container);
			addChild(thumbnail);
			
		}
		
		//Change color and texture settings
		override protected function commitUI():void{
			thumbnail.url= thumbUrl;
			outline.color = 0x999999;
			outline.size = 1;
			
			matte.alpha = .8;
		}
		
		//Move things to their correct location within this object
		override protected function layoutUI():void{
			var sLength;
			var tw = thumbnail.width;
			var th = thumbnail.height;
			
			//Find the longest side of this thumbnail
			if(tw >= th){
				sLength = tw;
			}
			else{
				sLength = th;
			}
			
			
			//Draw the matte rectangle
			matte.graphics.beginFill(0x202020);
			matte.graphics.drawRect(0, 0, sLength, sLength);
			matte.graphics.endFill();
			
			//Center the thumbnail within the matte
			thumbnail.x = sLength/2 - tw/2;
			thumbnail.y = sLength/2 - th/2;
			
			var tx = thumbnail.x;
			var ty = thumbnail.y;
			
			//set the width and height of this object according to the size of the matte
			width = sLength;
			height = sLength;
			
			//Arrange the other objects with respect to the thumbnail
			outline.width = tw - 3;
			outline.height = th - 3;
			outline.x = 1.5;
			outline.y = 1.5;
			container.width = tw;
			container.height = th;
			container.x = tx;
			container.y = ty;
			visible = true;
			super.layoutUI();
		}
		
		/**
		 * 
		 * 
		 * @param	pixels
		 * @return
		 */
		public function getScale(pixels:int):Number {
			return pixels/width;
		}
		
		public function getCtnrX():int {
			return container.x;
		}
		
		public function getCtnrY():int {
			return container.y;
		}
		
		public function setMatteColor(color:uint):void {
			var myColor:ColorTransform = matte.transform.colorTransform;
			myColor.color = color;
			matte.transform.colorTransform = myColor;
		}
		
		public function matteOff():void {
			container.visible = false;
			matte.visible = false;
			
		}
		
		public function matteOn():void {
			container.visible = true;
			matte.visible = true;
			setChildIndex(thumbnail, numChildren - 1);
		}
	}
}
