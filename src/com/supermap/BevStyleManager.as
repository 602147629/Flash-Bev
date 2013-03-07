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
package com.supermap
{
	import com.supermap.skins.customSkins.drawBtnSkin;
	import com.supermap.events.*;
	import com.supermap.framework.events.BaseEventDispatcher;
	import com.supermap.framework.skins.scrollBarSkins.Scroller_skin;
	import com.supermap.skins.customSkins.MapPanelSkin;

	import flash.events.EventDispatcher;
	
	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	public class BevStyleManager extends EventDispatcher
	{		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//---------------------------------------------------------------------------
		private var _styleObj:Object;
		
		private var _backgroundColor:uint;
		private var _rolloverColor:uint;
		private var _uniqueFillColor:uint;
		private var _highLightColor1:uint;
		private var _highLightColor2:uint;
		private var _textColor:uint;
		
		private var backgroundColorChanged:Boolean = false;
		private var rolloverColorChanged:Boolean = false;
		private var uniqueFillColorChanged:Boolean = false;
		private var highLightColor1Changed:Boolean = false;
		private var highLightColor2Changed:Boolean = false;
		private var textColorChanged:Boolean = false;		
		
		private var selectionColor:uint;
		
		private var _backgroundAlpha:Number = 1;		
		private var _rolloverAlpha:Number = 1;
		private var _selectionAlpha:Number = 1;
		private var _uniqueFillAlpha:Number = 1;
		
		private var backgroundAlphaChanged:Boolean = false;
		private var rolloverAlphaChanged:Boolean = false;
		private var selectionAlphaChanged:Boolean = false;
		private var uniqueFillAlphaChanged:Boolean = false;			
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function BevStyleManager(obj:Object = null)
		{
//			ViewerEventDispatcher.addEventListener(DivideBoxEvent.DIVIDEBOX_STYLE_CHANGE, getDivideBoxStyleHandler);
			BaseEventDispatcher.getInstance().addEventListener(DataConfigEvent.STYLE_LOAD, setStyleHandler);			
		}

		
		public function get rolloverColor():uint
		{
			return _rolloverColor;
		}

		public function set rolloverColor(value:uint):void
		{
			if(_rolloverColor != value)
			{
				_rolloverColor = value;
				rolloverColorChanged = true;
			}
		}

		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{			
			if(_backgroundColor != value)
			{
				_backgroundColor = value;
				backgroundColorChanged = true;
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		private function setStyleHandler(event:DataConfigEvent):void
		{
			var obj:Object = event.data;
			if(obj)
			{
				var styleColors:Array = obj.aryColors as Array;
				var styleAlphas:Array = obj.aryAlphas as Array;
				if(styleColors)
				{
					var colorLength:int = styleColors.length;				
				
					backgroundColor = styleColors[0];				
					rolloverColor = styleColors[1];						
				}				
				
				//声明样式管理器
				var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
				
//				var cssStyleDeclarationGlobal:CSSStyleDeclaration = styleManager.getStyleDeclaration("global");
//				cssStyleDeclarationGlobal.setStyle("chromeColor", backgroundColor);
//				cssStyleDeclarationGlobal.setStyle("fontFamily", "微软雅黑");
//				styleManager.setStyleDeclaration("global", cssStyleDeclarationGlobal, false);
				
				var CSSStyleDeclarationPanel:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.framework.dock.FloatPanel");
				CSSStyleDeclarationPanel.setStyle("titleBarUpColor", rolloverColor);
				CSSStyleDeclarationPanel.setStyle("titleBarDownColor", backgroundColor);
				//CSSStyleDeclarationPanel.setStyle("skinClass", titleWindowSkin);
				
				var CSSStyleDeclarationMapPanel:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.containers.MapPanel");
				CSSStyleDeclarationMapPanel.setStyle("titleBarUpColor", rolloverColor);
				CSSStyleDeclarationMapPanel.setStyle("titleBarDownColor", backgroundColor);
				CSSStyleDeclarationMapPanel.setStyle("skinClass", MapPanelSkin);
				
				var CSSStyleDeclarationStylePanel:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.containers.StylePanel");
				CSSStyleDeclarationStylePanel.setStyle("titleBarUpColor", rolloverColor);
				CSSStyleDeclarationStylePanel.setStyle("titleBarDownColor", backgroundColor);
				CSSStyleDeclarationStylePanel.setStyle("skinClass", com.supermap.skins.customSkins.StylePanelSkin);
				
				var CSSStyleDeclarationModule:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.framework.components.BaseGear");
				CSSStyleDeclarationModule.setStyle("contentBackgroundColor", rolloverColor);
				CSSStyleDeclarationModule.setStyle("fontFamily","微软雅黑");
				CSSStyleDeclarationModule.setStyle("color", 0xffffff);
				styleManager.setStyleDeclaration("com.supermap.framework.components.BaseGear", CSSStyleDeclarationModule, false);
				
				
				var CSSStyleDeclarationPanelTab:CSSStyleDeclaration = new CSSStyleDeclaration(".myTab");
				CSSStyleDeclarationPanelTab.setStyle("backgroundColor", backgroundColor);
				CSSStyleDeclarationPanelTab.setStyle("fontFamily","微软雅黑");
				CSSStyleDeclarationPanelTab.setStyle("color", 0xffffff);
				styleManager.setStyleDeclaration(".myTab", CSSStyleDeclarationPanelTab, false);
				
				var CSSStyleDeclarationPanelQueryItem:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.gears.accordionGears.queryGear.queryItemContainer");
				CSSStyleDeclarationPanelQueryItem.setStyle("backgroundColor", rolloverColor);				
				CSSStyleDeclarationPanelQueryItem.setStyle("fontFamily","微软雅黑");
				CSSStyleDeclarationPanelQueryItem.setStyle("color", 0xffffff);
				styleManager.setStyleDeclaration("com.supermap.gears.accordionGears.queryGear.queryItemContainer", CSSStyleDeclarationPanelQueryItem, false);
				
				var CSSStyleDeclarationCompass:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.web.components.Compass");
				CSSStyleDeclarationCompass.setStyle("backgroundColor", backgroundColor);				
				CSSStyleDeclarationCompass.setStyle("fontFamily","微软雅黑");
				CSSStyleDeclarationCompass.setStyle("color", 0xffffff);
				styleManager.setStyleDeclaration("com.supermap.web.components.Compass", CSSStyleDeclarationCompass, false);
				
				var CSSStyleDeclarationZoomSlider:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.web.components.ZoomSlider");
				CSSStyleDeclarationZoomSlider.setStyle("backgroundColor", backgroundColor);				
				CSSStyleDeclarationZoomSlider.setStyle("fontFamily","微软雅黑");
				CSSStyleDeclarationZoomSlider.setStyle("color", 0xffffff);
				styleManager.setStyleDeclaration("com.supermap.web.components.ZoomSlider", CSSStyleDeclarationZoomSlider, false);
				
				var CSSStyleDeclarationButton:CSSStyleDeclaration = new CSSStyleDeclaration("spark.components.Button");
//				CSSStyleDeclarationButton.setStyle("chromeColor", 0x333333);	
//				CSSStyleDeclarationButton.setStyle("color", 0xffffff);	
				CSSStyleDeclarationButton.setStyle("skinClass", drawBtnSkin);
				CSSStyleDeclarationButton.setStyle("fontFamily","微软雅黑");
				styleManager.setStyleDeclaration("spark.components.Button", CSSStyleDeclarationButton, false);
				
				var CSSStyleDeclarationScroller:CSSStyleDeclaration = new CSSStyleDeclaration("spark.components.Scroller");
				CSSStyleDeclarationScroller.setStyle("color", backgroundColor);	
				//CSSStyleDeclarationScroller.setStyle("chromeColor", 0xffffff);
				CSSStyleDeclarationScroller.setStyle("skinClass", com.supermap.framework.skins.scrollBarSkins.Scroller_skin);
				styleManager.setStyleDeclaration("spark.components.Scroller", CSSStyleDeclarationScroller, false);
				
				//GearTemplate样式
				var CSSStyleDeclarationGearTemplate:CSSStyleDeclaration = new CSSStyleDeclaration("com.supermap.framework.core.gearBase.GearTemplate");
				
				//----------------------------------------------------------------------
				//	颜色修改
				//----------------------------------------------------------------------
				if(backgroundColorChanged)
				{
					backgroundColorChanged = false;
				}
				
				if(rolloverColorChanged)
				{
					rolloverColorChanged = false;
				}	
			}			
		}		
		
		public function get styleObj():Object
		{
			return _styleObj;
		}

		public function set styleObj(value:Object):void
		{
			_styleObj = value;
		}

	}
}