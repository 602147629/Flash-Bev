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
	import com.supermap.framework.events.BaseEvent;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	public class ContainerEvent extends BaseEvent
	{
		/**
		 *  容器的Title
		 */
		private var _containerTitle:String;
		
		private var _resultContainer:UIComponent;
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		/**
		 * 显示统计图区域事件
		 */	
		public static const CONTAINER_ADD:String = "ContainerAdd";
		/**
		 * 删除统计图区域事件
		 */			
		public static const CONTAINER_DELETE:String = "ContainerDelete";
		
		public static const COMMAND_TEST:String = "CommandTest";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function ContainerEvent(type:String, containerTitle:String = null, resultContainer:UIComponent = null)
		{
			super(type);
			_resultContainer = resultContainer;
			this._containerTitle = containerTitle;
		}

		public function get containerTitle():String
		{
			return _containerTitle;
		}

		public function set containerTitle(value:String):void
		{
			_containerTitle = value;
		}

		public function get resultContainer():UIComponent
		{
			return _resultContainer;
		}

		public function set resultContainer(value:UIComponent):void
		{
			_resultContainer = value;
		}
	}
}