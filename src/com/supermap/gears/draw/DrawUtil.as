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
package com.supermap.gears.draw
{
	import com.supermap.web.actions.DrawFreeLine;
	import com.supermap.web.actions.DrawFreePolygon;
	import com.supermap.web.actions.DrawLine;
	import com.supermap.web.actions.DrawPoint;
	import com.supermap.web.actions.DrawPolygon;
	import com.supermap.web.actions.DrawRectangle;
	import com.supermap.web.actions.DrawText;
	import com.supermap.web.actions.Pan;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.Map;
	
	import flash.text.TextFormat;

	public class DrawUtil
	{
		public static var map:Map;
		
		public static function drawPointFeature(vo:Object, map:Map):void
		{
			var drawFeaPoint:DrawPoint = new DrawPoint(map);
			drawFeaPoint.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun); 
			
			var markerStyle:PredefinedMarkerStyle = new PredefinedMarkerStyle(
				vo.pointType.id.toLowerCase(),
				vo.pointSize,
				vo.pointColor, 
				0.85); 
			
			var isBorderVisible:Boolean = vo.isBorder;
			var pointBorderStyle:PredefinedLineStyle; 
			if(isBorderVisible == true)
			{
				pointBorderStyle = new PredefinedLineStyle(
					vo.borderType.id,
					vo.borderColor,
					1,
					2);
					markerStyle.border = pointBorderStyle;
			}
			
			drawFeaPoint.style = markerStyle;
			drawFeaPoint.style = markerStyle;
			map.action = drawFeaPoint;
		} 
		
		/**
		 *  绘制线
		 */
		public static function drawLineFeature(vo:Object, map:Map):void
		{
			var lineStyle:PredefinedLineStyle = new PredefinedLineStyle(
				vo.lineType.id.toLowerCase(),
				vo.lineColor,
				0.85,
				vo.lineWidth,
				vo.capType.id.toLowerCase());
			
			if(!vo.drawFreeLine)
			{
				var drawFeaLine:DrawLine  =new DrawLine(map);
				drawFeaLine.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun);
				drawFeaLine.style = lineStyle;
				map.action = drawFeaLine;
			}
			else
			{
				var drawFreeLine:DrawFreeLine  =new DrawFreeLine(map);
				drawFreeLine.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun);
				drawFreeLine.style = lineStyle;
				map.action = drawFreeLine;
			}
		} 
		
		/**
		 *  绘制面
		 */
		public static function drawPolygonFeature(vo:Object, map:Map):void
		{
			var polygonFillStyle:PredefinedFillStyle = new PredefinedFillStyle(
				vo.fillType.id.toLowerCase(), 
				vo.fillColor);
			
			if(vo.hasBorder == true)
			{
				var polygonBorderStyle:PredefinedLineStyle = new PredefinedLineStyle(
					vo.polygonBorderType.id.toLowerCase(),
					vo.polygonBorderColor,
					0.85,
					vo.polygonBorderWidth);
				
				polygonFillStyle.border = polygonBorderStyle;
			}
			
			if(vo.isFreePolygon)
			{
				var drawFreePolygon:DrawFreePolygon = new DrawFreePolygon(map);
				drawFreePolygon.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun);
				drawFreePolygon.style = polygonFillStyle;
				map.action = drawFreePolygon;
			}
			else if(vo.isRect)
			{
				var drawRectangle:DrawRectangle = new DrawRectangle(map);
				drawRectangle.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun);
				drawRectangle.style = polygonFillStyle;
				map.action = drawRectangle;
			}
			else 
			{
				var drawFeaPolygon:DrawPolygon = new DrawPolygon(map);
				drawFeaPolygon.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun);
				drawFeaPolygon.style = polygonFillStyle;
				map.action = drawFeaPolygon;
			}
		} 
		
		/**
		 *  绘制文本
		 */
		public static function drawTextFeature(vo:Object, map:Map):void
		{
			var drawText:DrawText = new DrawText(map);
			drawText.addEventListener(DrawEvent.DRAW_END, drawFeaEndFun);
						
			var textStyle:TextStyle = new TextStyle(null,
				vo.fontColor,
				vo.hasTextBorder,
				vo.borderStyleColor,
				vo.hasBackground,
				vo.backGroundColor);
			
			textStyle.textFormat = new TextFormat(vo.fontFamily, vo.fontWeight);
			textStyle.textFormat.underline = vo.hasUnderLine;
			drawText.textStyle = textStyle;
			map.action = drawText;
		}
		
		public static function drawFeaEndFun(event:DrawEvent):void
		{
			(map.getLayer("drawFeaturesLayer") as FeaturesLayer).addFeature(event.feature);
		}
		
		public static function clear():void
		{
			(map.getLayer("drawFeaturesLayer") as FeaturesLayer).clear();
			map.action = new Pan(map);
		}
		
		public static function setFeaturesLayer():void
		{
			var drawFeaturesLayer:FeaturesLayer = new FeaturesLayer();
			drawFeaturesLayer.id = "drawFeaturesLayer";
			if(!map.getLayer("drawFeaturesLayer"))
			{
				map.addLayer(drawFeaturesLayer);
			}
		}
	}
}