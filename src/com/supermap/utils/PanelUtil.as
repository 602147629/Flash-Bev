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
package com.supermap.utils
{
	import com.supermap.framework.dock.FloatPanel;
	
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.core.IVisualElementContainer;
	
	import spark.components.Application;

	public class PanelUtil
	{
		/**
		 *  当前选中的面板将最前端显示
		 */
		public static function mouseClickHandler(event:MouseEvent):void
		{
			var fp:FloatPanel = event.currentTarget as FloatPanel;
			var app:Application = FlexGlobals.topLevelApplication as Application;
			if(app.numElements &&　app.contains(fp))
			{
				app.addElementAt(fp, app.numElements - 1);
			}
		}
		
		/**
		 *  从全局目录里获取某一个面板引用对象
		 *  @param panelID 面板对象的id
		 *  @return Object 返回面板对象
		 *  2013.5.14
		 */
		public static function getPanelByID(panelID:String):Object
		{
			var app:IVisualElementContainer = IVisualElementContainer(FlexGlobals.topLevelApplication);	
			var childNum:int = app.numElements;
			for(var i:int = 0; i < childNum; i++)
			{
				var element:Object = app.getElementAt(i);
				if(element.id == panelID)
				{
					return element;
				}
			}
			return null;
		}
	}
}