package  {
	//Import all related libraries
	import gl.events.*;
	import id.element.ThumbLoader;
	import id.core.TouchComponent;
	import flash.events.*;
	import flash.utils.Timer;
	import ScrollerThumb;
	import flash.display.Stage;
	import caurina.transitions.Tweener;
	import flash.display.Shape;
	import flash.display.Graphics;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import id.core.TouchSprite;

	
	public class ImageScroll extends TouchComponent {
		private var list1:Array;
		private var list2:Array;
		private var held:Array;
		private var displayed1:Array;
		private var displayed2:Array;
		private var moved:Number;
		private var myTimer:Timer;
		
		private var initialList1:Number = 7;
		private var initialList2:Number = 6;
		private var sWidth:Number;

		private var half:Number;
		var paddingV:Number;
		var paddingH1:Number;
		var paddingH2:Number;
		
		private var tweening:Boolean = false;
		private var flicking:Boolean = false;
		private var friction:Number = .965;
		private var dy:Number = 0;
		private var flickEvent:GestureEvent;
		
		private var flickEnabled = true;
		
		private var line1:Shape;
		private var line2:Shape;
		
		private var pip1:Shape;
		private var pip2:Shape;
		
		private var maxScroll:Number;
		
		private var	leftS:Shape;
		private var rightS:Shape;
		private var left:TouchComponent;
		private var right:TouchComponent;
		
		private var backDragging:Boolean = false;		
		private var oldDrag = false;
		

		
		public function ImageScroll(scrollerWidth:Number){
		super();
		ImageParser.settingsPath="ExhibitList.xml";
		ImageParser.addEventListener(Event.COMPLETE,onParseComplete);
		sWidth = scrollerWidth;
		}
		
		
		private function onParseComplete(e:Event) {
			createUI();
			commitUI();
		}
		
		
		override protected function createUI():void{
			half = ImageParser.totalAmount / 2;
			list1 = new Array();
			list2 = new Array();
			displayed2 = new Array();
			displayed1 = new Array();
			held = new Array();
			line1 = new Shape();
			line2 = new Shape();
			pip1 = new Shape();
			pip2 = new Shape();
			leftS = new Shape();
			rightS = new Shape();
			left = new TouchComponent();
			right = new TouchComponent();
			moved = 0;
			
			addChild(line1);
			addChild(line2);
			addChild(pip1);
			addChild(pip2);
			
			
			left.addEventListener(GestureEvent.GESTURE_DRAG_N, backDrag);
			left.addEventListener(TouchEvent.TOUCH_DOWN, backDown);
			left.addEventListener(TouchEvent.TOUCH_UP, backUp);
			left.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
			
			right.addEventListener(GestureEvent.GESTURE_DRAG_N, backDrag);
			right.addEventListener(TouchEvent.TOUCH_DOWN, backDown);
			right.addEventListener(TouchEvent.TOUCH_UP, backUp);
			right.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);

			
			left.addChild(leftS);
			addChild(left);
			right.addChild(rightS);
			addChild(right);
			
			for(var i:Number = 0; i < half; ++i){
				var thumb:ScrollerThumb = new ScrollerThumb();
				thumb.addEventListener(GestureEvent.GESTURE_DRAG_1, scrollHandler);
				thumb.addEventListener(TouchEvent.TOUCH_DOWN, holdHandler);
				thumb.addEventListener(TouchEvent.TOUCH_UP, touchUpHandler);
				thumb.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
				
				list1.push(thumb);
			}
			
			for(var k:Number = half; k < (half * 2); ++k){
				var thumb2:ScrollerThumb = new ScrollerThumb();
				thumb2.addEventListener(GestureEvent.GESTURE_DRAG_1, scrollHandler);
				thumb2.addEventListener(TouchEvent.TOUCH_DOWN, holdHandler);
				thumb2.addEventListener(TouchEvent.TOUCH_UP, touchUpHandler);
				thumb2.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);

				
				list2.push(thumb2);
			}
			
			for(var j:Number = 0; j < initialList1; ++j){
				addChild(list1[j]);
				displayed1.push(list1[j]);
			}
			
			for(var l:Number = 0; l < initialList2; ++l){
				addChild(list2[l]);
				displayed2.push(list2[l]);
			}
			
		}
		
		override protected function commitUI():void{
			paddingV = ImageParser.settings.GlobalSettings.infoPadding;
			paddingH1 = ImageParser.settings.GlobalSettings.horizontalPadding1;
			paddingH2 = ImageParser.settings.GlobalSettings.horizontalPadding2;
			
			for(var i:Number = 0; i < half; ++i){
				list1[i].id = i;
			}
			for(var j:Number = half; j < (half * 2); ++j){
				list2[j - half].id = j;
			}
			line1.graphics.lineStyle(3, 0x575757, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
			line1.graphics.moveTo(paddingH1 + 120 + 7, paddingV);
			line1.graphics.lineTo(paddingH1 + 120 + 7, stage.stageHeight - paddingV);
			
			line2.graphics.lineStyle(3, 0x575757, 1, false, LineScaleMode.NORMAL, CapsStyle.ROUND);
			line2.graphics.moveTo(paddingH2 - 8, paddingV);
			line2.graphics.lineTo(paddingH2 - 8, stage.stageHeight - paddingV);
			
			pip1.graphics.beginFill(0xFFFFFF);
			pip1.graphics.drawRect(paddingH1 + 120 + 6, paddingV, 3, 20);
			pip1.graphics.endFill();
			
			pip2.graphics.beginFill(0xFFFFFF);
			pip2.graphics.drawRect(paddingH2 - 4 - 5, paddingV, 3, 20);
			pip2.graphics.endFill();
			
			maxScroll = stage.stageHeight - paddingV + 3;
			
			left.blobContainerEnabled = true;
			right.blobContainerEnabled = true;
			
			leftS.graphics.beginFill(0xFFFFFF);
			leftS.graphics.drawRect(0,0, 145, 800);
			leftS.graphics.endFill();
			leftS.alpha = 0;
			
			rightS.graphics.beginFill(0x0);
			rightS.graphics.drawRect(0,0, 145, 800);
			rightS.graphics.endFill();
			rightS.alpha = 0;
						
		}
		
		override protected function layoutUI():void{
			
			for(var i:Number = 0; i < list1.length ; ++i){
				if(i != 0){
					list1[i].x = paddingH1;
					list1[i].y = list1[i - 1].y + list1[i - 1].height + paddingV;

				}
				else{
					list1[i].x = paddingH1;
					list1[i].y = paddingH1;
				}
			}
			
			for(var j:Number = 0; j < list2.length ; ++j){
				if(j != 0){
					list2[j].x = paddingH2;
					list2[j].y = list2[j - 1].y + list2[j - 1].height + paddingV;

				}
				else{
					list2[j].x = paddingH2;
					list2[j].y = paddingH1;
				}
			}
			
			right.x = 145;
		}
		
		private function updateBottom(t:ScrollerThumb):void{
			if(t.id < half){
				var prev = list1[t.id - 1];
				
				t.x = paddingH1;
				t.y = prev.y + prev.height + paddingV;
			}
			else{
				var prev2 = list2[t.id - 1 - half];
				t.x = paddingH2;
				t.y = prev2.y + prev2.height + paddingV;
			}
		}
		
		private function updateTop1():void{
			var nextID = list1[displayed1[0].id + 1];
			
			displayed1[0].x = paddingH1;
			displayed1[0].y = nextID.y - displayed1[0].height - paddingV;
		}
		
		private function updateTop2():void{
			var nextID = list2[displayed2[0].id + 1 - half];
			
			displayed2[0].x = paddingH2;
			displayed2[0].y = nextID.y - displayed2[0].height - paddingV;
		}

		
		private function scrollHandler(e:GestureEvent):void {
			if(!backDragging){
				oldDrag = true;
				if(Math.abs(e.dx) > Math.abs(e.dy) && e.target.picTouched && e.dx > 0){
					e.target.dragging = true;
					Tweener.addTween(e.target.getChildAt(2), {alpha: 0.5, time: 0.2} );
				}
				
				var anyDragging:Boolean = false;
					
				if(flickEnabled){
					for each(var q:ScrollerThumb in displayed1){
						if(q.dragging){
							anyDragging = true;
							break;
						}
					}
					
					for each(var w:ScrollerThumb in displayed2){
						if(w.dragging){
							anyDragging = true;
							break;
						}
					}
				}
				
				if(anyDragging && flickEnabled){
					for each (var r:ScrollerThumb in list1){
						r.removeEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					}
					for each (var t:ScrollerThumb in list2){
						t.removeEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					}
					left.removeEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					right.removeEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					flickEnabled = false;
				}
				
				if(e.currentTarget.dragging){
					e.target.getChildAt(2).x += e.dx;
					e.target.getChildAt(2).y += e.dy;
				}
	
				else if(e.target.id < half && !tweening){
					var lastT1 = displayed1[displayed1.length - 1];
					if((lastT1.id != (half - 1)) && (displayed1[0].id != 0)){
						for each(var i in displayed1){
							i.y += e.dy;
							e.target.getChildAt(2).alpha = 1;
						}
					}
					else{
						if(displayed1[0].id == 0){
							if((displayed1[0].y <= paddingH1 && (displayed1[0].y + e.dy) <= paddingH1) || e.dy < 0){
								for each(var j in displayed1){
									j.y += e.dy;
									e.target.getChildAt(2).alpha = 1;
								}
							}
						}
						else{
							if(((lastT1.y + lastT1.height) >= (stage.stageHeight - paddingH1) && (lastT1.y + lastT1.height + e.dy) >= (stage.stageHeight - paddingH1)) || e.dy > 0){
								for each(var k in displayed1){
									k.y += e.dy;
									e.target.getChildAt(2).alpha = 1;
								}
							}
						}
					}
					
					if((displayed1[0].y + displayed1[0].height) < -10){
						removeChild(displayed1[0]);
						displayed1.splice(0,1);
					}
					
					if(lastT1.y > (stage.stageHeight + 10)){
						removeChild(lastT1);
						displayed1.splice(displayed1.length - 1, 1);
					}
									
					if((displayed1[0].y >= 0) && (displayed1[0].id > 0)){
						addChild(list1[displayed1[0].id - 1]);
						displayed1.splice(0,0, list1[displayed1[0].id - 1]);
						updateTop1();
					}
					
					if((lastT1.y + lastT1.height) <= stage.stageHeight && (lastT1.id + 1 < half)){
						var nextBottom:ScrollerThumb = list1[lastT1.id + 1];
						addChild(nextBottom);
						displayed1.push(nextBottom);
						updateBottom(nextBottom);
					}
				}
				else if(e.target.id >= half && !tweening){
					var lastT2 = displayed2[displayed2.length - 1];
					if((lastT2.id != (half * 2 - 1)) && (displayed2[0].id != half)){
						for each(var m in displayed2){
							m.y += e.dy;
							e.target.getChildAt(2).alpha = 1;
						}
					}
					else{
						if(displayed2[0].id == half){
							if((displayed2[0].y <= paddingH1 && (displayed2[0].y + e.dy) <= paddingH1) || e.dy < 0){
								for each(var p in displayed2){
									p.y += e.dy;
									e.target.getChildAt(2).alpha = 1;
								}
							}
						}
						else{
							if(((lastT2.y + lastT2.height) >= (stage.stageHeight - paddingH1) && (lastT2.y + lastT2.height + e.dy) >= (stage.stageHeight - paddingH1)) || e.dy > 0){
								for each(var n in displayed2){
									n.y += e.dy;
									e.target.getChildAt(2).alpha = 1;
								}
							}
						}
					}
					
					
					if((displayed2[0].y + displayed2[0].height) < -10){
						removeChild(displayed2[0]);
						displayed2.splice(0,1);
					}
					
					if(lastT2.y > (stage.stageHeight + 10)){
						removeChild(lastT2);
						displayed2.splice(displayed2.length - 1, 1);
					}
									
					if((displayed2[0].y >= 0) && (displayed2[0].id > half)){
						addChild(list2[displayed2[0].id - 1 - half]);
						displayed2.splice(0,0, list2[displayed2[0].id - 1 - half]);
						updateTop2();
					}
					
					if((lastT2.y + lastT2.height) <= stage.stageHeight && (lastT2.id + 1 < half * 2)){
						var nextBottom2:ScrollerThumb = list2[lastT2.id + 1 - half];
						addChild(nextBottom2);
						displayed2.push(nextBottom2);
						updateBottom(nextBottom2);
					}
				}
				updateIndicators();
			}
        }
		
		private function flickHandler(e:GestureEvent):void{
			flicking = true;
			dy = e.velocityY;
			flickEvent = e;
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void{
			if (Math.abs(dy) <= 1) {
                dy = 0;
				flicking = false;
                removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            }
			else if(flickEvent.target.id < half && !tweening){
				var lastT1 = displayed1[displayed1.length - 1];
				
				if((lastT1.id != (half - 1)) && (displayed1[0].id != 0)){
					for each(var i in displayed1){
						i.y += dy;
						if(flickEvent.target != left){
							flickEvent.target.getChildAt(2).alpha = 1;
						}
					}
				}
				else{
					if(displayed1[0].id == 0){
						if((displayed1[0].y <= paddingH1 && (displayed1[0].y + dy) <= paddingH1) || dy < 0){
							for each(var j in displayed1){
								j.y += dy;
								if(flickEvent.target != left){
									flickEvent.target.getChildAt(2).alpha = 1;
								}
							}
						}
						else{
							dy = 0;
							flicking = false;
                			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						}
					}
					else{
						if(((lastT1.y + lastT1.height) >= (stage.stageHeight - paddingH1) && (lastT1.y + lastT1.height + dy) >= (stage.stageHeight - paddingH1)) || dy > 0){
							for each(var k in displayed1){
								k.y += dy;
								if(flickEvent.target != left){
									flickEvent.target.getChildAt(2).alpha = 1;
								}
							}
						}
						else{
							dy = 0;
							flicking = false;
                			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						}
					}
				}
				
				if((displayed1[0].y + displayed1[0].height) < -10){
					removeChild(displayed1[0]);
					displayed1.splice(0,1);
				}
				
				if(lastT1.y > (stage.stageHeight + 10)){
					removeChild(lastT1);
					displayed1.splice(displayed1.length - 1, 1);
				}
								
				if((displayed1[0].y >= 0) && (displayed1[0].id > 0)){
					addChild(list1[displayed1[0].id - 1]);
					displayed1.splice(0,0, list1[displayed1[0].id - 1]);
					updateTop1();
				}
				
				if((lastT1.y + lastT1.height) <= stage.stageHeight && (lastT1.id + 1 < half)){
					var nextBottom:ScrollerThumb = list1[lastT1.id + 1];
					addChild(nextBottom);
					displayed1.push(nextBottom);
					updateBottom(nextBottom);
				}
			}
			else if(flickEvent.target.id >= half && !tweening){
				var lastT2 = displayed2[displayed2.length - 1];
				if((lastT2.id != (half * 2 - 1)) && (displayed2[0].id != half)){
					for each(var m in displayed2){
						m.y += dy;
						if(flickEvent.target != right){
							flickEvent.target.getChildAt(2).alpha = 1;
						}
					}
				}
				else{
					if(displayed2[0].id == half){
						if((displayed2[0].y <= paddingH1 && (displayed2[0].y + dy) <= paddingH1) || dy < 0){
							for each(var p in displayed2){
								p.y += dy;
								if(flickEvent.target != right){
									flickEvent.target.getChildAt(2).alpha = 1;
								}
							}
						}
						else{
							dy = 0;
							flicking = false;
                			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						}
					}
					else{
						if(((lastT2.y + lastT2.height) >= (stage.stageHeight - paddingH1) && (lastT2.y + lastT2.height + dy) >= (stage.stageHeight - paddingH1)) || dy > 0){
							for each(var n in displayed2){
								n.y += dy;
								if(flickEvent.target != right){
									flickEvent.target.getChildAt(2).alpha = 1;
								}
							}
						}
						else{
							dy = 0;
							flicking = false;
                			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						}
					}
				}
				
				
				if((displayed2[0].y + displayed2[0].height) < -10){
					removeChild(displayed2[0]);
					displayed2.splice(0,1);
				}
				
				if(lastT2.y > (stage.stageHeight + 10)){
					removeChild(lastT2);
					displayed2.splice(displayed2.length - 1, 1);
				}
								
				if((displayed2[0].y >= 0) && (displayed2[0].id > half)){
					addChild(list2[displayed2[0].id - 1 - half]);
					displayed2.splice(0,0, list2[displayed2[0].id - 1 - half]);
					updateTop2();
				}
				
				if((lastT2.y + lastT2.height) <= stage.stageHeight && (lastT2.id + 1 < half * 2)){
					var nextBottom2:ScrollerThumb = list2[lastT2.id + 1 - half];
					addChild(nextBottom2);
					displayed2.push(nextBottom2);
					updateBottom(nextBottom2);
				}
			}
			dy *= friction;
			updateIndicators();
		}
		
		
		private function holdHandler(e:TouchEvent):void{
			if (!Main.guideScrollOn ) {
				Main.guideScrollOn = true;
				dispatchEvent(new Event("next cue", true));
			}
			
			parent.setChildIndex(this as ImageScroll, parent.numChildren - 2);
			setChildIndex(e.currentTarget as ScrollerThumb, numChildren - 1);
			
			if(e.target.numChildren == 1 && !flicking){
				e.currentTarget.picTouched = true;
			}
			else if(flicking){
				dy = 0;
				flicking = false;
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		private function touchUpHandler(e:TouchEvent):void{
			if(e.target.numChildren == 1 && !flicking){
				e.currentTarget.dragging = false;
				e.currentTarget.picTouched = false;
				var focused = e.target;
				var fx = focused.x + focused.parent.x + (focused.width/2);
				var fy = focused.y + focused.parent.y + (focused.height/2);
				
				if (e.target.hitTestObject(Main.personalCollection.pc_dropArea) && Main.personalCollection.collection.length < 10) { //drop into MG
					//guidance cue
					if (!Main.guideMGOn) { //scroll performed, but not drag
						Main.guideMGOn = true;
						dispatchEvent(new Event("next cue", true));
					}
					//end guidance cue
					
					e.currentTarget.makeVisible(false);
					dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_ADD, e.currentTarget.id));
					++Main.currentlyDisplayed;
				}else if(focused.x + focused.parent.x > sWidth - 20 && Main.currentlyDisplayed < 10){ //drop into main workspace
					//guidance cue for dropping into main workspace
					if (!Main.guideDragOn) { //scroll performed, but not drag
						Main.guideDragOn = true; 
						dispatchEvent(new Event("next cue", true));
					}
					//end guidance cue
					
					focused.parent.makeVisible(false);
					dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_REQUEST, focused.parent.id, fx, fy));
				} 
				
				var anyDragging:Boolean = false;
				
				if(!flickEnabled){
					for each(var k:ScrollerThumb in displayed1){
						if(k.dragging){
							anyDragging = true;
							break;
						}
					}
					
					for each(var l:ScrollerThumb in displayed2){
						if(l.dragging){
							anyDragging = true;
							break;
						}
					}
				}
				
				if(!anyDragging && !flickEnabled){
					for each (var i:ScrollerThumb in list1){
						i.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					}
					for each (var j:ScrollerThumb in list2){
						j.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					}
					left.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					right.addEventListener(GestureEvent.GESTURE_FLICK_N, flickHandler);
					flickEnabled = true;
				}
				
				Tweener.addTween(e.target, { scaleX:1, scaleY:1, x: focused.parent.width/2 - focused.width/2, y: focused.parent.height/2 - focused.height/2, alpha: 1, time: 0.5 } );
			}
			oldDrag = false;
		}
		
		
		public function destroyHandler(e:PhotoEvent):void{
			if (e.id < half){
				list1[e.id].makeVisible(true);
				list1[e.id].thumbnail.alpha = 0;
				Tweener.addTween(list1[e.id].thumbnail, { alpha: 1, time: 1} );
			}
			else{
				list2[e.id - half].makeVisible(true);
				list2[e.id - half].thumbnail.alpha = 0;
				Tweener.addTween(list2[e.id - half].thumbnail, { alpha: 1, time: 1} );
			}
		}
		
		private function updateIndicators(){
			var d1:int = displayed1[0].id;
			var d2:int = displayed2[0].id - half;
			if(d1 > half - 5){
				d1 = half - 5;
			}
			if(d2 > (half - 5)){
				d2 = (half - 5);
			}
			
			var y1 = d1/(half - 5);
			var y2 = d2/(half - 5);
			
			pip1.y = (y1 * maxScroll);
			pip2.y = (y2 * maxScroll);
		}
		
		private function backDrag(e:GestureEvent):void{
			if(!oldDrag){
				backDragging = true;
				if(e.target == left && !tweening){
					var lastT1 = displayed1[displayed1.length - 1];
					if((lastT1.id != (half - 1)) && (displayed1[0].id != 0)){
						for each(var i in displayed1){
							i.y += e.dy;
						}
					}
					else{
						if(displayed1[0].id == 0){
							if((displayed1[0].y <= paddingH1 && (displayed1[0].y + e.dy) <= paddingH1) || e.dy < 0){
								for each(var j in displayed1){
									j.y += e.dy;
								}
							}
						}
						else{
							if(((lastT1.y + lastT1.height) >= (stage.stageHeight - paddingH1) && (lastT1.y + lastT1.height + e.dy) >= (stage.stageHeight - paddingH1)) || e.dy > 0){
								for each(var k in displayed1){
									k.y += e.dy;
								}
							}
						}
					}
					
					if((displayed1[0].y + displayed1[0].height) < -10){
						removeChild(displayed1[0]);
						displayed1.splice(0,1);
					}
					
					if(lastT1.y > (stage.stageHeight + 10)){
						removeChild(lastT1);
						displayed1.splice(displayed1.length - 1, 1);
					}
									
					if((displayed1[0].y >= 0) && (displayed1[0].id > 0)){
						addChild(list1[displayed1[0].id - 1]);
						displayed1.splice(0,0, list1[displayed1[0].id - 1]);
						updateTop1();
					}
					
					if((lastT1.y + lastT1.height) <= stage.stageHeight && (lastT1.id + 1 < half)){
						var nextBottom:ScrollerThumb = list1[lastT1.id + 1];
						addChild(nextBottom);
						displayed1.push(nextBottom);
						updateBottom(nextBottom);
					}
				}
				else if(e.target == right && !tweening){
					var lastT2 = displayed2[displayed2.length - 1];
					if((lastT2.id != (half * 2 - 1)) && (displayed2[0].id != half)){
						for each(var m in displayed2){
							m.y += e.dy;
						}
					}
					else{
						if(displayed2[0].id == half){
							if((displayed2[0].y <= paddingH1 && (displayed2[0].y + e.dy) <= paddingH1) || e.dy < 0){
								for each(var p in displayed2){
									p.y += e.dy;
								}
							}
						}
						else{
							if(((lastT2.y + lastT2.height) >= (stage.stageHeight - paddingH1) && (lastT2.y + lastT2.height + e.dy) >= (stage.stageHeight - paddingH1)) || e.dy > 0){
								for each(var n in displayed2){
									n.y += e.dy;
								}
							}
						}
					}
					
					
					if((displayed2[0].y + displayed2[0].height) < -10){
						removeChild(displayed2[0]);
						displayed2.splice(0,1);
					}
					
					if(lastT2.y > (stage.stageHeight + 10)){
						removeChild(lastT2);
						displayed2.splice(displayed2.length - 1, 1);
					}
									
					if((displayed2[0].y >= 0) && (displayed2[0].id > half)){
						addChild(list2[displayed2[0].id - 1 - half]);
						displayed2.splice(0,0, list2[displayed2[0].id - 1 - half]);
						updateTop2();
					}
					
					if((lastT2.y + lastT2.height) <= stage.stageHeight && (lastT2.id + 1 < half * 2)){
						var nextBottom2:ScrollerThumb = list2[lastT2.id + 1 - half];
						addChild(nextBottom2);
						displayed2.push(nextBottom2);
						updateBottom(nextBottom2);
					}
				}
				updateIndicators();
			}
		}
		
		private function backDown(e:TouchEvent):void{
			if(flicking){
				dy = 0;
				flicking = false;
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}
		
		private function backUp(e:TouchEvent):void{
			backDragging = false;
		}
	}
}
