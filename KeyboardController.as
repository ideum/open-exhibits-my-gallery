package  {
	import flash.text.*;
	import flash.events.Event;
	import gl.events.TouchEvent;
	import id.core.TouchComponent;
	import flash.display.MovieClip;
	import id.core.TouchSprite;
	import caurina.transitions.Tweener;

	
	public class KeyboardController extends TouchComponent{
		private var titleInputTxt:TextField;
		private var nameInputTxt:TextField;
		public var japaneseKeyboard:SoftKeyboardJpn;
		public var englishKeyboard:SoftKeyboard;
		public var touchName:TouchSprite;
		public var touchTitle:TouchSprite;
		private var n:NameInput;
		private var t:TitleInput;
		private var format:TextFormat;
		
		public var english:Boolean = true;
		public var transition:Boolean = false; //animation is occurring
		
		public function KeyboardController(){
			createUI();
			commitUI();
			layoutUI();
		}
		
		public function get titleText():String{
			return titleInputTxt.text;
		}
		
		public function get nameText():String{
			return nameInputTxt.text;
		}
		
		override protected function createUI():void{
			format = new TextFormat();
			titleInputTxt = new TextField();
			nameInputTxt = new TextField();
			englishKeyboard = new SoftKeyboard(titleInputTxt);
			japaneseKeyboard = new SoftKeyboardJpn(titleInputTxt);
			touchName = new TouchSprite();
			touchTitle = new TouchSprite();
			n = new NameInput();
			t = new TitleInput();
			
			addEventListener("english to japanese", englishToJapanese);
			addEventListener("japanese to english", japaneseToEnglish);
			touchName.addEventListener(TouchEvent.TOUCH_UP, nameUp);
			touchTitle.addEventListener(TouchEvent.TOUCH_UP, titleUp);
			
			addChild(englishKeyboard);
			addChild(japaneseKeyboard);
			touchName.addChild(n);
			touchName.addChild(nameInputTxt);
			addChild(touchName);
			touchTitle.addChild(t);
			touchTitle.addChild(titleInputTxt);
			addChild(touchTitle);
		}
		
		override protected function commitUI():void{
			format.font = "Arial";
			format.align = TextFieldAutoSize.LEFT;
			format.color = 0xFFFFFF;
			format.size = 24;
			
			titleInputTxt.type = TextFieldType.INPUT; 
			titleInputTxt.width = 685; 
			titleInputTxt.height = 30;
			titleInputTxt.border = false;
			titleInputTxt.background = false;
			titleInputTxt.defaultTextFormat = format;
			//titleInputTxt.textColor = 0xFFFFFF;
			//titleInputTxt.autoSize = TextFieldAutoSize.LEFT;
			
			nameInputTxt.type = TextFieldType.INPUT; 
			nameInputTxt.width = 685; 
			nameInputTxt.height = 30;
			nameInputTxt.border = false;
			nameInputTxt.background = false;
			nameInputTxt.defaultTextFormat = format;
			
		}
		
		override protected function layoutUI():void{
			x = 1425.35;
			y = 527.45;
			
			titleInputTxt.y = 28;
			titleInputTxt.x = 10;
			nameInputTxt.y = 28;
			nameInputTxt.x = 10;
			touchName. y = 66;
			
			englishKeyboard.y = touchName.y + touchName.height + 100;
			japaneseKeyboard.y = englishKeyboard.y;
			englishKeyboard.alpha = 0;
			japaneseKeyboard.scaleX = japaneseKeyboard.scaleY = englishKeyboard.scaleX = englishKeyboard.scaleY = 0.9;
			if(english){
				japaneseKeyboard.visible = false;
			}
			else{
				englishKeyboard.visible = false;
			}
		}
		
		public function reset():void {
			
		}
		
		public function englishToJapanese(e:Event):void{
			englishKeyboard.visible = false;
			japaneseKeyboard.visible = true;
			english = false;
			japaneseKeyboard.toDefault();
			Main.exitKeyboard.gotoAndStop("exitJPN");
		}
		
		public function japaneseToEnglish(e:Event):void{
			japaneseKeyboard.visible = false;
			englishKeyboard.visible = true;
			english = true;
			englishKeyboard.toDefault();
			Main.exitKeyboard.gotoAndStop("exitENG");
		}
		
		private function nameUp(e:Event) {
			if (!Main.guideTitNamOn) {
				Main.guideTitNamOn = true;
			}
			
			englishKeyboard.input = nameInputTxt;
			japaneseKeyboard.input = nameInputTxt;
			if(transition == false){
				Tweener.addTween(this, { y: y - 310, alpha: 1, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(englishKeyboard, {alpha: 1, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(japaneseKeyboard, { alpha: 1, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(Main.personalCollection, { y: Main.personalCollection.y - 310, time: 0.6, transition:"easeOutQuart" } );

				dispatchEvent(new Event("keyboard transition", true));
				transition = true;
			}
		}
		
		private function titleUp(e:Event) {
			if (!Main.guideTitNamOn) {
				Main.guideTitNamOn = true;
			}
			
			englishKeyboard.input = titleInputTxt;
			japaneseKeyboard.input = titleInputTxt;
			if(transition == false){
				Tweener.addTween(this, { y: y - 310, alpha: 1, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(englishKeyboard, { alpha: 1, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(japaneseKeyboard, { alpha: 1, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(Main.personalCollection, {y: Main.personalCollection.y - 310, time: 0.6, transition:"easeOutQuart" } );
				
				dispatchEvent(new Event("keyboard transition", true));
				transition = true;
			}
		}
		
		public function extKeyboard():void {
			if(transition == true){
				transition = false;
				Tweener.addTween(this, { y: y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(englishKeyboard, { alpha: 0, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(japaneseKeyboard, {alpha: 0, time:0.6, transition:"easeOutQuart" });
				Tweener.addTween(Main.personalCollection, {y: Main.personalCollection.y + 310, time: 0.6, transition:"easeOutQuart"} );
			}
		}
		
		public function clearText():void {
			titleInputTxt.text = '';
			nameInputTxt.text = '';
		}

	}
	
}
