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
package com.supermap.events
{
	import com.supermap.framework.events.FloatPanelEvent;
	
	public class QueryPanelEvent extends FloatPanelEvent
	{
		public static var QUERYPANEL_REMOVE:String = "queryPanel_remove";
		
		public function QueryPanelEvent(type:String="", data:Object=null)
		{
			super(type, data);
		}
	}
}