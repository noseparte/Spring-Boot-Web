var map;
var map_width_change = 0;
var map_height_change = 0;
var view;
var projection;
var projection_image;
var source_icon_temp;
var layerTemp;
var iconStyleTemp;
var coor;
var layerSwitcher;
// var layer_vector_icon
var initExtentCode = "var extent = [" + initExtentStr + "];"
// alert(initExtentCode);
eval(initExtentCode);
// var extent = [ 118.72246742248535,32.110419273376465,
// 118.86820793151855,32.03883647918701 ];
function initExtent() {
	var view = map.getView();
	// var extent = !this.extent_ ?
	// view.getProjection().getExtent() : this.extent_;
	var size = map.getSize();
	// goog.asserts.assert(size, 'size should be defined');
	view.fit(extent, size);
}

function init() {
	// alarmVector = new ol.source.Vector();

	// 基础地形图(Base maps)图层组

	// 设置投影
	projection = new ol.proj.Projection({
		code : 'EPSG:4326',
		units : 'degrees',
		axisOrientation : 'neu'
	});

	// 设置初始比例尺单位
	scaleLineControl.setUnits("metric");
	view = new ol.View({
		projection : projection,// 投影
		// center : [ 118.79680362583134, 32.07446994848293 ],// 中心点
		// zoom : 14,// 层级
		rotation : 0
	});
	// 最基本的容器对象
	var aaa;
	var abc = new Array(1);
	if(overlay != null){
		aaa = overlay;
		abc[0] = aaa;
	}
	map = new ol.Map({
		controls : ol.control.defaults({
			attribution : false,
			zoom : false
		}).extend([
		// myFullScreen,
		scaleLineControl]),
		// 加入基础地形图
		layers : [ new ol.layer.Group({
			'title' : '基础地形图',
			layers : layers
		}) ],
		overlays: abc,
		// 设置地图的html容器id
		target : document.getElementById('map'),
		view : view
	});
	var geolocation = new ol.Geolocation({
		// take the projection to use from the map's view
		projection : view.getProjection()
	});
	// listen to changes in position
	geolocation.on('change', function(evt) {
		alert(geolocation.getPosition())
	});
	geolocation.on('error', function(error) {
		alert(error.message)
	});

	initExtent();
	// 鼠标经过要素时弹出气泡提示.
	var element = document.getElementById('popup');
	var popup = new ol.Overlay({
		element : element,
		positioning : 'bottom-center',
		stopEvent : false
	});
	map.addOverlay(popup);

	// display popup on click
	// 实现要素单击事件
	map.on('click', function(evt) {
		// 获取被点击的要素
		var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature,
				layer) {
			return feature;
		});
	});
	if (schema == "full") {
		map.on('change:size', function(evt) {
			// var a=123;
			// arrangeAll();
			map_height_change = evt.oldValue[1] - map.getSize()[1];
			map_width_change = evt.oldValue[0] - map.getSize()[0];
			arrangeAll();
		})
	}
	;

	// 通过map的pointermove事件变相实现feature的onmouseover
	map.on('pointermove', function(e) {
		var feature = map.forEachFeatureAtPixel(e.pixel, function(feature,
				layer) {
			return feature;
		});

		// 如果正在拖拽
		if (e.dragging) {
			$(element).popover('destroy');
			return;
		}

		var pixel = map.getEventPixel(e.originalEvent);
		if (feature) {
			// document.getElementById("info").value=feature.get("fType");
		}
		if (feature && (feature.get("fType") == "marker" || feature.get("fType") == "pipeline" || feature.get("fType") == "equipment")) {
			if (curPointFeatureId == feature.get("id")) {
				return;
			}
			curPointFeatureId = feature.get("id");
			popup.setPosition(e.coordinate);
			$(element).popover({
				'placement' : 'top',
				'html' : true,
				'content' : feature.get('name')
			});
			$(element).popover('show');
		} else {
			curPointFeatureId = "";
			$(element).popover('destroy');
		}
		var hit = map.hasFeatureAtPixel(pixel);
		map.getTarget().style.cursor = hit ? 'pointer' : '';
	});
	if (isPc) {
		map.addControl(new ol.control.MousePosition({/* 鼠标位置坐标值控件 */
			undefinedHTML : '',
			projection : 'EPSG:4326',
			coordinateFormat : function(coordinate) {
				return ol.coordinate.format(coordinate, '{x}, {y}', 7);
			},
			className : 'custom-mouse-position',
			target : document.getElementById('mouse-position')
		}));
	}
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

	source_icon_temp = new ol.source.Vector();
	layerTemp = new ol.layer.Vector({
		'title' : 'temp_vector_layer',
		source : source_icon_temp

	});
	map.addLayer(layerTemp);
	// 图层控制控件
	// var layerSwitcher ;
	// if(schema=="full"){
	layerSwitcher = new ol.control.LayerSwitcher();
	// };
	// 添加缩放到当前视图滑动控件
	// map.addControl(new ol.control.ZoomToExtent());
	// 再添加一个map 点击事件
	map.on("click", onMapClick);

	$(map.getViewport()).on('mouseout', function() {
		$(helpTooltipElement).addClass('hidden');
	});
	// $('#notMap').
	document.getElementById("notMap").style.display = "block";
	//getPosition();
}
function getPosition() {
	var geolocation = new ol.Geolocation({
		projection : view.getProjection()
	});

	
	
	// update the HTML page when the position changes.
	geolocation.on('change', function() {
		// el('accuracy').innerText = geolocation.getAccuracy() + ' [m]';
		// el('altitude').innerText = geolocation.getAltitude() + ' [m]';
		// el('altitudeAccuracy').innerText = geolocation.getAltitudeAccuracy()
		// + ' [m]';
		// el('heading').innerText = geolocation.getHeading() + ' [rad]';
		// el('speed').innerText = geolocation.getSpeed() + ' [m/s]';
	});

	// handle geolocation error.
	geolocation.on('error', function(error) {
		  console.error(error.message);
	});

	var accuracyFeature = new ol.Feature();
	geolocation.on('change:accuracyGeometry', function() {
		accuracyFeature.setGeometry(geolocation.getAccuracyGeometry());
	});

	var positionFeature = new ol.Feature();
	positionFeature.setStyle(new ol.style.Style({
		image : new ol.style.Circle({
			radius : 6,
			fill : new ol.style.Fill({
				color : '#3399CC'
			}),
			stroke : new ol.style.Stroke({
				color : '#fff',
				width : 2
			})
		})
	}));

	geolocation.on('change:position', function() {
		var coordinates = geolocation.getPosition();
		positionFeature
				.setGeometry(coordinates ? new ol.geom.Point(coordinates)
						: null);
	});

	new ol.layer.Vector({
		map : map,
		source : new ol.source.Vector({
			features : [ accuracyFeature, positionFeature ]
		})
	});
	geolocation.setTracking(true);
}