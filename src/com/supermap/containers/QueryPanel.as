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
	import com.supermap.events.QueryPanelEvent;
	import com.supermap.framework.dock.ClosePanel;
	import com.supermap.framework.dock.FloatPanel;
	import com.supermap.framework.events.BaseEventDispatcher;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.containers.TabNavigator;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.INavigatorContent;
	import mx.core.IVisualElementContainer;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	public class QueryPanel extends FloatPanel
	{
		public function QueryPanel(param1:INavigatorContent=null)
		{
			super(param1);
		}
		
		override protected function closeButton_clickHandler(event:MouseEvent):void
		{
			//super.closeButton_clickHandler(event);
			var tabNavigator:TabNavigator;
			if(this.numElements)
				tabNavigator = (this.getElementAt(0) as TabNavigator);
			if (tabNavigator&&tabNavigator.numChildren>1)
			{
				PopUpManager.addPopUp(ClosePanel.getInstance(), DisplayObject(FlexGlobals.topLevelApplication), true);
				ClosePanel.getInstance().closeHandler = CloseAllHandler;
				ClosePanel.getInstance().cancelHandler = CloseAllHandler;
			}
			else
			{
				removeFromParent();
			}
		}
		
		private function CloseAllHandler(event:Event):void
		{
			if (event.target.label == ClosePanel.closeLabel)
			{
				removeFromParent();
			}
			else if (event.target.label == ClosePanel.cancelLabel)
			{
				//nothing
			}
			PopUpManager.removePopUp(ClosePanel.getInstance()); 
			
		}
		
		private function removeFromParent():void
		{
			if (this.parent&&this.parent.contains(this)&&(this.parent is IVisualElementContainer))
			{
				(this.parent as IVisualElementContainer).removeElement(this);
				BaseEventDispatcher.getInstance().dispatchEvent(new QueryPanelEvent(QueryPanelEvent.QUERYPANEL_REMOVE, this));
				
				//移除对command的注册 否则重新打开后会报错  这里是对面板里的所有插件里对command的注册都要移除掉 建议在
				
//				if(BaseEventDispatcher.getInstance().hasEventListener(ContainerEvent.CONTAINER_ADD))
//					BaseEventDispatcher.getInstance().removeCommand(ContainerEvent.CONTAINER_ADD, QueryCommand);
//				
//				if(BaseEventDispatcher.getInstance().hasEventListener(ContainerEvent.CONTAINER_DELETE))
//					BaseEventDispatcher.getInstance().removeCommand(ContainerEvent.CONTAINER_DELETE, QueryCommand);
//				
//				if(BaseEventDispatcher.getInstance().hasEventListener(QueryPanelEvent.QUERYPANEL_REMOVE))
//					BaseEventDispatcher.getInstance().removeCommand(QueryPanelEvent.QUERYPANEL_REMOVE, QueryCommand);
				
			}
		}
	}
}