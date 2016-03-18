package  {
	import id.core.TouchComponent;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import id.core.TouchSprite;
	import gl.events.TouchEvent;
	import flash.display.Shape;
	import caurina.transitions.Tweener;
	import flash.net.*;

	
	
	public class CollectionViewer extends TouchComponent{
		private var data:XML;
		private var cArray:Array;
		private var collectionObjects:Array;
		private var collectionObjects2:Array;
		private var currentPage:int = 1;
		private var totalPages:int;
		
		private var plusBtn:NextButton; //down arrow
		private var minusBtn:NextButton; //up arrow
		private var nameBtn:SortByName; //sort by name
		private var titleBtn:SortByTitle; //sort by title
		private var timeBtn:SortByTime; //sort by time
		private var returnBtn:BackButton; //back button
		//private var displayBtn:TileWallBtn; //tile wall button
		
		private var plus:TouchSprite;
		private var minus:TouchSprite;
		private var sortName:TouchSprite;
		private var sortTitle:TouchSprite;
		private var sortTime:TouchSprite;
		private var collectionReturn:TouchSprite;
		//private var toDisplay:TouchSprite;
		private var blockerContainer:TouchSprite;
		
		private var extra:Boolean = false;
		public var blocker:Blocker;
		private var topBar:Shape;
		private var middleBar:Shape;
		private var bottomBar:Shape;
		
		private var removed:int = 0;
		private var replaced:int = 0;
		private var moved:int = 0;
		
		private var page:TextDisplay;
		
		private var description:TextDisplay;
		private var curated:TextDisplay;
		
		private var tweening:Boolean = false;
		
		private var orderedBy:String = "time";
		
		public var personalCollection:PersonalCollection;
		
		public function CollectionViewer(){
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, readXML);
			xmlLoader.load(new URLRequest("SavedCollections.xml"));
		}
		
		private function readXML(e:Event):void{
			data = new XML(e.target.data);
			createUI();
			commitUI();
			layoutUI();
		}
		
		override public function Dispose():void{
			plus.removeEventListener(TouchEvent.TOUCH_DOWN, plusDown);
			plus.removeEventListener(TouchEvent.TOUCH_UP, plusUp);
			
			minus.removeEventListener(TouchEvent.TOUCH_DOWN, minusDown);
			minus.removeEventListener(TouchEvent.TOUCH_UP, minusUp);
			
			sortName.removeEventListener(TouchEvent.TOUCH_DOWN, nameDown);
			sortName.removeEventListener(TouchEvent.TOUCH_UP, nameUp);
			
			sortTitle.removeEventListener(TouchEvent.TOUCH_DOWN, titleDown);
			sortTitle.removeEventListener(TouchEvent.TOUCH_UP, titleUp);
			
			sortTime.removeEventListener(TouchEvent.TOUCH_DOWN, timeDown);
			sortTime.removeEventListener(TouchEvent.TOUCH_UP, timeUp);
			
			collectionReturn.removeEventListener(TouchEvent.TOUCH_DOWN, returnDown);
			collectionReturn.removeEventListener(TouchEvent.TOUCH_UP, returnUp);
			
			removeChild(middleBar);
			middleBar.graphics.clear();
			middleBar = null;
			
			removeChild(topBar);
			topBar.graphics.clear();
			topBar = null;
			
			removeChild(bottomBar);
			bottomBar.graphics.clear();
			bottomBar = null;
			
			plus.removeChild(plusBtn);
			plusBtn = null;
			removeChild(plus);
			plus = null;
			
			
			minus.removeChild(minusBtn);
			minusBtn = null;
			removeChild(minus);
			minus = null;
			
			sortName.removeChild(nameBtn);
			nameBtn = null;
			removeChild(sortName);
			sortName = null;
			
			sortTitle.removeChild(titleBtn);
			titleBtn = null;
			removeChild(sortTitle);
			sortTitle = null;
			
			sortTime.removeChild(timeBtn);
			timeBtn = null;
			removeChild(sortTime);
			sortTime = null;

			collectionReturn.removeChild(returnBtn);
			returnBtn = null;
			removeChild(collectionReturn);
			collectionReturn = null;
			
			removeChild(page);
			page.Dispose();
			page = null;
			
			removeChild(curated);
			curated.Dispose();
			curated = null;
			
			removeChild(description);
			description.Dispose();
			description = null;
			
			for(var i:int = cArray.length; i > 0;  --i){
				cArray[i-1] = null;
				cArray.pop();
			}
			
			for (var j:int = collectionObjects.length; j > 0; --j){
				var cObject = collectionObjects.pop();
				removeChild(cObject);
				cObject.removeEventListener(TouchEvent.TOUCH_DOWN, collectionDown);
				cObject.removeEventListener(TouchEvent.TOUCH_UP, collectionUp);
				cObject.Dispose();
			}
			
			if(personalCollection != null){
				removeChild(personalCollection);
				personalCollection.Dispose();
				personalCollection = null;
			}
		}
		
		override protected function createUI():void{
			cArray = new Array();
			collectionObjects = new Array();
			collectionObjects2 = new Array();
			plusBtn = new NextButton();
			minusBtn = new NextButton();
			nameBtn = new SortByName();
			titleBtn = new SortByTitle();
			timeBtn = new SortByTime();
			returnBtn = new BackButton();
			plus = new TouchSprite();
			minus = new TouchSprite();
			sortName = new TouchSprite();
			sortTitle = new TouchSprite();
			sortTime = new TouchSprite();
			collectionReturn = new TouchSprite();
			bottomBar = new Shape();
			middleBar = new Shape();
			topBar = new Shape();
			page = new TextDisplay();
			description = new TextDisplay();
			curated = new TextDisplay();
			
			plus.addEventListener(TouchEvent.TOUCH_DOWN, plusDown);
			plus.addEventListener(TouchEvent.TOUCH_UP, plusUp);
			
			minus.addEventListener(TouchEvent.TOUCH_DOWN, minusDown);
			minus.addEventListener(TouchEvent.TOUCH_UP, minusUp);
			
			sortName.addEventListener(TouchEvent.TOUCH_DOWN, nameDown);
			sortName.addEventListener(TouchEvent.TOUCH_UP, nameUp);
			
			sortTitle.addEventListener(TouchEvent.TOUCH_DOWN, titleDown);
			sortTitle.addEventListener(TouchEvent.TOUCH_UP, titleUp);
			
			sortTime.addEventListener(TouchEvent.TOUCH_DOWN, timeDown);
			sortTime.addEventListener(TouchEvent.TOUCH_UP, timeUp);
			
			collectionReturn.addEventListener(TouchEvent.TOUCH_DOWN, returnDown);
			collectionReturn.addEventListener(TouchEvent.TOUCH_UP, returnUp);
			
			addChild(middleBar);
			addChild(bottomBar);
			addChild(topBar);
			
			plusBtn.rotation = 180; //rotate 180;
			plus.addChild(plusBtn);
			minus.addChild(minusBtn);
			sortName.addChild(nameBtn);
			sortTitle.addChild(titleBtn);
			sortTime.addChild(timeBtn);
			collectionReturn.addChild(returnBtn);
			
			addChild(plus);
			addChild(minus);
			addChild(sortName);
			addChild(sortTitle);
			addChild(sortTime);
			addChild(collectionReturn);			
			addChild(page);
			addChild(curated);
			addChild(description);
			
			//blocker
			blocker = new Blocker();
			blockerContainer = new TouchSprite();
			blockerContainer.addChild(blocker);
			
			var cLength:int = data.collection.length();
						
			for(var i:int = 0; i < cLength; ++i){
				cArray.push(new Node(i, data.collection[i].title, data.collection[i].name));
			}
			
			cArray.reverse();
			
			for(var j:int = 0; j < 3; ++j){
				var output:Array = new Array();
				
				for(var k:int = 0; k < data.collection[cArray[j].id].image.length(); ++k){
					output.push(data.collection[cArray[j].id].image[k]);
				}
				
				var cObject:CollectionObject = new CollectionObject(cArray[j].title, cArray[j].name, output, cArray[j].id);
				collectionObjects.push(cObject);
			}
			
			
		}
		
		override protected function commitUI():void{
			if((cArray.length % 3) == 0){
				totalPages = cArray.length / 3;
			}
			else{
				totalPages = (cArray.length - (cArray.length % 3)) / 3 + 1;
				extra = true;
			}
			
			page.styleList = {fontColor:0xCCCCCC, fontSize:25};
			page.text = currentPage + "/" + totalPages;
			page.multilined = false;
			
			curated.styleList = {fontColor:0xFFFFFF,fontSize:24};
			curated.text = "Curated Collection";
			curated.multilined = false;
			curated.visible = false;
			
			description.styleList = {fontColor:0xFFFFFF,fontSize:18};
			description.visible = false;
			
			collectionReturn.visible = false;
			
			//sortTime.alpha = .5;
			timeBtn.gotoAndStop(2);
			minus.alpha = .5;
		}
		
		override protected function layoutUI():void{
			middleBar.graphics.beginFill(0x424242);
			middleBar.graphics.drawRect(0, 115, stage.stageWidth, 535);
			middleBar.graphics.endFill();
			
			topBar.graphics.beginFill(0x333333);
			topBar.graphics.drawRect(0,0, stage.stageWidth, 115);
			topBar.graphics.endFill();
			
			bottomBar.graphics.beginFill(0x333333);
			bottomBar.graphics.drawRect(0, 650, stage.stageWidth, stage.stageHeight - 650);
			bottomBar.graphics.endFill();
			
			collectionObjects[0].addEventListener(TouchEvent.TOUCH_DOWN, collectionDown, false, 0, true);
			collectionObjects[0].addEventListener(TouchEvent.TOUCH_UP, collectionUp, false, 0, true);
			addChildAt(collectionObjects[0], 1);
			
			collectionObjects[0].y = 125;
			for(var i:int = 1; i < 3; ++i){
				collectionObjects[i].addEventListener(TouchEvent.TOUCH_DOWN, collectionDown, false, 0, true);
				collectionObjects[i].addEventListener(TouchEvent.TOUCH_UP, collectionUp, false, 0, true);
				addChildAt(collectionObjects[i], 1);
				collectionObjects[i].y = collectionObjects[i-1].y + 175;
			}
			var padding = 20;
			//var navStart = stage.stageWidth/2 - (plusBtn.width + minusBtn.width + padding)/2;
			plus.x = 640;
			plus.y = 748.55;
			
			minus.x  = 640;
			minus.y = 675;
			
			sortName.x = 718.75;
			sortName.y = 70;
			
			sortTitle.x = 565.7;
			sortTitle.y = 70;
			
			sortTime.x = 414.6;
			sortTime.y = 70;
			
			page.x = stage.stageWidth/2 - page.width/2;
			page.y = 695;
			
			curated.x = 640 - curated.width/2;
			curated.y = padding*2 + 40;
			
			collectionReturn.x = padding;
			collectionReturn.y = stage.stageHeight - returnBtn.height - padding;

		}
		
		private function plusDown(e:TouchEvent):void{
			if(currentPage < totalPages && !tweening){
				//plus.alpha = .5;
				plusBtn.gotoAndStop(2);
			}

		}
		
		private function plusUp(e:TouchEvent):void{
			if(currentPage < totalPages && !tweening){
				plus.alpha = 1;
				plusBtn.gotoAndStop(1);
				++currentPage;
				page.text = currentPage + "/" + totalPages;
				newPage("up");
			}
		}
		
		private function minusDown(e:TouchEvent):void{
			if(currentPage > 1 && !tweening){
				//minus.alpha = .5;
				minusBtn.gotoAndStop(2);
			}
		}
		
		private function minusUp(e:TouchEvent):void{
			if(currentPage > 1 && !tweening){
				minus.alpha = 1;
				minusBtn.gotoAndStop(1);
				--currentPage;
				page.text = currentPage + "/" + totalPages;
				newPage("down");
			}
		}
		
		private function nameDown(e:TouchEvent):void{
			if(orderedBy != "name" && !tweening){
				//sortName.alpha = .5;
				nameBtn.gotoAndStop(2);
			}
		}
		
		private function nameUp(e:TouchEvent):void{
			if(orderedBy != "name" && !tweening){
				//sortTitle.alpha = 1;
				//sortTime.alpha = 1;
				titleBtn.gotoAndStop(1);
				timeBtn.gotoAndStop(1);
				cArray.sortOn("name");
				currentPage = 1;
				newPage("up");
				orderedBy = "name";
			}
		}
		
		private function titleDown(e:TouchEvent):void{
			if(orderedBy != "title" && !tweening){
				//sortTitle.alpha = .5;
				titleBtn.gotoAndStop(2);
			}
		}
		
		private function titleUp(e:TouchEvent):void{
			if(orderedBy != "title" && !tweening){
				//sortName.alpha = 1;
				//sortTime.alpha = 1;
				nameBtn.gotoAndStop(1);
				timeBtn.gotoAndStop(1);
				cArray.sortOn("title");
				currentPage = 1;
				newPage("up");
				orderedBy = "title";
			}
		}
		
		private function timeDown(e:TouchEvent):void{
			if(orderedBy != "time" && !tweening){
				//sortTime.alpha = .5;
				timeBtn.gotoAndStop(2);
			}
		}
		
		private function timeUp(e:TouchEvent):void{
			if(orderedBy != "time" && !tweening){
				//sortName.alpha = 1;
				//sortTitle.alpha = 1;
				nameBtn.gotoAndStop(1);
				titleBtn.gotoAndStop(1);
				cArray.sortOn("id");
				cArray.reverse();
				currentPage = 1;
				newPage("up");
				orderedBy = "time";
			}
		}

		private function newPage(dir:String):void{
			Main.blockerContainer.visible = true;
			
			tweening = true;
			if(currentPage == 1){
				minus.alpha = .5;
			}
			else{
				minus.alpha = 1;
			}
			if(currentPage == totalPages){
				plus.alpha = .5;
			}
			else{
				plus.alpha = 1;
			}
			
			if(dir == "up"){
				for each (var i:CollectionObject in collectionObjects){
					Tweener.addTween(i, {y: i.y - 550, time: 1.5, delay: 0.2, onComplete: removeOld});
				}
			}
			else if(dir == "down"){
				for each (var b:CollectionObject in collectionObjects){
					Tweener.addTween(b, {y: b.y + 550, time: 1.5, delay: 0.2, onComplete: removeOld});
				}
			}
			
			var startIndex = (currentPage * 3) - 3;
			
			if(currentPage < totalPages || !extra){
				for(var j:int = startIndex; j < startIndex + 3; ++j){
					var output:Array = new Array();
					
					for(var k:int = 0; k < data.collection[cArray[j].id].image.length(); ++k){
						output.push(data.collection[cArray[j].id].image[k]);
					}
					
					var cObject1:CollectionObject = new CollectionObject(cArray[j].title, cArray[j].name, output, cArray[j].id);
					collectionObjects2.push(cObject1);
				}
				
			}
			else{
				for(var m:int = startIndex; m < cArray.length; ++m){
					var output2:Array = new Array();
					
					for(var n:int = 0; n < data.collection[cArray[m].id].image.length(); ++n){
						output2.push(data.collection[cArray[m].id].image[n]);
					}
					
					var cObject2:CollectionObject = new CollectionObject(cArray[m].title, cArray[m].name, output2, cArray[m].id);
					collectionObjects2.push(cObject2);
				}
			}
			collectionObjects2[0].addEventListener(TouchEvent.TOUCH_DOWN, collectionDown, false, 0, true);
			collectionObjects2[0].addEventListener(TouchEvent.TOUCH_UP, collectionUp, false, 0, true);
			addChildAt(collectionObjects2[0], 1);
			
			if(dir == "up"){
				collectionObjects2[0].y = 675;
			}
			else if(dir == "down"){
				collectionObjects2[0].y = -425;
			}

			for(var p:int = 1; p < collectionObjects2.length; ++p){
				collectionObjects2[p].addEventListener(TouchEvent.TOUCH_DOWN, collectionDown, false, 0, true);
				collectionObjects2[p].addEventListener(TouchEvent.TOUCH_UP, collectionUp, false, 0, true);
				addChildAt(collectionObjects2[p], 1);
				collectionObjects2[p].y = collectionObjects2[p-1].y + 175;
			}
			
			if(dir == "up"){
				for each(var q:CollectionObject in collectionObjects2){
					Tweener.addTween(q, {y: q.y - 550, time:1.5, delay: 0.2, onComplete: wasMoved});
				}
			}
			else if(dir == "down"){
				for each(var f:CollectionObject in collectionObjects2){
					Tweener.addTween(f, {y: f.y + 550, time:1.5, delay: 0.2, onComplete: wasMoved});
				}
			}
		}
		
		
		private function removeOld():void{
			++removed;
			if(removed == collectionObjects.length){
				for (var i:int = collectionObjects.length; i > 0; --i){
					var cObject = collectionObjects.pop();
					removeChild(cObject);
					cObject.removeEventListener(TouchEvent.TOUCH_DOWN, collectionDown);
					cObject.removeEventListener(TouchEvent.TOUCH_UP, collectionUp);
					cObject.Dispose();
				}
				replaceArray();
				removed = 0;
			}
		}
		
		private function wasMoved():void{
			++moved;
			if(moved == collectionObjects2.length){
				replaceArray();
				moved = 0;
			}
		}
		
		private function replaceArray():void{
			++replaced;
			if(replaced == 2){
				for (var j:int = collectionObjects2.length; j > 0; --j){
						collectionObjects.push(collectionObjects2.pop());
						collectionObjects.reverse();
				}
				tweening = false;
				replaced = 0;
				Main.blockerContainer.visible = false;
			}
		}
		
		private function hideAll():void{
			for each(var i:CollectionObject in collectionObjects){
				Tweener.addTween(i, {alpha:0, time:1, onComplete: function(){i.visible = false;}});
			}
			
			Tweener.addTween(plus, {alpha:0, time:1, onComplete: function(){plus.visible = false;}});
			Tweener.addTween(minus, {alpha:0, time:1, onComplete: function(){minus.visible = false;}});
			Tweener.addTween(page, {alpha:0, time:1, onComplete: function(){page.visible = false;}});
			Tweener.addTween(sortName, {alpha:0, time:1, onComplete: function(){sortName.visible = false;}});
			Tweener.addTween(sortTitle, {alpha:0, time:1, onComplete: function(){sortTitle.visible = false;}});
			Tweener.addTween(sortTime, {alpha:0, time:1, onComplete: function(){sortTime.visible = false;}});
			Tweener.addTween(middleBar, {alpha:0, time:1, onComplete: function(){middleBar.visible = false;}});
			Tweener.addTween(topBar, {alpha:0, time:1, onComplete: function(){topBar.visible = false;}});
			Tweener.addTween(bottomBar, {alpha:0, time:1, onComplete: function(){bottomBar.visible = false;}});
		}
		
		private function showAll():void{
			for each(var i:CollectionObject in collectionObjects){
				i.visible = true;
				Tweener.addTween(i, {alpha:1, time:1, delay:1});
			}
			
			plus.visible = true;
			minus.visible = true;
			page.visible = true;
			sortName.visible = true;
			sortTitle.visible = true;
			sortTime.visible = true;
			middleBar.visible = true;
			topBar.visible = true;
			bottomBar.visible = true;
			
			var minusA:Number = 1;
			var plusA:Number = 1;
			if(currentPage == 1){
				minusA = .5;
			}
			else if(currentPage == totalPages){
				plusA = .5
			}
			
			
			var timeA:Number = 1;
			var titleA:Number = 1;
			var nameA:Number = 1;
			
			switch(orderedBy){
				case "time":
					timeA = .5;
					timeBtn.gotoAndStop(2);
					break;
				case "title":
					titleA = .5
					titleBtn.gotoAndStop(2);
					break;
				case "name":
					nameA = .5;
					titleBtn.gotoAndStop(2);
			}
			
			Tweener.addTween(plus, {alpha: plusA, time:1, delay:1});
			Tweener.addTween(minus, {alpha: minusA, time:1, delay:1});
			Tweener.addTween(page, {alpha: 1, time:1, delay:1});
			Tweener.addTween(sortName, {alpha: 1, time:1, delay:1});
			Tweener.addTween(sortTitle, {alpha: 1, time:1, delay:1});
			Tweener.addTween(sortTime, {alpha: 1, time:1, delay:1});
			Tweener.addTween(middleBar, {alpha:1, time:1, delay:1});
			Tweener.addTween(topBar, {alpha:1, time:1, delay:1});
			Tweener.addTween(bottomBar, {alpha:1, time:1, delay:1, onComplete: function(){Main.blockerContainer.visible = false;}});
		}
		
		private function collectionDown(e:TouchEvent):void{
			if(!tweening){
				e.currentTarget.alpha = .5;
			}
		}
		
		private function collectionUp(e:TouchEvent):void{
			if (!tweening) {
				if (!Main.guideIntThumbOn) {
					dispatchEvent(new Event("next cue", true));
				}
				
				if (!Main.guideViewGalOn) {
					Main.guideViewGalOn = true; //already performed view gallery
				}
				Main.sgMode = 1;
				
				Main.blockerContainer.visible = true;
				e.currentTarget.alpha = 1;
				hideAll();
				collectionReturn.alpha = 0;
				collectionReturn.visible = true;
				Tweener.addTween(collectionReturn, {alpha:1, time:1, delay:1});
				

				personalCollection = new PersonalCollection(e.currentTarget.images, e.currentTarget.title, e.currentTarget.name);
				personalCollection.alpha = 0;
				addChildAt(blockerContainer, getChildIndex(collectionReturn) - 1); //blocker behind PC
				addChild(personalCollection);
				Tweener.addTween(personalCollection, {alpha:1, time:1, delay:1, onComplete: function(){Main.blockerContainer.visible = false;}});
				if(data.collection[e.currentTarget.id].description != undefined){
					curated.alpha = 0;
					curated.visible = true;
					Tweener.addTween(curated, {alpha:1, time:1, delay:1});
	
					description.text = data.collection[e.currentTarget.id].description;
					description.textWidth = stage.stageWidth/2;
					description.x = 640 - description.width/2;
					description.y = 590;
					description.alpha = 0;
					description.visible = true;
					Tweener.addTween(description, {alpha:1, time:1, delay:1});
				}
			}
		}
		
		private function returnDown(e:TouchEvent):void{
			//collectionReturn.alpha = .5;
			returnBtn.gotoAndStop(2);
		}
		
		private function returnUp(e:TouchEvent):void{
			//collectionReturn.alpha = 1;
			Main.sgMode = 0;
			
			returnBtn.gotoAndStop(1);
			Main.blockerContainer.visible = true;
			Tweener.addTween(personalCollection, {alpha:0, time:1, onComplete: function(){
				removeChild(blockerContainer);
				removeChild(personalCollection);
				personalCollection.Dispose();
				personalCollection = null;
			}});
			
			var destroyList:Array = new Array();
			for(var i:uint = 0; i < parent.numChildren; ++i){
				//trace(numChildren);
				var p:Object = parent.getChildAt(i);
				if(p is PhotoDisplay){
					destroyList.push(p);
				}
			}
			for(var j:uint = 0; j < destroyList.length; ++j){
				destroyList[j].fadeOut();
				destroyList[j] = null;
			}
			Tweener.addTween(description, {alpha:0, time:1, onComplete: function(){description.visible = false;}});
			Tweener.addTween(curated, {alpha:0, time:1, onComplete: function(){curated.visible = false;}});
			Tweener.addTween(collectionReturn, {alpha:0, time:1, onComplete: function(){collectionReturn.visible = false;}});
			showAll();
						
		}
		
	}
	
}
