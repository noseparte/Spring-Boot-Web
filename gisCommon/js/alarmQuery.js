//$("#EQ_TYPE_ID").createOption();
$("#PP_BH").createOption();
$("#PP_BJLX").createOption();
$("#PP_ZT").createOption();


var array_markers = new Array();
//实时报警图层
var alarmLayer;
//选中报警图层
var alarmLayer_temp;
//历史报警图层
var alarmLayer_his;
//实时报警点集合
var alarmingMap = new Object();
//实时报警数据源
var alarmVector = new ol.source.Vector();
//选中报警点数据源
var alarmVector_temp = new ol.source.Vector();
//历史报警数据源
var alarmVector_his = new ol.source.Vector();
//报警弹窗集合 通过id查询 index
var alarmIndexMap= new Object();
//通过index查询id
var alarmIdMap= new Object();
//通过id查询layer对象
var alarmWinObjMap= new Object();
alarmVector.on('addfeature', function(e) {
	  flash(e.feature);
	});

//历史报警table
var tableAlarm;
//历史相似报警table
var tableAlarm_rel;
//相似报警table显示状态
var isSubShow = false;
//多选时记录选择行 目前不支持多选。
var selMap = new Object();
var tempIcon;

var imageAlarm = new ol.style.Circle({
	radius : 5,
	fill : new ol.style.Fill({
		color:'red'
	}),
	stroke : new ol.style.Stroke({
		color : 'red',
		width : 3
	})
});
var iconStyleMap = new Object();
function createIconStyle_default(){
	//报警点图标
	//甲烷
	var iconStyle_jwnd = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	      anchor: [1.5, 0.5],
	      anchorXUnits: 'fraction',
	      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/jw.png'
	    }))
	  });
	iconStyleMap["iconStyle_jwnd"]=iconStyle_jwnd;
	//甲烷电量
	var iconStyle_jwdl = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	      anchor: [-0.5, 0.5],
	      anchorXUnits: 'fraction',
	      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/jwdl.png'
	    }))
	  });
	iconStyleMap["iconStyle_jwdl"]=iconStyle_jwdl;
	var iconStyle_dts = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	      anchor: [0.5, 0.5],
	      anchorXUnits: 'fraction',
	      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/dts.png'
	    }))
	  });
	iconStyleMap["iconStyle_dts"]=iconStyle_dts;
	iconStyleMap["iconStyle_dts_一级"]=iconStyle_dts;
	iconStyleMap["iconStyle_dts_二级"]=iconStyle_dts;
	iconStyleMap["iconStyle_dts_三级"]=iconStyle_dts;
	var iconStyle_dvs = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	    	  anchor: [0.5, 0.5],
		      anchorXUnits: 'fraction',
		      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/dvs.png'
	    }))
	  });
	iconStyleMap["iconStyle_dvs"]=iconStyle_dvs;
	iconStyleMap["iconStyle_dvs_一级"]=iconStyle_dvs;
	iconStyleMap["iconStyle_dvs_二级"]=iconStyle_dvs;
	iconStyleMap["iconStyle_dvs_三级"]=iconStyle_dvs;
	var iconStyle_dx = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	    	  anchor: [0.5, 0.5],
		      anchorXUnits: 'fraction',
		      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/dx.png'
	    }))
	  });
	var iconStyle_qc = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	    	  anchor: [0.5, 0.5],
		      anchorXUnits: 'fraction',
		      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/truck.gif'
	    }))
	  });
	iconStyleMap["iconStyle_dvs_1060205"]=iconStyle_qc;
	var iconStyle_hc = new ol.style.Style({
	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
	    	  anchor: [0.5, 0.5],
		      anchorXUnits: 'fraction',
		      anchorYUnits: 'fraction',
	      opacity: 0.75,
	      src: 'gisCommon/common/img/train.gif'
	    }))
	  });
	iconStyleMap["iconStyle_dvs_1060206"]=iconStyle_hc;
	iconStyleMap["iconStyle_dvs_断纤"]=iconStyle_dx;
	iconStyleMap["iconStyle_dvs_断纤一级"]=iconStyle_dx;
	iconStyleMap["iconStyle_dvs_断纤二级"]=iconStyle_dx;
	iconStyleMap["iconStyle_dvs_断纤三级"]=iconStyle_dx;
	iconStyleMap["iconStyle_dts_断纤"]=iconStyle_dx;
	iconStyleMap["iconStyle_dts_断纤一级"]=iconStyle_dx;
	iconStyleMap["iconStyle_dts_断纤二级"]=iconStyle_dx;
	iconStyleMap["iconStyle_dts_断纤三级"]=iconStyle_dx;
	
	//选中报警点图标
