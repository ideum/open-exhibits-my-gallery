package 
{	
	//Import all related libraries
	import flash.events.Event;
	import flash.display.DisplayObject;	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import gl.events.GestureEvent;
	import gl.events.TouchEvent;
	import id.core.TouchComponent;
	import id.core.TouchSprite;
	
	import caurina.transitions.Tweener;
	
	public class PersonalCollection extends TouchComponent	{
		private var collectionTitle:String;
		private var collectionAuthor:String;
		private var position:int = 0; //the position IN ARRAY at which to add next photo, always 0-9
		private var myTimer:Timer;
		
		public var collection:Array;
		private var pcSlots:Array;
		private var mcSlots:Array;
		private var bumpSwitch:Array; //Array of switches for whether a slot is being "bumped"
		private var collectionCopy:Array; //copy of array to store for resetting drag in PC editor
		private var originalPos:Array; //Array of each image's original position before drags in PC editor
		
		private var dropIn:Boolean = false;
		private var garbageCollision:Boolean = false; //testing for now
		private var bumping:Boolean = false; //switch for whether bumping is currently happening		
		private var currentPos:int; //position of thumb being dragged in PC editor
		private var setVals:Boolean = false;
		private var deleteAnimating:Boolean = false;
		public var pcGlowing:Boolean = false;
		private var deleteButtonContainer:TouchSprite;
		
		public var titleData:String = "";
		public var nameData:String = "";
		private var userTitle:TextDisplay;
		private var userName:TextDisplay;
		
		public function PersonalCollection(aCollection:Array, ttl:String="",  nm:String = "") {
			super();
			blobContainerEnabled = false;
						
			titleData = ttl;
			nameData = nm;
			
			collection = new Array();
			collectionCopy = new Array();
			pcSlots = new Array();
			mcSlots = new Array();
			bumpSwitch = new Array(); //Array of switches for whether a slot is being "bumped"
			originalPos = new Array(); //Array of 
			userName = new TextDisplay();
			userTitle = new TextDisplay();
			
			createUI();
			commitUI();
			
			//layout PC in gallery mode
			if (Main.mode == 2) {
				userTitle.styleList = {fontColor:0xFFFFFF,fontSize:20};
				userTitle.text = titleData;
				userTitle.multilined = false;
				
				userName.styleList = {fontColor:0xFFFFFF,fontSize:14};
				userName.text = nameData;
				userName.multilined = false;
				
				for (var i:int = 0; i < aCollection.length; i++) {
					var thumb:ScrollerThumb = new ScrollerThumb(true);
					thumb.id = aCollection[i];
					thumb.width = thumb.height = 120; //hard code
					collection.push(thumb);					
				}
				
				for (var r:int = 0; r < collection.length; r++ ) {
					collection[r].addEventListener(TouchEvent.TOUCH_UP, showImage, false, 0, true);
				}
				
				toPCMode();
			}
			
		}
		
		override protected function createUI():void {
			deleteButtonContainer = new  TouchSprite();
			deleteButtonContainer.addChild(deleteButton);
			deleteButton.garbage_glow.gotoAndStop(1);
			
			removeChild(editPCbg);
			pcSlots.push(pcSlot1);
			pcSlots.push(pcSlot2);
			pcSlots.push(pcSlot3);
			pcSlots.push(pcSlot4);
			pcSlots.push(pcSlot5);
			pcSlots.push(pcSlot6);
			pcSlots.push(pcSlot7);
			pcSlots.push(pcSlot8);
			pcSlots.push(pcSlot9);
			pcSlots.push(pcSlot10);
			
			mcSlots.push(slot1);
			mcSlots.push(slot2);
			mcSlots.push(slot3);
			mcSlots.push(slot4);
			mcSlots.push(slot5);
			mcSlots.push(slot6);
			mcSlots.push(slot7);
			mcSlots.push(slot8);
			mcSlots.push(slot9);
			mcSlots.push(slot10);
			
			for (var i:int = 0; i < 10; i++) {
				bumpSwitch.push(0);
			}
			
			for (var j:int = 0; j < 10; j++) {
				removeChild(pcSlots[j]);
			}
			
			deleteButtonContainer.addEventListener(TouchEvent.TOUCH_DOWN, deleteHandlerDwn, false, 0, true);
			deleteButtonContainer.addEventListener(TouchEvent.TOUCH_UP, deleteHandlerUp, false, 0, true);
		}
		
		override protected function commitUI():void {
			addChild(deleteButtonContainer);
		}
		
		override protected function layoutUI():void {
		}
		
		override public function Dispose():void {
			for (var i:int = 0; i < collection.length; i++){
				collection[i].matteOn();
				collection[i].Dispose();
				removeChild(pcSlots[i]);
			}
			
			
			for (var k:int = 0; k < 10; k++) {
				bumpSwitch[k] = null;
				pcSlots[k].dropArea = null;
				pcSlots[k] = null;
				mcSlots[k].dropArea = null;
				mcSlots[k] = null;
			}
			
			removeChild(userName);
			userName.Dispose();
			userName = null;
			
			removeChild(userTitle);
			userTitle.Dispose();
			userTitle = null;
			
			defaultBG = defaultBG = pc_dropOutArea = pc_dropArea = grbgdropArea = null;
			removeChild(editPCbg);
			editPCbg = null;
			deleteButtonContainer = null;
			deleteButton = null;
			
		}
		
		public function resetGallery():void {
			
		}
		
		private function deleteHandlerDwn(e:TouchEvent):void {
			deleteButton.gotoAndStop("pressed");
		}
		
		private function deleteHandlerUp(e:TouchEvent):void {
			deleteButton.gotoAndStop("default");
			if ( collection.length > 0 && !deleteAnimating) {				
				//guidance cues
				if (!Main.guideRemoveOn) {
					Main.guideRemoveOn = true; //performed a photo remove
					dispatchEvent(new Event("next cue", true));
				}
				//end guidance cues
				
				deleteAnimating = true;
				position--;
				Tweener.addTween(collection[position], { alpha: 0, time: 1, onComplete: removeLastPhoto } );
			}
			
		}
		
		private function removeLastPhoto():void {			
			removeChild(collection[position]);			
			collection[position].setMatteColor(0x202020); //returns matte color back to dark grey
			dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_DESTROY, collection[position].id, 640, 400));
			++Main.currentlyDisplayed;
			collection.pop();
			deleteAnimating = false;
			dispatchEvent(new Event("enable add", true));

		}
		
		/**
		 * Removes a photo at specified position
		 */
		private function removePhotoAt(targetPhoto:int, e:TouchEvent, spawn:Boolean):void {
			var stagePoint:Point = localToGlobal(new Point(e.target.x, e.target.y)); //create global point to spawn photo
			
			if (spawn){ //dropping into main area
				dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_REQUEST, e.currentTarget.id, stagePoint.x, stagePoint.y));
			}
			else //dropping into garbage can
				dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_DESTROY, e.currentTarget.id, 640, 400));
			
			collection[targetPhoto].setMatteColor(0x202020);
			collection.splice(targetPhoto, 1);
			position--;
			reorganize(targetPhoto);
			e.currentTarget.Dispose();
			dispatchEvent(new Event("enable add", true));
		}
		
		/** Visually reorganizes photo positions
		 * deletePos - the position just deleted
		 */
		private function reorganize(deletedPos:int):void {
			for (var i:int = deletedPos; i <=  collection.length - 1; i++) {
				Tweener.addTween( collection[i], { x: getPosition(i)[0], y: getPosition(i)[1], time: 1.5 } );
				collection[i].setPos(i);
			}
		}
		
		/**
		 * 
		 */
		public function addPhotoHandler(e:PhotoEvent):void {
			if( collection.length < 10 ) {
				var thumb:ScrollerThumb = new ScrollerThumb(true);
				thumb.id = e.id;
				collection.push(thumb);
				if(collection.length == 10){
					dispatchEvent(new Event("disable add", true));
				}
				displayPhoto();
			}
		}
		
		/**
		 * 
		 */
		private function displayPhoto():void {
			
			//get coords to place thumbnail
			collection[position].x = getPosition(position)[0];
			collection[position].y = getPosition(position)[1];			
			
			//add touch functionality
			collection[position].addEventListener(TouchEvent.TOUCH_DOWN, touchHandler, false, 0, true);
			collection[position].addEventListener(TouchEvent.TOUCH_UP, releaseHandler, false, 0, true);
			collection[position].addEventListener(GestureEvent.GESTURE_DRAG_N, dragHandler, false, 0, true);
			
			collection[position].setMatteColor(0x444444);
			collection[position].width = collection[position].height = 120; //setting width hardcoded 120 CHANGE LATER
			collection[position].scaleX = collection[position].scaleY = collection[position].getScale(90);
			collection[position].alpha = 0;
			
			collection[position].setPos(position);
			addChild(collection[position]);
			Tweener.addTween(collection[position], { alpha: 1, time: 1 } );
			position++;
		}		
		
		/**
		 * 
		 */
		private function touchHandler(e:TouchEvent):void {
			if(e.target.numChildren == 1) {				
				parent.setChildIndex(this as PersonalCollection, parent.numChildren - 2);
				setChildIndex(e.currentTarget as ScrollerThumb, numChildren - 1);
				
				if (Main.mode == 0) {
					Tweener.addTween(e.target, { scaleX:1.1, scaleY:1.1, alpha: 0.5, time: 0.5 } );
					e.target.startTouchDrag(0);
				} else if(Main.mode == 1) {
					trace("collection[0] width = " + collection[0].width * collection[0].scaleX);
					trace("collection[0] height = " + collection[0].height * collection[0].scaleY);

					e.currentTarget.startTouchDrag(0);
					Tweener.addTween(e.currentTarget, { scaleX:e.currentTarget.getScale(getSlotCoords(0)[2] * 1.03), scaleY:e.currentTarget.getScale(getSlotCoords(0)[2] * 1.03), alpha: 0.5, time: 0.5 } );
					
					//remove other touch handlers
					for (var i:int = 0; i < e.currentTarget.position; i++ ) {
						collection[i].removeEventListener(TouchEvent.TOUCH_DOWN, touchHandler);
						collection[i].removeEventListener(TouchEvent.TOUCH_UP, releaseHandler);
						collection[i].removeEventListener(GestureEvent.GESTURE_DRAG_N, dragHandler);
					}
					for (var j:int = e.currentTarget.position + 1; j < collection.length; j++) {
						collection[j].removeEventListener(TouchEvent.TOUCH_DOWN, touchHandler);
						collection[j].removeEventListener(TouchEvent.TOUCH_UP, releaseHandler);
						collection[j].removeEventListener(GestureEvent.GESTURE_DRAG_N, dragHandler);
					}
				}
			}
		}
		
		/**
		 * 
		 */
		private function releaseHandler(e:TouchEvent):void {			
			if (e.target.numChildren == 1) {
				parent.setChildIndex(this as PersonalCollection, 1); //USEFUL
				
				if (Main.mode == 0) { //if in MC mode
					var stagePoint:Point = localToGlobal(new Point(e.target.x, e.target.y));
					garbageCollision = false;
					deleteButton.garbage_glow.gotoAndStop(1);
					
					//Different method for dragging and dropping
					if (e.target.hitTestObject(scroller_hitArea)) { //drop into scroller
						//guidance cues
						if (!Main.guideRemoveOn) {
							Main.guideRemoveOn = true; //performed a photo remove
							dispatchEvent(new Event("next cue", true));							
						}
						//end guidance cues
						
						removePhotoAt(e.currentTarget.getPos(), e, false);
					} else if (e.target.hitTestObject(grbgdropArea)) { //drop into garbage
						//guidance cues
						if (!Main.guideRemoveOn) {
							Main.guideRemoveOn = true; //performed a photo remove
							dispatchEvent(new Event("next cue", true));
						}
						//end guidance cues
						
						Tweener.addTween(e.target, { alpha: 0, x: 106, y: 555, scaleX: 0, scaleY: 0, time: 1.5, onComplete: removePhotoAt(e.currentTarget.getPos(), e, false) } );
					} else if (e.target.hitTestObject(pc_dropOutArea)) { //drop back in gallery
						e.target.stopTouchDrag(0);
						Tweener.addTween(e.target, { x: e.currentTarget.getCtnrX(), y: e.currentTarget.getCtnrY(), scaleX:1, scaleY:1, alpha: 1, transition: "eastOutSine", time: 0.5 } );
					} else { //drop into workspace
						//guidance cues
						if (!Main.guideRemoveOn) {
							Main.guideRemoveOn = true; //performed a photo remove
							dispatchEvent(new Event("next cue", true));
						}
						//end guidance cues
						
						if(Main.currentlyDisplayed < 10){
							Tweener.addTween(e.currentTarget, { alpha: 0, time: 1 } ); //fade out entire thumbnail
							Tweener.addTween(e.target, { scaleX: 0.95, scaleY: 0.95, time: 1, onComplete: removePhotoAt(e.currentTarget.getPos(), e, true) } ); //scale out the image thumbnail
						}
						else{
							Tweener.addTween(e.target, { x: e.currentTarget.getCtnrX(), y: e.currentTarget.getCtnrY(), scaleX:1, scaleY:1, alpha: 1, transition: "eastOutSine", time: 0.5 } );
						}
					}
					
				} else if (Main.mode == 1) { //if in PC mode
					setVals = false;
					originalPos.splice(0, originalPos.length); //clear out array
					collectionCopy.splice(0, collectionCopy.length);
					bumping = false;
					
					e.currentTarget.stopTouchDrag(0);					
					
					//animate thumbnail into place
					for (var slotnum:int = 0; slotnum < collection.length; slotnum++) {
						if (e.target.hitTestObject(pcSlots[slotnum].dropArea)) { //if dropping into slot drop area
							Tweener.addTween(e.currentTarget, { x: getSlotCoords(slotnum)[0], y: getSlotCoords(slotnum)[1], scaleX:e.currentTarget.getScale(getSlotCoords(0)[2]), scaleY:e.currentTarget.getScale(getSlotCoords(0)[2]), alpha: 1, time: 0.5} );
						} else {
							Tweener.addTween(e.currentTarget, { x: getSlotCoords(e.currentTarget.position)[0], y: getSlotCoords(e.currentTarget.position)[1], scaleX:e.currentTarget.getScale(getSlotCoords(0)[2]), scaleY:e.currentTarget.getScale(getSlotCoords(0)[2]), alpha: 1, transition: "eastOutSine", time: 0.5 } );
						}
					}
					
					//re-add other touch handlers
					for (var i:int = 0; i < e.currentTarget.position; i++ ) {
						collection[i].addEventListener(TouchEvent.TOUCH_DOWN, touchHandler, false, 0, true);
						collection[i].addEventListener(TouchEvent.TOUCH_UP, releaseHandler, false, 0, true);
						collection[i].addEventListener(GestureEvent.GESTURE_DRAG_N, dragHandler, false, 0, true);
					}
					for (var j:int = e.currentTarget.position + 1; j < collection.length; j++) {
						collection[j].addEventListener(TouchEvent.TOUCH_DOWN, touchHandler, false, 0, true);
						collection[j].addEventListener(TouchEvent.TOUCH_UP, releaseHandler, false, 0, true);
						collection[j].addEventListener(GestureEvent.GESTURE_DRAG_N, dragHandler, false, 0, true);
					}
					
				}
			}
		}
		
		
		/**
		 * 
		 */
		private function dragHandler(e:GestureEvent):void {
			if ( Main.mode == 0) {
				if (e.currentTarget.thumbnail.hitTestObject(grbgdropArea)) {
					if (!garbageCollision) {
						deleteButton.garbage_glow.gotoAndPlay("glow");
						trace("garbage collide!");
						garbageCollision = true;
					}
				} else { 
					if (garbageCollision) {
						garbageCollision = false;
						deleteButton.garbage_glow.gotoAndStop(1);
						trace("garbage uncollide!");
					}
					garbageCollision = false;
				}
				
			} else if (Main.mode == 1) {
				bumping = false;				
				
				if (!setVals) {
					currentPos = e.currentTarget.position; //set position of current thumb being dragged
					collectionCopy = collection.concat(); //restoring to original setup
					for (var r:int = 0; r < collection.length; r++) {
						originalPos.push(collection[r].position); //get position of 
					}
					setVals = true;
				}
				
				for (var i:int = 0; i < collection.length; i++) { //i = this drop area
					if (e.target.hitTestObject(pcSlots[i].dropArea)) { //if collide with this slot drop area					
						if (bumpSwitch[i] != 1) {
							
							bumpSwitch[i] = 1;
							
							if (e.currentTarget.position > collection[i].position) { //if target's position is larger than slot							
								for (var j:int = e.currentTarget.position - 1; j >= i; j--) {
									Tweener.addTween(collection[j], { x:getSlotCoords(j + 1)[0], y: getSlotCoords(j + 1)[1], time: 0.8 } );
									collection[j].position = j + 1; //change positions
									collection[j + 1] = collection[j]; //replace thumbnail into new location
								}
							} else if (e.currentTarget.position < collection[i].position) { //else if target's position is smaller than slot
								for (var k:int = e.currentTarget.position + 1; k <= i; k++ ) {
									Tweener.addTween(collection[k], { x:getSlotCoords(k - 1)[0], y: getSlotCoords(k - 1)[1], time: 0.8 } );
									collection[k].position = k - 1; //change positions
									collection[k - 1] = collection[k]; //replace thumbnail into new location
								}
							}
							
							e.currentTarget.position = i;
							collection[i] = e.currentTarget;
						}
					} else { 
						if (bumpSwitch[i] != 0) { //if not collide with this drop area
							bumpSwitch[i] = 0;
							
							//check if any bumping is occuring
							for (var a:int = 0; a < i; a++)
								if (bumpSwitch[a] == 1)
									bumping = true;
							for (var b:int = i + 1; b < 10; b++ )
								if (bumpSwitch[b] == 1)
									bumping = true;
							
							
							if (!bumping) { //if no other bumping is occuring, then restore to original position
								//restore to original array
								collection = collectionCopy.concat();
								for (var h:int = 0; h < collection.length; h++)
									collection[h].position = originalPos[h];
								
								//tween to original positions
								for (var w:int = 0; w < currentPos; w++)
									Tweener.addTween(collection[w], { x:getSlotCoords(w)[0], y: getSlotCoords(w)[1], time: 0.8} );
								for (var q:int = currentPos + 1; q < collection.length; q++ )
									Tweener.addTween(collection[q], { x:getSlotCoords(q)[0], y: getSlotCoords(q)[1], time: 0.8} );
							}
						}						
					}
				}
				
			}
		}
		
		private function showImage(e:TouchEvent):void {
			dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_REQUEST, e.currentTarget.id, 640, 400, true));
			e.currentTarget.visible = false;
		}
		
		private function bumpReorg(target:int, thumbnail:int):void {
			trace("thumb at slot " + thumbnail + ", drop into slot " + target);			
		}
		
		/**
		 * Trasitions to Personal Collection mode
		 */
		public function startToPC():void {
			Tweener.addTween(this, {alpha: 0, time: 1, onComplete: toPCMode} );
			Tweener.addTween(this, { alpha: 1, time: 1, delay: 2.2 } );
		}
		
		/**
		 * Transitions to Museum Collection mode
		 */
		public function startToMC():void {
			Tweener.addTween(this, { alpha: 0, time: 1, onComplete: toMCMode} );
			Tweener.addTween(this, { alpha: 1, time: 1, delay: 2.2 } );
		}
		
		/**
		 * Turns off the visibility (therefore interactivity) of PC mode components
		 */
		private function toMCMode():void {
			//turn off personal collection components
			removeChild(editPCbg);
			for (var j:int = 0; j < 10; j++) {
				pcSlots[j].y = -2000; //move all MG slots off the stage, note: quick fix
				
			}
			
			x = 986;
			y = 80;
			
			//turn on mc collection components
			addChild(defaultBG);
			addChild(deleteButtonContainer);
			setChildIndex(deleteButtonContainer, numChildren - 1);
			
			//put museum collection slots back
			for (var k:int = 0; k < 10; k++)
				addChild(mcSlots[k]);
			
			for (var i:int = 0; i < collection.length; i++) {
				collection[i].x = getPosition(i)[0];
				collection[i].y = getPosition(i)[1];
				collection[i].scaleX = collection[i].scaleY = collection[i].getScale(90);
				collection[i].matteOn();
				setChildIndex(collection[i], numChildren - 1);
			}
			
			parent.setChildIndex(this as PersonalCollection, 1);
		}
		
		/**
		 * Turns off the visbility (therefore interactivity) of MC mode components
		 */
		private function toPCMode():void {
			//turn off museum collection components
			removeChild(deleteButtonContainer);
			removeChild(defaultBG);
			for (var q:int = 0; q < 10; q++)
				removeChild(mcSlots[q]);
			
			x = 115;
			y = 90;	
			addChildAt(editPCbg, 0);
			
			//reposition slots
			for (var i:int = 0; i < collection.length; i++) {
				addChild(pcSlots[i]);
				pcSlots[i].visible = true;
				pcSlots[i].x = getSlotCoords(i)[0];
				pcSlots[i].y = getSlotCoords(i)[1];
				pcSlots[i].width = getSlotCoords(i)[2];
				pcSlots[i].height = getSlotCoords(i)[2];
			}
			
			//turn off unused slots
			for (var j:int = collection.length; j < 10; j++) {
				pcSlots[j].visible = false;
				pcSlots[j].y = -3000;
			}
			
			if (collection.length == 10 || collection.length == 9) {
				editPCbg.width = 1050;
				editPCbg.height = 410;
				
			} else if (collection.length == 8 || collection.length == 7) {
				x = 230;
				y = 90;
				
				editPCbg.width = 820;
				editPCbg.height = 410;
			} else if (collection.length == 6 || collection.length == 5) {
				x = 332.5
				y = 90;
				
				editPCbg.width = 615;
				editPCbg.height = 410;
			} else if (collection.length == 4) {
				x = 65;
				y = 140;
				
				editPCbg.width = 1150;
				editPCbg.height = 310;
			} else if (collection.length == 3) {
				x = 130;
				y = 125;
				
				editPCbg.width = 1020;
				editPCbg.height = 360;
			} else if (collection.length == 2) {
				x = 235;
				y = 100;
				
				editPCbg.width = 810;
				editPCbg.height = 410;
			}
			
			if(Main.mode == 2){
				x = 640 - editPCbg.width/2;
				y = 375 - editPCbg.height/2;
				
				addChild(userName);
				addChild(userTitle);
				
				var padding:int = 20;
				userName.x = editPCbg.width/2 - userName.width/2;
				userName.y = editPCbg.y - userName.height - padding;
				
				userTitle.x = editPCbg.width/2 - userTitle.width/2;
				userTitle.y = userName.y - userTitle.height;
				
			}
			
			//place thumbnails in position
			for (var k:int = 0; k < collection.length; k++) { //get rid of thumbnails, CHANGE LATER???
				collection[k].x = getSlotCoords(k)[0];
				collection[k].y = getSlotCoords(k)[1];
				collection[k].scaleX = collection[k].scaleY = collection[k].getScale(getSlotCoords(k)[2]);
				collection[k].matteOff();
				addChild(collection[k]);
			}
		}
		
		/**
		 * Returns the visual coordinates of input index (idx) based on number of images in collection
		 * @param	idx - index number of the slot to get the coordinates of, following Array index numbering
		 * @return	an array with the x and y coordinates and the picture size respectively
		 */
		private function getSlotCoords(idx:int):Array {
			var hMargin:int = 30; //margins between images horizontally
			var y:int = 30;
			var x:int = 30; //x-coord to return. NOTE: pre-for-loop, it will equal position of first image in the row
			var picSize:int = 0;
			
			if (collection.length == 10 || collection.length == 9) { //10 or 9
				hMargin = 60;
				picSize = 150;
				
				if (idx > 4) { //if 2nd row
					y = 230; //else: y is initialized to 30
					
					if (collection.length == 9) //if 9 images AND 2nd row
						x += (picSize + (hMargin / 2) ) - (picSize / 2); //add padding for coord of 1st image of 2nd row
						idx -= 5;
				}				
			} else if (collection.length == 8 || collection.length == 7) { //8 or 7
				hMargin = 40;
				picSize = 160;
				
				if (idx > 3) { //if 2nd row
					y = 220; //else: y is initialized to 30
					
					if (collection.length == 7) //if 7 images AND 2nd row
						x += (picSize + (hMargin / 2) ) - (picSize / 2); //add padding for coord of 1st image of 2nd row
						idx -= 4;
				}			
			} else if (collection.length == 6 || collection.length == 5) { //6 or 5
				hMargin = 30;
				picSize = 165;
				
				if (idx > 2) { //if 2nd row
					y = 215; //else: y is initialized to 30
					
					if (collection.length == 5) //if 5 images AND 2nd row
						x += (picSize + (hMargin / 2) ) - (picSize / 2); //add padding for coord of 1st image of 2nd row
						idx -= 3; //reset positioning for new row
				}
				
			} else if (collection.length == 4) { //4
				hMargin = 30;
				picSize = 250;
				
			} else if (collection.length == 3) { //3
				hMargin = 30;
				picSize = 300;
				
			} else if (collection.length == 2) { //2
				hMargin = 50;
				picSize = 350;
			}
			
			//calculate x
			x += (picSize * idx) + (hMargin * idx);
			
			return new Array(x, y, picSize);
		}
		 
		/**
		 * 
		 * @param	number
		 * @return
		 */
		public function reset():void {
			
			//fade out PC slots, because reset changes collection size, so messes up toMCMode. NOTE: quick fix
			if (Main.mode == 1) {
				for (var k:int = 0; k < collection.length; k++) {
					removeChild(pcSlots[k]);
				}
			}
			
			//puts photos back into scroller
			for (var i:int = collection.length - 1; i >= 0; i--) {
				dispatchEvent(new PhotoEvent(PhotoEvent.PHOTO_DESTROY, collection[i].id, 640, 400));
				collection[i].Dispose();
				collection.pop();
			}
			
			for (var j:int = 0; j < collectionCopy.length; j++) {
				collectionCopy[j].Dispose();
				collection.pop();
			}
			
			for (var h:int = 0; h < originalPos.length; h++) {
				originalPos.pop();
			}
			
			
			
			collectionTitle = '';
			collectionAuthor = '';
			
			dropIn = false;
			garbageCollision = false;
			bumping = false;
			setVals = false;
			deleteAnimating = false;
			pcGlowing = false;
			position = 0;
			
		}
		 
		/**
		 * Returns an array of the x and y coordinates of the thumbnail slots in MC mode
		 * 
		 */
		private function getPosition(number:int) : Array {
			var coords:Array = new Array();
			switch(number) {
				case 0: 
					coords.push(slot1.x);
					coords.push(slot1.y);
					break;
				case 1: 
					coords.push(slot2.x);
					coords.push(slot2.y);
					break;
				case 2: 
					coords.push(slot3.x);
					coords.push(slot3.y);
					break;
				case 3: 
					coords.push(slot4.x);
					coords.push(slot4.y);
					break;
				case 4: 
					coords.push(slot5.x);
					coords.push(slot5.y);
					break;
				case 5: 
					coords.push(slot6.x);
					coords.push(slot6.y);
					break;
				case 6: 
					coords.push(slot7.x);
					coords.push(slot7.y);
					break;
				case 7: 
					coords.push(slot8.x);
					coords.push(slot8.y);
					break;
				case 8: 
					coords.push(slot9.x);
					coords.push(slot9.y);
					break;
				case 9: 
					coords.push(slot10.x);
					coords.push(slot10.y);
					break;
			}
			
			return coords;
			
		}
		
		/**
		 * 
		 */
		public function setTitle(title:String):void {
			collectionTitle = title;
		}
		
		/**
		 * 
		 */
		public function setAuthor(name:String):void {
			collectionAuthor = name;
		}
		
		/**
		 * 
		 */
		public function getTitle():String {
			return collectionTitle;
		}
		
		/**
		 * 
		 */
		public function getAuthor():String {
			return collectionAuthor;
		}		
		
		/**
		 * 
		 */
		public function getCollection():Array {
			var array:Array = new Array();
			for each(var i:ScrollerThumb in collection){
				array.push(i.id);
			}
			return array;
		}
		
		private function clearCollection() : void {
			
		}
		
		public function displayImage(iD:int):void{
			for each(var i:ScrollerThumb in collection){
				if(i.id == iD){
					i.alpha = 0;
					i.visible = true;
					Tweener.addTween(i, {alpha: 1, time: .9});
					break;
				}
			}
		}
		
	}
	
}