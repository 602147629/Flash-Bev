/////////////////////////////////////////////////////////////////////////////////////////////
//
//	Copyright (c) 2013 SuperMap. All Rights Reserved.
//
//	Licensed under the Apache License, Version 2.0 (the "License");
//	you may not use this file except in compliance with the License.
//	You may obtain a copy of the License at
//
//	http://www.apache.org/licenses/LICENSE-2.0
//
//	Unless required by applicable law or agreed to in writing, software
//	distributed under the License is distributed on an  "AS IS" BASIS,
//	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//	See the License for the specific language governing permissions and
//	limitations under the License.
//
///////////////////////////////////////////////////////////////////////////////////////////// 
package com.supermap.containers
{
	import com.supermap.web.components.FeatureDataGrid;
	import com.supermap.web.mapping.FeaturesLayer;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import mx.controls.listClasses.ListBaseContentHolder;
	import mx.core.FlexShape;
	
	//-------------------------------------------------------------------------
	//	Styles
	//-------------------------------------------------------------------------
	[Style(name="oddRowColor",type="uint",format="Color",inherit="no")]
	[Style(name="evenRowColor",type="uint",format="Color",inherit="no")]
	[Style(name="oddRowAlpha",type="number",format="Alpha")]
	[Style(name="evenRowAlpha",type="number",format="Alpha")]

	public class CustomFeatureDataGrid extends FeatureDataGrid
	{
		/**
		 *  奇数行颜色
		 */
		private var _oddRowColor:uint;
		/**
		 *  偶数行颜色
		 */
		private var _evenRowColor:uint;
		//------------------------------------------------------------------------
		//
		//  扩展接口
		//
		//------------------------------------------------------------------------
		/**
		 *  奇数行透明度默认值为1
		 */
		private var _oddRowAlpha:Number = 1; 
		/**
		 *  偶数行透明度默认值为1
		 */
		private var _evenRowAlpha:Number = 1;		
		
		private var oddRowColorChanged:Boolean = false;
		private var evenRowColorChanged:Boolean = false;
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function CustomFeatureDataGrid(featuresLayer:FeaturesLayer=null, features:Array=null, parentContainer:DisplayObject=null)
		{
			super(featuresLayer, features, parentContainer);
		}
		
		public function get evenRowAlpha():Number
		{
			return _evenRowAlpha;
		}

		public function set evenRowAlpha(value:Number):void
		{
			if(_evenRowAlpha != value)
			{
				_evenRowAlpha = value;
				super.invalidateDisplayList();
			}
		}

		public function get oddRowAlpha():Number
		{
			return _oddRowAlpha;
		}

		public function set oddRowAlpha(value:Number):void
		{
			if(_oddRowAlpha != value)
			{
				_oddRowAlpha = value;
				super.invalidateDisplayList();
			}			
		}

		public function get evenRowColor():uint
		{
			return _evenRowColor;
		}
		
		public function set evenRowColor(value:uint):void
		{			
			if(value && _evenRowColor != value)
			{
				evenRowColorChanged = true;
				_evenRowColor = value;
				super.invalidateDisplayList();
			}
		}
		
		public function get oddRowColor():uint
		{
			return _oddRowColor;
		}
		
		public function set oddRowColor(value:uint):void
		{
			if(value && _oddRowColor != value)
			{
				oddRowColorChanged = true;
				_oddRowColor = value;
				super.invalidateDisplayList();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Overridden Methods
		//
		//--------------------------------------------------------------------------
		override protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void
		{
			var contentHolder:ListBaseContentHolder = ListBaseContentHolder(s.parent);
			
			var background:Shape;
			if (rowIndex < s.numChildren)
			{
				background = Shape(s.getChildAt(rowIndex));
			}
			else
			{
				background = new FlexShape();
				background.name = "background";
				s.addChild(background);
			}
			
			background.y = y;

			var height:Number = Math.min(height,
				contentHolder.height -
				y);
			
			var g:Graphics = background.graphics;
			g.clear();
			
			if(_evenRowColor)//如果偶数行颜色修改
			{
				if(dataIndex%2 == 0)
				{
					color = _evenRowColor;
					if(_evenRowAlpha)
						g.beginFill(color, _evenRowAlpha);
					else
						g.beginFill(color, getStyle("backgroundAlpha"));
				}
			}			
			else
			{
				g.beginFill(color, getStyle("backgroundAlpha"));
			}
			
			if(_oddRowColor)//如果奇数行颜色修改
			{
				if(dataIndex%2 != 0)
				{
					color = _oddRowColor;
					if(_oddRowAlpha)
						g.beginFill(color, _oddRowAlpha);
					else
						g.beginFill(color, getStyle("backgroundAlpha"));
				}
			}
			else
			{
				g.beginFill(color, getStyle("backgroundAlpha"));
			}
			g.drawRect(0, 0, contentHolder.width, height);
			g.endFill();			
		}
		
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			if(evenRowColorChanged)
			{
				_evenRowColor = getStyle("evenRowColor");
				evenRowColorChanged = false;
			}
			else
			{
				_evenRowColor = getStyle("evenRowColor");
			}
			if(oddRowColorChanged)
			{
				_oddRowColor = getStyle("oddRowColor");
				oddRowColorChanged = false;
			}
			else
			{
				_oddRowColor = getStyle("oddRowColor");
			}
			
			_oddRowAlpha = getStyle("oddRowAlpha");
			_evenRowAlpha = getStyle("evenRowAlpha");

			super.invalidateDisplayList();			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			invalidateList();//强制刷新...
		}
		
		public var listeners:Array = [];
		public override function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakPeference:Boolean = false):void
		{
			if (listener!=null)
			{
				listeners.push({ theType: type, theListener: listener });
			}
			super.addEventListener(type, listener, useCapture, priority, useWeakPeference);
		}
		
		public function removeDoubleClickListener():void
		{
			var listenersLen:int = listeners.length;
			for (var i:int = 0; i < listenersLen; i++)
			{
				if(listeners[i]["theType"] == MouseEvent.DOUBLE_CLICK)
				{
				 	removeEventListener(listeners[i]["theType"], listeners[i]["theListener"]);
					break;
				}
			}
			//这里也要对 linsteners数组进行处理......
		}
	}	
}