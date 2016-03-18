package  {
	//Import all used classes that are not in the default class.
	import flash.display.Shape;
	import flash.display.Stage;
	import gl.events.GestureEvent;
	import gl.events.TouchEvent;
	import flash.events.Event;
	import id.core.TouchComponent;
	import id.element.BitmapLoader;
	import id.element.Graphic;
	import flash.display.DisplayObject;
	import id.core.TouchSprite;
	import caurina.transitions.Tweener;
	import id.element.Outline;

	public class PhotoDisplay extends TouchComponent {
		//Variables that make up this object
		private var photo:BitmapLoader;
		private var outline:Shape;
		private var artist:TextDisplay;
		private var bio:TextDisplay;
		private var title:TextDisplay;
		private var process:TextDisplay;
		private var credit:TextDisplay;
		private var bg:Graphic;
		private var info:TouchComponent;
		private var btnTab:ButtonTab;
		private var addBtn:AddBtn;
		private var closeBtn:CloseBtn;
		private var infoBtn:InfoBtn;
		private var addContainer:TouchSprite;
		private var closeContainer:TouchSprite;
		private var infoContainer:TouchSprite;
		
		//Data variables
		private var iUrl:String;
		private var iArtist:String;
		private var iBio:String;
		private var iTitle:String;
		private var iDate:String;
		private var iProcess:String;
		private var iCredit:String;
		
		//Other variables
		private var _id:int;
		private var _x:int;
		private var _y:int;
		private var scaled:Boolean = false;
		private var maxScale = 2.2;
		private var minScale = .40;
		private var sWidth;
		private var persoColl:PersonalCollection; //reference to personal collection
		private var dropIn:Boolean = false;
		private var modified:Boolean = false;

		
		//Constructor that creates a PhotoDisplay Object and sets appropriate variables
		public function PhotoDisplay(value:int, x:int, y:int, scrollerWidth, perCol:PersonalCollection){
			super();
			blobContainerEnabled=true;
			visible=false;
			_x = x;
			_y = y;
			this.id = value;
			sWidth = scrollerWidth;
			persoColl = perCol;
		}
		
		//Getter for this object's id
		override public function get id():int{
			return _id;
		}
		
		//Setter for this object's id
		override public function set id(value:int):void{
			_id = value;
			createUI();
			commitUI();
		}
		
		public function disableAdd():void{
			addContainer.alpha = 0.5;
		}
		
		public function enableAdd():void{
			addContainer.alpha = 1;
		}
		
		//Dispose method that frees up memory and removes this object from the stage
		override public function Dispose():void{
			
			info.removeChild(bg);
			bg.Dispose();
			bg = null;
			
			info.removeChild(artist);
			artist.Dispose();
			artist = null;
			
			info.removeChild(bio);
			bio.Dispose();
			bio = null;
			
			info.removeChild(title);
			title.Dispose();
			title = null;
			
			info.removeChild(process);
			process.Dispose();
			process = null;
			
			info.removeChild(credit);
			credit.Dispose();
			credit = null;
			
			removeChild(info);
			info.Dispose();
			info = null;
			
			removeChild(photo);
			photo.Dispose();
			photo = null;
			
			removeChild(outline);
			outline.graphics.clear();
			outline = null;
			
			
			
			addContainer.removeEventListener(TouchEvent.TOUCH_UP, addPressed);
			infoContainer.removeEventListener(TouchEvent.TOUCH_UP, infoPressed);
			
			addContainer.removeEventListener(TouchEvent.TOUCH_DOWN, addDown);
			infoContainer.removeEventListener(TouchEvent.TOUCH_DOWN, infoDown);
			
			addContainer.removeChild(addBtn);
			addBtn = null;
			removeChild(addContainer);
			addContainer = null;
			
			closeContainer.removeChild(closeBtn);
			closeBtn = null;
			removeChild(closeContainer);
			closeContainer = null;
			
			infoContainer.removeChild(infoBtn);
			infoBtn = null;
			removeChild(infoContainer);
			infoContainer = null;
			
			removeChild(btnTab);
			btnTab = null;
			
			parent.removeChild(this);
			Main.blockerContainer.visible = false;
		}
		
		//Intantiate all objects this object is made of, add listeners, and add to stage
		override protected function createUI():void{
			//Data
			iUrl = ImageParser.settings.Content.Source[id].url[0];
			iArtist = ImageParser.settings.Content.Source[id].artist;
			iBio  = ImageParser.settings.Content.Source[id].bio;
			iTitle = ImageParser.settings.Content.Source[id].title;
			iDate = ImageParser.settings.Content.Source[id].date;
			iProcess = ImageParser.settings.Content.Source[id].process;
			iCredit = ImageParser.settings.Content.Source[id].credit;
			
			photo = new BitmapLoader();
			photo.blobContainerEnabled = false;
			outline = new Shape();
			
			artist = new TextDisplay();
			bio = new TextDisplay();
			title = new TextDisplay();
			process = new TextDisplay();
			credit = new TextDisplay();
			bg = new Graphic();
			info = new TouchComponent();
			btnTab = new ButtonTab();
			addBtn = new AddBtn();
			closeBtn = new CloseBtn();
			infoBtn = new InfoBtn();
			addContainer = new TouchSprite();
			closeContainer = new TouchSprite();
			infoContainer = new TouchSprite();
			
			addContainer.addEventListener(TouchEvent.TOUCH_UP, addPressed);
			closeContainer.addEventListener(TouchEvent.TOUCH_UP, closePressed, false, 0, true);
			infoContainer.addEventListener(TouchEvent.TOUCH_UP, infoPressed);
			
			addContainer.addEventListener(TouchEvent.TOUCH_DOWN, addDown);
			closeContainer.addEventListener(TouchEvent.TOUCH_DOWN, closeDown, false, 0, true);
			infoContainer.addEventListener(TouchEvent.TOUCH_DOWN, infoDown);
			
			addEventListener(TouchEvent.TOUCH_DOWN, touchDownHandler, false, 0, true);
			addEventListener(TouchEvent.TOUCH_UP, touchUpHandler, false, 0, true);
			addEventListener(GestureEvent.GESTURE_SCALE_N, scaleHandler, false, 0, true);
			addEventListener(GestureEvent.GESTURE_DRAG_N, dragHandler, false, 0, true);
			
			addChild(outline);
			addChild(photo);
			info.addChild(bg);
			info.addChild(artist);
			info.addChild(bio);
			info.addChild(title);
			info.addChild(process);
			info.addChild(credit);
			addChild(info);
			addContainer.addChild(addBtn);
			closeContainer.addChild(closeBtn);
			infoContainer.addChild(infoBtn);
			addChild(btnTab);
			addChild(addContainer);
			addChild(closeContainer);
			addChild(infoContainer);			
		}
		
		//Set color, texture, and add information
		override protected function commitUI():void{
			
			photo.pixels = 400;
			photo.url = iUrl;
			photo.x = 10;
			photo.y = 10;
			
			outline.alpha = .8;
			
			artist.styleList = {fontColor:0xFFFFFF,fontSize:12};
			artist.text = iArtist;
			artist.multilined = false;
						
			bio.styleList = {fontColor:0xFFFFFF,fontSize:12};
			bio.text = iBio;
			bio.multilined = false;
			
			title.styleList = {fontColor:0xFFFFFF,fontSize:12};
			title.text = iTitle + ", " + iDate;
			title.multilined = false;
			
			process.styleList = {fontColor:0xFFFFFF,fontSize:12};
			process.text = iProcess;
			process.multilined = false;
			
			credit.styleList = {fontColor:0xFFFFFF,fontSize:12};
			credit.text = iCredit;
			credit.multilined = false
			
			bg.alpha = .8;
			bg.fillColor1 = 0x202020; //2105376;
		}
		
		//Move objects to the right spot within this object
		override protected function layoutUI():void{
			
			var padding:int = 10;
			var biggest:Number = 0;
			var pw = photo.width;
			var ph = photo.height;
			var px = photo.x;
			var py = photo.y;
			
			outline.graphics.beginFill(0x202020);
			outline.graphics.drawRect(0, 0, pw + 20, ph + 20);
			outline.graphics.endFill();

			infoContainer.x = px - infoContainer.width - padding;
			infoContainer.y = py + ph - infoContainer.height;
			
			addContainer.x = infoContainer.x;
			addContainer.y = infoContainer.y - addContainer.height - padding;
			if (Main.personalCollection.collection.length >= 10)
				addContainer.alpha = 0.5;
			
			closeContainer.x = infoContainer.x;
			closeContainer.y = addContainer.y - closeContainer.height - padding;
			
			btnTab.x = closeContainer.x - 5.85;
			btnTab.y = closeContainer.y - 4.8;
			
			if(title.width > biggest){
				biggest = title.width;
				bg.width = (padding * 2) + title.width;
			}
			if(artist.width > biggest){
				biggest = artist.width;
				bg.width = (padding * 2) + artist.width;
			}
			if(bio.width > biggest){
				biggest = bio.width;
				bg.width = (padding * 2) + bio.width;
			}
			if(process.width > biggest){
				biggest = process.width;
				bg.width = (padding * 2) + process.width;
			}
			if(credit.width > biggest){
				biggest = credit.width;
				bg.width = (padding * 2) + credit.width;
			}
			if(biggest < pw && bg.width < pw){
				bg.width = pw;
			}
			
			info.y = py + ph + padding;
			info.x = px + pw/2 - bg.width/2;
			

			title.y = 0;
			title.x = padding;
			
			artist.x = padding;
			artist.y = title.y + title.height;
			
			bio.x = padding;
			bio.y = artist.y + artist.height;
			
			process.x = padding;
			process.y = bio.y + bio.height;
			
			credit.x = padding;
			credit.y = process.y + process.height;

			bg.height = artist.height + bio.height + title.height + process.height + credit.height + (padding);			
			visible = true;
			
			width = outline.width;
			height = outline.height;
			
			x = _x - (outline.width/2);
			y = _y - (outline.height/2);
			
			_x = x + outline.x;
			_y = y + outline.y;
			
			if(x <= sWidth){
				x = sWidth + 1;
			}
			else if(x + width >= persoColl.x){
				x = persoColl.x - width;
			}
			
			
			alpha = 0;
			scaleX = 0.9;
			scaleY = 0.9;
			
			fadeIn();
		}
		
		//Update the positioning of each object after it has been scaled
		override protected function updateUI():void{
			width = photo.width * photo.scaleX;
			height = (photo.height * photo.scaleY) + info.height;			
			var padding:int = 10;
			var pw = photo.width * photo.scaleX;
			var ph = photo.height * photo.scaleY;
			var px = photo.x;
			var py = photo.y;
			
			
			outline.width = pw + 20;
			outline.height = ph + 20;
			outline.x = px - 10;
			outline.y = py - 10;
			
			_x = x + outline.x;
			_y = y + outline.y;
			
			
			info.y = py + ph + padding;
			info.x = px + pw/2 - bg.width/2;

			
			infoContainer.x = px - infoContainer.width - padding;
			infoContainer.y = py + ph - infoContainer.height;
			
			addContainer.x = infoContainer.x;
			addContainer.y = infoContainer.y - addContainer.height - padding;
			
			closeContainer.x = infoContainer.x;
			closeContainer.y = addContainer.y - closeContainer.height - padding;
			
			btnTab.x = closeContainer.x - 5.85;
			btnTab.y = closeContainer.y - 4.8;
			
			width = outline.width;
			height = outline.height;
		}
		
		//Focus this object when it is touched
		private function touchDownHandler(event:TouchEvent):void
		{
			parent.setChildIndex(this as PhotoDisplay, parent.numChildren - 2);
			if(!modified){
				addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			}

		}
		
		//Rules for dragging this object
		private function dragHandler(e:GestureEvent):void{
			if (Main.guideResizeOn) { //resize guidance cue already shown (set in Main after animation shown)
				dispatchEvent(new Event("next cue", true));
			}
			
			
			scaled = false;
			x += e.dx;
			y += e.dy;
			
			_x = x + outline.x;
			_y = y + outline.y;
			
			if(!modified){
				if ((_x + (width * .25)) <= sWidth ){
					alpha = 0.5;		
				} else if (outline.hitTestObject(Main.personalCollection.pc_dropArea) && Main.personalCollection.collection.length != 10) {
					alpha = 0.5;
					
					if (!Main.personalCollection.pcGlowing) {
						Main.personalCollection.pcGlowing = true;
						Main.personalCollection.setChildIndex(Main.personalCollection.pcGlow, Main.personalCollection.numChildren - 1);
						Main.personalCollection.pcGlow.gotoAndPlay("glow");
					}
				} else {
					alpha = 1;
					if (Main.personalCollection.pcGlowing) {
							Main.personalCollection.pcGlowing = false;
							Main.personalCollection.pcGlow.gotoAndStop(1);
						}
						Main.personalCollection.pcGlowing = false;
				}
				
			}
		}
		
		//Dropping into scroller or personal collection, repositioning otherwise
		private function touchUpHandler(event:TouchEvent):void
		{
			Main.personalCollection.pcGlowing = false;
			Main.personalCollection.pcGlow.gotoAndStop(1);
			
			if((_x + (width * .25)) < sWidth && !scaled){ //dropping into scroller boundary
				returnToScroller();
			}
			
			else if (dropIn) { //allowed to drop into personal collection
				//begin guidance cue
				if (!Main.guideMGOn) { //scroll performed, but not drag
					Main.guideMGOn = true;
					dispatchEvent(new Event("next cue", true));
				}
				//end guidance cue
				
				addToPersonalCollection();
			}
			
			else if(_x <= sWidth){ //reposition when dropping too close to scroller BUT NOT within boundary
				Tweener.addTween(this, { x: (x + sWidth - _x), time: .25, onComplete: function(){_x = x + outline.x;}} );
			}
			else if ( (_x + outline.width >= persoColl.x) || //reposition when dropping too close to personal collection BUT NOT within boundary
			          (Main.personalCollection.collection.length >= 10 && dropIn) ){ 
				Tweener.addTween(this, { x: (x - (_x + outline.width - persoColl.x) ), time: .25, onComplete: function(){_x = x + outline.x;}} );
			}
			
			removeEventListener(Event.ENTER_FRAME, loop);			
		}
		
		//Rules for scaling this object
		private function scaleHandler(event:GestureEvent):void{
			if (!Main.guideResizeOn) {
				Main.guideResizeOn = true;
				dispatchEvent(new Event("next cue", true));
			}
			
			if(photo.scaleX == photo.scaleY && photo.scaleX <= maxScale && photo.scaleX >= minScale){
				scaled = true;
				if(_x > sWidth && (_x + outline.width) < persoColl.x && width < (persoColl.x - sWidth)){ 
					photo.scaleX+=event.value;
					photo.scaleY+=event.value;
				}
				else{
					if(event.value < 0){
						photo.scaleX+=event.value;
					    photo.scaleY+=event.value;
					}
				}
			}
			else{
				photo.scaleX = photo.scaleY;
				if(photo.scaleX <= minScale){
					photo.scaleX = minScale + .1;
					photo.scaleY = minScale + .1;
				}
				if(photo.scaleX >= maxScale){
					photo.scaleX = maxScale - .1;
					photo.scaleY = maxScale - .1;
				}
			}
			if(photo.scaleX < .75 || photo.scaleX > 1.5){
				btnTab.visible = false;
				addContainer.visible = false;
				closeContainer.visible = false;
				infoContainer.visible = false;
				info.visible = false;
			}
			else{
				btnTab.visible = true;
				if(!modified){
					addContainer.visible = true;
				}
				closeContainer.visible = true;
				infoContainer.visible = true;
				info.visible = true;
			}
			
			updateUI();
		}
		
		//Fade in tween for when the object is instantiated
		public function fadeIn():void {
			Tweener.addTween(this, { scaleX: 1, scaleY: 1, alpha: 1, time: 1} );
		}
		
		public function fadeOut():void {
			Tweener.addTween(this, { scaleX: 0.94, scaleY: 0.94, alpha: 0, time: 0.9, onComplete: returnToScroller } );
		}
		
		//Listener for the add button
		private function addPressed(e:TouchEvent):void{
			Main.blockerContainer.visible = true;
			if (Main.personalCollection.collection.length < 10) {
				//begin guidance cue
				if (!Main.guideMGOn) { //scroll performed, but not drag
					Main.guideMGOn = true;
					dispatchEvent(new Event("next cue", true));
				}
				//end guidance cue
				
				addContainer.alpha = 1;
				Tweener.addTween(this, { scaleX: 1.05, scaleY: 1.05, time: 0.9, alpha: 0, onComplete: addToPersonalCollection } );
			}
		}
		
		//Listener for the close button
		private function closePressed(e:TouchEvent):void {
			Main.blockerContainer.visible = true;
			closeContainer.alpha = 1;
			if(modified){
				Main.cViewer.personalCollection.displayImage(_id);
			}
			Tweener.addTween(this, { scaleX: 0.94, scaleY: 0.94, time: 0.9, alpha: 0, onComplete: function(){
				if(!modified){
					returnToScroller();
				}
				else{
					Dispose();
				}
			}} );
		}
		
		//Listener for the info button
		private function infoPressed(e:TouchEvent):void{
			infoContainer.alpha = 1;
			if(info.visible == false){
				info.visible = true;
			}
			else{
				info.visible = false;
			}
		}
		
		//The next three methods change the alpha of the buttons when pressed
		private function addDown(e:TouchEvent):void{
			addContainer.alpha = .5;
		}
		
		private function closeDown(e:TouchEvent):void{
			closeContainer.alpha = .5;
		}
		
		private function infoDown(e:TouchEvent):void{
			infoContainer.alpha = .5;
		}
		
		//Called when the photo is dragged into the scroller area
		public function returnToScroller():void {
			Main.blockerContainer.visible = true;
			if(!modified){
				dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_DESTROY, id));
			}
			Dispose();
		}
		
		//Called when the photo is dragged into the personal collection area
		private function addToPersonalCollection():void {
			dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_ADD, id));
			Dispose();
		}
		
		//Tests whether or not the photo has been dragged into the personal collection
		private function loop(e:Event):void {
			if (outline.hitTestObject(Main.personalCollection.pc_dropArea) && Main.personalCollection.collection.length < 10) {
				dropIn = true;
			} else {
				dropIn = false;
			}
		}
		
		public function convert():void{
			modified = true;
			maxScale = 3;
			addContainer.visible = false;
			closeContainer.removeEventListener(TouchEvent.TOUCH_DOWN, closeDown);
			closeContainer.removeEventListener(TouchEvent.TOUCH_DOWN, closePressed);
			
			closeContainer.addEventListener(TouchEvent.TOUCH_DOWN, modCloseDown, false, 0, true);
			closeContainer.addEventListener(TouchEvent.TOUCH_UP, modCloseUp, false, 0, true);
			
			removeEventListener(TouchEvent.TOUCH_UP, touchUpHandler);

		}
		
		private function modCloseDown(e:TouchEvent):void{
			closeContainer.alpha = .5;
		}
		
		private function modCloseUp(e:TouchEvent):void{
			closeContainer.alpha = 1;
			Tweener.addTween(this, { scaleX: 0.94, scaleY: 0.94, time: 0.9, alpha: 0, onComplete: function(){Dispose();}} );
		}
	}
}
