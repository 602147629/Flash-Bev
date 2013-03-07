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
package com.supermap
{
	/**
	 * 主配置文件
	 */
	
	import com.supermap.events.DataConfigEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	[Event(name="proloadgear", type="com.supermap.events.DataConfigEvent")]
	[Event(name="configload", type="com.supermap.events.DataConfigEvent")]
	[Event(name="mapGearLoad", type="com.supermap.events.DataConfigEvent")]
	[Event(name="configPanelPlugin", type="com.supermap.events.DataConfigEvent")]
	[Event(name="customPanelNoPlugin", type="com.supermap.events.DataConfigEvent")]
	[Event(name="loadMapPanel", type="com.supermap.events.DataConfigEvent")]
	[Event(name="loadMapPanel", type="com.supermap.events.DataConfigEvent")]
	[Event(name="panelVectorData", type="com.supermap.events.DataConfigEvent")]
	[Event(name="panelManagerBar", type="com.supermap.events.DataConfigEvent")]
	
	public class XMLDecoder extends EventDispatcher
	{		
		private var _aryAlpha:Array = new Array();
		private var _aryColor:Array = new Array();
		private var mapperList:XMLList = new XMLList();
		private var gearID:int = 0;
		private var configXML:String = "application-config.xml";
		
		private var vectorPanel:Vector.<Object>;
		//= new Vector.<String>();
		
		public function XMLDecoder()
		{			
			configLoad();
		}
		
		public function get aryColor():Array
		{
			return _aryColor;
		}
		
		public function set aryColor(value:Array):void
		{
			_aryColor = value;
		}
		
		public function get aryAlpha():Array
		{
			return _aryAlpha;
		}
		
		public function set aryAlpha(value:Array):void
		{
			_aryAlpha = value;
		}
		
		private function configLoad():void
		{
			var configService:HTTPService = new HTTPService();			
			configService.url = configXML;
			configService.resultFormat = "e4x";
			configService.addEventListener(ResultEvent.RESULT, configResult);
			configService.addEventListener(FaultEvent.FAULT, configFault);	
			configService.send();
		}
		
		private function configResult(event:ResultEvent):void
		{						
			var configData:XML = event.result as XML;
			var i:int;
			var j:int;
			var themeColors:Array = String(configData.Style.color).split(",");
			var alphas:Array;
			if(configData.Style.alpha[0])
				alphas = String(configData.Style.alpha).split(",");
			else
				alphas = null;
			var colorStr:String = "";
			var alphaStr:String = "";
			for each (colorStr in themeColors)
			{
				aryColor.push(uint(colorStr));
			}
			
			if(alphas)
			{
				for each(alphaStr in alphas)
				{
					aryAlpha.push(alphaStr);
				}
			}
			else
				aryAlpha = null;
			
			var styles:Object = {
				aryColors:aryColor,
				aryAlphas:aryAlpha
			}
			
			dispatchEvent(new DataConfigEvent(DataConfigEvent.CONFIG_LOAD,styles));
			
			//预加载Gear--工具条 导航条等
			var preGearList:XMLList = new XMLList();
			
			var gcData:Object = new Object();
			var panelList:XMLList = configData.panel;
			vectorPanel = new Vector.<Object>();
			
			var mapPanel:Array = [];
			//没有插件的面板
			var noPlugins:Array = [];			
			var panelWithPlugin:Array = [];			
			var panelWithPlugins:Array = [];
			
			//暂时没放在这里解析 直接把拿到的数据 抛到 main页面去解析并加载 ......
			var panelBar:XMLList = configData.panelManangerBar;
			
			for each(var panelXML:XML in panelList)
			{
				var className:String = panelXML.@name[0];
				//floatPanel本身的配置信息
				var panelMsg:Array = [];
				var panelMsgObj:Object = 
					{		
						x : panelXML.@x[0],
						y : panelXML.@y[0],
						width : panelXML.@width[0],
						height :　panelXML.@height[0],
						selectedIndex : panelXML.@selectedIndex[0],
						isDragAble : panelXML.@isDragAble[0],
						isResizeAble : panelXML.@isResizeAble[0], 
						isDock : panelXML.@isDock[0],
						maxTabNum : panelXML.@maxTabNum[0],
						name : panelXML.@name[0],
						icon : panelXML.@icon[0],
						iconBar:panelXML.@iconBar[0],
						title : panelXML.@title[0],
						id : panelXML.@id[0],
						describe : panelXML.@describe[0]
					}
				if( panelXML.plugin.length())
				{
					panelWithPlugin.push(panelMsgObj);
				}
				else if(panelXML.children().length())
				{
					panelMsg.push(panelMsgObj);	
				}
				
				vectorPanel.push({
					x : panelMsgObj.x,
					y : panelMsgObj.y,
					width : panelMsgObj.width,
					height :　panelMsgObj.height,
					selectedIndex : panelMsgObj.selectedIndex,
					isDragAble : panelMsgObj.isDragAble,
					isResizeAble : panelMsgObj.isResizeAble, 
					isDock : panelMsgObj.isDock,
					maxTabNum : panelMsgObj.maxTabNum,
					id : panelMsgObj.id, 
					name : panelMsgObj.name, 
					title : panelMsgObj.title,
					icon : panelMsgObj.icon, 
					iconBar : panelMsgObj.iconBar,
					describe : panelMsgObj.describe,
					isPanel : true
				});		
				
				var childLen:int = panelXML.children().length();
				var pluginNum:int = panelXML.plugin.length()
				//如果有插件
				if(pluginNum)
				{
					var plugins:Array = [];
					for(var m:int = 0; m < pluginNum; m++)
					{
						var pluginXML:XML = panelXML.plugin[m] as XML;
						var pluginObj:Object = 
							{							
								id : pluginXML.@id[0],
									name : pluginXML.@name[0],
									label : pluginXML.@label[0],
									icon : pluginXML.@icon[0],
									iconBar : pluginXML.@iconBar[0],
									describe : pluginXML.@describe[0]
							}
						plugins.push(pluginObj);
						vectorPanel.push({id : pluginObj.id,
							panelID : panelMsgObj.id,
							label: pluginObj.label,
							name : pluginObj.name, 
							icon : pluginObj.icon, 
							iconBar : pluginObj.iconBar,
							describe : pluginObj.describe,
							isPanel : false
						});
					}
					panelWithPlugins.push({panel:panelMsgObj, plugin:plugins});//一个object里对应着一组对应关系 一个panel里对应着plugins
				}
				else if(childLen)//如果有子项 并且不包含plugin 那么按照mappanel面板来解析
				{
					mapPanel = panelMsg;//这里暂时只处理地图面板 
					preGearList = panelXML.gearcontainer.gear;
					var proGear:Array = [];
					var preGearsLen:int = preGearList.length();
					for(var n:int = 0; n < preGearsLen; n++)
					{
						var object:Object = {
							left:preGearList[n].@left[0],
								right:preGearList[n].@right[0],
								top:preGearList[n].@top[0],
								bottom:preGearList[n].@bottom[0], 
								id:preGearList[n].@id[0],
								url:preGearList[n].@url[0],
								label:preGearList[n].@title[0],
								icon:preGearList[n].@icon[0],	
								horizontalCenter:preGearList[n].@horizontalCenter[0],
								verticalCenter:preGearList[n].@verticalCenter[0]
						}
						proGear.push(object);				
					}
					gcData.gears = proGear;
					
					var gleft:String = panelXML.gearcontainer.@left;
					var gright:String = panelXML.gearcontainer.@right;
					var gtop:String = panelXML.gearcontainer.@top;
					var gbottom:String = panelXML.gearcontainer.@bottom;
					var glayout:String = panelXML.gearcontainer.@layout;
					if (!glayout)
					{
						glayout = "absolute";
					}
					
					if (gleft || gright || gtop || gbottom || glayout)
					{
						var gearContainer:Object =
							{
								id: "gearContainer",
								left: gleft,
								right: gright,
								top: gtop,
								bottom: gbottom,
								layout: glayout						
							};
						gcData.gearContainer = gearContainer;
					}
					
					//地图上的Gears弹窗
					var mapGearsList:XMLList = new XMLList();
					mapGearsList = configData.panel.templatecontainer.gear;
					var gearLen:int = mapGearsList.length();
					var proMapGears:Array = [];
					for(var t:int = 0; t < gearLen; t++)
					{
						var proGearObj:Object = {
							id : mapGearsList[t].@id[0],
								left : mapGearsList[t].@left[0],					
								top : mapGearsList[t].@top[0],
								right : mapGearsList[t].@right[0],
								bottom : mapGearsList[t].@bottom[0],
								preload : mapGearsList[t].@preload[0], 					
								url : mapGearsList[t].@url[0],
								label : mapGearsList[t].@label[0],
								icon : mapGearsList[t].@icon[0]						
						}					
						proMapGears.push(proGearObj);	
					}
				}
				else//既没有插件  又没有地图配置的面板 直接是面板本身扩展项的配置 如stylepanel
				{
					noPlugins.push(panelMsgObj);					
				}
			}
			
			//派发带有 Plugin插件的面板
			if(panelWithPlugins)
				dispatchEvent(new DataConfigEvent(DataConfigEvent.CONFIG_PANEL_PLUGIN, panelWithPlugins));
			//先派发mappanel事件
			if(mapPanel)
				dispatchEvent(new DataConfigEvent(DataConfigEvent.LOAD_MAP_PANEL, mapPanel));
			//没有Plugin插件与地图面板
			if(noPlugins)
				dispatchEvent(new DataConfigEvent(DataConfigEvent.CUSTOM_PANEL_NO_PLUGIN, {panel:noPlugins}));
			//面板管理组件
			if(vectorPanel)
				dispatchEvent(new DataConfigEvent(DataConfigEvent.PANEL_VECTOR_DATA, {vectorPanel : vectorPanel, panelBar : panelBar}));
			//gearContainer
			if(gcData)
				dispatchEvent(new DataConfigEvent(DataConfigEvent.PROLOAD_GEAR, gcData));
			//地图上的Gears弹窗
			if(proMapGears)
				dispatchEvent(new DataConfigEvent(DataConfigEvent.MAP_GEAR_LOAD, proMapGears));
		}
		
		/**
		 *  当主配置文件解析失败时 派发CONFIG_LOAD_ERROR事件
		 */
		private function configFault(event:FaultEvent):void
		{			
			this.dispatchEvent(new DataConfigEvent(DataConfigEvent.CONFIG_LOAD_ERROR, event.fault));
		}		
	}
}