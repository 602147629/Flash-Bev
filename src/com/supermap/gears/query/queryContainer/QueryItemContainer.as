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
package com.supermap.gears.query.queryContainer
{
	import flash.events.MouseEvent;
	
	import mx.graphics.SolidColorStroke;
	
	import spark.components.CheckBox;
	import spark.components.SkinnableContainer;
	import spark.primitives.Rect;
	
	public class QueryItemContainer extends SkinnableContainer
	{
		[SkinPart]
		public var checkBox:CheckBox;

		[SkinPart]
		public var fill:Rect;
		
		[Bindable]
		public var title:String;
		
		[Bindable]
		public var content:String;
		
		[Bindable]
		public var headerColor:uint = 0xff0000;
		
		public function QueryItemContainer()
		{
			super();
			setStyle("skinClass", QueryBorderContainerSkin);
			addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
		}		
		
		private function rollOverHandler(event:MouseEvent):void
		{
			(fill.stroke as SolidColorStroke).color = headerColor;
		}
		
		private function rollOutHandler(event:MouseEvent):void
		{
			(fill.stroke as SolidColorStroke).color = 0;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
		}		
	}
}