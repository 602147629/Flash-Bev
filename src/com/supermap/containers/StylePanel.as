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
	import com.supermap.framework.dock.FloatPanel;
	
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.INavigatorContent;
	import mx.core.IVisualElement;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.layouts.BasicLayout;
	
	public class StylePanel extends FloatPanel
	{
		private var isFullScreen:Boolean = true;	

		
		public function StylePanel(param1:INavigatorContent=null)
		{
			super(param1);
			doubleClickEnabled = true;			
			addEventListener(FlexEvent.CREATION_COMPLETE, createCompleteHandler);
		}
		
		private function createCompleteHandler(event:FlexEvent):void
		{
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if(instance == moveArea)
			{
				moveArea.addEventListener(MouseEvent.DOUBLE_CLICK, resizePanelHandler);
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
		}
		
		private function layoutHandler(event:MouseEvent):void
		{

		}
		
		/**
		 *  切换到云地图
		 *  TODO:优化根据id取元素......
		 */
		private function tiandituBtnClickHandler(event:MouseEvent):void
		{

		}
		
		/**
		 *  切换到china地图
		 *  TODO:优化根据id取元素......
		 */
		private function chinaBtnClickHandler(event:MouseEvent):void
		{
			
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