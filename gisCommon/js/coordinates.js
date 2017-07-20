//坐标值
var gis_coordinates = "";
//通过GIS地图，获取坐标点信息，并赋值给文本框
function getCoordinateByGis(lng, lat){
	layer.open({
	    type: 2,
	    title: '获取GIS坐标经纬度',//窗体标题
	    area: ['500px', '500px'],//整个窗体宽、高，单位：像素px
	    fix: false, //窗体位置不固定
	    maxmin: true,//最大、小化是否显示
	    scrollbar: false,//整个页面滚动条是否显示
	    content: ['gis/toGisNew?source=coordinate', 'no'],//URL地址
	    btn: ['获取坐标'],
	    btn1: function(){
	    	if(gis_coordinates != null && gis_coordinates.indexOf(',') != -1){
	    		var array_gis_coordinates = gis_coordinates.split(",");
		        document.getElementById(lng).value = array_gis_coordinates[0];
		        document.getElementById(lat).value = array_gis_coordinates[1];
	    	}
	    }
	});
}
//通过GIS地图，获取坐标值
function setGISCoordinates(coordinates, map){
	gis_coordinates = coordinates;
}