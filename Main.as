package{
	import adobe.utils.ProductManager;
	import flash.display.Shader;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import id.core.Application;
	import flash.net.URLRequest;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.Stage;
	import flash.utils.Timer;
	import id.core.ApplicationGlobals;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import id.core.TouchSprite;
	import gl.events.TouchEvent;
	
	import caurina.transitions.Tweener;
	
	public class Main extends Application {
		private var images:ImageScroll;
		private var clearButton:TouchSprite;
		private var toPersCollCtnr:TouchSprite;
		private var toMuseCollCtnr:TouchSprite;
		private var toMuseColl2Ctnr:TouchSprite;
		private var toOthrCollCtnr:TouchSprite;
		public static var blockerContainer:TouchSprite;
		private var keyboardContainer:TouchSprite;
		private var aboutTabCtnr:TouchSprite;		
		private var submitBtn:TouchSprite;
		private var okBtn:TouchSprite;
		private var okSentBtn:TouchSprite;
		private var switchLangCtnr:TouchSprite;
		private var beginCtnr:TouchSprite;
		private var welcomeLangCtnr:TouchSprite;
		public var shaderCtnr:TouchSprite;
		private var exitKeyboardCtnr:TouchSprite; //invisible click area to trigger keyboard exit
		private var startOverContainer:TouchSprite;
		private var yesBtn:TouchSprite;
		private var cancelBtn:TouchSprite;
		
		private var softKeyboard:KeyboardController;
		private var pCollection:PersonalCollectionSaver;		
		public static var cViewer:CollectionViewer;
		public static var exitKeyboard:ExitKeyboard; //hit area outside of keyboard to retract keyboard
		public static var personalCollection:PersonalCollection;
		public var shader:Shade;
		public var blocker:Blocker; //used to block touch input during transitions
		
		public static var mode:int = 0; //0: museum collection, 1: personal collection, 2: others' collections
		public static var sgMode:int = 0; //saved gallery mode. 0: viewing list, 1:viewing specific gallery
		public static var currentlyDisplayed = 0;		
		private var aboutLang:int = 0; //Language of about tab. 0 = English; 1 = Japanese
		private var aboutOn:Boolean = false;
		private var keyboardOn:Boolean = false;
		public var round:int = 1; //keeps count of which running through entire sequence since beginning
		
		private var idleCountdown:Timer; //countdown for resetting
		public var nextGuidance:Timer; //countdown for next guidance cue
		private var reminder:Timer; //remind user next step
		private var curationTime:Timer; //length of time user took to submit a gallery
		
		//guidance message switches. Turned on when previous gesture performed and timer reached. Turned off when gesture performed.
		public static var guideStep:int = 0; //step that user is in for guidance cues
		public static var guideScrollOn:Boolean = false;
		public static var guideDragOn:Boolean = false;
		public static var guideResizeOn:Boolean = false;
		public static var guideMGOn:Boolean = false;
		public static var guideRemoveOn:Boolean = false;
		public static var guideEditGalOn:Boolean = false;
		public static var guideMinOn:Boolean = false;
		public static var guideReorgOn:Boolean = false;
		public static var guideTitNamOn:Boolean = false;
		public static var guideViewGalOn:Boolean = false;
		public static var guideIntThumbOn:Boolean = false;
		public static var guideTWOn:Boolean = false;
		
		public function Main() {       
            settingsPath = "application.xml";
        }
		
		override protected function initialize():void {
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.displayState=StageDisplayState.FULL_SCREEN;
			stage.align = StageAlign.TOP_LEFT;
			
			addEventListener(LogoEvent.LOGO_LOADED, welcome);
			addEventListener(PhotoEvent.PHOTO_REQUEST, insertPhoto);
			addEventListener(PhotoEvent.PHOTO_DESTROY, destroyPhoto);
			addEventListener(PhotoEvent.PHOTO_ADD, addPhoto);
			
			addEventListener("keyboard transition", inputEntrance);
			addEventListener("disable add", disableAdd);
			addEventListener("enable add", enableAdd);
			addEventListener("next cue", setupNextCue);
			addEventListener("send to TW", sendToTW);
			addEventListener(TouchEvent.TOUCH_DOWN, anyTouch);
			
			idleCountdown = new Timer(180000, 1); //3 minutes for auto reset
			idleCountdown.addEventListener(TimerEvent.TIMER, promptStartOver); //
			nextGuidance = new Timer(5000, 1); //varies with steps
			nextGuidance.addEventListener(TimerEvent.TIMER, showNextCue);
			reminder = new Timer(20000, 1); //remind user of next step after 20 sec of idle
			reminder.addEventListener(TimerEvent.TIMER, remind);
			
			btnWelcomeLang.x = 895;
			btnWelcomeLang.y = 254.7;
			welcomeLangCtnr = new TouchSprite();
			welcomeLangCtnr.addChild(btnWelcomeLang);
			welcomeLangCtnr.addEventListener(TouchEvent.TOUCH_DOWN, welcomeLangDown);
			welcomeLangCtnr.addEventListener(TouchEvent.TOUCH_UP, welcomeLangUp);
			welcomeLangCtnr.alpha = 0;
			
			btnBegin.x = 640;
			btnBegin.y = 628.2;
			beginCtnr = new TouchSprite();
			beginCtnr.addChild(btnBegin);
			beginCtnr.addEventListener(TouchEvent.TOUCH_DOWN, beginDown);
			beginCtnr.addEventListener(TouchEvent.TOUCH_UP, beginUp);
			beginCtnr.alpha = 0;
			
			//blocker
			blocker = new Blocker();
			blockerContainer = new TouchSprite();
			blockerContainer.addChild(blocker);
		}
		
		private function welcome(e:LogoEvent):void {			
			//prep all guidance bubbles to be faded in
			removeChild(introAni);
			welcomeScreen.gotoAndPlay(1);			
			guide_scroll.alpha = guide_drag.alpha = guide_resize.alpha = guide_mg.alpha = guide_remove.alpha = guide_editgal.alpha = guide_minimum.alpha = guide_reorg.alpha = guide_titlename.alpha = guide_submitfail.alpha = guide_viewgal.alpha = guide_interactthumb.alpha = guide_tilewall.alpha = 0;
			
			welcomeLangCtnr.alpha = 0;
			addChild(welcomeLangCtnr);
			Tweener.addTween(welcomeLangCtnr, { delay: 1.33, alpha: 1, time: 1 } );
			
			beginCtnr.alpha = 0;
			addChild(beginCtnr);
			Tweener.addTween(beginCtnr, { delay: 1.33, alpha: 1, time: 1 } );
			
			//fade in connections text
			connections.alpha = 0;
			addChild(connections);			
			Tweener.addTween(connections, { delay: 1.33, alpha: 1, time: 1 } );
			
			addChild(blockerContainer);
			
			Tweener.addTween(blockerContainer, { delay: 2.3, onComplete: blockerOff } );
			
			//setup for entrance animation
			clearBtn.y = -16;
			btnStartOver.y = -16;
			to_perscoll.x = 1305;
			to_others.y = 820;
			thumbnail_bar.x = -300;
			aboutTab.y = -58;
		}
		
		private function loadUI():void{			
			//timer
			idleCountdown.start();
			
			//clear workspace button
			clearButton = new TouchSprite();
			clearButton.addChild(clearBtn);
			clearButton.addEventListener(TouchEvent.TOUCH_UP, clearWorkspace);
			clearButton.addEventListener(TouchEvent.TOUCH_DOWN, clearTouchDown);
			addChild(clearButton);
			
			//start over button
			startOverContainer = new TouchSprite();
			startOverContainer.addChild(btnStartOver);
			startOverContainer.addEventListener(TouchEvent.TOUCH_DOWN, startOvrDwn);
			startOverContainer.addEventListener(TouchEvent.TOUCH_UP, startOvrUp);
			addChild(startOverContainer);
			
			//to personal collection button
			toPersCollCtnr = new TouchSprite();
			toPersCollCtnr.addChild(to_perscoll);
			addChild(toPersCollCtnr);
			toPersCollCtnr.addEventListener(TouchEvent.TOUCH_DOWN, toPCHandlerDwn);
			toPersCollCtnr.addEventListener(TouchEvent.TOUCH_UP, toPCHandlerUp);
			
			//return to museum collection button
			toMuseCollCtnr = new TouchSprite();
			toMuseCollCtnr.addChild(to_musecoll);
			addChild(toMuseCollCtnr);
			toMuseCollCtnr.addEventListener(TouchEvent.TOUCH_DOWN, toMCHandlerDwn);
			toMuseCollCtnr.addEventListener(TouchEvent.TOUCH_UP, toMCHandlerUp);
			
			//2nd return to museum collection button
			toMuseColl2Ctnr = new TouchSprite();
			toMuseColl2Ctnr.addChild(to_musecoll2);
			addChild(toMuseColl2Ctnr);
			toMuseColl2Ctnr.addEventListener(TouchEvent.TOUCH_DOWN, toMC2HandlerDwn);
			toMuseColl2Ctnr.addEventListener(TouchEvent.TOUCH_UP, toMC2HandlerUp);
			
			//to others' collection button
			toOthrCollCtnr = new TouchSprite();
			toOthrCollCtnr.addChild(to_others);
			addChild(toOthrCollCtnr);
			toOthrCollCtnr.addEventListener(TouchEvent.TOUCH_DOWN, toOCHandlerDwn);
			toOthrCollCtnr.addEventListener(TouchEvent.TOUCH_UP, toOCHandlerUp);
			
			//exit keyboard hit area
			exitKeyboard = new ExitKeyboard();
			exitKeyboardCtnr = new TouchSprite();
			exitKeyboardCtnr.addEventListener(TouchEvent.TOUCH_UP, extKeyboard);
			exitKeyboardCtnr.addChild(exitKeyboard);
			
			//shader
			shader = new Shade();
			shaderCtnr = new TouchSprite();
			shaderCtnr.addChild(shader);
			shaderCtnr.alpha = 0;
			shaderCtnr.x = shaderCtnr.y = 0;
			
			//submit butoon
			submitBtn = new TouchSprite();
			submitBtn.addChild(btnSubmit);
			submitBtn.addEventListener(TouchEvent.TOUCH_DOWN, submitDown);
			submitBtn.addEventListener(TouchEvent.TOUCH_UP, submitUp);
			addChild(submitBtn);
			
			//ok button
			okBtn = new TouchSprite();
			okBtn.addChild(btnOK);
			okBtn.addEventListener(TouchEvent.TOUCH_DOWN, okDown);
			okBtn.addEventListener(TouchEvent.TOUCH_UP, okUp);
			addChild(okBtn);
			
			//ok TW sent button
			okSentBtn = new TouchSprite();
			okSentBtn.addChild(okTWsent);
			okSentBtn.addEventListener(TouchEvent.TOUCH_DOWN, okSentDown);
			okSentBtn.addEventListener(TouchEvent.TOUCH_UP, okSentUp);
			addChild(okSentBtn);
			
			//yes button
			yesBtn = new TouchSprite();
			yesBtn.addChild(btnYes);
			yesBtn.addEventListener(TouchEvent.TOUCH_DOWN, yesDwn);
			yesBtn.addEventListener(TouchEvent.TOUCH_UP, yesUp);
			addChild(yesBtn);
			
			//cancel button
			cancelBtn = new TouchSprite();
			cancelBtn.addChild(btnCancel);
			cancelBtn.addEventListener(TouchEvent.TOUCH_DOWN, cancelDwn);
			cancelBtn.addEventListener(TouchEvent.TOUCH_UP, cancelUp);
			addChild(cancelBtn);
			
			//about tab
			aboutTabCtnr = new TouchSprite();
			aboutTabCtnr.addChild(aboutTab);
			aboutTabCtnr.addEventListener(TouchEvent.TOUCH_DOWN, aboutDown);
			aboutTabCtnr.addEventListener(TouchEvent.TOUCH_UP, aboutUp);
			addChild(aboutTabCtnr);
			
			//switch language button
			switchLangCtnr = new TouchSprite();
			switchLangCtnr.addChild(switchLang);
			switchLangCtnr.addEventListener(TouchEvent.TOUCH_DOWN, switchLangDown);
			switchLangCtnr.addEventListener(TouchEvent.TOUCH_UP, switchLangUp);
			addChild(switchLangCtnr);
			
			images = new ImageScroll(thumbnail_bar.width);
			addChild(images);
			
			personalCollection = new PersonalCollection([]);
			personalCollection.y = 80;
			addChildAt(personalCollection, 0); //DO NOT use stage.addChild(), will not work
			
			pCollection = new PersonalCollectionSaver();			
			loadKeyboard();			
			
			thumbnail_bar.height = 800;
			thumbnail_bar.y = 0;
			
			setChildIndex(blockerContainer, numChildren - 1);
			
			//setup for entrance animation
			images.x = -300;
			personalCollection.x = 1290;
		}		
		
		/**
		 * Fancy little entrance sequence for MOPA Collection interface on begin
		 * 
		 * @param	e
		 */
		private function interfaceEntrance():void {
			Tweener.addTween(thumbnail_bar, { x: 0, delay: 2, time: 2 } );
			Tweener.addTween(images, { x: 0, delay: 2, time: 2 } );
			Tweener.addTween(personalCollection, { x: 986, delay: 2, time: 2 } );
			Tweener.addTween(clearBtn, { y: 40.5, delay: 3, time: 1 } );
			Tweener.addTween(btnStartOver, { y: 40.5, delay: 3, time: 1 } ); 
			Tweener.addTween(to_perscoll, { x: 1241.85, delay: 3, time: 1 } );
			Tweener.addTween(to_others, { y: 751.25, delay: 3, time: 1 } ); //Adjust to 710 for testing in Flash, usually 751.25
			Tweener.addTween(aboutTab, { y: 0, delay: 3, time: 1 } );
			dispatchEvent(new Event("next cue", true));
		}
		
		/**
		 * Resets the Exhibit Viewer back to default, clears collection and text fields.  Handles all programmatic resets.
		 * 
		 * @param	e
		 */
		private function returnToMOPA():void { //BLARGH
			mode = 0;
			exitKeyboardCtnr.y = -2000;
			sendAnimation.gotoAndStop(1);
			softKeyboard.clearText();
			personalCollection.reset();
		}
		
		/**
		 * Places all interface elements back to initial state interface from logo animation sequence, and resets variables for new session
		 * 
		 * @param	e
		 */
		private function resetInterface():void{
			//reposition for entrance animation
			btnStartOver.y = -16;
			clearBtn.y = -16;
			to_perscoll.x = 1305;
			to_others.y = 820;
			thumbnail_bar.x = -300;
			aboutTab.y = -58;
			images.x = -300;
			personalCollection.x = 1290;
			
			softKeyboard.x = 1425.35;
			softKeyboard.y = 527.45;
			
			btnSubmit.x = 1429.1;
			btnSubmit.y = 686.05;
			
			guideScrollOn = false;
			guideDragOn = false;
			guideResizeOn = false;
			guideMGOn = false;
			guideRemoveOn = false;
			guideEditGalOn = false;
			guideMinOn = false;
			guideReorgOn = false;
			guideTitNamOn = false;
			guideViewGalOn = false;
			guideIntThumbOn = false;
			guideTWOn = false;
			
			mode = 0;
			exitKeyboardCtnr.y = -2000;
			sendAnimation.gotoAndStop(1);
			softKeyboard.clearText();
			personalCollection.reset();
			
			sgMode = 0;
			currentlyDisplayed = 0;
			
			aboutLang = 0;
			switchLang.gotoAndStop("toJpn");
			aboutTab.gotoAndStop("english");
			btnWelcomeLang.gotoAndStop("toJpn");
			connections.gotoAndStop("english");
		}
		
		/**
		 * Remind user what to do next
		 * 
		 * @param	e
		 */
		private function remind(e:Event):void {
			if (mode == 0) {
				if (guideScrollOn && guide_drag.alpha == 0 && !guideDragOn) { //auto prompt drag
					Tweener.addTween(guide_drag, { alpha:1, time: 0.8, onComplete: function() { guide_drag.gotoAndPlay("animate"); } } );
				} else if (guideDragOn && !guideMGOn && guide_mg.alpha == 0) { //auto prompt My Gallery drop
					Tweener.addTween(guide_mg, { alpha:1, time: 0.8 } );
				} else if (guideDragOn && guideMGOn && guide_editgal.alpha == 0) { //auto prompt Edit Gallery
					Tweener.addTween(guide_editgal, { alpha:1, time: 0.8 } );
				}
			} if (mode == 1) {
				if (!guideTitNamOn) {
					Tweener.addTween(guide_titlename, { alpha:1, time: 0.8 } );
				}
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function insertPhoto(e:PhotoEvent):void{
			if(currentlyDisplayed < 10){
				var photo:PhotoDisplay = new PhotoDisplay(e.id, e.x, e.y, thumbnail_bar.width, personalCollection);
				if(e.other){
					photo.convert();
					--currentlyDisplayed;
				}
				addChildAt(photo, numChildren - 2);
				++currentlyDisplayed;
			}
		}
		
		/**
		 * Tells user they only have 10 seconds left
		 * 
		 * @param	e
		 */
		private function promptStartOver(e:TimerEvent):void{
		}		
		
		private function clearWorkspace(e:TouchEvent):void{
			clearBtn.gotoAndStop(1);
			var destroyList:Array = new Array();
			for(var i:uint = 0; i < numChildren; ++i){
				var p:Object = getChildAt(i);
				if(p is PhotoDisplay){
					destroyList.push(p);
				}
			}
			for(var j:uint = 0; j < destroyList.length; ++j){
				destroyList[j].fadeOut();
				destroyList[j] = null;
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function setupNextCue(e:Event):void {
			if (mode == 0) {
				if (!guideScrollOn) {
					nextGuidance.delay = 3000;
					nextGuidance.reset();
					nextGuidance.start();
				} else if (guideScrollOn && !guideDragOn) { //completed scroll, haven't dragged
					Tweener.addTween(guide_scroll, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guide_scroll.gotoAndStop(1); }  } );
					nextGuidance.delay = 5000;
					nextGuidance.reset();
					nextGuidance.start();
				} else if (guideDragOn && !guideResizeOn) { //dragged, haven't resized
					Tweener.addTween(guide_drag, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guide_drag.gotoAndStop(1); }  } );
					nextGuidance.delay = 5000;
					nextGuidance.reset();
					nextGuidance.start();
				} else if (guideResizeOn && !guideMGOn) { //resized, haven't dropped into MG
					Tweener.addTween(guide_resize, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guide_resize.gotoAndStop(1); }  } );
					nextGuidance.delay = 7000;
					nextGuidance.reset();
					nextGuidance.start();
				} else if (!guideResizeOn && guideMGOn) { //dropped into MG, but havent' resized
					Tweener.addTween(guide_drag, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guide_drag.gotoAndStop(1); }  } );
					nextGuidance.delay = 5000;
					nextGuidance.reset();
					nextGuidance.start();
				} else if (!guideRemoveOn && guideMGOn) { //dropped into MG, but haven't removed
					Tweener.addTween(guide_mg, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guide_mg.gotoAndStop(1); }  } );
					nextGuidance.delay = 5000;
					nextGuidance.reset();
					nextGuidance.start();
				} else if (guideRemoveOn && !guideEditGalOn) { //remove shown, but haven't show edit MG
					Tweener.addTween(guide_remove, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guide_remove.gotoAndStop(1); }  } );
					nextGuidance.delay = 10000;
					nextGuidance.reset();
					nextGuidance.start();
				}
			} 
			if (mode == 1) {
				if (guideReorgOn && !guideTitNamOn) {
					nextGuidance.delay = 10000;
					nextGuidance.reset();
					nextGuidance.start();
				}
			}
			if (mode == 2) {
				if (sgMode == 0) {
					nextGuidance.delay = 2000;
					nextGuidance.reset();
					nextGuidance.start();
				}
				
				if (sgMode == 1) {
					if (!guideIntThumbOn) {
						nextGuidance.delay = 2000;
						nextGuidance.reset();
						nextGuidance.start();
					} else if (!guideTWOn) {
						nextGuidance.delay = 5000;
						nextGuidance.reset();
						nextGuidance.start();
					}
				}
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function showNextCue(e:TimerEvent):void {
			if(mode == 0) {
				if (!guideScrollOn) {
					Tweener.addTween(guide_scroll, { alpha:1, time: 0.8, onComplete: function() { guide_scroll.gotoAndPlay("animate"); } } );
				} else if (guideScrollOn && !guideDragOn) { //completed scroll, animate in drag cue
					Tweener.addTween(guide_drag, { alpha:1, time: 0.8, onComplete: function() { guide_drag.gotoAndPlay("animate"); } } );
				} else if (guideDragOn && !guideResizeOn) { //completed drag, haven't resized, animate in resize cue
					setChildIndex(guide_resize, numChildren - 1);
					Tweener.addTween(guide_resize, { alpha:1, time: 0.8, onComplete: function() { guide_resize.gotoAndPlay("animate"); guideResizeOn = true; } } );
				} else if (guideResizeOn && !guideMGOn) { //completed resize, animate in MG cue
					setChildIndex(guide_mg, numChildren - 1);
					Tweener.addTween(guide_mg, { alpha:1, time: 0.8, onComplete: function() { guideStep = 3; } } );
				} else if (!guideResizeOn && guideMGOn) { //completed drop into MG, but havent' resized
					setChildIndex(guide_resize, numChildren - 1);
					Tweener.addTween(guide_resize, { alpha:1, time: 0.8, onComplete: function() { guide_resize.gotoAndPlay("animate"); } } );
				} else if (!guideRemoveOn && guideMGOn) { //completed drop into MG, but havent' removed
					setChildIndex(guide_remove, numChildren - 1);
					Tweener.addTween(guide_remove, { alpha:1, time: 0.8, onComplete: function() { guideRemoveOn = true; } } );
				} else if (guideRemoveOn) {
					Tweener.addTween(guide_editgal, { alpha:1, time: 0.8, onComplete: function() { guideEditGalOn = true; } } );
				}
			} 
			
			if (mode == 1) {
				if (guideReorgOn) {
					Tweener.addTween(guide_titlename, { alpha:1, time: 0.8, onComplete: function() { guideTitNamOn = true; } } );
				}
			}
			
			if (mode == 2) {
				if (sgMode == 0) {
					Tweener.addTween(guide_viewgal, { alpha:1, time: 0.8, onComplete: function() { guideViewGalOn = true; } } );
				}				
				if (sgMode == 1) {
					if (!guideIntThumbOn) {
						Tweener.addTween(guide_interactthumb, { alpha:1, time: 0.8, onComplete: function() { guideIntThumbOn = true; } } );
					} else if (!guideTWOn) {
						Tweener.addTween(guide_tilewall, { alpha:1, time: 0.8, onComplete: function() { guideTWOn = true; } } );
					}
				}
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function anyTouch(e:TouchEvent):void {
			idleCountdown.reset();
			idleCountdown.start();
			reminder.reset();
			reminder.start();
			
			if (mode == 0){
				if (guide_remove.alpha == 1) {
					Tweener.addTween(guide_remove, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guideRemoveOn = true; } } );
					dispatchEvent(new Event("next cue", true));
				}			
				if (guide_resize.alpha == 1) {
					Tweener.addTween(guide_resize, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guideResizeOn = true; guide_resize.gotoAndStop(1); } } );
				}
				if (guide_editgal.alpha == 1) {
					Tweener.addTween(guide_editgal, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guideEditGalOn = true; } } );
				}
			}
			if (mode == 1) {
				if (guide_reorg.alpha == 1) {
					Tweener.addTween(guide_reorg, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guideReorgOn = true; } } );
					dispatchEvent(new Event("next cue", true));
				}
				if (guide_titlename.alpha == 1) {
					Tweener.addTween(guide_titlename, { alpha:0, time: 0.8, delay: 1, onComplete: function() { guideTitNamOn = true; } } );
				}
			}			
			if(mode == 2) {
				if (guide_viewgal.alpha == 1) {
					Tweener.addTween(guide_viewgal, { alpha:0, time: 0.8, onComplete: function() { guideViewGalOn = true; } } );
				}
				if (guide_tilewall.alpha == 1) {
					Tweener.addTween(guide_tilewall, { alpha:0, time: 0.8, onComplete: function() { guideTWOn = true; } } );
				} 
				if (guide_interactthumb.alpha == 1) {
					Tweener.addTween(guide_interactthumb, { alpha:0, time: 0.8, onComplete: function() { guideIntThumbOn = true; } } );
					dispatchEvent(new Event("next cue", true));
				}
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function beginDown(e:TouchEvent):void {
			btnBegin.gotoAndStop(2);
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function beginUp(e:TouchEvent):void {
			btnBegin.gotoAndStop(1);
			blockerOn();
			welcomeScreen.gotoAndPlay("fadeOut");
			
			//if this is the first time running, load UI, initialize everything, otherwise everything is already initialized
			if (round == 1) {
				loadUI();
			}
			
			Tweener.addTween( beginCtnr, { alpha: 0, time: 1, onComplete: function() { removeChild(beginCtnr); } } );
			Tweener.addTween( connections, { alpha: 0, time: 1, onComplete: function() { removeChild(connections); } } );
			Tweener.addTween( welcomeLangCtnr, { alpha: 0, time: 1, onComplete: function() { removeChild(welcomeLangCtnr); } } );
			Tweener.addTween( welcomeScreen, { alpha: 0, time: 1, delay: 2, onComplete: function() { removeChild(welcomeScreen); } } );			
			Tweener.addTween( this, { delay: 3, onComplete: function() {interfaceEntrance();} } ); //cue UI entrance
			
			Tweener.addTween(blockerContainer, { delay: 7, onComplete: blockerOff } );
		}
		
		/**
		 * Start over interface from logo animation sequence
		 * 
		 * @param	e
		 */
		private function startOvrDwn(e:TouchEvent):void{
			btnStartOver.gotoAndStop(2);
		}
		
		/**
		 * Start over interface from logo animation sequence
		 * 
		 * @param	e
		 */
		private function startOvrUp(e:TouchEvent):void {
			btnStartOver.gotoAndStop(1);
			guide_scroll.alpha = guide_drag.alpha = guide_resize.alpha = guide_mg.alpha = guide_remove.alpha = guide_editgal.alpha = guide_minimum.alpha = guide_reorg.alpha = guide_titlename.alpha = guide_submitfail.alpha = guide_viewgal.alpha = guide_interactthumb.alpha = guide_tilewall.alpha = 0;
			
			shadeOn();
			setChildIndex(popWindow, numChildren - 1);
			popWindow.x = 315;
			popWindow.y = 200;
			popWindow.height = 300;
			popWindow.width = 730.95;
			popWindow.alpha = 0;
			Tweener.addTween(popWindow, { delay: 1, alpha: 1, time: 0.8 } );
			
			setChildIndex(startOvertxt, numChildren - 1);
			startOvertxt.x = 640;
			startOvertxt.y = 300;
			startOvertxt.alpha = 0;
			Tweener.addTween(startOvertxt, { delay: 1, alpha: 1, time: 0.8 } );
			
			setChildIndex(yesBtn, numChildren - 1);
			btnYes.x = 469.15;
			btnYes.y = 377.2;
			yesBtn.alpha = 0;
			Tweener.addTween(yesBtn, { delay: 1, alpha: 1, time: 0.8 } );
			
			setChildIndex(cancelBtn, numChildren - 1);
			btnCancel.x = 649.15;
			btnCancel.y = 377.2;
			cancelBtn.alpha = 0;
			Tweener.addTween(cancelBtn, { delay: 1, alpha: 1, time: 0.8 } );			
		}
		
		private function yesDwn(e:TouchEvent):void {
			btnYes.gotoAndStop(2);
		}
		
		private function yesUp(e:TouchEvent):void {
			btnYes.gotoAndStop(1);
			
			round++;
			blockerOn();
			Tweener.addTween(blockerContainer, { delay: 2.2, onComplete: blockerOff } );
			
			//remove any photo displays
			var destroyList:Array = new Array();
			for(var i:uint = 0; i < numChildren; ++i){
				var p:Object = getChildAt(i);
				if(p is PhotoDisplay){
					destroyList.push(p);
				}
			}
			for(var j:uint = 0; j < destroyList.length; ++j){
				destroyList[j].fadeOut();
				destroyList[j] = null;
			}
			currentlyDisplayed = 0;
			
			welcomeScreen.gotoAndStop(1);
			welcomeScreen.alpha = 0;
			addChild(welcomeScreen);
			
			introAni.alpha = 0;
			introAni.gotoAndStop(1);
			addChild(introAni); //put logo animation on top first
			Tweener.addTween(introAni, { alpha: 1, time: 2, onComplete: function() {
				introAni.gotoAndPlay(1); welcomeScreen.alpha = 1; resetInterface();
				popWindow.x = 265; popWindow.y = -2000;
				startOvertxt.x = 265; startOvertxt.y = -2000;
				btnYes.x = 265; btnYes.y = -2000;
				btnCancel.x = 265; btnCancel.y = -2000;
				shadeOff();
			} } );
		}
		
		private function cancelDwn(e:TouchEvent):void {
			btnCancel.gotoAndStop(2);
		}
		
		private function cancelUp(e:TouchEvent):void {
			btnCancel.gotoAndStop(1);
			
			Tweener.addTween(popWindow, { alpha: 0, time: 0.8, onComplete: function() {popWindow.x = 265; popWindow.y = -2000;} } );
			Tweener.addTween(startOvertxt, { alpha: 0, time: 0.8, onComplete: function() {startOvertxt.x = 265; startOvertxt.y = -2000;} } );
			Tweener.addTween(cancelBtn, { alpha: 0, time: 0.8, onComplete: function() {btnCancel.x = 265; btnCancel.y = -2000;} } );
			Tweener.addTween(yesBtn, { alpha: 0, time: 0.8, onComplete: function() {btnYes.x = 265; btnYes.y = -2000;} } );
			shadeOff();
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function welcomeLangDown(e:TouchEvent):void {
			if (aboutLang == 0) {
				btnWelcomeLang.gotoAndStop("toJpnDown");
			} else {
				btnWelcomeLang.gotoAndStop("toEngDown");
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function welcomeLangUp(e:TouchEvent):void {
			if(aboutLang == 0) {
				btnWelcomeLang.gotoAndStop("toEng");
				connections.gotoAndStop("japanese");
				aboutLang = 1;
			} else {
				btnWelcomeLang.gotoAndStop("toJpn");
				connections.gotoAndStop("english");
				aboutLang = 0;
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function aboutDown(e:TouchEvent):void {
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function aboutUp(e:TouchEvent):void {
			if(!aboutOn) {
				aboutOn = true;
				shadeOn();				
				setChildIndex(aboutTabCtnr, numChildren - 1);
				setChildIndex(switchLangCtnr, numChildren - 1);
				blockerOn();
				if (aboutLang == 0) 
					aboutTab.gotoAndStop("english");
				else
					aboutTab.gotoAndStop("japanese");
				
				Tweener.addTween(switchLangCtnr, { y: 716.2, time: 1 } );
				Tweener.addTween(aboutTabCtnr, { y: 716.2, time: 1 } );
				Tweener.addTween(blockerContainer, { delay: 1, onComplete: blockerOff } );
			} else {
				aboutOn = false;
				shadeOff();
				blockerOn();
				Tweener.addTween(switchLangCtnr, { y: 0, time: 1 } );
				Tweener.addTween(aboutTabCtnr, { y: 0, time: 1 } );
				Tweener.addTween(blockerContainer, { delay: 2, onComplete: blockerOff } );
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function switchLangDown(e:TouchEvent):void {
			if (aboutLang == 0) { //if in English mode
				switchLang.gotoAndStop("toJpnDown");
			} else { //if in Japanese mode
				switchLang.gotoAndStop("toEngDown");
			}
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function switchLangUp(e:TouchEvent):void {
			if (aboutLang == 0) { //if in English mode, go to Japanese mode
				switchLang.gotoAndStop("toEng");
				aboutTab.gotoAndStop("japanese");
				aboutLang = 1;
			} else { //if in Japanese mode, go to English mode
				switchLang.gotoAndStop("toJpn");
				aboutTab.gotoAndStop("english");
				aboutLang = 0;
			}

		}
		
		/*-- begin to personal collection handlers --*/
		private function toPCHandlerDwn(e:TouchEvent):void {
			to_perscoll.gotoAndStop("pressed");
		}
		
		private function toPCHandlerUp(e:TouchEvent):void {
			to_perscoll.gotoAndStop("default");
			
			if (personalCollection.collection.length >= 2) {
				Tweener.addTween(guide_scroll, { alpha:0, time: 0.8, onComplete: function() { guide_scroll.gotoAndStop(1); }  } );
				Tweener.addTween(guide_drag, { alpha:0, time: 0.8, onComplete: function() { guide_drag.gotoAndStop(1); }  } );
				Tweener.addTween(guide_drag, { alpha:0, time: 0.8 } );
				Tweener.addTween(guide_mg, { alpha:0, time: 0.8 } );				
				
				if (!guideEditGalOn) { //already performed edit gallery
					guideEditGalOn = true;
				}
				
				blockerOn();
				
				if (!guideReorgOn) {
					Tweener.addTween(guide_reorg, { alpha: 1, time: 0.8, delay: 4 } );
				}
				
				var destroyList:Array = new Array();
				for(var i:uint = 0; i < numChildren; ++i){
					var p:Object = getChildAt(i);
					if(p is PhotoDisplay){
						destroyList.push(p);
					}
				}
				for(var j:uint = 0; j < destroyList.length; ++j){
					destroyList[j].fadeOut();
					destroyList[j] = null;
				}
				currentlyDisplayed = 0;
				
				mode = 1;
				Tweener.addTween(to_perscoll, { x: to_perscoll.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(to_musecoll, { x: to_musecoll.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(images, { x: images.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(thumbnail_bar, { x: thumbnail_bar.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(clearButton, { x: clearButton.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(startOverContainer, { x: startOverContainer.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(to_others, { x: to_others.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				softKeyboard.visible = true;
				Tweener.addTween(softKeyboard, { x: softKeyboard.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(submitBtn, { x: submitBtn.x - 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
				Tweener.addTween(blocker, { delay: 3.2, onComplete:blockerOff } );
				personalCollection.startToPC();
				
				trace(currentlyDisplayed);
			} else {
				setChildIndex(guide_minimum, numChildren - 1);
				Tweener.addTween(guide_minimum, { alpha: 1, time: 0.8 } );
				Tweener.addTween(guide_minimum, { alpha: 0, time: 0.8, delay: 4 } );
			}
		}
		/*-- end --*/
		
		/*-- begin return to museum collection handlers --*/
		private function toMCHandlerDwn(e:TouchEvent):void {
			to_musecoll.gotoAndStop("pressed");
		}
		
		/**
		 * Animates transition to Museum Collection
		 * 
		 * @param	e
		 */
		private function toMCHandlerUp(e:TouchEvent):void {
			mode = 0;
			exitKeyboardCtnr.y = -2000; //shift extKeyboard off screen to prevent PC from shifting down in MC Mode (note: quick fix)
			
			Tweener.addTween(guide_reorg, { alpha:0, time: 0.8 } );
			Tweener.addTween(guide_titlename, { alpha:0, time: 0.8 } );
			Tweener.addTween(guide_submitfail, { alpha:0, time: 0.8 } );
			
			to_musecoll.gotoAndStop("default");
			addPC();
			Tweener.addTween(to_perscoll, { x: to_perscoll.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_musecoll, { x: to_musecoll.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(images, { x: images.x + 1280, time: 2, delay: 0.7, transition:"easeOutQuart" } );
			Tweener.addTween(thumbnail_bar, { x: thumbnail_bar.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(clearButton, { x: clearButton.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(startOverContainer, { x: startOverContainer.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_others, { x: to_others.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(softKeyboard, { x: softKeyboard.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );	
			Tweener.addTween(submitBtn, { x: submitBtn.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			
			if (keyboardOn) {
				Tweener.addTween(softKeyboard, { y: softKeyboard.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(softKeyboard.englishKeyboard, { alpha: 0, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(softKeyboard.japaneseKeyboard, {alpha: 0, time:0.6, transition:"easeOutQuart" });
				Tweener.addTween(submitBtn, { y: submitBtn.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(guide_submitfail, { y: guide_submitfail.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(guide_titlename, { y: guide_titlename.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(personalCollection, { y: Main.personalCollection.y + 310, time: 0.6, transition:"easeOutQuart" } );
				softKeyboard.transition = false;
				keyboardOn = false;
			}
			
			personalCollection.startToMC();
			//blocker
			blockerOn();
			Tweener.addTween(blocker, { delay: 3.2, onComplete:blockerOff } );
		}
		/*-- end --*/
		
		/*-- begin to others' collection handlers --*/
		private function toOCHandlerDwn(e:TouchEvent):void {
			to_others.gotoAndStop("pressed");
		}
		
		private function toOCHandlerUp(e:TouchEvent):void {
			
			Tweener.addTween(guide_scroll, { alpha:0, time: 0.8, onComplete: function() { guide_scroll.gotoAndStop(1); }  } );
			Tweener.addTween(guide_drag, { alpha:0, time: 0.8, onComplete: function() { guide_drag.gotoAndStop(1); }  } );
			Tweener.addTween(guide_drag, { alpha:0, time: 0.8 } );
			Tweener.addTween(guide_mg, { alpha:0, time: 0.8 } );
			
			if (!guideViewGalOn) {
				dispatchEvent(new Event("next cue", true));
			}
			
			cViewer = new CollectionViewer();
			cViewer.y = stage.stageHeight;
			addChildAt(cViewer, 0);
			
			
			var destroyList:Array = new Array();
			for(var i:uint = 0; i < numChildren; ++i){
				var p:Object = getChildAt(i);
				if(p is PhotoDisplay){
					destroyList.push(p);
				}
			}
			for(var j:uint = 0; j < destroyList.length; ++j){
				destroyList[j].fadeOut();
				destroyList[j] = null;
			}
			
			currentlyDisplayed = 0;
			
			mode = 2;
			blockerOn();
			
			to_others.gotoAndStop("default");
			Tweener.addTween(to_perscoll, { y: to_perscoll.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_musecoll, { y: to_musecoll.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(images, { y: images.y - 800, alpha:0, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(thumbnail_bar, { y: thumbnail_bar.y - 800, alpha:0, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(clearButton, { y: clearButton.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(startOverContainer, { y: startOverContainer.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_others, { y: to_others.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(personalCollection, { y: personalCollection.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_musecoll2, { y: to_musecoll2.y - 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(cViewer, { y: 0, time:2, transition:"easeOutQuart"});			
			Tweener.addTween(blocker, { delay: 2, onComplete:blockerOff } );
			mode = 2;
			
			setChildIndex(images, 0);
			setChildIndex(thumbnail_bar, 0);
		}
		/*-- end --*/
		
		/*-- begin 2nd return to museum collection handlers --*/
		private function toMC2HandlerDwn(e:TouchEvent):void {
			to_musecoll2.gotoAndStop("pressed");
		}
		
		private function toMC2HandlerUp(e:TouchEvent):void {
			mode = 0;
			blockerOn();
			
			var destroyList:Array = new Array();
			for(var i:uint = 0; i < numChildren; ++i){
				var p:Object = getChildAt(i);
				if(p is PhotoDisplay){
					destroyList.push(p);
				}
			}
			for(var j:uint = 0; j < destroyList.length; ++j){
				destroyList[j].fadeOut();
				destroyList[j] = null;
			}
			
			//for safe measure
			Tweener.addTween(guide_interactthumb, { alpha:0, time: 0.8 } );
			Tweener.addTween(guide_viewgal, { alpha:0, time: 0.8 } );
			Tweener.addTween(guide_tilewall, { alpha:0, time: 0.8 } );
			
			to_musecoll2.gotoAndStop("default");
			Tweener.addTween(to_perscoll, { y: to_perscoll.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_musecoll, { y: to_musecoll.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(images, { y: images.y + 800, alpha: 1, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(thumbnail_bar, { y: thumbnail_bar.y + 800, alpha:1, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(clearButton, { y: clearButton.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(startOverContainer, { y: startOverContainer.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_others, { y: to_others.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(personalCollection, { y: personalCollection.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_musecoll2, { y: to_musecoll2.y + 800, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(blocker, { delay: 2, onComplete:blockerOff } );
			Tweener.addTween(cViewer, { y: stage.stageHeight, time:2, transition:"easeOutQuart", onComplete: function(){
				cViewer.Dispose();
				cViewer = null;
			}});
			
			setChildIndex(images, 0); //prevents weird layering of thumbnails over Saved Galleries top border
			setChildIndex(thumbnail_bar, 0);			
			setChildIndex(personalCollection, 0); //Keeps My Gallery's drop area at bottom NOTE: quick fix
		}
		/*-- end --*/
		 
		private function clearTouchDown(e:TouchEvent):void{
			clearBtn.gotoAndStop(2);
		}
		
		private function removePC():void {
			removeChild(personalCollection);
		}
		
		private function addPC():void {
			addChild(personalCollection);
		}
		
		private function loadKeyboard():void{
			softKeyboard = new KeyboardController();
			addChild(softKeyboard);
			softKeyboard.visible = false;
		}
		
		private function okDown(e:TouchEvent):void {
			btnOK.gotoAndStop(2);
		}
		
		private function okUp(e:TouchEvent):void {
			btnOK.gotoAndStop(1);
			blockerOn();
			Tweener.addTween( shaderCtnr, {delay: 2.2, onComplete: shadeOff } );
			
			//move keyboard back down if on
			if (keyboardOn) {
				Tweener.addTween(softKeyboard, { y: softKeyboard.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(softKeyboard.englishKeyboard, { alpha: 0, time:0.6, transition:"easeOutQuart" } );
				Tweener.addTween(softKeyboard.japaneseKeyboard, {alpha: 0, time:0.6, transition:"easeOutQuart" });
				Tweener.addTween(submitBtn, { y: submitBtn.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(guide_submitfail, { y: guide_submitfail.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(guide_titlename, { y: guide_titlename.y + 310, time: 0.6, transition:"easeOutQuart" } );
				Tweener.addTween(personalCollection, { y: Main.personalCollection.y + 310, time: 0.6, transition:"easeOutQuart" } );
				softKeyboard.transition = false;
				keyboardOn = false;
			}
			Tweener.addTween(to_perscoll, { x: to_perscoll.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_musecoll, { x: to_musecoll.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(images, { x: images.x + 1280, time: 2, delay: 0.7, transition:"easeOutQuart" } );
			Tweener.addTween(thumbnail_bar, { x: thumbnail_bar.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(clearButton, { x: clearButton.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(startOverContainer, { x: startOverContainer.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(to_others, { x: to_others.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(softKeyboard, { x: softKeyboard.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );	
			Tweener.addTween(submitBtn, { x: submitBtn.x + 1280, delay: 0.7, time: 2, transition:"easeOutQuart" } );
			Tweener.addTween(blocker, { delay: 3.2, onComplete:blockerOff } );y
			
			personalCollection.startToMC();		
			trace("collection length: " + personalCollection.collection.length );
			
			//fade out submission window
			Tweener.addTween(popWindow, { alpha: 0, time: 0.8, onComplete: function() {popWindow.x = 265; popWindow.y = -2000;} } );
			Tweener.addTween(feedbackText, { alpha: 0, time: 0.8, onComplete: function() {feedbackText.x = 265; feedbackText.y = -2000;} } );
			Tweener.addTween(okBtn, { alpha: 0, time: 0.8, onComplete: function() {okBtn.x = 265; okBtn.y = -2000;} } );
			Tweener.addTween(sendAnimation, { alpha: 0, time: 0.8, onComplete: function() { sendAnimation.x = 265; sendAnimation.y = -2000; } } );			
			
			returnToMOPA(); //KEY //BLARGH
		}
		
		private function okSentDown(e:TouchEvent):void {
			okTWsent.gotoAndStop(2);
		}
		
		private function okSentUp(e:TouchEvent):void {
			okTWsent.gotoAndStop(1);
			
			Tweener.addTween(popWindow, { alpha: 0, time: 0.8, onComplete: function() {popWindow.x = 265; popWindow.y = -2000;} } );
			Tweener.addTween(sentTWtext, { alpha: 0, time: 0.8, onComplete: function() {sentTWtext.x = 265; sentTWtext.y = -2000;} } );
			Tweener.addTween(okSentBtn, { alpha: 0, time: 0.8, onComplete: function() {okSentBtn.x = 265; okSentBtn.y = -2000;} } );
			Tweener.addTween(sendAnimation, { alpha: 0, time: 0.8, onComplete: function() { sendAnimation.x = 265; sendAnimation.y = -2000; } } );
			shadeOff();
		}
		
		private function submitDown(e:TouchEvent):void{
			btnSubmit.gotoAndStop(2);
		}
		
		private function submitUp(e:TouchEvent):void{
			btnSubmit.gotoAndStop(1);
			if (softKeyboard.titleText == '' || softKeyboard.nameText == '') {
				trace("Need to fill in fields");
				
				setChildIndex(guide_submitfail, numChildren - 1);
				Tweener.addTween(guide_submitfail, { alpha: 1, time: 0.8 } );
				Tweener.addTween(guide_submitfail, { alpha: 0, time: 0.8, delay: 4 } );
				
			} else {				
				pCollection.saveCollection(personalCollection.getCollection(), softKeyboard.titleText, softKeyboard.nameText);
				
				shadeOn();
				setChildIndex(popWindow, numChildren - 1);
				popWindow.x = 265;
				popWindow.y = 140;
				popWindow.height = 532.5;
				popWindow.width = 814.95;
				trace("height:" + popWindow.height + ", width:" + popWindow.width);
				popWindow.alpha = 0;
				Tweener.addTween(popWindow, { delay: 1, alpha: 1, time: 0.8 } );
				
				setChildIndex(feedbackText, numChildren - 1);
				feedbackText.x = 640;
				feedbackText.y = 432.3;
				feedbackText.alpha = 0;
				Tweener.addTween(feedbackText, { delay: 3, alpha: 1, time: 0.8 } );
				
				setChildIndex(okBtn, numChildren - 1);
				okBtn.x = 0;
				okBtn.y = 668;
				okBtn.alpha = 0;
				Tweener.addTween(okBtn, { delay: 3, alpha: 1, time: 0.8 } );
				
				setChildIndex(sendAnimation, numChildren - 1);
				sendAnimation.y = 176.75;
				sendAnimation.x = 351.7;
				sendAnimation.alpha = 0;
				Tweener.addTween(sendAnimation, { delay: 1, alpha: 1, time: 0.8, onComplete: function() { sendAnimation.gotoAndStop(1); sendAnimation.gotoAndPlay("begin"); } } );
			}
		}
		
		public function inputEntrance(e:Event):void{
			Tweener.addTween(submitBtn, { y: submitBtn.y - 310, time: 0.6, transition:"easeOutQuart" } );
			Tweener.addTween(guide_submitfail, { y: guide_submitfail.y - 310, time: 0.6, transition:"easeOutQuart" } );
			Tweener.addTween(guide_titlename, { y: guide_titlename.y - 310, time: 0.6, transition:"easeOutQuart" } );
			exitKeyboardCtnr.x = exitKeyboardCtnr.y = 0;
			addChild(exitKeyboardCtnr);
			blockerOn();
			Tweener.addTween( blocker, { delay: 0.6, onComplete: blockerOff } );
			keyboardOn = true;
		}
		
		private function extKeyboard(e:TouchEvent): void {
			Tweener.addTween(submitBtn, { y: submitBtn.y + 310, time: 0.6, transition:"easeOutQuart" } );
			Tweener.addTween(guide_submitfail, { y: guide_submitfail.y + 310, time: 0.6, transition:"easeOutQuart" } );
			Tweener.addTween(guide_titlename, { y: guide_titlename.y + 310, time: 0.6, transition:"easeOutQuart" } );
			blockerOn();
			Tweener.addTween( blocker, { delay: 0.6, onComplete: blockerOff } );
			softKeyboard.extKeyboard();
			removeChild(exitKeyboardCtnr);
			keyboardOn = false;
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function sendToTW(e:Event):void{
			shadeOn();
			setChildIndex(popWindow, numChildren - 1);
			popWindow.x = 315;
			popWindow.y = 174.6;
			popWindow.height = 380;
			popWindow.width = 730.95;
			popWindow.alpha = 0;
			Tweener.addTween(popWindow, { delay: 1, alpha: 1, time: 0.8 } );
			
			setChildIndex(sentTWtext, numChildren - 1);
			sentTWtext.x = 640;
			sentTWtext.y = 414.25;
			sentTWtext.alpha = 0;
			Tweener.addTween(sentTWtext, { delay: 3, alpha: 1, time: 0.8 } );
			
			setChildIndex(okSentBtn, numChildren - 1);
			okSentBtn.x = 0;
			okSentBtn.y = 1070;
			okSentBtn.alpha = 0;
			Tweener.addTween(okSentBtn, { delay: 3, alpha: 1, time: 0.8 } );
			
			setChildIndex(sendAnimation, numChildren - 1);
			sendAnimation.y = 220.15;
			sendAnimation.x = 351.7;
			sendAnimation.alpha = 0;
			Tweener.addTween(sendAnimation, { delay: 1, alpha: 1, time: 0.8, onComplete: function() { sendAnimation.gotoAndStop(1); sendAnimation.gotoAndPlay("begin"); } } );
		}
		
		/**
		 * 
		 * @param	e
		 */
		private function destroyPhoto(e:PhotoEvent):void{
			images.destroyHandler(e);
			if(mode != 2){
				--currentlyDisplayed;
			}
		}
		
		private function addPhoto(e:PhotoEvent):void{
			personalCollection.addPhotoHandler(e);
			--currentlyDisplayed;
		}
		
		private function disableAdd(e:Event):void{
			for(var i:uint = 0; i < numChildren; ++i){
				var p:Object = getChildAt(i);
				if(p is PhotoDisplay){
					p.disableAdd();
				}
			}
		}
		
		
		private function enableAdd(e:Event):void{
			for(var i:uint = 0; i < numChildren; ++i){
				var p:Object = getChildAt(i);
				if(p is PhotoDisplay){
					p.enableAdd();
				}
			}
		}
		
		public function blockerOn():void {
			blockerContainer.x = blockerContainer.y = 0;
			setChildIndex(blockerContainer, numChildren - 1);
			blockerContainer.visible = true;
		}
		
		public function blockerOff():void {
			blockerContainer.visible = false;
		}
		
		public function shadeOn():void {
			addChild(shaderCtnr);
			Tweener.addTween(shaderCtnr, { alpha: 1, time: 0.5 } );
		}
		
		public function shadeOff():void {
			trace("call off shader");
			Tweener.addTween(shaderCtnr, { delay: 1, alpha: 0, time: 0.5, onComplete: function() { removeChild(shaderCtnr) } } );
		}
	}
}