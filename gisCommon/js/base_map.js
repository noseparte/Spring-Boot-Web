var baseMap;
var baseMap1;
var baseMap2;
var layers  = new Array();
// for(var i=0;i<"${fn:length(baseLayers)}";i++){
// consol.info("$)
// }
function initBaseMap() {
	for ( var i = baseLayers.length-1; i >=0; i--) {
		var baseMapObj;
		if(baseLayers[i].type=="geoServer"){
			baseMapObj = new ol.layer.Tile({
				title : baseLayers[i].name,
				zIndex : -(i+1),
				type : 'base',
				source : new ol.source.TileWMS({
					url : baseLayers[i].url,
					params : {
						'LAYERS' : baseLayers[i].layers,
						'FORMAT' : baseLayers[i].format
					},
					serverType : 'geoserver'
				})
			});
		}else if(baseLayers[i].type=="arcgisServer"){
			baseMapObj = new ol.layer.Tile({ 
				title: baseLayers[i].name,
				zIndex : -(i+1),
				type:'base', 
				source: new
				  ol.source.TileArcGISRest({ title: 'osm', url:
					  baseLayers[i].url })
				  });
				 
		}else if(baseLayers[i].type=="staticImage"){
			var extent = [0, 0, 1024, 968];
			projection_image = new ol.proj.Projection({
				  code: 'xkcd-image',
				  units: 'pixels',
				  extent: extent
				});
			new ol.layer.Image({
	            source: new ol.source.ImageStatic({
	              url:baseLayers[i].url,
	              projection: projection_image,
	              imageExtent: extent
	            })
	          })
		}
		layers[layers.length]=baseMapObj;
	}
//	layers[layers.length]=baseMap;
}
//baseMap = new ol.layer.Tile({
//	title : '地形图',
//	zIndex : -2,
//	type : 'base',
//	source : new ol.source.TileWMS({
//		// url : 'http://192.168.1.185:8989/geoserver/china/wms',
//		url : 'http://192.168.1.185:8989/geoserver/china/wms',
//		// url : 'http://192.168.199.107:9898/geoserver/china/wms',
//		params : {
//			'LAYERS' : 'china:nanjing',
//			'FORMAT' : 'image/jpeg'
//		},
//		serverType : 'geoserver'
//	})
//});
//baseMap = new ol.layer.Tile({ title: 'ArcGIS', type:'base', source: new
//  ol.source.TileArcGISRest({ title: 'osm', url:
//  'http://cache1.arcgisonline.cn/arcgis/rest/services/ChinaOnlineCommunity/MapServer' })
//  });
 


//baseMap1 = new ol.layer.Tile({
//	title : '卫星图',
//	zIndex : -1,
//	type : 'base',
//	visible : false,
//	source : new ol.source.TileWMS({
//		url : 'http://192.168.1.185:8989/geoserver/china/wms',
//		params : {
//			'LAYERS' : 'china:china_all',
//			'FORMAT' : 'image/jpeg'
//		},
//		serverType : 'geoserver'
//	})
//});
//layers = [ baseMap ]
/*
 * new ol.layer.Tile({ source: new ol.source.MapQuest({layer: 'sat'}) }),
 */
// geo服务
// arcgis服务
/*
 * new ol.layer.Tile({ 'title': 'ArcGIS',
 * 
 * source: new ol.source.TileArcGISRest({ 'title': 'osm', url:
 * 'http://cache1.arcgisonline.cn/arcgis/rest/services/ChinaOnlineCommunity/MapServer' }) })
 */
initBaseMap();
