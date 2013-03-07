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
package com.supermap.utils
{
	import com.supermap.containers.QueryPanel;
	import com.supermap.gears.bookmark.BookmarkContainer;
	import com.supermap.gears.draw.DrawLineContainer;
	import com.supermap.gears.draw.DrawPointContainer;
	import com.supermap.gears.draw.DrawRegionContainer;
	import com.supermap.gears.draw.DrawTextContainer;
	import com.supermap.gears.print.PrintContainer;
	import com.supermap.gears.query.QueryContainer;

	public class ReflectUtil
	{
		private var queryPanel:QueryPanel;
		private var queryContainer:QueryContainer;
		private var drawPointContainer:DrawPointContainer;
		private var drawLineContainer:DrawLineContainer;
		private var drawRegionContainer:DrawRegionContainer;
		private var drawTextContainer:DrawTextContainer;
		private var bookmarkContainer:BookmarkContainer;
		private var printContainer:PrintContainer;
		
		public static function initialize():void
		{
			QueryPanel;
			QueryContainer;
			DrawPointContainer;
			DrawLineContainer;
			DrawRegionContainer;
			DrawTextContainer;
			BookmarkContainer;
			PrintContainer;
		}
	}
}