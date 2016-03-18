package 
{	
	import flash.events.Event;
	import flash.display.DisplayObject;	
	
	import flash.display.MovieClip;
    import flash.display.Stage;

	import gl.events.GestureEvent;
	import gl.events.TouchEvent;
	import id.core.TouchComponent;
	import id.core.TouchSprite;
	
	import flash.text.*;
	
	public class SoftKeyboard extends TouchComponent {
		private var keyboardStates:KeyboardStates;
		private var key0:TouchSprite;
		private var key1:TouchSprite;
		private var key2:TouchSprite;
		private var key3:TouchSprite;
		private var key4:TouchSprite;
		private var key5:TouchSprite;
		private var key6:TouchSprite;
		private var key7:TouchSprite;
		private var key8:TouchSprite;
		private var key9:TouchSprite;
		private var keyA:TouchSprite;
		private var keyB:TouchSprite;
		private var keyC:TouchSprite;
		private var keyD:TouchSprite;
		private var keyE:TouchSprite;
		private var keyF:TouchSprite;
		private var keyG:TouchSprite;
		private var keyH:TouchSprite;
		private var keyI:TouchSprite;
		private var keyJ:TouchSprite;
		private var keyK:TouchSprite;
		private var keyL:TouchSprite;
		private var keyM:TouchSprite;
		private var keyN:TouchSprite;
		private var keyO:TouchSprite;
		private var keyP:TouchSprite;
		private var keyQ:TouchSprite;
		private var keyR:TouchSprite;
		private var keyS:TouchSprite;
		private var keyT:TouchSprite;
		private var keyU:TouchSprite;
		private var keyV:TouchSprite;
		private var keyW:TouchSprite;
		private var keyX:TouchSprite;
		private var keyY:TouchSprite;
		private var keyZ:TouchSprite;
		
		private var keyShift:TouchSprite;
		private var keySymbols:TouchSprite;
		private var keyToJapanese:TouchSprite;
		private var keyBackspace:TouchSprite;
		private var keySpace:TouchSprite;
		
		
		private var inputTxt:TextField; 
		
		public function SoftKeyboard(titleInput:TextField) {
			inputTxt = titleInput;
			createUI();
			commitUI();
			layoutUI();
		}
		
		public function toDefault():void{
			keyboardStates.gotoAndStop("keyboard_lc");
		}
		
		public function set input(newInput:TextField):void{
			inputTxt = newInput;
			stage.focus = inputTxt;
		}
		
		override protected function createUI():void{
			keyboardStates = new KeyboardStates();
			
			key0 = new TouchSprite();
			key0.addChild(key_0);
			key0.addEventListener(TouchEvent.TOUCH_UP, zeroUpHandler);
			key0.addEventListener(TouchEvent.TOUCH_DOWN, zeroDownHandler);
			
			key1 = new TouchSprite();
			key1.addChild(key_1);
			key1.addEventListener(TouchEvent.TOUCH_UP, oneUpHandler);
			key1.addEventListener(TouchEvent.TOUCH_DOWN, oneDownHandler);
			
			key2 = new TouchSprite();
			key2.addChild(key_2);
			key2.addEventListener(TouchEvent.TOUCH_UP, twoUpHandler);
			key2.addEventListener(TouchEvent.TOUCH_DOWN, twoDownHandler);
			
			key3 = new TouchSprite();
			key3.addChild(key_3);
			key3.addEventListener(TouchEvent.TOUCH_UP, threeUpHandler);
			key3.addEventListener(TouchEvent.TOUCH_DOWN, threeDownHandler);
			
			key4 = new TouchSprite();
			key4.addChild(key_4);
			key4.addEventListener(TouchEvent.TOUCH_UP, fourUpHandler);
			key4.addEventListener(TouchEvent.TOUCH_DOWN, fourDownHandler);
			
			key5 = new TouchSprite();
			key5.addChild(key_5);
			key5.addEventListener(TouchEvent.TOUCH_UP, fiveUpHandler);
			key5.addEventListener(TouchEvent.TOUCH_DOWN, fiveDownHandler);
			
			key6 = new TouchSprite();
			key6.addChild(key_6);
			key6.addEventListener(TouchEvent.TOUCH_UP, sixUpHandler);
			key6.addEventListener(TouchEvent.TOUCH_DOWN, sixDownHandler);
			
			key7 = new TouchSprite();
			key7.addChild(key_7);
			key7.addEventListener(TouchEvent.TOUCH_UP, sevenUpHandler);
			key7.addEventListener(TouchEvent.TOUCH_DOWN, sevenDownHandler);
			
			key8 = new TouchSprite();
			key8.addChild(key_8);
			key8.addEventListener(TouchEvent.TOUCH_UP, eightUpHandler);
			key8.addEventListener(TouchEvent.TOUCH_DOWN, eightDownHandler);
			
			key9 = new TouchSprite();
			key9.addChild(key_9);
			key9.addEventListener(TouchEvent.TOUCH_UP, nineUpHandler);
			key9.addEventListener(TouchEvent.TOUCH_DOWN, nineDownHandler);
			
			keyA = new TouchSprite();
			keyA.addChild(key_a);
			keyA.addEventListener(TouchEvent.TOUCH_UP, aUpHandler);
			keyA.addEventListener(TouchEvent.TOUCH_DOWN, aDownHandler);
			
			keyB = new TouchSprite();
			keyB.addChild(key_b);
			keyB.addEventListener(TouchEvent.TOUCH_UP, bUpHandler);
			keyB.addEventListener(TouchEvent.TOUCH_DOWN, bDownHandler);
			
			keyC = new TouchSprite();
			keyC.addChild(key_c);
			keyC.addEventListener(TouchEvent.TOUCH_UP, cUpHandler);
			keyC.addEventListener(TouchEvent.TOUCH_DOWN, cDownHandler);
			
			keyD = new TouchSprite();
			keyD.addChild(key_d);
			keyD.addEventListener(TouchEvent.TOUCH_UP, dUpHandler);
			keyD.addEventListener(TouchEvent.TOUCH_DOWN, dDownHandler);
			
			keyE = new TouchSprite();
			keyE.addChild(key_e);
			keyE.addEventListener(TouchEvent.TOUCH_UP, eUpHandler);
			keyE.addEventListener(TouchEvent.TOUCH_DOWN, eDownHandler);
			
			keyF = new TouchSprite();
			keyF.addChild(key_f);
			keyF.addEventListener(TouchEvent.TOUCH_UP, fUpHandler);
			keyF.addEventListener(TouchEvent.TOUCH_DOWN, fDownHandler);
			
			keyG = new TouchSprite();
			keyG.addChild(key_g);
			keyG.addEventListener(TouchEvent.TOUCH_UP, gUpHandler);
			keyG.addEventListener(TouchEvent.TOUCH_DOWN, gDownHandler);
			
			keyH = new TouchSprite();
			keyH.addChild(key_h);
			keyH.addEventListener(TouchEvent.TOUCH_UP, hUpHandler);
			keyH.addEventListener(TouchEvent.TOUCH_DOWN, hDownHandler);
			
			keyI = new TouchSprite();
			keyI.addChild(key_i);
			keyI.addEventListener(TouchEvent.TOUCH_UP, iUpHandler);
			keyI.addEventListener(TouchEvent.TOUCH_DOWN, iDownHandler);
			
			keyJ = new TouchSprite();
			keyJ.addChild(key_j);
			keyJ.addEventListener(TouchEvent.TOUCH_UP, jUpHandler);
			keyJ.addEventListener(TouchEvent.TOUCH_DOWN, jDownHandler);
			
			keyK = new TouchSprite();
			keyK.addChild(key_k);
			keyK.addEventListener(TouchEvent.TOUCH_UP, kUpHandler);
			keyK.addEventListener(TouchEvent.TOUCH_DOWN, kDownHandler);
			
			keyL = new TouchSprite();
			keyL.addChild(key_l);
			keyL.addEventListener(TouchEvent.TOUCH_UP, lUpHandler);
			keyL.addEventListener(TouchEvent.TOUCH_DOWN, lDownHandler);
			
			keyM = new TouchSprite();
			keyM.addChild(key_m);
			keyM.addEventListener(TouchEvent.TOUCH_UP, mUpHandler);
			keyM.addEventListener(TouchEvent.TOUCH_DOWN, mDownHandler);
			
			keyN = new TouchSprite();
			keyN.addChild(key_n);
			keyN.addEventListener(TouchEvent.TOUCH_UP, nUpHandler);
			keyN.addEventListener(TouchEvent.TOUCH_DOWN, nDownHandler);
			
			keyO = new TouchSprite();
			keyO.addChild(key_o);
			keyO.addEventListener(TouchEvent.TOUCH_UP, oUpHandler);
			keyO.addEventListener(TouchEvent.TOUCH_DOWN, oDownHandler);
			
			keyP = new TouchSprite();
			keyP.addChild(key_p);
			keyP.addEventListener(TouchEvent.TOUCH_UP, pUpHandler);
			keyP.addEventListener(TouchEvent.TOUCH_DOWN, pDownHandler);
			
			keyQ = new TouchSprite();
			keyQ.addChild(key_q);
			keyQ.addEventListener(TouchEvent.TOUCH_UP, qUpHandler);
			keyQ.addEventListener(TouchEvent.TOUCH_DOWN, qDownHandler);
			
			keyR = new TouchSprite();
			keyR.addChild(key_r);
			keyR.addEventListener(TouchEvent.TOUCH_UP, rUpHandler);
			keyR.addEventListener(TouchEvent.TOUCH_DOWN, rDownHandler);
			
			keyS = new TouchSprite();
			keyS.addChild(key_s);
			keyS.addEventListener(TouchEvent.TOUCH_UP, sUpHandler);
			keyS.addEventListener(TouchEvent.TOUCH_DOWN, sDownHandler);
			
			keyT = new TouchSprite();
			keyT.addChild(key_t);
			keyT.addEventListener(TouchEvent.TOUCH_UP, tUpHandler);
			keyT.addEventListener(TouchEvent.TOUCH_DOWN, tDownHandler);
			
			keyU = new TouchSprite();
			keyU.addChild(key_u);
			keyU.addEventListener(TouchEvent.TOUCH_UP, uUpHandler);
			keyU.addEventListener(TouchEvent.TOUCH_DOWN, uDownHandler);
			
			keyV = new TouchSprite();
			keyV.addChild(key_v);
			keyV.addEventListener(TouchEvent.TOUCH_UP, vUpHandler);
			keyV.addEventListener(TouchEvent.TOUCH_DOWN, vDownHandler);
			
			keyW = new TouchSprite();
			keyW.addChild(key_w);
			keyW.addEventListener(TouchEvent.TOUCH_UP, wUpHandler);
			keyW.addEventListener(TouchEvent.TOUCH_DOWN, wDownHandler);
			
			keyX = new TouchSprite();
			keyX.addChild(key_x);
			keyX.addEventListener(TouchEvent.TOUCH_UP, xUpHandler);
			keyX.addEventListener(TouchEvent.TOUCH_DOWN, xDownHandler);
			
			keyY = new TouchSprite();
			keyY.addChild(key_y);
			keyY.addEventListener(TouchEvent.TOUCH_UP, yUpHandler);
			keyY.addEventListener(TouchEvent.TOUCH_DOWN, yDownHandler);
			
			keyZ = new TouchSprite();
			keyZ.addChild(key_z);
			keyZ.addEventListener(TouchEvent.TOUCH_UP, zUpHandler);
			keyZ.addEventListener(TouchEvent.TOUCH_DOWN, zDownHandler);

			
			keyShift = new TouchSprite();
			keyShift.addChild(key_shift);
			keyShift.addEventListener(TouchEvent.TOUCH_UP, shiftUpHandler);
			keyShift.addEventListener(TouchEvent.TOUCH_DOWN, shiftDownHandler);
			
			keySymbols = new TouchSprite();
			keySymbols.addChild(key_symbols);
			keySymbols.addEventListener(TouchEvent.TOUCH_UP, symbolsUpHandler);
			keySymbols.addEventListener(TouchEvent.TOUCH_DOWN, symbolsDownHandler);
			
			keyToJapanese = new TouchSprite();
			keyToJapanese.addChild(key_toJpn);
			keyToJapanese.addEventListener(TouchEvent.TOUCH_UP, toJapaneseUpHandler);
			keyToJapanese.addEventListener(TouchEvent.TOUCH_DOWN, toJapaneseDownHandler);			
			
			keyBackspace = new TouchSprite();
			keyBackspace.addChild(key_backspace);
			keyBackspace.addEventListener(TouchEvent.TOUCH_UP, backspaceUpHandler);
			keyBackspace.addEventListener(TouchEvent.TOUCH_DOWN, backspaceDownHandler);
			
			keySpace = new TouchSprite();
			keySpace.addChild(key_space);
			keySpace.addEventListener(TouchEvent.TOUCH_UP, spaceUpHandler);
			keySpace.addEventListener(TouchEvent.TOUCH_DOWN, spaceDownHandler);
			 
			addChild(keyboardStates);
			addChildAt(key0, 0);
			addChildAt(key1, 0);
			addChildAt(key2, 0);
			addChildAt(key3, 0);
			addChildAt(key4, 0);
			addChildAt(key5, 0);
			addChildAt(key6, 0);
			addChildAt(key7, 0);
			addChildAt(key8, 0);
			addChildAt(key9, 0);
			addChildAt(keyA, 0);
			addChildAt(keyB, 0);
			addChildAt(keyC, 0);
			addChildAt(keyD, 0);
			addChildAt(keyE, 0);
			addChildAt(keyF, 0);
			addChildAt(keyG, 0);
			addChildAt(keyH, 0);
			addChildAt(keyI, 0);
			addChildAt(keyJ, 0);
			addChildAt(keyK, 0);
			addChildAt(keyL, 0);
			addChildAt(keyM, 0);
			addChildAt(keyN, 0);
			addChildAt(keyO, 0);
			addChildAt(keyP, 0);
			addChildAt(keyQ, 0);
			addChildAt(keyR, 0);
			addChildAt(keyS, 0);
			addChildAt(keyT, 0);
			addChildAt(keyU, 0);
			addChildAt(keyV, 0);
			addChildAt(keyW, 0);
			addChildAt(keyX, 0);
			addChildAt(keyY, 0);
			addChildAt(keyZ, 0);
			addChildAt(keyShift, 0);
			addChildAt(keySymbols, 0);
			addChildAt(keyToJapanese, 0);
			addChildAt(keyBackspace, 0);
			addChildAt(keySpace, 0);
		}
		
		override protected function commitUI():void{
			key_q.gotoAndStop("default");
		}
		
		override protected function layoutUI():void{
		}
		
		private function zeroDownHandler(e:TouchEvent):void{
			key_0.gotoAndStop("pressed");
		}
		
		private function zeroUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("0");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_0.gotoAndStop("default");
		}
		
		
		private function oneDownHandler(e:TouchEvent):void{
			key_1.gotoAndStop("pressed");
		}
		
		private function oneUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("1");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_1.gotoAndStop("default");
		}
		
		
		private function twoDownHandler(e:TouchEvent):void{
			key_2.gotoAndStop("pressed");
		}
		
		private function twoUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("2");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_2.gotoAndStop("default");
		}
		
		
		private function threeDownHandler(e:TouchEvent):void{
			key_3.gotoAndStop("pressed");
		}
		
		private function threeUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("3");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_3.gotoAndStop("default");
		}
		
		
		private function fourDownHandler(e:TouchEvent):void{
			key_4.gotoAndStop("pressed");
		}
		
		private function fourUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("4");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_4.gotoAndStop("default");
		}
		
		
		private function fiveDownHandler(e:TouchEvent):void{
			key_5.gotoAndStop("pressed");
		}
		
		private function fiveUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("5");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_5.gotoAndStop("default");
		}
		
		
		private function sixDownHandler(e:TouchEvent):void{
			key_6.gotoAndStop("pressed");
		}
		
		private function sixUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("6");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_6.gotoAndStop("default");
		}
		
		
		private function sevenDownHandler(e:TouchEvent):void{
			key_7.gotoAndStop("pressed");
		}
		
		private function sevenUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("7");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_7.gotoAndStop("default");
		}
		
		
		private function eightDownHandler(e:TouchEvent):void{
			key_8.gotoAndStop("pressed");
		}
		
		private function eightUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("8");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_8.gotoAndStop("default");
		}
		
		
		private function nineDownHandler(e:TouchEvent):void{
			key_9.gotoAndStop("pressed");
		}
		
		private function nineUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("9");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_9.gotoAndStop("default");
		}
		
		private function aDownHandler(e:TouchEvent):void{
			key_a.gotoAndStop("pressed");
		}
		
		private function aUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("a");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("A");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("~");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function bDownHandler(e:TouchEvent):void{
			key_b.gotoAndStop("pressed");
		}
		
		private function bUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("b");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_b.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("B");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_b.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText(",");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_b.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function cDownHandler(e:TouchEvent):void{
			key_c.gotoAndStop("pressed");
		}
		
		private function cUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("c");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_c.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("C");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_c.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText('"');
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_c.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function dDownHandler(e:TouchEvent):void{
			key_d.gotoAndStop("pressed");
		}
		
		private function dUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("d");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_d.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("D");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_d.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText(">");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_d.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function eDownHandler(e:TouchEvent):void{
			key_e.gotoAndStop("pressed");
		}
		
		private function eUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("e");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("E");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("#");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function fDownHandler(e:TouchEvent):void{
			key_f.gotoAndStop("pressed");
		}
		
		private function fUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("f");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_f.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("F");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_f.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("-");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_f.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function gDownHandler(e:TouchEvent):void{
			key_g.gotoAndStop("pressed");
		}
		
		private function gUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("g");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_g.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("G");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_g.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("+");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_g.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function hDownHandler(e:TouchEvent):void{
			key_h.gotoAndStop("pressed");
		}
		
		private function hUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("h");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_h.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("H");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_h.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("/");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_h.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function iDownHandler(e:TouchEvent):void{
			key_i.gotoAndStop("pressed");
		}
		
		private function iUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("i");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("I");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("*");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function jDownHandler(e:TouchEvent):void{
			key_j.gotoAndStop("pressed");
		}
		
		private function jUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("j");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_j.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("J");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_j.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("=");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_j.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function kDownHandler(e:TouchEvent):void{
			key_k.gotoAndStop("pressed");
		}
		
		private function kUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("k");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_k.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("K");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_k.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("[");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_k.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function lDownHandler(e:TouchEvent):void{
			key_l.gotoAndStop("pressed");
		}
		
		private function lUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("l");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_l.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("L");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_l.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("]");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_l.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function mDownHandler(e:TouchEvent):void{
			key_m.gotoAndStop("pressed");
		}
		
		private function mUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("m");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_m.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("M");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_m.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("?");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_m.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function nDownHandler(e:TouchEvent):void{
			key_n.gotoAndStop("pressed");
		}
		
		private function nUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("n");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_n.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("N");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_n.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText(".");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_n.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function oDownHandler(e:TouchEvent):void{
			key_o.gotoAndStop("pressed");
		}
		
		private function oUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("o");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("O");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("(");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function pDownHandler(e:TouchEvent):void{
			key_p.gotoAndStop("pressed");
		}
		
		private function pUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("p");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_p.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("P");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_p.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText(")");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_p.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function qDownHandler(e:TouchEvent):void{
			key_q.gotoAndStop("pressed");
		}
		
		private function qUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("q");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_q.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("Q");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_q.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("!");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_q.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function rDownHandler(e:TouchEvent):void{
			key_r.gotoAndStop("pressed");
		}
		
		private function rUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("r");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_r.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("R");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_r.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("$");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_r.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function sDownHandler(e:TouchEvent):void{
			key_s.gotoAndStop("pressed");
		}
		
		private function sUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("s");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_s.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("S");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_s.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("<");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_s.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function tDownHandler(e:TouchEvent):void{
			key_t.gotoAndStop("pressed");
		}
		
		private function tUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("t");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_t.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("T");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_t.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("%");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_t.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function uDownHandler(e:TouchEvent):void{
			key_u.gotoAndStop("pressed");
		}
		
		private function uUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("u");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("U");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("&");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function vDownHandler(e:TouchEvent):void{
			key_v.gotoAndStop("pressed");
		}
		
		private function vUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("v");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_v.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("V");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_v.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("'");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_v.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function wDownHandler(e:TouchEvent):void{
			key_w.gotoAndStop("pressed");
		}
		
		private function wUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("w");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_w.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("W");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_w.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("@");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_w.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function xDownHandler(e:TouchEvent):void{
			key_x.gotoAndStop("pressed");
		}
		
		private function xUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("x");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_x.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("X");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_x.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText(":");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_x.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function yDownHandler(e:TouchEvent):void{
			key_y.gotoAndStop("pressed");
		}
		
		private function yUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("y");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_y.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("Y");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_y.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText("^");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_y.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function zDownHandler(e:TouchEvent):void{
			key_z.gotoAndStop("pressed");
		}
		
		private function zUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					inputTxt.appendText("z");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_z.gotoAndStop("default");
					break;
				case "keyboard_uc":
					inputTxt.appendText("Z");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_z.gotoAndStop("default");
					keyboardStates.gotoAndStop("keyboard_lc");
					break;
				case "keyboard_symnum":
					inputTxt.appendText(";");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_z.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function shiftDownHandler(e:TouchEvent):void{
			key_shift.gotoAndStop("pressed");
		}
		
		private function shiftUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					keyboardStates.gotoAndStop("keyboard_uc");
					key_shift.gotoAndStop("default");
					break;
				case "keyboard_uc":
					keyboardStates.gotoAndStop("keyboard_lc");
					key_shift.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function symbolsDownHandler(e:TouchEvent):void{
			key_symbols.gotoAndStop("pressed");
		}
		
		private function symbolsUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "keyboard_lc":
					keyboardStates.gotoAndStop("keyboard_symnum");
					keyShift.visible = false;
					key_symbols.gotoAndStop("default");
					break;
				case "keyboard_uc":
					keyboardStates.gotoAndStop("keyboard_symnum");
					keyShift.visible = false;
					key_symbols.gotoAndStop("default");
					break;
				case "keyboard_symnum":
					keyboardStates.gotoAndStop("keyboard_lc");
					keyShift.visible = true;
					key_symbols.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function toJapaneseDownHandler(e:TouchEvent):void{
			key_toJpn.gotoAndStop("pressed");
		}
		
		private function toJapaneseUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			dispatchEvent(new Event("english to japanese", true));
			key_toJpn.gotoAndStop("default");
		}
		
		
		private function backspaceDownHandler(e:TouchEvent):void{
			key_backspace.gotoAndStop("pressed");
		}
		
		private function backspaceUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			inputTxt.replaceText(inputTxt.length - 1, inputTxt.length, "");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_backspace.gotoAndStop("default");
		}
		
		
		private function spaceDownHandler(e:TouchEvent):void{
			key_space.gotoAndStop("pressed");
		}
		
		private function spaceUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			inputTxt.appendText(" ");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_space.gotoAndStop("default");
		}
	}
}