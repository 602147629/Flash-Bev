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
	import com.supermap.framework.components.LayoutComponent;
	import com.supermap.framework.components.MapControl;
	import com.supermap.framework.core.BaseLayout;
	import com.supermap.framework.dock.FloatPanel;
	import com.supermap.framework.events.BaseEventDispatcher;
	import com.supermap.framework.events.GearEvent;
	import com.supermap.web.mapping.Map;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.INavigatorContent;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;
	
	import spark.components.Button;
	import spark.layouts.BasicLayout;
	
	//-------------------------------------------------------------------------
	//	Styles
	//-------------------------------------------------------------------------
	[Style(name="titleBarUpColor",type="uint",format="Color",inherit="no")]
	[Style(name="titleBarDownColor",type="uint",format="Color",inherit="no")]
	
	public class MapPanel extends FloatPanel
	{
		private var isFullScreen:Boolean = true;		
		
		[SkinPart(required="false")]
		public var chinaButton:Button;
		
		[SkinPart(required="false")]
		public var tiandituButton:Button;
		
		[SkinPart(required="false")]
		public var horizontalBtn:Button;
		
		[SkinPart(required="false")]
		public var verticalBtn:Button;
		
		[SkinPart(required="false")]
		public var absoluteBtn:Button;
		
		private var mapContainer:LayoutComponent;
		private var cloudMap:MapControl;
		private var tiledMap:MapControl;
		
		/**
		 *  上面样式
		 */
		private var _titleBarUpColor:uint;
		private var titleBarUpColorChanged:Boolean = false;
		/**
		 *  下面样式
		 */
		private var _titleBarDownColor:uint;
		private var titleBarDownColorChanged:Boolean = false;
		
		public function MapPanel(param1:INavigatorContent=null)
		{
			super(param1);
			doubleClickEnabled = true;	
			addEventListener(FlexEvent.CREATION_COMPLETE, createCompleteHandler);
			addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			addEventListener(ResizeEvent.RESIZE, resizeMapPanelHandler);
		}
		
		/**
		 *  GearContainer与TemplateContainer需要根据MapPanel进行自适应
		 */
		private function resizeMapPanelHandler(event:ResizeEvent):void
		{
			BaseEventDispatcher.getInstance().dispatchEvent(new GearEvent(GearEvent.GEAR_TEMPLATE_RESIZE, {width:this.width, height:this.height, panel:this}));
		}
		
		private function addedHandler(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, stageResizeHandler);
		}
		
		private function stageResizeHandler(event:Event):void
		{
			//trace(stage.width + " " + stage.height);
		}
		
		private function createCompleteHandler(event:FlexEvent):void
		{
			(titleDisplay as DisplayObject).parent.visible = false;
			
			BaseEventDispatcher.getInstance().dispatchEvent(new GearEvent(GearEvent.GEAR_TEMPLATE_RESIZE, {width:this.width, height:this.height, panel:this}));
			
			mapContainer = getElementById("mapContainer") as LayoutComponent;
			if(mapContainer)
				mapContainer.addEventListener(Event.ADDED_TO_STAGE, mapContainerCreatedHandler);
		}
		
		private function mapContainerCreatedHandler(event:Event):void
		{
			cloudMap = mapContainer.getPluginById("cloudMap") as MapControl;
			tiledMap = mapContainer.getPluginById("tiledMap") as MapControl;
		}
		
		public function get titleBarUpColor():uint
		{
			return _titleBarUpColor;
		}
		
		public function set titleBarUpColor(value:uint):void
		{			
			if(value && _titleBarUpColor != value)
			{
				titleBarUpColorChanged = true;
				_titleBarUpColor = value;
				super.invalidateDisplayList();
			}
		}
		
		public function get titleBarDownColor():uint
		{
			return _titleBarDownColor;
		}
		
		public function set titleBarDownColor(value:uint):void
		{
			if(value && _titleBarDownColor != value)
			{
				titleBarDownColorChanged = true;
				_titleBarDownColor = value;
				super.invalidateDisplayList();
			}
		}
		
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			if(titleBarUpColorChanged)
			{
				_titleBarUpColor = getStyle("titleBarUpColor");
				titleBarUpColorChanged = false;
			}
			else
			{
				_titleBarUpColor = getStyle("titleBarUpColor");
			}
			if(titleBarDownColorChanged)
			{
				_titleBarDownColor = getStyle("titleBarDownColor");
				titleBarDownColorChanged = false;
			}
			else
			{
				_titleBarDownColor = getStyle("titleBarDownColor");
			}
			
			super.invalidateDisplayList();			
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if(instance == moveArea)
			{
				moveArea.addEventListener(MouseEvent.DOUBLE_CLICK, resizePanelHandler);
			}
			if(instance == tiandituButton)
			{
				tiandituButton.addEventListener(MouseEvent.CLICK, tiandituBtnClickHandler);
			}
			if(instance == chinaButton)
			{
				chinaButton.addEventListener(MouseEvent.CLICK, chinaBtnClickHandler);
			}
			if(instance == verticalBtn)
			{
				verticalBtn.addEventListener(MouseEvent.CLICK, layoutHandler);
			}
			if(instance == absoluteBtn)
			{
				absoluteBtn.addEventListener(MouseEvent.CLICK, layoutHandler);
			}
			if(instance == horizontalBtn)
			{
				horizontalBtn.addEventListener(MouseEvent.CLICK, layoutHandler);
			}
			if(instance == minButton)
			{
				minButton.enabled = false;
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			if(instance == moveArea)
			{
				moveArea.removeEventListener(MouseEvent.DOUBLE_CLICK, resizePanelHandler);
			}
			if(instance == tiandituButton)
			{
				tiandituButton.removeEventListener(MouseEvent.CLICK, tiandituBtnClickHandler);
			}
			if(instance == chinaButton)
			{
				chinaButton.removeEventListener(MouseEvent.CLICK, chinaBtnClickHandler);
			}
			if(instance == verticalBtn)
			{
				verticalBtn.removeEventListener(MouseEvent.CLICK, layoutHandler);
			}
			if(instance == absoluteBtn)
			{
				absoluteBtn.removeEventListener(MouseEvent.CLICK, layoutHandler);
			}
			if(instance == horizontalBtn)
			{
				horizontalBtn.removeEventListener(MouseEvent.CLICK, layoutHandler);
			}
		}
		
		private function layoutHandler(event:MouseEvent):void
		{
			cloudMap.visible= true;
			tiledMap.visible= true;
			
			switch((event.target as Button).id)
			{
				case "horizontalBtn":
					mapContainer.setLayout(BaseLayout.HORIZONTAL);
					break;
				case "verticalBtn":
					mapContainer.setLayout(BaseLayout.VERTICAL);
					break;
				case "absoluteBtn":
					mapContainer.setLayout(BaseLayout.ABSOLUTE);
					break;
				default:
					break;
			}
		}
		
		/**
		 *  切换到云地图
		 *  TODO:优化根据id取元素......
		 */
		private function tiandituBtnClickHandler(event:MouseEvent):void
		{
			cloudMap.visible= true;
			tiledMap.visible= false;
		}
		
		/**
		 *  切换到china地图
		 *  TODO:优化根据id取元素......
		 */
		private function chinaBtnClickHandler(event:MouseEvent):void
		{
			cloudMap.visible= false;
			tiledMap.visible= true;
		}
		
		private function resizePanelHandler(event:MouseEvent):void
		{
			if(this.layout is BasicLayout)
			{
				if(!isFullScreen)
				{				
					this.x = 0; 
					this.y = 0;
					this.width = FlexGlobals.topLevelApplication.width;
					this.height = FlexGlobals.topLevelApplication.height;
					isFullScreen = true;
				}
				else
				{	
					this.width = (FlexGlobals.topLevelApplication.width) * 0.5;
					this.height = (FlexGlobals.topLevelApplication.height) * 0.6;
					this.x = (FlexGlobals.topLevelApplication.width - this.width) * 0.5;
					this.y = (FlexGlobals.topLevelApplication.height - this.height) * 0.5;
					isFullScreen = false;
				}					
			}		
			//TODO:其他布局的处理...因此application默认的是绝对布局 先处理这种情况
		}
		
		public function getElementById(id:String):IVisualElement
		{
			var element:IVisualElement;
			var num:int = this.numElements;
			for(var i:int = 0; i < num; i++ )
			{
				element = this.getElementAt(i);
				if(( element as UIComponent).id == id)
					return element;
			}
			return null;
		}
	}
}