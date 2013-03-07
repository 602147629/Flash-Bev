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
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class ViewerEventDispatcher
	{
		/**
		 * 该方法用于为事件添加侦听器。
		 * @param type 定义事件类型。
		 * @param listener 处理事件的侦听器函数。此函数必须接受 Event 对象作为其唯一的参数，并且不能返回任何结果。
		 * @param useCapture 确定侦听器是运行于捕获阶段还是目标阶段和冒泡阶段。如果将 useCapture 设置为 true，则侦听器只在捕获阶段处理事件，而不在目标或冒泡阶段处理事件。如果 useCapture 为 false，则侦听器只在目标或冒泡阶段处理事件。 
		 * @param priority 事件侦听器的优先级。
		 * @param useWeakReference 确定对侦听器的引用是强引用，还是弱引用。强引用（默认值）可防止您的侦听器被当作垃圾回收。弱引用则没有此作用。
		 */
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			ViewerDispatcher.getInstance().addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * 该方法用于为事件移除侦听器。
		 * @param type 事件的类型。
		 * @param listener 要删除的侦听器对象。
		 * @param useCapture 此参数适用于 SWF 内容所使用的 ActionScript 3.0 显示列表体系结构中的显示对象。指出是为捕获阶段还是目标阶段和冒泡阶段注册了侦听器。如果为捕获阶段以及目标和冒泡阶段注册了侦听器，则需要对 removeEventListener() 进行两次调用才能将这两个侦听器删除，一次调用将 useCapture() 设置为 true，另一次调用将 useCapture() 设置为 false。
		 */
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			ViewerDispatcher.getInstance().removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * 将事件分派到事件流中。事件目标是对其调用 dispatchEvent() 方法的 EventDispatcher 对象。
		 * @param event 分派到事件流中的 Event 对象。如果正在重新分派事件，则会自动创建此事件的一个克隆。 在分派了事件后，其 target 属性将无法更改，因此您必须创建此事件的一个新副本以能够重新分派。
		 */ 
		public static function dispatchEvent(event:Event):Boolean
		{
			return ViewerDispatcher.getInstance().dispatchEvent(event);
		}
	}
}

/////////////////////////////////////////////////////////////////////////////
//
//	Helper Class: ViewerDispatcher
//
/////////////////////////////////////////////////////////////////////////////
import flash.events.EventDispatcher;
class ViewerDispatcher extends EventDispatcher
{
	public function ViewerDispatcher()
	{
		
	}
	
	private static var _instance:ViewerDispatcher;
	public static function getInstance():ViewerDispatcher 
	{
		if ( _instance == null) 
		{
			_instance = new ViewerDispatcher();
		}
		return _instance;
	}
}