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
	
	public class DataConfigEvent extends BaseEvent
	{
		//--------------------------------------------------------------------------
		//
		//  Class constants
		//
		//--------------------------------------------------------------------------
		/**
		 * 定义当配置文件载入时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const CONFIG_LOAD:String	= "configload";
		
		/**
		 * 定义当图层载入时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const LAYER_LOAD:String = "layerload";
		/**
		 * 定义当图层改变载入时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const LAYER_SWITCH:String = "layerswitch";
		/**
		 * 定义当工具条、导航条等交互模块预载入时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const PROLOAD_GEAR:String = "proloadgear";
		/**
		 * 定义当预载入可伸缩面板时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const PROLOAD_ACCORDIONPANEL:String = "proloadaccordionpanel";
		/**
		 * 定义当鹰眼地图载入时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const OVERVIEWMAP_LAYERLOAD:String = "overviewmapload";
		/**
		 * 定义当工具条、导航条等交互模块绑定数据时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const GEAR_BINDABLE_DATA:String = "gearbindaledata";
		/**
		 * 定义当预载入图例控件时，ConfigDataEvent事件对象的type属性。
		 */		
		public static const LEGEND_PRELOAD:String = "legendpreload";
		
		public static const STYLE_LOAD:String = "styleLoad";
		
		public static const MAP_GEAR_LOAD:String = "mapGearLoad";
		
		public static const CONFIG_LOAD_ERROR:String = "configLoadError";
		
		public static const CONFIG_PANEL_PLUGIN:String = "configPanelPlugin";
		
		public static const CUSTOM_PANEL_NO_PLUGIN:String = "customPanelNoPlugin";
		
		public static const LOAD_MAP_PANEL:String = "loadMapPanel";
		
		public static const PANEL_MANAGER_BAR:String = "panelManagerBar";
		
		public static const PANEL_VECTOR_DATA:String = "panelVectorData";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * 处理配置文件数据时，都会将 ConfigDataEvent 对象分派到事件流中。
		 * @param type 定义事件类型。
		 * @param data 定义事件信息。
		 */ 		
		public function DataConfigEvent(type:String,  data:Object=null)
		{
			super(type);
			if (data != null) _data = data;
		}
	}
}