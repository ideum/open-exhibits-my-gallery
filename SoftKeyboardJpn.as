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
	
	public class SoftKeyboardJpn extends TouchComponent {
		private var keyboardStates:KeyboardStatesJpn;
		private var keyA:TouchSprite;
		private var keyI:TouchSprite;
		private var keyU:TouchSprite;
		private var keyE:TouchSprite;
		private var keyO:TouchSprite;
		private var keyKa:TouchSprite;
		private var keyKi:TouchSprite;
		private var keyKu:TouchSprite;
		private var keyKe:TouchSprite;
		private var keyKo:TouchSprite;
		private var keySa:TouchSprite;
		private var keyShi:TouchSprite;
		private var keySu:TouchSprite;
		private var keySe:TouchSprite;
		private var keySo:TouchSprite;
		private var keyTa:TouchSprite;
		private var keyChi:TouchSprite;
		private var keyTsu:TouchSprite;
		private var keyTe:TouchSprite;
		private var keyTo:TouchSprite;
		private var keyNa:TouchSprite;
		private var keyNi:TouchSprite;
		private var keyNu:TouchSprite;
		private var keyNe:TouchSprite;
		private var keyNo:TouchSprite;
		private var keyHa:TouchSprite;
		private var keyHi:TouchSprite;
		private var keyFu:TouchSprite;
		private var keyHe:TouchSprite;
		private var keyHo:TouchSprite;
		private var keyMa:TouchSprite;
		private var keyMi:TouchSprite;
		private var keyMu:TouchSprite;
		private var keyMe:TouchSprite;
		private var keyMo:TouchSprite;
		private var keyYa:TouchSprite;  //Old key z
		private var	keyYi:TouchSprite;	//Start of new keys
		private var keyYu:TouchSprite;
		private var keyYe:TouchSprite;
		private var keyYo:TouchSprite;
		private var keyRa:TouchSprite;
		private var keyRi:TouchSprite;
		private var keyRu:TouchSprite;
		private var keyRe:TouchSprite;
		private var keyRo:TouchSprite;
		private var keyWa:TouchSprite;
		private var keyWo:TouchSprite;
		private var keyN:TouchSprite;
		
		private var keyCloseQuote:TouchSprite;
		private var keyComma:TouchSprite;
		private var keyQuestion:TouchSprite;
		private var keyMidPeriod:TouchSprite;
		private var keyCircle:TouchSprite;
		private var keyOpenQuote:TouchSprite;
		private var keyPeriod:TouchSprite;
		private var keyExclamation:TouchSprite;
		private var keyHyphen:TouchSprite;
		private var keyX:TouchSprite;
		
		private var keyShift:TouchSprite;
		private var keyKanaShift:TouchSprite;
		private var keyEnglishShift:TouchSprite;
		private var keyToEnglish:TouchSprite;
		private var keyBackspace:TouchSprite;
		private var keySpace:TouchSprite;
		
		
		private var inputTxt:TextField; 
		private var outputTxt:TextField;
		
		public function SoftKeyboardJpn(titleInput:TextField) {
			inputTxt = titleInput;
			createUI();
			commitUI();
			layoutUI();
		}
		
		public function toDefault():void{
			keyboardStates.gotoAndStop("hiragana");
		}
		
		public function set input(newInput:TextField):void{
			inputTxt = newInput;
			stage.focus = inputTxt;
		}
		
		override protected function createUI():void{
			keyboardStates = new KeyboardStatesJpn();
			outputTxt = new TextField();
			
			
			keyA = new TouchSprite();
			keyA.addChild(key_a);
			keyA.addEventListener(TouchEvent.TOUCH_UP, aUpHandler);
			keyA.addEventListener(TouchEvent.TOUCH_DOWN, aDownHandler);
			
			keyI = new TouchSprite();
			keyI.addChild(key_i);
			keyI.addEventListener(TouchEvent.TOUCH_UP, iUpHandler);
			keyI.addEventListener(TouchEvent.TOUCH_DOWN, iDownHandler);
			
			keyU = new TouchSprite();
			keyU.addChild(key_u);
			keyU.addEventListener(TouchEvent.TOUCH_UP, uUpHandler);
			keyU.addEventListener(TouchEvent.TOUCH_DOWN, uDownHandler);
			
			keyE = new TouchSprite();
			keyE.addChild(key_e);
			keyE.addEventListener(TouchEvent.TOUCH_UP, eUpHandler);
			keyE.addEventListener(TouchEvent.TOUCH_DOWN, eDownHandler);
			
			keyO = new TouchSprite();
			keyO.addChild(key_o);
			keyO.addEventListener(TouchEvent.TOUCH_UP, oUpHandler);
			keyO.addEventListener(TouchEvent.TOUCH_DOWN, oDownHandler);
			
			keyKa = new TouchSprite();
			keyKa.addChild(key_ka);
			keyKa.addEventListener(TouchEvent.TOUCH_UP, kaUpHandler);
			keyKa.addEventListener(TouchEvent.TOUCH_DOWN, kaDownHandler);
			
			keyKi = new TouchSprite();
			keyKi.addChild(key_ki);
			keyKi.addEventListener(TouchEvent.TOUCH_UP, kiUpHandler);
			keyKi.addEventListener(TouchEvent.TOUCH_DOWN, kiDownHandler);
			
			keyKu = new TouchSprite();
			keyKu.addChild(key_ku);
			keyKu.addEventListener(TouchEvent.TOUCH_UP, kuUpHandler);
			keyKu.addEventListener(TouchEvent.TOUCH_DOWN, kuDownHandler);
			
			keyKe = new TouchSprite();
			keyKe.addChild(key_ke);
			keyKe.addEventListener(TouchEvent.TOUCH_UP, keUpHandler);
			keyKe.addEventListener(TouchEvent.TOUCH_DOWN, keDownHandler);
			
			keyKo = new TouchSprite();
			keyKo.addChild(key_ko);
			keyKo.addEventListener(TouchEvent.TOUCH_UP, koUpHandler);
			keyKo.addEventListener(TouchEvent.TOUCH_DOWN, koDownHandler);
			
			keySa = new TouchSprite();
			keySa.addChild(key_sa);
			keySa.addEventListener(TouchEvent.TOUCH_UP, saUpHandler);
			keySa.addEventListener(TouchEvent.TOUCH_DOWN, saDownHandler);
			
			keyShi = new TouchSprite();
			keyShi.addChild(key_shi);
			keyShi.addEventListener(TouchEvent.TOUCH_UP, shiUpHandler);
			keyShi.addEventListener(TouchEvent.TOUCH_DOWN, shiDownHandler);
			
			keySu = new TouchSprite();
			keySu.addChild(key_su);
			keySu.addEventListener(TouchEvent.TOUCH_UP, suUpHandler);
			keySu.addEventListener(TouchEvent.TOUCH_DOWN, suDownHandler);
			
			keySe = new TouchSprite();
			keySe.addChild(key_se);
			keySe.addEventListener(TouchEvent.TOUCH_UP, seUpHandler);
			keySe.addEventListener(TouchEvent.TOUCH_DOWN, seDownHandler);
			
			keySo = new TouchSprite();
			keySo.addChild(key_so);
			keySo.addEventListener(TouchEvent.TOUCH_UP, soUpHandler);
			keySo.addEventListener(TouchEvent.TOUCH_DOWN, soDownHandler);
			
			keyTa = new TouchSprite();
			keyTa.addChild(key_ta);
			keyTa.addEventListener(TouchEvent.TOUCH_UP, taUpHandler);
			keyTa.addEventListener(TouchEvent.TOUCH_DOWN, taDownHandler);
			
			keyChi = new TouchSprite();
			keyChi.addChild(key_chi);
			keyChi.addEventListener(TouchEvent.TOUCH_UP, chiUpHandler);
			keyChi.addEventListener(TouchEvent.TOUCH_DOWN, chiDownHandler);
			
			keyTsu = new TouchSprite();
			keyTsu.addChild(key_tsu);
			keyTsu.addEventListener(TouchEvent.TOUCH_UP, tsuUpHandler);
			keyTsu.addEventListener(TouchEvent.TOUCH_DOWN, tsuDownHandler);
			
			keyTe = new TouchSprite();
			keyTe.addChild(key_te);
			keyTe.addEventListener(TouchEvent.TOUCH_UP, teUpHandler);
			keyTe.addEventListener(TouchEvent.TOUCH_DOWN, teDownHandler);
			
			keyTo = new TouchSprite();
			keyTo.addChild(key_to);
			keyTo.addEventListener(TouchEvent.TOUCH_UP, toUpHandler);
			keyTo.addEventListener(TouchEvent.TOUCH_DOWN, toDownHandler);
			
			keyNa = new TouchSprite();
			keyNa.addChild(key_na);
			keyNa.addEventListener(TouchEvent.TOUCH_UP, naUpHandler);
			keyNa.addEventListener(TouchEvent.TOUCH_DOWN, naDownHandler);
			
			keyNi = new TouchSprite();
			keyNi.addChild(key_ni);
			keyNi.addEventListener(TouchEvent.TOUCH_UP, niUpHandler);
			keyNi.addEventListener(TouchEvent.TOUCH_DOWN, niDownHandler);
			
			keyNu = new TouchSprite();
			keyNu.addChild(key_nu);
			keyNu.addEventListener(TouchEvent.TOUCH_UP, nuUpHandler);
			keyNu.addEventListener(TouchEvent.TOUCH_DOWN, nuDownHandler);
			
			keyNe = new TouchSprite();
			keyNe.addChild(key_ne);
			keyNe.addEventListener(TouchEvent.TOUCH_UP, neUpHandler);
			keyNe.addEventListener(TouchEvent.TOUCH_DOWN, neDownHandler);
			
			keyNo = new TouchSprite();
			keyNo.addChild(key_no);
			keyNo.addEventListener(TouchEvent.TOUCH_UP, noUpHandler);
			keyNo.addEventListener(TouchEvent.TOUCH_DOWN, noDownHandler);
			
			keyHa = new TouchSprite();
			keyHa.addChild(key_ha);
			keyHa.addEventListener(TouchEvent.TOUCH_UP, haUpHandler);
			keyHa.addEventListener(TouchEvent.TOUCH_DOWN, haDownHandler);
			
			keyHi = new TouchSprite();
			keyHi.addChild(key_hi);
			keyHi.addEventListener(TouchEvent.TOUCH_UP, hiUpHandler);
			keyHi.addEventListener(TouchEvent.TOUCH_DOWN, hiDownHandler);
			
			keyFu = new TouchSprite();
			keyFu.addChild(key_fu);
			keyFu.addEventListener(TouchEvent.TOUCH_UP, fuUpHandler);
			keyFu.addEventListener(TouchEvent.TOUCH_DOWN, fuDownHandler);
			
			keyHe = new TouchSprite();
			keyHe.addChild(key_he);
			keyHe.addEventListener(TouchEvent.TOUCH_UP, heUpHandler);
			keyHe.addEventListener(TouchEvent.TOUCH_DOWN, heDownHandler);
			
			keyHo = new TouchSprite();
			keyHo.addChild(key_ho);
			keyHo.addEventListener(TouchEvent.TOUCH_UP, hoUpHandler);
			keyHo.addEventListener(TouchEvent.TOUCH_DOWN, hoDownHandler);
			
			keyMa = new TouchSprite();
			keyMa.addChild(key_ma);
			keyMa.addEventListener(TouchEvent.TOUCH_UP, maUpHandler);
			keyMa.addEventListener(TouchEvent.TOUCH_DOWN, maDownHandler);
			
			keyMi = new TouchSprite();
			keyMi.addChild(key_mi);
			keyMi.addEventListener(TouchEvent.TOUCH_UP, miUpHandler);
			keyMi.addEventListener(TouchEvent.TOUCH_DOWN, miDownHandler);
			
			keyMu = new TouchSprite();
			keyMu.addChild(key_mu);
			keyMu.addEventListener(TouchEvent.TOUCH_UP, muUpHandler);
			keyMu.addEventListener(TouchEvent.TOUCH_DOWN, muDownHandler);
			
			keyMe = new TouchSprite();
			keyMe.addChild(key_me);
			keyMe.addEventListener(TouchEvent.TOUCH_UP, meUpHandler);
			keyMe.addEventListener(TouchEvent.TOUCH_DOWN, meDownHandler);
			
			keyMo = new TouchSprite();
			keyMo.addChild(key_mo);
			keyMo.addEventListener(TouchEvent.TOUCH_UP, moUpHandler);
			keyMo.addEventListener(TouchEvent.TOUCH_DOWN, moDownHandler);
			
			keyYa = new TouchSprite();
			keyYa.addChild(key_ya);
			keyYa.addEventListener(TouchEvent.TOUCH_UP, yaUpHandler);
			keyYa.addEventListener(TouchEvent.TOUCH_DOWN, yaDownHandler);
			
			keyYi = new TouchSprite();
			keyYi.addChild(key_yi);
			keyYi.addEventListener(TouchEvent.TOUCH_UP, yiUpHandler);
			keyYi.addEventListener(TouchEvent.TOUCH_DOWN, yiDownHandler);
			
			keyYu = new TouchSprite();
			keyYu.addChild(key_yu);
			keyYu.addEventListener(TouchEvent.TOUCH_UP, yuUpHandler);
			keyYu.addEventListener(TouchEvent.TOUCH_DOWN, yuDownHandler);
			
			keyYe = new TouchSprite();
			keyYe.addChild(key_ye);
			keyYe.addEventListener(TouchEvent.TOUCH_UP, yeUpHandler);
			keyYe.addEventListener(TouchEvent.TOUCH_DOWN, yeDownHandler);
			
			keyYo = new TouchSprite();
			keyYo.addChild(key_yo);
			keyYo.addEventListener(TouchEvent.TOUCH_UP, yoUpHandler);
			keyYo.addEventListener(TouchEvent.TOUCH_DOWN, yoDownHandler);
			
			keyRa = new TouchSprite();
			keyRa.addChild(key_ra);
			keyRa.addEventListener(TouchEvent.TOUCH_UP, raUpHandler);
			keyRa.addEventListener(TouchEvent.TOUCH_DOWN, raDownHandler);
			
			keyRi = new TouchSprite();
			keyRi.addChild(key_ri);
			keyRi.addEventListener(TouchEvent.TOUCH_UP, riUpHandler);
			keyRi.addEventListener(TouchEvent.TOUCH_DOWN, riDownHandler);
			
			keyRu = new TouchSprite();
			keyRu.addChild(key_ru);
			keyRu.addEventListener(TouchEvent.TOUCH_UP, ruUpHandler);
			keyRu.addEventListener(TouchEvent.TOUCH_DOWN, ruDownHandler);
			
			keyRe = new TouchSprite();
			keyRe.addChild(key_re);
			keyRe.addEventListener(TouchEvent.TOUCH_UP, reUpHandler);
			keyRe.addEventListener(TouchEvent.TOUCH_DOWN, reDownHandler);
			
			keyRo = new TouchSprite();
			keyRo.addChild(key_ro);
			keyRo.addEventListener(TouchEvent.TOUCH_UP, roUpHandler);
			keyRo.addEventListener(TouchEvent.TOUCH_DOWN, roDownHandler);
			
			keyWa = new TouchSprite();
			keyWa.addChild(key_wa);
			keyWa.addEventListener(TouchEvent.TOUCH_UP, waUpHandler);
			keyWa.addEventListener(TouchEvent.TOUCH_DOWN, waDownHandler);
			
			keyWo = new TouchSprite();
			keyWo.addChild(key_wo);
			keyWo.addEventListener(TouchEvent.TOUCH_UP, woUpHandler);
			keyWo.addEventListener(TouchEvent.TOUCH_DOWN, woDownHandler);
			
			keyN = new TouchSprite();
			keyN.addChild(key_n);
			keyN.addEventListener(TouchEvent.TOUCH_UP, nUpHandler);
			keyN.addEventListener(TouchEvent.TOUCH_DOWN, nDownHandler);
			
			keyCloseQuote = new TouchSprite();
			keyCloseQuote.addChild(key_closeQuote);
			keyCloseQuote.addEventListener(TouchEvent.TOUCH_UP, closeQuoteUpHandler);
			keyCloseQuote.addEventListener(TouchEvent.TOUCH_DOWN, closeQuoteDownHandler);
			
			keyComma = new TouchSprite();
			keyComma.addChild(key_comma);
			keyComma.addEventListener(TouchEvent.TOUCH_UP, commaUpHandler);
			keyComma.addEventListener(TouchEvent.TOUCH_DOWN, commaDownHandler);
			
			keyQuestion = new TouchSprite();
			keyQuestion.addChild(key_questn);
			keyQuestion.addEventListener(TouchEvent.TOUCH_UP, questionUpHandler);
			keyQuestion.addEventListener(TouchEvent.TOUCH_DOWN, questionDownHandler);
			
			keyMidPeriod = new TouchSprite();
			keyMidPeriod.addChild(key_midPd);
			keyMidPeriod.addEventListener(TouchEvent.TOUCH_UP, midPeriodUpHandler);
			keyMidPeriod.addEventListener(TouchEvent.TOUCH_DOWN, midPeriodDownHandler);
			
			keyCircle = new TouchSprite();
			keyCircle.addChild(key_O);
			keyCircle.addEventListener(TouchEvent.TOUCH_UP, circleUpHandler);
			keyCircle.addEventListener(TouchEvent.TOUCH_DOWN, circleDownHandler);
			
			keyOpenQuote = new TouchSprite();
			keyOpenQuote.addChild(key_openQuote);
			keyOpenQuote.addEventListener(TouchEvent.TOUCH_UP, openQuoteUpHandler);
			keyOpenQuote.addEventListener(TouchEvent.TOUCH_DOWN, openQuoteDownHandler);
			
			keyPeriod = new TouchSprite();
			keyPeriod.addChild(key_pd);
			keyPeriod.addEventListener(TouchEvent.TOUCH_UP, periodUpHandler);
			keyPeriod.addEventListener(TouchEvent.TOUCH_DOWN, periodDownHandler);
			
			keyExclamation = new TouchSprite();
			keyExclamation.addChild(key_exclam);
			keyExclamation.addEventListener(TouchEvent.TOUCH_UP, exclamationUpHandler);
			keyExclamation.addEventListener(TouchEvent.TOUCH_DOWN, exclamationDownHandler);
			
			keyHyphen = new TouchSprite();
			keyHyphen.addChild(key_hyphen);
			keyHyphen.addEventListener(TouchEvent.TOUCH_UP, hyphenUpHandler);
			keyHyphen.addEventListener(TouchEvent.TOUCH_DOWN, hyphenDownHandler);
			
			keyX = new TouchSprite();
			keyX.addChild(key_x);
			keyX.addEventListener(TouchEvent.TOUCH_UP, xUpHandler);
			keyX.addEventListener(TouchEvent.TOUCH_DOWN, xDownHandler);
			
			keyShift = new TouchSprite();
			keyShift.addChild(key_shift);
			keyShift.addEventListener(TouchEvent.TOUCH_UP, shiftUpHandler);
			keyShift.addEventListener(TouchEvent.TOUCH_DOWN, shiftDownHandler);
			
			keyKanaShift = new TouchSprite();
			keyKanaShift.addChild(key_kana);
			keyKanaShift.addEventListener(TouchEvent.TOUCH_UP, kanaShiftUpHandler);
			keyKanaShift.addEventListener(TouchEvent.TOUCH_DOWN, kanaShiftDownHandler);
			
			keyToEnglish = new TouchSprite();
			keyToEnglish.addChild(key_toEng);
			keyToEnglish.addEventListener(TouchEvent.TOUCH_UP, toEnglishUpHandler);
			keyToEnglish.addEventListener(TouchEvent.TOUCH_DOWN, toEnglishDownHandler);
			
			keyEnglishShift = new TouchSprite();
			keyEnglishShift.addChild(key_alphanum);
			keyEnglishShift.addEventListener(TouchEvent.TOUCH_UP, englishShiftUpHandler);
			keyEnglishShift.addEventListener(TouchEvent.TOUCH_DOWN, englishShiftDownHandler);
			
			keyBackspace = new TouchSprite();
			keyBackspace.addChild(key_backspace);
			keyBackspace.addEventListener(TouchEvent.TOUCH_UP, backspaceUpHandler);
			keyBackspace.addEventListener(TouchEvent.TOUCH_DOWN, backspaceDownHandler);
			
			keySpace = new TouchSprite();
			keySpace.addChild(key_space);
			keySpace.addEventListener(TouchEvent.TOUCH_UP, spaceUpHandler);
			keySpace.addEventListener(TouchEvent.TOUCH_DOWN, spaceDownHandler);
			
			addChild(outputTxt); 
			addChild(keyboardStates);
			addChildAt(keyA, 0);
			addChildAt(keyI, 0);
			addChildAt(keyU, 0);
			addChildAt(keyE, 0);
			addChildAt(keyO, 0);
			addChildAt(keyKa, 0);
			addChildAt(keyKi, 0);
			addChildAt(keyKu, 0);
			addChildAt(keyKe, 0);
			addChildAt(keyKo, 0);
			addChildAt(keySa, 0);
			addChildAt(keyShi, 0);
			addChildAt(keySu, 0);
			addChildAt(keySe, 0);
			addChildAt(keySo, 0);
			addChildAt(keyTa, 0);
			addChildAt(keyChi, 0);
			addChildAt(keyTsu, 0);
			addChildAt(keyTe, 0);
			addChildAt(keyTo, 0);
			addChildAt(keyNa, 0);
			addChildAt(keyNi, 0);
			addChildAt(keyNu, 0);
			addChildAt(keyNe, 0);
			addChildAt(keyNo, 0);
			addChildAt(keyHa, 0);
			addChildAt(keyHi, 0);
			addChildAt(keyFu, 0);
			addChildAt(keyHe, 0);
			addChildAt(keyHo, 0);
			addChildAt(keyMa, 0);
			addChildAt(keyMi, 0);
			addChildAt(keyMu, 0);
			addChildAt(keyMe, 0);
			addChildAt(keyMo, 0);
			addChildAt(keyYa, 0);
			addChildAt(keyYi, 0);
			addChildAt(keyYu, 0);
			addChildAt(keyYe, 0);
			addChildAt(keyYo, 0);
			addChildAt(keyRa, 0);
			addChildAt(keyRi, 0);
			addChildAt(keyRu, 0);
			addChildAt(keyRe, 0);
			addChildAt(keyRo, 0);
			addChildAt(keyWa, 0);
			addChildAt(keyWo, 0);
			addChildAt(keyN, 0);
			addChildAt(keyCloseQuote, 0);
			addChildAt(keyComma, 0);
			addChildAt(keyQuestion, 0);
			addChildAt(keyMidPeriod, 0);
			addChildAt(keyCircle, 0);
			addChildAt(keyOpenQuote, 0);
			addChildAt(keyPeriod, 0);
			addChildAt(keyExclamation, 0);
			addChildAt(keyHyphen, 0);
			addChildAt(keyX, 0);
			addChildAt(keyShift, 0);
			addChildAt(keyKanaShift, 0);
			addChildAt(keyEnglishShift, 0);
			addChildAt(keyToEnglish, 0);
			addChildAt(keyBackspace, 0);
			addChildAt(keySpace, 0);
			
			addEventListener("kana", switchToKana);
			addEventListener("english shift", switchToEnglish);
		}
		
		override protected function commitUI():void{
			key_wa.gotoAndStop("default");

			
			outputTxt.autoSize = TextFieldAutoSize.LEFT;
			
		}
		
		override protected function layoutUI():void{
			
			outputTxt.y = -20;
			
			keyYi.visible = false;
			keyYe.visible = false;
		}
		
		
		
		private function aDownHandler(e:TouchEvent):void{
			key_a.gotoAndStop("pressed");
		}
		
		private function aUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("あ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぁ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ア");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ァ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ａ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ａ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_a.gotoAndStop("default");
					;
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
				case "hiragana":
					inputTxt.appendText("い");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぃ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("イ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ィ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｂ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｂ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_i.gotoAndStop("default");
					;
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
				case "hiragana":
					inputTxt.appendText("う");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぅ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ウ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ゥ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｃ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｃ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_u.gotoAndStop("default");
					;
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
				case "hiragana":
					inputTxt.appendText("え");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぇ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("エ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ェ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｄ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｄ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_e.gotoAndStop("default");
					;
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
				case "hiragana":
					inputTxt.appendText("お");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぉ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("オ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ォ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｅ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｅ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_o.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function kaDownHandler(e:TouchEvent):void{
			key_ka.gotoAndStop("pressed");
		}
		
		private function kaUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("か");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ka.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("が");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ka.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("カ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ka.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ガ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ka.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｆ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ka.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｆ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ka.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function kiDownHandler(e:TouchEvent):void{
			key_ki.gotoAndStop("pressed");
		}
		
		private function kiUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("き");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ki.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぎ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ki.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("キ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ki.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ギ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ki.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｇ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ki.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｇ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ki.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function kuDownHandler(e:TouchEvent):void{
			key_ku.gotoAndStop("pressed");
		}
		
		private function kuUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("く");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ku.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぐ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ku.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ク");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ku.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("グ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ku.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｈ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ku.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｈ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ku.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function keDownHandler(e:TouchEvent):void{
			key_ke.gotoAndStop("pressed");
		}
		
		private function keUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("け");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ke.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("げ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ke.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ケ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ke.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ゲ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ke.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｉ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ke.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｉ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ke.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function koDownHandler(e:TouchEvent):void{
			key_ko.gotoAndStop("pressed");
		}
		
		private function koUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("こ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ko.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ご");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ko.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("コ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ko.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ゴ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ko.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｊ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ko.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｊ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ko.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function saDownHandler(e:TouchEvent):void{
			key_sa.gotoAndStop("pressed");
		}
		
		private function saUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("さ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_sa.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ざ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_sa.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("サ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_sa.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ザ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_sa.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｋ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_sa.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｋ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_sa.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function shiDownHandler(e:TouchEvent):void{
			key_shi.gotoAndStop("pressed");
		}
		
		private function shiUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("し");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_shi.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("じ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_shi.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("シ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_shi.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ジ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_shi.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｌ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_shi.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｌ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_shi.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function suDownHandler(e:TouchEvent):void{
			key_su.gotoAndStop("pressed");
		}
		
		private function suUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("す");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_su.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ず");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_su.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ス");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_su.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ズ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_su.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｍ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_su.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｍ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_su.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function seDownHandler(e:TouchEvent):void{
			key_se.gotoAndStop("pressed");
		}
		
		private function seUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("せ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_se.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぜ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_se.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("セ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_se.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ゼ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_se.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｎ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_se.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｎ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_se.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function soDownHandler(e:TouchEvent):void{
			key_so.gotoAndStop("pressed");
		}
		
		private function soUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("そ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_so.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぞ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_so.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ソ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_so.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ゾ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_so.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｏ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_so.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｏ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_so.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function taDownHandler(e:TouchEvent):void{
			key_ta.gotoAndStop("pressed");
		}
		
		private function taUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("た");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ta.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("だ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ta.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("タ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ta.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ダ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ta.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｐ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ta.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｐ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ta.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function chiDownHandler(e:TouchEvent):void{
			key_chi.gotoAndStop("pressed");
		}
		
		private function chiUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ち");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_chi.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぢ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_chi.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("チ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_chi.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ヂ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_chi.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｑ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_chi.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｑ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_chi.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function tsuDownHandler(e:TouchEvent):void{
			key_tsu.gotoAndStop("pressed");
		}
		
		private function tsuUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("つ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_tsu.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("づ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_tsu.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ツ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_tsu.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ヅ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_tsu.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｒ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_tsu.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｒ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_tsu.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function teDownHandler(e:TouchEvent):void{
			key_te.gotoAndStop("pressed");
		}
		
		private function teUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("て");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_te.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("で");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_te.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("テ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_te.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("デ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_te.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｓ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_te.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｓ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_te.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function toDownHandler(e:TouchEvent):void{
			key_to.gotoAndStop("pressed");
		}
		
		private function toUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("と");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_to.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ど");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_to.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ト");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_to.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ド");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_to.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｔ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_to.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｔ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_to.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function naDownHandler(e:TouchEvent):void{
			key_na.gotoAndStop("pressed");
		}
		
		private function naUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("な");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_na.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ナ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_na.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｕ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_na.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｕ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_na.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function niDownHandler(e:TouchEvent):void{
			key_ni.gotoAndStop("pressed");
		}
		
		private function niUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("に");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ni.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ニ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ni.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｖ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ni.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｖ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ni.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function nuDownHandler(e:TouchEvent):void{
			key_nu.gotoAndStop("pressed");
		}
		
		private function nuUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ぬ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_nu.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("っ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_nu.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ヌ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_nu.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ッ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_nu.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｗ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_nu.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｗ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_nu.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function neDownHandler(e:TouchEvent):void{
			key_ne.gotoAndStop("pressed");
		}
		
		private function neUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ね");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ne.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ネ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ne.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｘ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ne.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｘ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ne.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function noDownHandler(e:TouchEvent):void{
			key_no.gotoAndStop("pressed");
		}
		
		private function noUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("の");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_no.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ノ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_no.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｙ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_no.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｙ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_no.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function haDownHandler(e:TouchEvent):void{
			key_ha.gotoAndStop("pressed");
		}
		
		private function haUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("は");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ha.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ば");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ha.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ハ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ha.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("バ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ha.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("ｚ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ha.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("Ｚ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ha.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function hiDownHandler(e:TouchEvent):void{
			key_hi.gotoAndStop("pressed");
		}
		
		private function hiUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ひ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_hi.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("び");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_hi.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ヒ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_hi.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ビ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_hi.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function fuDownHandler(e:TouchEvent):void{
			key_fu.gotoAndStop("pressed");
		}
		
		private function fuUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ふ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_fu.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぶ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_fu.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("フ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_fu.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ブ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_fu.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function heDownHandler(e:TouchEvent):void{
			key_he.gotoAndStop("pressed");
		}
		
		private function heUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("へ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_he.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("べ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_he.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ヘ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_he.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ベ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_he.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function hoDownHandler(e:TouchEvent):void{
			key_ho.gotoAndStop("pressed");
		}
		
		private function hoUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ほ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ho.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぼ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ho.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ホ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ho.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ボ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ho.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function maDownHandler(e:TouchEvent):void{
			key_ma.gotoAndStop("pressed");
		}
		
		private function maUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ま");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ma.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぱ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ma.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("マ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ma.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("パ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ma.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function miDownHandler(e:TouchEvent):void{
			key_mi.gotoAndStop("pressed");
		}
		
		private function miUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("み");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mi.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぴ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mi.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ミ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mi.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ピ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mi.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function muDownHandler(e:TouchEvent):void{
			key_mu.gotoAndStop("pressed");
		}
		
		private function muUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("む");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mu.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぷ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mu.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ム");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mu.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("プ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mu.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function meDownHandler(e:TouchEvent):void{
			key_me.gotoAndStop("pressed");
		}
		
		private function meUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("め");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_me.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぺ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_me.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("メ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_me.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ペ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_me.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function moDownHandler(e:TouchEvent):void{
			key_mo.gotoAndStop("pressed");
		}
		
		private function moUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("も");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mo.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ぽ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mo.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("モ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mo.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ポ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_mo.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function yaDownHandler(e:TouchEvent):void{
			key_ya.gotoAndStop("pressed");
		}
		
		private function yaUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("や");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ya.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ゃ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ya.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ヤ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ya.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ャ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ya.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("1");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ya.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("1");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ya.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function yiDownHandler(e:TouchEvent):void{
			key_yi.gotoAndStop("pressed");
		}
		
		private function yiUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "alphanum_lc":
					inputTxt.appendText("2");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yi.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("2");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yi.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function yuDownHandler(e:TouchEvent):void{
			key_yu.gotoAndStop("pressed");
		}
		
		private function yuUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ゆ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yu.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ゅ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yu.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ユ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yu.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ュ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yu.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("3");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yu.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("3");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yu.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function yeDownHandler(e:TouchEvent):void{
			key_ye.gotoAndStop("pressed");
		}
		
		private function yeUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "alphanum_lc":
					inputTxt.appendText("4");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ye.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("4");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ye.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function yoDownHandler(e:TouchEvent):void{
			key_yo.gotoAndStop("pressed");
		}
		
		private function yoUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("よ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					break;
				case "hg_shift":
					inputTxt.appendText("ょ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					keyboardStates.gotoAndStop("hiragana");
					break;
				case "katakana":
					inputTxt.appendText("ヨ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					break;
				case "kk_shift":
					inputTxt.appendText("ョ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					keyboardStates.gotoAndStop("katakana");
					break;
				case "alphanum_lc":
					inputTxt.appendText("5");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("5");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}


		private function raDownHandler(e:TouchEvent):void{
			key_ra.gotoAndStop("pressed");
		}
		
		private function raUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ら");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ra.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ラ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ra.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("6");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ra.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("6");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ra.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function riDownHandler(e:TouchEvent):void{
			key_ri.gotoAndStop("pressed");
		}
		
		private function riUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("り");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ri.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("リ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ri.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("7");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ri.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("7");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ri.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function ruDownHandler(e:TouchEvent):void{
			key_ru.gotoAndStop("pressed");
		}
		
		private function ruUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("る");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ru.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ル");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ru.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("8");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ru.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("8");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ru.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function reDownHandler(e:TouchEvent):void{
			key_re.gotoAndStop("pressed");
		}
		
		private function reUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("れ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_re.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("レ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_re.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("9");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_re.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("9");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_yo.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function roDownHandler(e:TouchEvent):void{
			key_ro.gotoAndStop("pressed");
		}
		
		private function roUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("ろ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ro.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ロ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ro.gotoAndStop("default");
					break;
				case "alphanum_lc":
					inputTxt.appendText("0");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ro.gotoAndStop("default");
					break;
				case "alphanum_uc":
					inputTxt.appendText("0");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_ro.gotoAndStop("default");
					;
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function waDownHandler(e:TouchEvent):void{
			key_wa.gotoAndStop("pressed");
		}
		
		private function waUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("わ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_wa.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ワ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_wa.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}

		
		private function woDownHandler(e:TouchEvent):void{
			key_wo.gotoAndStop("pressed");
		}
		
		private function woUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					inputTxt.appendText("を");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_wo.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ヲ");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_wo.gotoAndStop("default");
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
				case "hiragana":
					inputTxt.appendText("ん");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_n.gotoAndStop("default");
					break;
				case "katakana":
					inputTxt.appendText("ン");
					inputTxt.setSelection(inputTxt.length, inputTxt.length);
					key_n.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function closeQuoteDownHandler(e:TouchEvent):void{
			key_closeQuote.gotoAndStop("pressed");
		}
		
		private function closeQuoteUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("」");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_closeQuote.gotoAndStop("default");
		}
		
		
		private function commaDownHandler(e:TouchEvent):void{
			key_comma.gotoAndStop("pressed");
		}
		
		private function commaUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("、");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_comma.gotoAndStop("default");
		}
		
		
		private function questionDownHandler(e:TouchEvent):void{
			key_questn.gotoAndStop("pressed");
		}
		
		private function questionUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("？");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_questn.gotoAndStop("default");
		}
		
		
		private function midPeriodDownHandler(e:TouchEvent):void{
			key_midPd.gotoAndStop("pressed");
		}
		
		private function midPeriodUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("・");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_midPd.gotoAndStop("default");
		}
		
		
		private function circleDownHandler(e:TouchEvent):void{
			key_O.gotoAndStop("pressed");
		}
		
		private function circleUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("○");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_O.gotoAndStop("default");
		}
		
		
		private function　openQuoteDownHandler(e:TouchEvent):void{
			key_openQuote.gotoAndStop("pressed");
		}
		
		private function openQuoteUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("「");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_openQuote.gotoAndStop("default");
		}
		
		
		private function periodDownHandler(e:TouchEvent):void{
			key_pd.gotoAndStop("pressed");
		}
		
		private function periodUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("。");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_pd.gotoAndStop("default");
		}
		
		
		private function exclamationDownHandler(e:TouchEvent):void{
			key_exclam.gotoAndStop("pressed");
		}
		
		private function exclamationUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("！");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_exclam.gotoAndStop("default");
		}
		
		
		private function hyphenDownHandler(e:TouchEvent):void{
			key_hyphen.gotoAndStop("pressed");
		}
		
		private function hyphenUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("ー");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_hyphen.gotoAndStop("default");
		}
		
		
		private function xDownHandler(e:TouchEvent):void{
			key_x.gotoAndStop("pressed");
		}
		
		private function xUpHandler(e:TouchEvent):void {
			stage.focus = inputTxt;
			inputTxt.appendText("×");
			inputTxt.setSelection(inputTxt.length, inputTxt.length);
			key_x.gotoAndStop("default");
		}
		
		
		private function shiftDownHandler(e:TouchEvent):void{
			key_shift.gotoAndStop("pressed");
		}
		
		private function shiftUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					keyboardStates.gotoAndStop("hg_shift");
					key_shift.gotoAndStop("default");
					
					keyNa.visible = false;
					keyNi.visible = false;
					keyNe.visible = false;
					keyNo.visible = false;
					keyRa.visible = false;
					keyRi.visible = false;
					keyRu.visible = false;
					keyRe.visible = false;
					keyRo.visible = false;
					keyWa.visible = false;
					keyWo.visible = false;
					keyN.visible = false;
					break;
				case "hg_shift":
					keyboardStates.gotoAndStop("hiragana");
					key_shift.gotoAndStop("default");

					break;
				case "katakana":
					keyboardStates.gotoAndStop("kk_shift");
					key_shift.gotoAndStop("default");
					
					keyNa.visible = false;
					keyNi.visible = false;
					keyNe.visible = false;
					keyNo.visible = false;
					keyRa.visible = false;
					keyRi.visible = false;
					keyRu.visible = false;
					keyRe.visible = false;
					keyRo.visible = false;
					keyWa.visible = false;
					keyWo.visible = false;
					keyN.visible = false;
					break;
				case "kk_shift":
					keyboardStates.gotoAndStop("katakana");
					key_shift.gotoAndStop("default");
					break;
				case "alphanum_lc":
					keyboardStates.gotoAndStop("alphanum_uc");
					key_shift.gotoAndStop("default");
					break;
				case "alphanum_uc":
					keyboardStates.gotoAndStop("alphanum_lc");
					key_shift.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
		}
		
		
		private function kanaShiftDownHandler(e:TouchEvent):void{
			key_kana.gotoAndStop("pressed");
		}
		
		private function kanaShiftUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "hiragana":
					keyboardStates.gotoAndStop("katakana");
					key_kana.gotoAndStop("default");
					break;
				case "hg_shift":
					keyboardStates.gotoAndStop("katakana");
					key_kana.gotoAndStop("default");
					break;
				case "katakana":
					keyboardStates.gotoAndStop("hiragana");
					key_kana.gotoAndStop("default");
					break;
				case "kk_shift":
					keyboardStates.gotoAndStop("hiragana");
					key_kana.gotoAndStop("default");
					break;
				case "alphanum_lc":
					keyboardStates.gotoAndStop("hiragana");
					key_kana.gotoAndStop("default");
					break;
				case "alphanum_uc":
					keyboardStates.gotoAndStop("hiragana");
					key_kana.gotoAndStop("default");
					break;
				default:
					trace("Keyboard state was not an expected value: " + keyboardStates.currentLabel);
			}
			keyEnglishShift.visible = true;
			keyYi.visible = false;
			keyYe.visible = false;
			
			keyHi.visible = true;
			keyFu.visible = true;
			keyHe.visible = true;
			keyHo.visible = true;
			keyMa.visible = true;
			keyMi.visible = true;
			keyMu.visible = true;
			keyMe.visible = true;
			keyMo.visible = true;
			keyWa.visible = true;
			keyWo.visible = true;
			keyN.visible = true;
			
			
		}
		
		
		private function englishShiftDownHandler(e:TouchEvent):void{
			key_alphanum.gotoAndStop("pressed");
		}
		
		private function englishShiftUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			switch(keyboardStates.currentLabel){
				case "alphanum_lc":
					keyboardStates.gotoAndStop("katakana");
					key_alphanum.gotoAndStop("default");
					keyHi.visible = true;
					keyFu.visible = true;
					keyHe.visible = true;
					keyHo.visible = true;
					keyMa.visible = true;
					keyMi.visible = true;
					keyMu.visible = true;
					keyMe.visible = true;
					keyMo.visible = true;
					keyYi.visible = false;
					keyYe.visible = false;
					break;
				case "alphanum_uc":
					keyboardStates.gotoAndStop("katakana");
					key_alphanum.gotoAndStop("default");
					keyHi.visible = true;
					keyFu.visible = true;
					keyHe.visible = true;
					keyHo.visible = true;
					keyMa.visible = true;
					keyMi.visible = true;
					keyMu.visible = true;
					keyMe.visible = true;
					keyMo.visible = true;
					keyYi.visible = false;
					keyYe.visible = false;
					break;
				default:
					keyboardStates.gotoAndStop("alphanum_uc");
					key_alphanum.gotoAndStop("default");
					keyYi.visible = true;
					keyYe.visible = true;
					
					keyHi.visible = false;
					keyFu.visible = false;
					keyHe.visible = false;
					keyHo.visible = false;
					keyMa.visible = false;
					keyMi.visible = false;
					keyMu.visible = false;
					keyMe.visible = false;
					keyMo.visible = false;
					keyWa.visible = false;
					keyWo.visible = false;
					keyN.visible = false;
					
					keyNa.visible = true;
					keyNi.visible = true;
					keyNe.visible = true;
					keyNo.visible = true;
					keyRa.visible = true;
					keyRi.visible = true;
					keyRu.visible = true;
					keyRe.visible = true;
					keyRo.visible = true;
			}
		}
		
		private function toEnglishDownHandler(e:TouchEvent):void{
			key_toEng.gotoAndStop("pressed");
		}
		
		private function toEnglishUpHandler(e:TouchEvent):void{
			stage.focus = inputTxt;
			dispatchEvent(new Event("japanese to english", true));
			keyHi.visible = true;
			keyFu.visible = true;
			keyHe.visible = true;
			keyHo.visible = true;
			keyMa.visible = true;
			keyMi.visible = true;
			keyMu.visible = true;
			keyMe.visible = true;
			keyMo.visible = true;
			keyYi.visible = false;
			keyYe.visible = false;
			key_toEng.gotoAndStop("default");
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
		
		private function switchToKana(e:Event):void{
			keyNa.visible = true;
			keyNi.visible = true;
			keyNe.visible = true;
			keyNo.visible = true;
			keyRa.visible = true;
			keyRi.visible = true;
			keyRu.visible = true;
			keyRe.visible = true;
			keyRo.visible = true;
			keyWa.visible = true;
			keyWo.visible = true;
			keyN.visible = true;
		}
		
		private function switchToEnglish(e:Event):void{
			keyNa.visible = true;
			keyNi.visible = true;
			keyNe.visible = true;
			keyNo.visible = true;
			keyRa.visible = true;
			keyRi.visible = true;
			keyRu.visible = true;
			keyRe.visible = true;
			keyRo.visible = true;
		}
	}
}