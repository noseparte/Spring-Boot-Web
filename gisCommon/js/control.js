window.app = {};
var app = window.app;
var measure_img;
var baseMap_img;
var drawBs_img;
var scaleLineControl = new ol.control.ScaleLine();
var myFullScreen;
if(schema=="full"){
	myFullScreen= new ol.control.FullScreen({
  		className:'zoomtoExtnet'  
    });
}
/**
 * @constructor
 * @extends {ol.control.Control}
 * @param {Object=}
 *            opt_options Control options.
 */
// 控件：地图旋转
/*app.RotateNorthControl = function(opt_options) {

	var options = opt_options || {};

	var button = document.createElement('button');
	button.innerHTML = 'N';

	var this_ = this;
	var handleRotateNorth = function(e) {
		this_.getMap().getView().setRotation(2);
	};

	button.addEventListener('click', handleRotateNorth, false);
	button.addEventListener('touchstart', handleRotateNorth, false);

	var element = document.createElement('div');
	element.className = 'rotate-north ol-unselectable ol-control';
	element.appendChild(button);

	ol.control.Control.call(this, {
		element : element,
		target : options.target
	});

};
ol.inherits(app.RotateNorthControl, ol.control.Control);
*/


// 底图切换
if(schema=="full"){
	app.BaseMapSwitch = function(opt_options) {
	
		var options = opt_options || {};
	
		baseMap_img = document.createElement('img');
		baseMap_img.src = 'gisCommon/common/img/zmsb_1.png';
	
		var this_ = this;
		var handleBaseMap = function(e) {
			// alert(button.src)
			if (baseMap_img.src.indexOf('gisCommon/common/img/zmsb_1.png') >= 0) {
				baseMap_img.src = 'gisCommon/common/img/zmsb_0.png';
	
	//			 map.removeLayer(baseMap);
	//			 map.addLayer(baseMap1);
	//			baseMap1.setZIndex(-1);
				baseMap1.visible = true;
				baseMap.visible = false;
	//			baseMap.setZIndex(-2);
			} else {
				baseMap_img.src = 'gisCommon/common/img/zmsb_1.png';
	//			baseMap1.setZIndex(-2);
	//			baseMap.setZIndex(-1);
	//			 map.removeLayer(baseMap1);
	//			 map.addLayer(baseMap);
				baseMap1.visible = false;
				baseMap.visible = true;
				// baseMap.setZIndex(-1);
			}
		};
	
		baseMap_img.addEventListener('click', handleBaseMap, false);
		baseMap_img.addEventListener('touchstart', handleBaseMap, false);
	
		var element = document.createElement('div');
		element.className = 'baseMap ol-unselectable ol-control';
		element.appendChild(baseMap_img);
	
		ol.control.Control.call(this, {
			element : element,
			target : options.target
		});
	};
	ol.inherits(app.BaseMapSwitch, ol.control.Control);
}
// 鹰眼
var overviewMapControl = new ol.control.OverviewMap({
	// see in overviewmap-custom.html to see the custom CSS used
	className : 'ol-overviewmap ol-custom-overviewmap',
	layers : [ baseMap ],
	collapseLabel : '\u00BB',
	label : '\u00AB',
	collapsed : true
});
//绘制吸附
var snap = new ol.interaction.Snap({
	//source : layer_vector_icon.getSource()
});
//绘制测量
if(schema=="full"){
	app.Measure = function(opt_options) {
	
		var options = opt_options || {};
	
		measure_img = document.createElement('img');
		measure_img.src = 'gisCommon/common/img/zmsb_1.png';
	
		var this_ = this;
		var handleMeasure = function(e) {
			// alert(button.src)
			if (measure_img.src.indexOf('gisCommon/common/img/zmsb_1.png') >= 0) {
				measure_img.src = 'gisCommon/common/img/zmsb_0.png';
				addInteraction();
			} else {
				measure_img.src = 'gisCommon/common/img/zmsb_1.png';
				draw_source = new ol.source.Vector();
				draw_vector.setSource(draw_source);
				removeInteraction();
			}
		};
	
		measure_img.addEventListener('click', handleMeasure, false);
		measure_img.addEventListener('touchstart', handleMeasure, false);
	
		var element = document.createElement('div');
		element.className = 'draw ol-unselectable ol-control';
		element.appendChild(measure_img);
	
		ol.control.Control.call(this, {
			element : element,
			target : options.target
		});
	};
	ol.inherits(app.Measure, ol.control.Control);
}
//绘制标识
/*app.DrawBs = function(opt_options) {

	var options = opt_options || {};

	drawBs_img = document.createElement('img');
	drawBs_img.src = 'gisCommon/common/img/zmsb_1.png';

	var this_ = this;
	var handleDrawBs = function(e) {
		// alert(button.src)
		if (drawBs_img.src.indexOf('gisCommon/common/img/zmsb_1.png') >= 0) {
			drawBs_img.src = 'gisCommon/common/img/zmsb_0.png';
			addInteraction1();
			map.addInteraction(snap);
		} else {
			drawBs_img.src = 'gisCommon/common/img/zmsb_1.png';
			draw_source1 = new ol.source.Vector();
			draw_vector1.setSource(draw_source1);
			removeInteraction1();
			map.removeInteraction(snap);
		}
	};

	drawBs_img.addEventListener('click', handleDrawBs, false);
	drawBs_img.addEventListener('touchstart', handleDrawBs, false);

	var element = document.createElement('div');
	element.className = 'drawBs ol-unselectable ol-control';
	element.appendChild(drawBs_img);

	ol.control.Control.call(this, {
		element : element,
		target : options.target
	});
};
ol.inherits(app.DrawBs, ol.control.Control);*/