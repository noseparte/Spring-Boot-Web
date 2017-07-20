var isOverAlarmPopup = false;
var pop =null;
var layers_marker;
function onMapClick(e) {
	var str = e.coordinate[0] + "," + e.coordinate[1];
	coor = [ e.coordinate[0], e.coordinate[1] ];
	if (document.getElementById("zb") != null)
		document.getElementById("zb").value = str;
	if(window.parent.setGISCoordinates){
		window.parent.setGISCoordinates(str);
		map.removeLayer(layers_marker);
		var array_gis_coordinates = str.split(",");
		var markerFeatureTemp = new ol.Feature({
			geometry : new ol.geom.Point([array_gis_coordinates[0], array_gis_coordinates[1]]),
			fType : "marker"
		});
		markerFeatureTemp.setStyle(iconStyle);
		layers_marker = new ol.layer.Vector({
			source: new ol.source.Vector({
				features: [markerFeatureTemp]
			}),
			style: styleFunction
		});
		map.addLayer(layers_marker);
	}
	var feature = map.forEachFeatureAtPixel(e.pixel, function(feature,
			layer) {
		
			return feature;
		
	},null,function(layer){
		return layer===alarmLayer;
	});
	//单击报警点打开窗口
	if(feature!=null){
		//showSelectFeature(feature.getProperties());
		var nearby = getNearby(feature.getGeometry().getCoordinates());
		showAlarmWin(feature.get("aid"),feature.get("title"),feature.get("alarmType"),feature.get("bjwz"),nearby);
	}
//	popRtAlarmInfo(feature);
	
//	}
}
function popRtAlarmInfo(f) {
	if(f!=null){
		if(pop!=null){
			$(element_alarm).popover('hide');
		}
		popup_alarm.setPosition(f.getGeometry().getCoordinates());
	   pop = $(element_alarm).popover({
	      'placement': 'top',
	      'html': true
	      ,'content': f.get('title')
	    });
	    $(element_alarm).popover('show');	
	}else{
		if(!isOverAlarmPopup){
			//$(element_alarm).popover('destroy');
		}
	}
}

// 比例尺单位改变
function onChange() {
	scaleLineControl.setUnits(unitsSelect.value);
}

function locationMap(coord) {
	map.getView().setCenter(coord);
}
function showPopup(coord,text){
	 content.innerHTML = '<code>' + text +
     '</code>';
	 overlay.setPosition(coord);
}

var duration = 3000;
//实时报警点闪烁监听器集合
var listenerMp = new Object();
//实时报警点闪烁
function flash(feature) {
	var start = new Date().getTime();
	//ol.Observable.unByKey(listenerKey);
	var listenerKey;
	var flashGeom;
	function animate(event) {
		var vectorContext = event.vectorContext;
		var frameState = event.frameState;
		if(flashGeom != null){
			flashGeom = null;
		}
		flashGeom= feature.getGeometry().clone();
		
		var elapsed = frameState.time - start;
		var elapsedRatio = elapsed / duration;
		// radius will be 5 at start and 30 at end.
		var radius = ol.easing.easeOut(elapsedRatio) * 25 + 5;
		var opacity = ol.easing.easeOut(1 - elapsedRatio);
		// var opacity=1;
		var flashStyle = new ol.style.Circle({
			radius : radius,
			snapToPixel : false,
			stroke : new ol.style.Stroke({
				//color : 'rgba(255, 0, 0, ' + opacity + ')',
				color : (typeof feature.getProperties().flashColor==="undefined")?'red':feature.getProperties().flashColor,
				width : 2
			})
		});
		vectorContext.setImageStyle(flashStyle);
		vectorContext.drawPointGeometry(flashGeom);
		if (elapsed > duration) {
			// ol.Observable.unByKey(listenerKey);
			// return;
			start = new Date().getTime();

		}
		// tell OL3 to continue postcompose animation
		map.render();
	}
	listenerKey = map.on('postcompose', animate);
	listenerMp[feature.get("aid")] = listenerKey;
}
//历史报警点闪烁监听器
var listenerKey_his;
//当前历史报警点
var curr_his_feature;
//停止 历史报警点闪烁
function stop_flash_his(){
	ol.Observable.unByKey(listenerKey_his);
}
//切换历史报警点闪烁
function restart_flash_his(){
	if(curr_his_feature){
		flash_his(curr_his_feature);
	}
}
//停止所有闪烁
function stop_flash(){
	for(var obj in listenerMp){
		ol.Observable.unByKey(listenerMp[obj]);
	}
}
//根据id停止闪烁
function stop_flashById(id){
	ol.Observable.unByKey(listenerMp[id]);
}
//历史报警点闪烁
function flash_his(feature) {
	curr_his_feature = feature;
	var start = new Date().getTime();
	//同一时刻只有一个圈在闪
	ol.Observable.unByKey(listenerKey_his);
	
	function animate(event) {
		var vectorContext = event.vectorContext;
		var frameState = event.frameState;
		var flashGeom = feature.getGeometry().clone();
		var elapsed = frameState.time - start;
		var elapsedRatio = elapsed / duration;
		// radius will be 5 at start and 30 at end.
		var radius = ol.easing.easeOut(elapsedRatio) * 25 + 5;
		var opacity = ol.easing.easeOut(1 - elapsedRatio);
		// var opacity=1;
		var flashStyle = new ol.style.Circle({
			radius : radius,
			snapToPixel : false,
			stroke : new ol.style.Stroke({
				color : 'rgba(8, 121, 237, ' + opacity + ')',
				width : 4
			})
		});

		vectorContext.setImageStyle(flashStyle);
		vectorContext.drawPointGeometry(flashGeom);
		if (elapsed > duration) {
			// ol.Observable.unByKey(listenerKey);
			// return;
			start = new Date().getTime();

		}
		// tell OL3 to continue postcompose animation
		map.render();
	}
	listenerKey_his = map.on('postcompose', animate);
	//listenerMp[feature.get("id")] = listenerKey_his;
}
function flash2(coor) {
	var point_div = document.getElementById("css_animation");
	var point_overlay = new ol.Overlay({
		element : point_div,
		positioning : 'center-center'
	});
	map.addOverlay(point_overlay);
	point_overlay.setPosition(coor);
}

function IsPC()  
{  
   var userAgentInfo = navigator.userAgent;  
   var Agents = new Array("Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod");  
   var flag = true;  
   for (var v = 0; v < Agents.length; v++) {  
       if (userAgentInfo.indexOf(Agents[v]) > 0) { flag = false; break; }  
   }  
   return flag;  
}
var isPc = IsPC();
function disableGuide(username){
	$.ajax({
        type: "POST",
        url: "user/updateGuide",
        dataType: "JSON",
        data:"username="+username,
        async: false,
        success: function(jsonsData){
		}
	});
}
   
function getCookie(name)
{
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
		return unescape(arr[2]);
	else
		return null;
}
function setCookie(name,value)
{
	var exp = new Date();
	exp.setTime(exp.getTime() + 100000*60*60*1000);
	document.cookie = name + "="+ value+";expires=" + exp.toGMTString();
}