//样式
var styleFunction = (function() {
	var styles = {};
	var image = new ol.style.Circle({
		radius: 5,
		fill: null,
		stroke: new ol.style.Stroke({color: 'blue', width: 2})
	});
	styles['Point'] = new ol.style.Style({image: image});
	styles['Polygon'] = new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: 'blue',
			width: 3
		}),
		fill: new ol.style.Fill({
			color: 'rgba(0, 0, 255, 0.1)'
		})
	});
	styles['LineString'] = new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: 'green',
			width: 3
		})
	});
	styles['MultiPolygon'] = new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: 'yellow',
			width: 1
		}),
		fill: new ol.style.Fill({
			color: 'rgba(255, 255, 0, 0.1)'
		})
	});
	styles['default'] = new ol.style.Style({
		stroke: new ol.style.Stroke({
			color: 'red',
			width: 3
		}),
		fill: new ol.style.Fill({
			color: 'rgba(255, 0, 0, 0.1)'
		}),
		image: image
	});
	return function(feature, resolution) {
		return styles[feature.getGeometry().getType()] || styles['default'];
	};
})();
//标识物要素样式
var iconStyle = new ol.style.Style({
	image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
		anchor: [0.5, 46],
		anchorXUnits: 'fraction',
		anchorYUnits: 'pixels',
		opacity: 0.75,
		imgSize: [40, 40],
		src: 'gisCommon/common/img/i_pin2.png'
	})),
	//文本样式
	text: new ol.style.Text({
		font: '14px Calibri,sans-serif',
		fill: new ol.style.Fill({
			color: '#000'
		}),
		stroke: new ol.style.Stroke({
			color: '#000',
			width: 1
		})
	})
});

//标识物要素样式
var iconStyle_alarm_gc = new ol.style.Style({
	image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
		anchor: [0.5, 10],
		anchorXUnits: 'fraction',
		anchorYUnits: 'pixels',
		opacity: 0.75,
		rotation:1.6,
		//imgSize: [40, 40],
		src: 'gisCommon/common/img/ppp.gif'
	}))
});
//线条要素样式
var lineStringStyle = new ol.style.Style({
	//矢量图层填充颜色，以及透明度
	fill: new ol.style.Fill({
		color: 'rgba(255, 255, 255, 0.6)'
	}),
	//边界样式
	stroke: new ol.style.Stroke({
		color: '#319FD3',
		width: 3
	}),
	//文本样式
	text: new ol.style.Text({
		font: '12px Calibri,sans-serif',
		fill: new ol.style.Fill({
			color: '#000'
		}),
		stroke: new ol.style.Stroke({
			color: '#000',
			width: 3
		})
	})
});
//标定点要素样式
var pointStandardizationStyle = new ol.style.Style({
	//矢量图层填充颜色，以及透明度
	fill : new ol.style.Fill({
		color : 'rgba(255, 255, 255, 0.2)'
	}),
	//边界样式
	stroke : new ol.style.Stroke({
		color : 'rgba(0, 0, 0, 0.5)',
		lineDash : [ 10, 10 ],
		width : 2
	}),
	image : new ol.style.Circle({
		radius : 5,
		stroke : new ol.style.Stroke({
			color : 'rgba(0, 0, 0, 0.7)'
		}),
		fill : new ol.style.Fill({
			color : 'rgba(0, 0, 0, 0.2)'
		})
	})
});