//	var iconStyle_dts_sel = new ol.style.Style({
//	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//	      anchor: [0.5, 28],
//	      anchorXUnits: 'fraction',
//	      anchorYUnits: 'pixels',
//	      opacity: 0.75,
//	      src: 'gisCommon/common/img/dts_sel.png'
//	    }))
//	  });
//	var iconStyle_dvs_sel = new ol.style.Style({
//	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//	      anchor: [0.5, 28],
//	      anchorXUnits: 'fraction',
//	      anchorYUnits: 'pixels',
//	      opacity: 0.75,
//	      src: 'gisCommon/common/img/dvs_sel.png'
//	    }))
//	  });
//	var iconStyle_dx_sel = new ol.style.Style({
//	    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//	      anchor: [0.49, 28],
//	      anchorXUnits: 'fraction',
//	      anchorYUnits: 'pixels',
//	      opacity: 0.75,
//	      src: 'gisCommon/common/img/dx_sel.png'
//	    }))
//	  });
}
createIconStyle_default();
function createIconStyle(type,config){
	if(config == "null"){
		createIconStyle_default(type);
	}else{
		var bhs = config.split(",")[0].split(";");
		var pics = config.split(",")[1].split(";");
		var colors = config.split(",")[2].split(";");
		for(var i=0;i<bhs.length;i++){
			var iconStyle = new ol.style.Style({
				image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
		        anchor: [0.5, 0.5],
		        anchorXUnits: 'fraction',
		        anchorYUnits: 'fraction',
		        opacity: 0.75,
		        src: 'filesUploads/download?ID='+pics[i]
		      }))
		    });
			iconStyleMap["iconStyle_"+type+"_"+bhs[i]] = iconStyle;
			iconStyleMap["iconStyle_"+type+"_"+bhs[i]+"_color"] = colors[i];
		}
	}
}
createIconStyle("dvs",dvsLegend);
createIconStyle("dts",dtsLegend);
createIconStyle("jwnd",jwndLegend);
createIconStyle("jwdl",jwdlLegend);
createIconStyle("jwwd",jwwdLegend);
createIconStyle("jwyw",jwywLegend);
////报警点图标
//var iconStyle_dts = new ol.style.Style({
//    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//      anchor: [0.5, 15],
//      anchorXUnits: 'fraction',
//      anchorYUnits: 'pixels',
//      opacity: 0.75,
//      src: 'gisCommon/common/img/dts.png'
//    }))
//  });
//var iconStyle_dvs = new ol.style.Style({
//    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//      anchor: [0.5, 15],
//      anchorXUnits: 'fraction',
//      anchorYUnits: 'pixels',
//      opacity: 0.75,
//      src: 'gisCommon/common/img/dvs.png'
//    }))
//  });
//
//var iconStyle_dx = new ol.style.Style({
//    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//      anchor: [0.5, 15],
//      anchorXUnits: 'fraction',
//      anchorYUnits: 'pixels',
//      opacity: 0.75,
//      src: 'gisCommon/common/img/dx.png'
//    }))
//  });
////选中报警点图标
//var iconStyle_dts_sel = new ol.style.Style({
//    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//      anchor: [0.5, 28],
//      anchorXUnits: 'fraction',
//      anchorYUnits: 'pixels',
//      opacity: 0.75,
//      src: 'gisCommon/common/img/dts_sel.png'
//    }))
//  });
//var iconStyle_dvs_sel = new ol.style.Style({
//    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//      anchor: [0.5, 28],
//      anchorXUnits: 'fraction',
//      anchorYUnits: 'pixels',
//      opacity: 0.75,
//      src: 'gisCommon/common/img/dvs_sel.png'
//    }))
//  });
//var iconStyle_dx_sel = new ol.style.Style({
//    image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
//      anchor: [0.49, 28],
//      anchorXUnits: 'fraction',
//      anchorYUnits: 'pixels',
//      opacity: 0.75,
//      src: 'gisCommon/common/img/dx_sel.png'
//    }))
//  });
var imageAlarm_curr = new ol.style.Circle({
	radius : 6,
	fill : new ol.style.Fill({
		color:'yellow'
	}),
	stroke : new ol.style.Stroke({
		color : 'red',
		width : 3
	})
});
var alarmStyle = new ol.style.Style({
	image : imageAlarm
});
var alarmStyle_curr = new ol.style.Style({
	image : imageAlarm_curr
});
//定位
function locationAlarm(coord) {
	 var pan = ol.animation.pan({
         duration: 500,
         source: /** @type {ol.Coordinate} */ (view.getCenter())
       });
      // map.beforeRender(pan);
//	 document.getElementById('bgsound').play();
       view.setCenter(coord);
	// map.getView().setCenter(coord);
	// flash2(coord);
}
//打开关闭报警历史查询窗口时，隐藏显示历史报警地图图标
function setHisLayerVisible(isShow){
	alarmLayer_his.setVisible(isShow);
	if(isShow){
		restart_flash_his();
	}else{
		stop_flash_his();
	}
}
//单击报警历史表行时在地图上显示报警点
function showAlarmPoint_his(row) {
	alarmVector_his = new ol.source.Vector();
	alarmVector_his.on('addfeature', function(e) {
		  flash_his(e.feature);
		});
	var point = new ol.geom.Point([ row.lng, row.lat ]);
	
	var featureTemp = new ol.Feature({
		geometry : point,
		title:row.bjwz
	});
	if("methane" == row.bjlx){
		featureTemp.setStyle(getIconStyle_config(row.typeCode,false,row.alevel));
	}else{
		featureTemp.setStyle(getIconStyle_config(row.bjlx,false,row.level));
	}
	alarmVector_his.addFeature(featureTemp);
	
//	 var iconFeature = new ol.Feature({
//	        geometry: new ol.geom.Point([118.8017749786377,32.074198722839355])
//	      
//	      });
//	 iconFeature.setStyle(iconStyle_alarm_gc);
//	 alarmVector.addFeature(iconFeature);
	// var pos = ol.proj.fromLonLat([118.7940502166748,32.066988945007324]);

     // Vienna marker
// var marker = new ol.Overlay({
// position: [row.lng, row.lat],
// positioning: 'center-center',
// element: document.getElementById('marker'),
// stopEvent: false
// });
// map.addOverlay(marker);
     
     
	 alarmLayer_his.setSource(alarmVector_his);
//	 if(popup_alarm!=null){
//		 $(element_alarm).popover('hide');
//		 map.removeOverlay(popup_alarm);
//	 }
//	 element_alarm = document.getElementById('popup_alarm');
//	 popup_alarm = new ol.Overlay({
//	       element: element_alarm,
//	       positioning: 'bottom-center',
//	       stopEvent: false
//		    });
//     map.addOverlay(popup_alarm);
//	 popup_alarm.setPosition([ row.lng, row.lat ]);
//	 $(element_alarm).popover({
//		 'trigger':'click',
//	      'placement': 'top',
//	      'html': true
//	      ,'content': row.bjwz
//	    });
}
var global_bjwz;
function showAlarmWin(id,title,alarmType,bjwz,nearby){
	if(alarmIndexMap[id] != null){
		layer.setTopByCall(alarmWinObjMap[id]);
		return;
	}
	global_bjwz =  bjwz.replace("</br>",";");
	if(alarmType=="jwdl" || alarmType=="jwnd" || alarmType=="jwwd" || alarmType=="jwyw"){
		alarmType ="methane";
	}
	var url = encodeURI('gis/alarm/queryAlarmDetail?id='+id+"&PP_BJLX="+alarmType+"&bjwz="+bjwz+"&nearbyid="+nearby.featureid);
	var width = screen.width>=400?"400px":"100%";
	var height = screen.height>=1000?"500px":"100%";
	var index = layer.open({
	    type: 2,
	    title:title,
	    skin: 'layui-layer-rim', //加上边框
	    area: [width, height], //宽高
	    scrolling:'yes',
	    scrollbar:'yes',
	    closeBtn: 1,
	    
	    maxmin: false,
	    //content: 'html内容',
	    content: [url, 'yes'],
	    shade: 0,
	    success: function(layero){
            layer.setTop(layero); //重点2
            alarmWinObjMap[id] = layero;
	    },
	    cancel:function(index){
//	    	console.info(index);
	    	var id = alarmIdMap[index];
	    	delete alarmIndexMap[id];
	    	delete alarmWinObjMap[id];
	    	delete alarmIdMap[index];
	    }
	});
	alarmIndexMap[id] = index;
	alarmIdMap[index] = id;
}
//在地图上删除报警点
function removeAlarm(id){
	if(typeof alarmingMap[id]  ==='undefined'){
		return ;
	}
	alarmVector.removeFeature(alarmingMap[id]);
	stop_flashById(id);
	alarmingMap[id]=null;
}
//在地图上删除所有报警点
function clearAlarm(){
	alarmVector = new ol.source.Vector();
	
	alarmVector_temp = new ol.source.Vector();
	tempIcon = null;
	alarmLayer_temp.setSource(alarmVector_temp);
	alarmLayer.setSource(alarmVector);
	alarmVector.on('addfeature', function(e) {
		  flash(e.feature);
		});
	alarmingMap = new Object();
	stop_flash();
	//Player.controls.stop();
}
//关闭
function closeWinByAlarmId(id){
	var index = alarmIndexMap[id];
	delete alarmIndexMap[id];
	delete alarmWinObjMap[id];
	layer.close(index);
	removeAlarm(id);
	if(tempIcon){
		alarmVector_temp.removeFeature(tempIcon);
		tempIcon = null;
	}
	ol.Observable.unByKey(listenerMp[id]);
	parent.closeToastrById(id);
}
function getMarkers_alarm(){
	$.ajax({
		type: "POST",
		url: "gis/getMarkerBy?isAlarm=1",
		dataType: "JSON",
		async: true,
		success: function(jsonsData_marker){
			if(jsonsData_marker != null && jsonsData_marker.length > 0){
				array_markers = jsonsData_marker;
				
			}
		}
	});
}
//function getNearby(coor1){
//	var wgs84Sphere = new ol.Sphere(6378137);
//	var distance=9999999999999999999999;
//	var featureObj = new Object();
//	featureObj.featureName="";
//	featureObj.featureid="";
//	featureObj.length=0;
//	for ( var i = 0; i < temp_layers.length; i++) {
//
//		if (temp_layers[i].getProperties().code.startWith("marker")) {
//			if (temp_layers[i].getSource() == null) {
//				continue;
//			}
//			for ( var j = 0; j < temp_layers[i].getSource().getFeatures().length; j++) {
//				var feature = temp_layers[i].getSource().getFeatures()[j];
//				var a=123;
//				if (feature.getGeometry() instanceof ol.geom.Point) {
//					if(feature.getProperties().mapalarm=="011001"){
//						var coor2 = feature.getGeometry().getCoordinates();
//						var length = wgs84Sphere.haversineDistance(coor1,coor2);
//						if(length<distance){
//							distance = length;
//							feature.length = distance;
//							featureObj.featureName = feature.getProperties().name;
//							featureObj.featureid = feature.getProperties().id;
//						}
//					}
//				}
//			}
//		}
//	}
//	return featureObj;
//}

