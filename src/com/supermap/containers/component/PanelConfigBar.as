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
package com.supermap.containers.component
{
	import com.supermap.Main;
	import com.supermap.containers.LayoutContainer;
	import com.supermap.containers.MapPanel;
	import com.supermap.containers.StylePanel;
	import com.supermap.events.QueryPanelEvent;
	import com.supermap.framework.dock.DockableTabNavigator;
	import com.supermap.framework.dock.FloatPanel;
	import com.supermap.framework.dock.IconUtil;
	import com.supermap.framework.dock.supportClasses.ToolTip;
	import com.supermap.framework.events.FloatPanelEvent;
	import com.supermap.utils.PanelUtil;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	import spark.components.Application;
	import spark.components.Group;
	import spark.components.Label;
	import spark.components.NavigatorContent;
	import spark.components.Scroller;
	import spark.layouts.TileLayout;
	
	public class PanelConfigBar extends LayoutContainer
	{
		[SkinPart(required="false")]
		public var label:Label;
		
		[SkinPart(required="false")]
		public var group:Group;
		
		[SkinPart(required="false")]
		public var upimg:Image;
		
		[SkinState("unfold")]
		
		private var _panelState:String = "normal";
		private var disabledPanelIDs:Array = ["MapPanel"];
		
		[Bindable]
		public var upImg:String = "assets/upImg.png";
		[Bindable]
		public var downImg:String = "assets/downImg.png";
		[Bindable]
		public var upTxt:String = "更多";		
		[Bindable]
		public var title:String;
		public var defaultIcon:String = "test.jpg";		
		[Bindable]
		public var leftNum:int = 20;//内容与左边框的距离 缩进值	
		
		[Bindable]
		public var defaultHeight:int = 50;
		public var defaultWidth:int = 450;
		private var defaultMaxWidth:int = 370;
		private var _defNum:Number = 6;
		
		private var dictionary:Dictionary;
		/**
		 *  默认的图标 在面板管理条上的默认显示图标 如果没有设置该项的话
		 */
		private var barDefImg:String = "assets/panel/help.png";
		
		private var _vector:Vector.<Object>;
		
		public function PanelConfigBar()
		{
			super();
			
			tilelayout = new TileLayout();
			tilelayout.horizontalGap = 12;
			layout = tilelayout;
			
			addEventListener(FlexEvent.CREATION_COMPLETE, createdHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, moveToTopHandler);
		}
		
		private function moveToTopHandler(event:MouseEvent):void
		{
			var app:Application = FlexGlobals.topLevelApplication as Application;
			if(app.numElements &&　app.contains(this))
			{
				app.addElementAt(this, app.numElements - 1);
			}
		}
		
		public function get vector():Vector.<Object>
		{
			return _vector;
		}

		public function set vector(value:Vector.<Object>):void
		{
			_vector = value;
		}

		public function get defNum():Number
		{
			return _defNum;
		}

		public function set defNum(value:Number):void
		{
			_defNum = value;
		}
		
		public function get panelState():String
		{
			return _panelState;
		}

		public function set panelState(value:String):void
		{
			_panelState = value;
			invalidateSkinState();			
			dispatchEvent(new Event(value));
		}
		
		override protected function getCurrentSkinState():String
		{
			return _panelState;
		}

		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if(instance == group)
			{
				group.addEventListener(Event.ADDED_TO_STAGE, groupCreatedHandler);
			}
			if(instance == upimg)
			{
				upimg.addEventListener(MouseEvent.CLICK, unfoldPanelHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			if(instance == group)
			{
				group.removeEventListener(Event.ADDED_TO_STAGE, groupCreatedHandler);
			}
			if(instance == upimg)
			{
				upimg.removeEventListener(MouseEvent.CLICK, unfoldPanelHandler);
			}
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			//todo:支持属性动态修改
		}
		
		private var vectorLen:int;
		private function unfoldPanelHandler(event:MouseEvent):void
		{
			if(this.panelState == "normal")
			{
				this.panelState = "unfold";
			}
			else
			{
				this.panelState = "normal";
				tilelayout.requestedRowCount = 1;
				//只显示一行 列数为_defNum
				if(otherDataGroup && otherDataGroup.length)
				{
					var len:int = otherDataGroup.length;
					for(var i:int = 0; i < len; i++)
					{
						if(this.contains(otherDataGroup[i] as DisplayObject))
							this.removeElement(otherDataGroup[i]);
					}
				}
			}
		}
		
		/**
		 *  恢复默认布局方式
		 */
		public function setDefLayout():void
		{
			//tilelayout.requestedRowCount = 1;为了更好的效果 这里把这个代码放在unfoldPanelHandler()里
		}
		
		/**
		 *  展开动画结束后的布局调整
		 */
		public function setUnfoldLayout():void
		{
			if(showNum && (showNum > defNum))
			{
				//设置图片显示
				var len:int = otherDataGroup.length;
				for(var i:int = 0; i < len; i++)
				{
					this.addElement(otherDataGroup[i]);
				}
				var num:Number = showNum / defNum;
				(int(num) == num)? num : num++;
				tilelayout.requestedRowCount = int(num);
				layout = tilelayout;
			}
		}
		
		private var tilelayout:TileLayout;
		private var otherDataGroup:Array;
		private var showNum:int = 0;//从配置文件读取进来的显示数目
		private var realShowNum:int = 0;//实际中要加载的panel数目
		
		private function createdHandler(event:FlexEvent):void
		{
			dictionary = new Dictionary(false);
			
			//字体显示处理
			upTxt = upTxt.split("").join("\n");
			
			vectorLen = vector.length;
			
			otherDataGroup = [];
			for(var i:int = 0; i < vectorLen; i++)
			{
				var panelObj:Object = vector[i];
				var imgStr:String = panelObj.iconBar;
				if(!imgStr)
					imgStr = barDefImg;
				
				//如果有图片 就显示 没有用默认的 提示信息也同样处理
				var isPanel:Boolean = panelObj.isPanel;
				var dockBarDataGroup:PanelBarDataGroup;
				if(imgStr &&　isPanel)
				{
					dockBarDataGroup = new PanelBarDataGroup();
					dockBarDataGroup.id = panelObj.id;//panel的id
					//TODO:
//					for(var k:int = 0; k < disabledPanelIDs.length; i++)
//					{
//							
//					}
					if(dockBarDataGroup.id == "MapPanel")
						continue;
					//dictionary[dockBarDataGroup.id] = dockBarDataGroup;
					if(panelObj.describe)
						dockBarDataGroup.name = panelObj.describe;
					else
						dockBarDataGroup.name = "这是一个面板！";
					
					var dockData:PanelDockData = new PanelDockData();
					dockData.name = "第一个";
					dockData.icon = imgStr;//48*48
					var arrayC:ArrayCollection = new ArrayCollection();
					arrayC.addItem(dockData);			
					dockBarDataGroup.dataProvider = arrayC;
					dockBarDataGroup.addEventListener(MouseEvent.MOUSE_OVER, imgMouseOverHandler);
					dockBarDataGroup.addEventListener(MouseEvent.CLICK, openPanelHandler);
					if(showNum < _defNum)
					{						
						addElement(dockBarDataGroup);
						realShowNum++;
					}
					else
					{
						otherDataGroup.push(dockBarDataGroup);
					}
					showNum++;
				}
				
				if(showNum < defNum)
					upimg.visible = false;
				else
					upimg.visible = true;
			}
			
			var columnCount:int = (realShowNum >= _defNum) ? _defNum : realShowNum;
			tilelayout.requestedColumnCount = columnCount;
			
			//根据传进来的值进行宽高的计算 暂时只对宽度进行了自适应
			height = defaultHeight;
			width = (columnCount * 48) + (columnCount - 1) * (tilelayout.horizontalGap) + (leftNum - tilelayout.horizontalGap);
			maxWidth = defaultMaxWidth;		
			
			//设置居中显示 2012.7.6
			if(width)
				x = ( FlexGlobals.topLevelApplication.width - width ) * .5;
			if(height)
				y = ( FlexGlobals.topLevelApplication.height - height ) * .5;
			
			EventBus.addEventListener(FloatPanelEvent.FLOATPANEL_REMOVE, removePanelHandler);
			//如果是自定义的panel 并且关闭时候自定义了事件 这里要添加对应的监听
			EventBus.addEventListener(QueryPanelEvent.QUERYPANEL_REMOVE, removePanelHandler);
			//EventBus.addEventListener(FloatPanelEvent.FLOATPANEL_CREATE, createPanelHandler);
		}
		
		private function removePanelHandler(event:FloatPanelEvent):void
		{
			var fp:FloatPanel = event.data as FloatPanel;
			for(var panelID:String in dictionary)
			{
				if(fp.id == panelID)
				{
					dictionary[panelID] = null;
					delete dictionary[panelID];
				}
			}
		}
		
		/**
		 *  根据传入拖拽对象来确定对应在配置文件里的插件配置信息
		 */
		private function getPluginMsg(navigatorContent:NavigatorContent):Object
		{
			for(var i:int = 0; i < vectorLen; i++)
			{
				var panelObj:Object = vector[i];
				if(panelObj.id == navigatorContent.id)
				{
					return panelObj;
				}
			}
			return null;
		}
		
		/**
		 *  根据传入的面板ID来确定对应在配置文件里的面板配置信息
		 */
		private function getPanelMsg(panelID:String):Object
		{
			for(var i:int = 0; i < vectorLen; i++)
			{
				var panelObj:Object = vector[i];
				if(panelObj.id == panelID)
				{
					return panelObj;
				}
			}
			return null;
		}
		
		private function removePluginMsg(navigatorContent:NavigatorContent):Object
		{
 			for(var i:int = 0; i < vectorLen; i++)
			{
				var panelObj:Object = vector[i];
				if(panelObj.id == navigatorContent.id)
				{
					//修改数据
					//vector.splice(i, 1);
					return panelObj;
				}
			}
			return null;
		}
		
		/**
		 *  判读是不是包含了这个panel
		 */
		private function isExist(panelObj:Object):Boolean
		{
			return false;
		}
		
		/**
		 *  tooltip处理部分
		 */
		private var tooltip:ToolTip;
		private function groupCreatedHandler(event:Event):void
		{
			var ui:UIComponent = new UIComponent();
			stage.addChild(ui);
			tooltip = ToolTip.getInstance();				
			ui.addChild(tooltip);
			tooltip.hook = true;
			tooltip.autoSize = true;
		}
		
		public function getToolTip():ToolTip
		{
			return this.tooltip;
		}
		
		/**
		 *  实例化对应的面板(当关闭一个面板后 只允许弹出一个)
		 *  这里要注意一个问题 就是新弹出的面板要记得给内部插件传递map 因为插件都重新创建了 map属性要重新传入 
		 */
		private function openPanelHandler(event:MouseEvent):void
		{
			var target:PanelBarDataGroup = event.currentTarget as PanelBarDataGroup;
			if(target.id == "MapPanel")
				return;
			for(var panelID:String in dictionary)
			{
				if(target.id == panelID && dictionary[panelID])
					return;
			}
			
			var len:int = vector.length;
			var plugins:Array = [];
			var lastPanelObj:Object;
			for(var i:int = 0; i < len; i++)
			{
				var panelObj:Object = vector[i];
				if((panelObj.id == target.id || panelObj.panelID == target.id) && !panelObj.isPanel)
					plugins.push(panelObj);
				if((panelObj.id == target.id || panelObj.panelID == target.id) && panelObj.isPanel)
					lastPanelObj = panelObj;
			}
				
			//这里应该根据主配置文件里的类 进行反射
			var floatPanel:FloatPanel;
			//mappanel不允许关闭与再次实例化 下面两行代码无效
			if(lastPanelObj.id == "MapPanel")
				floatPanel = new MapPanel();
			else if(lastPanelObj.id == "StylePanel")
				floatPanel = new StylePanel();
			else
			{
				var instance:Class = getDefinitionByName(lastPanelObj.name) as Class;
				floatPanel = new instance();
			}
			
			if(lastPanelObj.width)
				floatPanel.width = lastPanelObj.width;
			if(lastPanelObj.height)
				floatPanel.height = lastPanelObj.height;	
			
			//设置显示位置 根据传入的xy
//			if(lastPanelObj.x)
//				floatPanel.x = lastPanelObj.x;
//			if(lastPanelObj.y)
//				floatPanel.y = lastPanelObj.y;
			
			//设置居中显示 2012.7.6
			floatPanel.x = ( FlexGlobals.topLevelApplication.width - floatPanel.width ) * .5;
			floatPanel.y = ( FlexGlobals.topLevelApplication.height - floatPanel.height ) * .5;
			
			if(lastPanelObj.id)
				floatPanel.id = lastPanelObj.id;	
			if(lastPanelObj.maxTabNum)
				floatPanel.tabLimitNum = lastPanelObj.maxTabNum;
			if(lastPanelObj.icon)
				floatPanel.icon = lastPanelObj.icon;
			if(lastPanelObj.title)
				floatPanel.title = lastPanelObj.title;
			floatPanel.mouseClickHandler = PanelUtil.mouseClickHandler;
			FlexGlobals.topLevelApplication.addElement(floatPanel);		
			dictionary[target.id] = floatPanel;
			dictionary[floatPanel.id] = floatPanel;
			//加载plugin
			var pluginLen:int = plugins.length;
			if(pluginLen)
			{
				var tabNavigator:DockableTabNavigator = new DockableTabNavigator();
				floatPanel.addChild(tabNavigator);
			}
			for(var j:int = 0; j < pluginLen; j++)
			{
				var pluginObj:Object = plugins[j] as Object;
				var queryItem:*;
				if(pluginObj.name)
				{
					var pluginInstance:Class = getDefinitionByName(pluginObj.name) as Class;
					queryItem = new pluginInstance();
				}		
				var navigatorContent:NavigatorContent = new NavigatorContent();
				
				//添加滚动条
				var scroller:Scroller = new Scroller();
				scroller.percentHeight = 100;
				scroller.percentWidth = 100;
				navigatorContent.addElement(scroller);
				
				//添加viewPort
				var group:Group = new Group();
				group.percentHeight = 100;
				group.percentWidth = 100;
				scroller.viewport = group;
				
				if(pluginObj.label)
					navigatorContent.label = pluginObj.label;
				if(pluginObj.iconBar)
					queryItem.iconBar = pluginObj.iconBar;
				if(pluginObj.describe)
					queryItem.describe = pluginObj.describe;
				if(pluginObj.id)
				{
					queryItem.id = pluginObj.id;
					navigatorContent.id = pluginObj.id;
				}
				if(pluginObj.icon)
				{
					navigatorContent.icon = IconUtil.getClass(navigatorContent, String(pluginObj.icon));
				}	
				if(Main.map)
					queryItem.map = Main.map;
				group.addElement(queryItem);
				//TODO:(优化)这句话很重要......根据生命周期可知这里已经添加了对创建完成时间的监听 但是没法进入到对应的监听函数里面去 这里暂时这么处理 后期优化该处
				(queryItem as LayoutContainer).dispatchEvent(new FlexEvent(FlexEvent.CREATION_COMPLETE));
				tabNavigator.addChild(navigatorContent);	
			}					
		}
		
		private function imgMouseOverHandler(event:MouseEvent):void
		{
			tooltip.show(event.currentTarget as DisplayObject, event.currentTarget.name,  event.currentTarget.name );	
		}
	}
}