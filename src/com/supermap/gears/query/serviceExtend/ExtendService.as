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
package com.supermap.gears.query.serviceExtend
{
	import com.supermap.web.service.ServiceBase;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class ExtendService extends ServiceBase
	{
		override public function ExtendService()
		{
			super("http://services.supermapcloud.com/iserver");
		}
		
		public function execute(attributeFilter:String, responder:IResponder = null):AsyncToken
		{
			var reqVar:URLVariables = new URLVariables();
			reqVar.servicename = "Search";
			reqVar.methodname = "queryByGeometry";
			if(attributeFilter)
			{
				var commonStr:String = "{\"dataSourceName\":\"china_poi\"," + 
					"\"queryParam\":{\"queryDatasetParams\":[{\"name\":\"PbeijingP\"," +
					"\"sqlParam\":{\"groupClause\":null, \"ids\":null," + 
					"\"returnFields\":[\"SMID\", \"SMX\", \"SMY\", \"Name\", \"PY\", \"POI_ID\", \"ZipCode\", \"Address\", \"Telephone\"]," +
					"\"sortClause\":null, \"attributeFilter\":\"Name like '%" + attributeFilter + "%'\", \"joinItems\":null, \"linkItems\":null}}], " +  
					"\"returnResultSetInfo\":\"ATTRIBUTE\", \"startRecord\":0, \"expectCount\":10, \"sortPriorityType\":-1}," + 
					"\"geometry\":{\"id\":6, \"feature\":5, \"parts\":[4]," +
					"\"point2Ds\":[{\"x\":12921673.5484445, \"y\":4881157.127069949}, {\"x\":12995125.3879325, \"y\":4881157.127069949}, {\"x\":12995125.3879325, \"y\":4823007.75414195}, {\"x\":12921673.5484445, \"y\":4823007.75414195}]}," + 
					"\"queryMode\":\"INTERSECT\"}";
				
				reqVar.parameter = commonStr;
			}
			return sendURL("/cloudhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			if(object)
				var lastResult:ExtendRecordSet = ExtendRecordSet.toExtendRecordSet(object.result[0].records);
			for each (responder in asyncToken.responders)
			{
				responder.result(lastResult);
			}			
		}
	}
}