function getNearby(coor1){
	var wgs84Sphere = new ol.Sphere(6378137);
	var distance=9999999999999999999999;
	var featureObj = new Object();
	featureObj.featureName="";
	featureObj.featureid="";
	featureObj.length=0;
	for ( var j = 0; j < array_markers.length; j++) {
		var feature = array_markers[j];
			if(array_markers[j].M_MAPALARM=="011001"){
				var coor2 = [array_markers[j].M_LON,array_markers[j].M_LAT];
				var length = wgs84Sphere.haversineDistance(coor1,coor2);
				if(length<distance){
					distance = length;
					featureObj.length = Math.ceil(distance);
					featureObj.featureName = array_markers[j].M_NAME;
					featureObj.featureid = array_markers[j].M_ID;
				}
			}
	}
//	for ( var i = 0; i < temp_layers.length; i++) {
//
//		if (temp_layers[i].getProperties().code.startWith("marker")) {
//			if (temp_layers[i].getSource() == null) {
//				continue;
//			}
//			for ( var j = 0; j < temp_layers[i].getSource().getFeatures().length; j++) {
//				var feature = temp_layers[i].getSource().getFeatures()[j];
//				var a=123;
//				if (feature.getGeometry() instanceof ol.geom.Point) {
//					if(feature.getProperties().mapalarm=="011001"){
//						var coor2 = feature.getGeometry().getCoordinates();
//						var length = wgs84Sphere.haversineDistance(coor1,coor2);
//						if(length<distance){
//							distance = length;
//							feature.length = distance;
//							featureObj.featureName = feature.getProperties().name;
//							featureObj.featureid = feature.getProperties().id;
//						}
//					}
//				}
//			}
//		}
//	}
	return featureObj;
}

