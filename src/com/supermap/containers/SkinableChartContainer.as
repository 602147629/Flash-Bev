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
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	import spark.components.SkinnableContainer;	
	
	[Event(name="closeTabEvent", type="flash.events.Event")]
	public class SkinableChartContainer extends SkinnableContainer
	{		
		[SkinPart(required="false")]		
		public var closeGroup:Group;	
		
		public function SkinableChartContainer()
		{
			super();
			this.percentHeight = 100;
			this.percentWidth = 100;
		}
		
		protected override function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName,instance);
			if(instance == closeGroup)
			{
				closeGroup.addEventListener(MouseEvent.CLICK,closeHandler);					
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName,instance);
			if(instance == closeGroup)
			{
				closeGroup.removeEventListener(MouseEvent.CLICK,closeHandler);
			}
		}
		
		private function closeHandler(event:MouseEvent):void
		{
			this.visible = false;
			this.dispatchEvent(new Event("closeTabEvent"));
		}
	}	
}