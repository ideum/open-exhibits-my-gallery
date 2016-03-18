////////////////////////////////////////////////////////////////////////////////
//
//  IDEUM
//  Copyright 2010-2011 Ideum
//  All Rights Reserved.
//
//  GestureWorks
//
//  File:     TouchMovieClip.as
//  Author:   Matthew Valverde (matthew(at)ideum(dot)com)
//
//  NOTICE: Ideum permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package
{
	import id.core.TouchComponent;
	import flash.display.MovieClip;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.display.BlendMode;

	/**
	 * The TextDisplay class.
	 * 
	 * <p><b>Properties:</b></p>
	 * <pre>
	 * styleList={fontColor:0x000000,fontSize:15}
	 * appendText="false"
	 * multilined="true"
	 * textWidth=100</pre>
	 * 
	 * 
	 */
	public class TextDisplay extends TouchComponent
	{
		/**
		 * @private
		 */
		public var txt:TextField;
		private var _initialized:Boolean;
		private var textFormat:TextFormat;
		private var font:Font;
		private var _textWidth:Number=100;
		private var _width:Number=0;
		private var _height:Number=0;
		private var _text:String="";
		private var _appendText:Boolean;
		private var _styleList:String;
		private var _multilined:Boolean=true;
		
		/**
		 * <pre>Default style for the TextDisplay class.</pre>
		 * 
		 */
		private var _style:Object={fontColor:0x000000,fontSize:15};


		/**
		 * <pre>Main public function. 
		 * Constructor.</pre>
		 */
		public function TextDisplay()
		{
			super();

			createUI();
			commitUI();
			layoutUI();
			updateUI();
			
			_initialized=true;
		}
		
		/**
		 * <pre>The Dipsose function for the TextDisplay class.</pre>
		 */
		override public function Dispose():void
		{
			if (parent)
			{
				parent.removeChild(this);
			}
		}

		/**
		 * @private
		 */
		public override function get width():Number
		{
			return _width;
		}
		/**
		 * @private
		 */
		public override function set width(value:Number):void
		{
			_width=value;
			layoutUI();
		}
		/**
		 * @private
		 */
		public override function get height():Number
		{
			return _height;
		}
		/**
		 * @private
		 */
		public override function set height(value:Number):void
		{
			_height=value;
			layoutUI();
		}

		
		public function get multilined():Boolean
		{
			return _multilined;
		}
		/**
		 * 
		 * <pre>Sets the text field to multilined or single lined.</pre>
		 * 
		 * @default : mutlined = true;
		 */
		public function set multilined(value:Boolean):void
		{
			_multilined=value;
			updateUI();
		}

		/**
		 * <pre>Call style object for TextDisplay class.</pre>
		 */
		public function get styleList():Object
		{
			return _style;
		}
		
		/**
		 * <pre>Set style object for TextDisplay class.</pre>
		 */
		public function set styleList(value:Object):void
		{
			if (value.fontColor!=undefined&&value.fontColor!="")
			{
				_style.fontColor=value.fontColor;
			}

			if (value.fontSize!=undefined&&value.fontSize!="")
			{
				_style.fontSize=value.fontSize;
			}

			layoutUI();
		}

		
		public function get textWidth():Number
		{
			return _textWidth;
		}
		/**
		 * <pre>Set text width to a certain width.</pre>
		 *
		 * @default : textWidth = 100;
		 */
		public function set textWidth(value:Number):void
		{
			_textWidth=value;
			updateUI();
		}
		/**
		 * <pre>Set text for text field.</pre>
		 */
		public function set text(value:String):void
		{
			_text=value;
			//trace(_text);
			updateUI();
		}

		/**
		 * <pre>Choose weather to Append text or not.</pre>
		 */
		public function set appendText(value:Boolean):void
		{
			_appendText=value;
		}

		/**
		 * <pre>Sets color of Text.</pre>
		 *
		 * @default : color = 0x000000;
		 */
		public function set color(value:uint):void
		{
			_style.fontColor=value;
			updateUI();
		}

		/**
		 * <pre>Sets size of Text.</pre>
		 * @default : size = 15;
		 */
		public function set size(value:Number):void
		{
			_style.fontSize=value;
			layoutUI();
		}

		/**
		 * @private
		 */
		override protected function createUI():void
		{
			textFormat=new TextFormat();
			txt=new TextField();
			addChild(txt);
		}

		/**
		 * @private
		 */
		override protected function commitUI():void
		{
			textFormat.font="Arial";
			textFormat.align=TextFormatAlign.LEFT;
			textFormat.color=_style.fontColor;
			textFormat.size=_style.fontSize;

			//txt.embedFonts=true;
			txt.defaultTextFormat=textFormat;
			txt.antiAliasType=AntiAliasType.ADVANCED;

			txt.blendMode=BlendMode.LAYER;
			txt.selectable=false;
		}

		/**
		 * @private
		 */
		override protected function layoutUI():void
		{
		}

		/**
		 * Update function call changes color, size and width.
		 */
		override protected function updateUI():void
		{
			//trace(_style.fontColor);
			//trace(_style.fontSize);
			textFormat.color=_style.fontColor;
			textFormat.size=_style.fontSize;
			txt.defaultTextFormat=textFormat;

			if (_multilined)
			{
				txt.multiline=true;
				txt.wordWrap=true;
			}
			else
			{
				txt.multiline=false;
				txt.wordWrap=false;
			}

			if (_appendText)
			{
				txt.appendText(_text);
			}
			else
			{
				txt.text=_text;
				//trace(txt.text);
			}

			//txt.width=txt.textWidth;

			if (_textWidth!=100)
			{
				txt.width=_textWidth;
			}

			_textWidth=txt.width;

			_width=txt.textWidth;

			_height=txt.textHeight;

			//txt.width=txt.textWidth;

			txt.autoSize=TextFieldAutoSize.LEFT;
		}
	}
}