function showAlarmPointMutli(row,isclick,needOpenWin) {
	if(isclick){
		if(row.lng !=null && row.lat!=null){
			locationAlarm([ row.lng, row.lat ]);
		}
		if(needOpenWin){
			var nearby = getNearby([ row.lng, row.lat ]);
			showAlarmWin(row.aid,row.ppname,row.alarmType,row.bjwz,nearby);
		}
	}
	if(alarmingMap[row.aid]!=null || alarmingMap[row.id]!=null){
		//showSelectFeature(row);
		return;
	}
	
	
//	alarmVector.on('addfeature', function(e) {
//		  flash(e.feature);
//		});
	var point = new ol.geom.Point([ row.lng, row.lat ]);
	var featureTemp = new ol.Feature({
		geometry : point,
		title:row.ppname,
		aid:row.aid,
		alevelname:row.alevelname,
		lng:row.lng,
		lat:row.lat,
		flashColor:iconStyleMap["iconStyle_"+row.alarmType+"_"+row.alevel+"_color"],
		alarmType:row.alarmType,
		bjwz:row.bjwz
	});
	featureTemp.setStyle(getIconStyle_config(row.alarmType,false,row.alevelname,row.alevel));
	if(voiceSwitch.indexOf(row.alevel+";")>=0){
		if(document.getElementById(row.atype+"_voice").paused){
			document.getElementById(row.atype+"_voice").play();
			setTimeout("stopVoice('"+row.atype+"_voice')", 10000)
		}
		
	}
//	if(row.alarmType=="dvs"){
//		if(row.alevelname=="断纤"){
//			featureTemp.setStyle(iconStyle_dx);
//		}else{
//			featureTemp.setStyle(iconStyle_dvs);
//		}
//	}else{
//		if(row.alevelname=="断纤"){
//			featureTemp.setStyle(iconStyle_dx);
//		}else{
//			featureTemp.setStyle(iconStyle_dts);
//		}
//	}
	alarmVector.addFeature(featureTemp);
	if(row.aid){
		alarmingMap[row.aid] = featureTemp;
	}
//	 var iconFeature = new ol.Feature({
//	        geometry: new ol.geom.Point([118.8017749786377,32.074198722839355])
//	      
//	      });
//	 iconFeature.setStyle(iconStyle_alarm_gc);
//	 alarmVector.addFeature(iconFeature);
	// var pos = ol.proj.fromLonLat([118.7940502166748,32.066988945007324]);

     // Vienna marker
// var marker = new ol.Overlay({
// position: [row.lng, row.lat],
// positioning: 'center-center',
// element: document.getElementById('marker'),
// stopEvent: false
// });
// map.addOverlay(marker);
     
     
	 alarmLayer.setSource(alarmVector);
	 //Player.controls.play();
//	 if(popup_alarm!=null){
//		 $(element_alarm).popover('hide');
//		 map.removeOverlay(popup_alarm);
//	 }
//	 element_alarm = document.getElementById('popup_alarm');
//	 popup_alarm = new ol.Overlay({
//	       element: element_alarm,
//	       positioning: 'bottom-center',
//	       stopEvent: false
//		    });
//     map.addOverlay(popup_alarm);
//	 popup_alarm.setPosition([ row.lng, row.lat ]);
//	 $(element_alarm).popover({
//		 'trigger':'click',
//	      'placement': 'top',
//	      'html': true
//	      ,'content': row.bjwz
//	    });
}
// function refreshAlarmPoint(row) {
// alarmVector = new ol.source.Vector();
// locationAlarm([ row.lng, row.lat ]);
// var selRow = tableAlarm.bootstrapTable('getAllSelections');
// for ( var i = 0; i < selRow.length; i++) {
// selMap[selRow[i].id] = selRow[i];
// }
// for ( var obj in selMap) {
// if (selMap[obj]) {
// var point = new ol.geom.Point([ selMap[obj].lng, selMap[obj].lat ]);
// var featureTemp = new ol.Feature({
// geometry : point
// });
// featureTemp.setStyle(alarmStyle);
// alarmVector.addFeature(featureTemp);
// }
// }
// alarmLayer.setSource(alarmVector);
// }
// function unCheck(row, el) {
// for ( var obj in selMap) {
// if (selMap[obj] && selMap[obj].id == row.id) {
// selMap[obj] = null;
// }
// }
// refreshAlarmPoint();
// }
function stopVoice(id){
	//alert(id);
	document.getElementById(id).pause();
}
//突出 显示 被选中的 Featrue
function showSelectFeature(obj){
	var temp_point = new ol.geom.Point([ obj.lng, obj.lat ]);
	if(tempIcon!=null){
		tempIcon.setStyle(getIconStyle_config(obj.alarmType,true,obj.alevelname));
//		if(row.alarmType=="dvs"){
//			if(row.alevelname=="断纤"){
//				tempIcon.setStyle(iconStyle_dx_sel);
//			}else{
//				tempIcon.setStyle(iconStyle_dvs_sel);	
//			}
//		}else{
//			if(row.alevelname=="断纤"){
//				tempIcon.setStyle(iconStyle_dx_sel);
//			}else{
//				tempIcon.setStyle(iconStyle_dts_sel);
//			}
//		}
		tempIcon.setGeometry(temp_point);
	}else{
		tempIcon = new ol.Feature({
			geometry : temp_point,
		})
		tempIcon.setStyle(getIconStyle_config(obj.alarmType,true,obj.alevelname));
//		if(row.alarmType=="dvs"){
//			if(row.alevelname=="断纤"){
//				tempIcon.setStyle(iconStyle_dx_sel);
//			}else{
//				tempIcon.setStyle(iconStyle_dvs_sel);	
//			}
//		}else{
//			if(row.alevelname=="断纤"){
//				tempIcon.setStyle(iconStyle_dx_sel);
//			}else{
//				tempIcon.setStyle(iconStyle_dts_sel);
//			}
//		}
//		
		alarmVector_temp.addFeature(tempIcon);
		alarmLayer_temp.setSource(alarmVector_temp);
	}
}
function getIconStyle(type,isSelect,levelname){
	type = type.toLowerCase();
	var fstyle;
	if(type=="dvs"){
		if(levelname=="断纤"){
			fstyle = eval("iconStyle_dvs_"+levelname+(isSelect?"_sel":""));
		}else{
			fstyle = eval("iconStyle_dvs_"+levelname+(isSelect?"_sel":""));
		}
	}else{
		if(levelname=="断纤"){
			fstyle = eval("iconStyle_dts_"+levelname+(isSelect?"_sel":""));
		}else{
			fstyle = eval("iconStyle_dts_"+levelname+(isSelect?"_sel":""));
		}
	}
	return fstyle ;
}
function getIconStyle_config(type,isSelect,levelname,alevel){
	type = type.toLowerCase();
	var fstyle;
	if(typeof iconStyleMap["iconStyle_"+type+"_"+alevel] ==='undefined' ){
		if(iconStyleMap["iconStyle_"+type+"_"+levelname] !=null){
			return iconStyleMap["iconStyle_"+type+"_"+levelname];
		}else{
			return iconStyleMap["iconStyle_"+type];
		}
	}
	return iconStyleMap["iconStyle_"+type+"_"+alevel]
}
function processCheckbox(data) {
	for ( var i = 0; i < data.rows.length; i++) {
		if (selMap[data.rows[i].id] != null) {
			tableAlarm.bootstrapTable('check', i);
		}
	}
}
var isRowChange=false;
function queryAlarm() {
	
	alarmLayer = new ol.layer.Vector({
		'title' : "temp_alarm_layer",
		'zIndex':100
	});
	map.addLayer(alarmLayer);
	alarmLayer_temp = new ol.layer.Vector({
		'title' : "temp_alarm_layer1",
		'zIndex':100
	});
	alarmLayer_his = new ol.layer.Vector({
		'title' : "temp_alarm_layer_his",
		'zIndex':100
	});
	map.addLayer(alarmLayer_temp);
	map.addLayer(alarmLayer_his);
	// if (isInit) {
	var initTblHeight= document.body.offsetHeight<523?document.body.offsetHeight:537;
	//var initTblHeight= document.body.offsetHeight<323?document.body.offsetHeight:357;
	if(!isPc) initTblHeight=0
	tableAlarm = $('#alarmTable').bootstrapTable({
		url : undefined,
		toolbar : '#toolbar',
		showCheckbox : false,
		showRefresh : false,
		showColumns : false,
		showToggle : false,
		clickToSelect : false,
		striped : false,
		height : initTblHeight,
		showSeqColumn:false,
		pageSize:10,
// onCheck : function(row, el) {
//
// refreshAlarmPoint(row);
// },
// onUncheck : function(row, el) {
// unCheck(row, el);
// },
		onLoadSuccess : function(data) {
			// processCheckbox(data);
		},
		onClickCell : function(field, value, row, $element) {
			// $('.seleceRow').removeClass('seleceRow');
			// $element.parent().addClass('seleceRow');
			showAlarmPoint_his(row);
			
			onMainTblClick(row);
			locationAlarm([ row.lng, row.lat ]);
		},
		columns : [ {
			field : 'id',
			visible : false,
			halign : 'center',
		}, {
			field : 'aDVS_lng',
			visible : false,
			halign : 'center',
		}, {
			field : 'aDVS_lat',
			visible : false,
			halign : 'center',
		}, {
			field : 'pp_name',
			title : '管道/设备',
			align : 'center',
			halign : 'center',
			width : '200px'
		}, {
			field : 'bjwz',
			title : '位置(米)',
			align : 'center',
			halign : 'center',
			width : '90px'
		}, {
			field : 'level',
			title : '等级',
			align : 'center',
			halign : 'center',
		}, {
			field : 'bjsj',
			title : '报警时间',
			align : 'center',
			halign : 'center',
		}, {
			field : 'zt',
			title : '状态',
			align : 'center',
			halign : 'center',
		} , {
			field : 'bjlx',
			title : '类型',
			visible:false,
			align : 'center',
			halign : 'center',
		} , {
			field : 'typeCode',
			title : '甲烷类型',
			visible:false,
			align : 'center',
			halign : 'center',
		} ]
	});
	// isInit=false;
	// }else{
	// bstQuery();
	// }
};
var url = "";
var currRow;
function onMainTblClick(row) {
	// tableAlarm_rel.height="223";
	currRow = row;
	 if (isPc) {
		document.getElementById("charFrame").src = "gis/toGisCharts.do?pid=010801";
		url = 'gis/alarm/queryRelationAlarm?PP_BH=' + row.pp_id + "&bjwz="
				+ row.bjwz + "&PP_ALARM_TIME=" + row.bjsj + "&PP_BJLX="
				+ $('#PP_BJLX').val()+"&rel_id="+row.id;

		bstParamQuery({
			'url' : url
		}, "relationAlarmTable");
	 }
}
function onSubShowRefresh(){
	if(currRow == undefined){
		return;
	}
	onMainTblClick(currRow);
}
function queryRelationAlarm() {

	// if (isInit) {
	tableAlarm_rel = $('#relationAlarmTable').bootstrapTable({
		url : undefined,
		showCheckbox : false,
		showRefresh : false,
		showColumns : false,
		showToggle : false,
		showSeqColumn:false,
		height : '270',
		pageSize : 5,
		columns : [ {
			field : 'id',
			visible : false,
			halign : 'center',
		}, {
			field : 'aDVS_lng',
			visible : false,
			halign : 'center',
		}, {
			field : 'aDVS_lat',
			visible : false,
			halign : 'center',
		}, {
			field : 'pp_name',
			title : '管道',
			align : 'center',
			halign : 'center',
			width : '130px'
		}, {
			field : 'bjwz',
			title : '位置(米)',
			align : 'center',
			halign : 'center',
			width : '80px'
		}, {
			field : 'level',
			title : '等级',
			align : 'center',
			halign : 'center',
			width:'50px'
		}, {
			field : 'bjsj',
			title : '报警时间',
			align : 'center',
			halign : 'center'
			
		} , {
			field : 'zt',
			title : '状态',
			align : 'center',
			halign : 'center',
			width:'60px'
		} ]
	});
};
function initAlarm() {
	// 坐标定位层
	var image = new ol.style.Circle({
		radius : 5,
		fill : null,
		stroke : new ol.style.Stroke({
			color : 'blue',
			width : 2
		})
	});
	iconStyleTemp = new ol.style.Style({
		image : image
	});
}
//GIS地图报警查询按钮
function onclickQueryAlarm() {
	var bjlxSel = $("#PP_BJLX").val();
	bstParamQuery({
		'url' : 'gis/alarm/pageSearch'
	}, "alarmTable");
	if("010603" == bjlxSel || "010604" == bjlxSel || "010605" == bjlxSel || "010606" == bjlxSel){
		if(isSubShow){
			showOrHideSub();
		}
		$("#iconI").hide();
	}else{
		$("#iconI").show();
	}
	if(!isPc)
		document.getElementById("mbbox").style.height = document.body.offsetHeight - 50 + "px";
}
//GIS地图报警查询结果，扩展页面
function showOrHideSub() {
	if (isSubShow) {
		document.getElementById("subInfo").style.visibility = "hidden";
		document.getElementById("mbbox").style.width = "700px";
		$('#subInfo').css("width", "0px");
		$('#subInfo').css("height", "0px");
		isSubShow = false;
		$('#iconI').addClass("flipx");
		$('#iconI').removeClass("no_flipx");
		// $('#iconDiv').css("right","0");
	} else {
		isSubShow = true;
		if(tableAlarm_rel.bootstrapTable('getOptions').url == undefined){
			onSubShowRefresh();
		}else{
			// tableAlarm_rel.bootstrapTable('getOptions').url = url;
			if(currRow !=undefined){
				tableAlarm_rel.bootstrapTable('refresh');
			}
		}
		document.getElementById("subInfo").style.visibility = "visible";
		document.getElementById("mbbox").style.width = "1185px";
		$('#subInfo').css("width", "500px");
		$('#subInfo').css("height", "100%");
		
		$('#iconI').removeClass("flipx");
		$('#iconI').addClass("no_flipx");
		// $('#iconDiv').css("right","-5");
	}
}
function showTruckOrTrain(data){
	var element =createOverlayElement(data.aid,data.alevel);
	
	var marker = new ol.Overlay({
		 position: [data.lng, data.lat],
		 positioning: 'center-center',
		 element: element,
		 stopEvent: false
		 });
	map.addOverlay(marker);
	setTimeout(function(){removeOL(element.id)},parent.getAlarmDvsTraficLasttime())
}
function removeOL(id){
	$("#"+id).remove();
}
function createOverlayElement(id,level){
	var imgSrc = "";
//	if(level==parent.getAlarmTruck()){
	imgSrc +=iconStyleMap["iconStyle_dvs_"+level].getImage().getSrc();
//	}else if(level==parent.getAlarmTrain()){
//		imgSrc+="train.gif";
//	}
	var elm = $("<div  id='alarmOL_"+id+"'><img style='width:35px;height:15px' src='"+imgSrc+"'/></div>");
	$("body").append(elm);
	return document.getElementById("alarmOL_"+id);
}
function clearSubTbl(){
	tableAlarm_rel.bootstrapTable('removeAll');
	document.getElementById("charFrame").src="";
	currRow = undefined;
}
function initSize(){
	if(isPc){
		document.getElementById("alarmTblContainer").style.width="685px";
		document.getElementById("mbbox").style.width="700px";
		document.getElementById("subInfo").style.visibility = "hidden";
		document.getElementById("PP_BJLX").style.width="80px";
		document.getElementById("PP_ZT").style.width="95px";
		document.getElementById("PP_QSRQ").style.width="95px";
		document.getElementById("PP_JSRQ").style.width="95px";
	}else{
		document.getElementById("alarmTblContainer").style.width="100%";
		document.getElementById("mbbox").style.width="100%";
		document.getElementById("mbbox").style.overflow="auto";
		var toolbar = document.getElementById("toolbar");
		toolbar.parentNode.style.width="100%"
		removeElmOnMobile();
		document.getElementById("PP_BH").style.width="100%";
	}
	
	$('#subInfo').css("width", "0px");
	$('#subInfo').css("height", "0px");
	isSubShow = false;
	$('#iconI').addClass("flipx");
	$('#iconI').removeClass("no_flipx");
}
$('#alarmTable').on('click-row.bs.table', function(e, row, $element) {
	$('.seleceRow').removeClass('seleceRow');
	$element.addClass('seleceRow');
});
function removeElmOnMobile(){
	$("#subInfo").remove();
	$("#iconI").remove();
}
function initBjdj(){
	var bjdjSel = document.getElementById("bjdj");
	var bjlxSel = document.getElementById("PP_BJLX");
	bjdjSel.attributes["ajax--url"].nodeValue ="gis/alarm/getAlarmlevelByType?Code="+$("#PP_BJLX").val();
	$("#bjdj").empty();
	$("#bjdj").append("<option value=''>等级</option>");
	$("#bjdj").createOption();
}
function bjlxChg(){
	initBjdj();
}
queryRelationAlarm();
queryAlarm();
initSize();
initBjdj()
//setTimeout("initBjdj()",1000);
