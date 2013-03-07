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

	public class BevStyleEvent extends BaseEvent
	{
		/**
		 *  当ui界面样式修改时派发该事件
		 */
		public static const STYLE_CHANGE:String = "styleChange";
		
		private var _data:Object = null;
		
		public function get data():Object
		{
			return _data;
		}

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function BevStyleEvent(type:String,  data:Object=null)
		{
			super(type);
			if (data != null) 
				_data = data;
		}
	}
}