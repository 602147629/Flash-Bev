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
package com.supermap.commands
{
	import com.supermap.events.ContainerEvent;
	import com.supermap.events.QueryPanelEvent;
	import com.supermap.framework.commands.Command;
	import com.supermap.framework.events.BaseEvent;
	import com.supermap.framework.events.FloatPanelEvent;
	import com.supermap.gears.query.QueryContainer;
	
	import spark.components.Label;
	
	public class QueryCommand extends Command
	{
		[Inject]
		public var qContainer:QueryContainer;
		
		public function QueryCommand()
		{
			super();
		}
		
		override public function execute(event:BaseEvent):void
		{
			if(event.type == ContainerEvent.CONTAINER_ADD)
			{
				qContainer.showDataGridHandler(event as ContainerEvent);
			}
			else if(event.type == QueryPanelEvent.QUERYPANEL_REMOVE)
			{
				qContainer.queryPanelRemoveHandler(event as QueryPanelEvent);
				qContainer.deleteAllDataGridHandler();
			}
			else if(event.type == ContainerEvent.CONTAINER_DELETE)
				qContainer.deleteDataGridHandler(event as ContainerEvent);
		}
	}
}