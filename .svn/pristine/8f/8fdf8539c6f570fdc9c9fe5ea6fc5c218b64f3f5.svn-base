var lineFeature = new ol.Feature({
	geometry : new ol.geom.LineString([
			[ 118.78045678138733, 32.08637595176697 ],
			[ 118.77934098243713, 32.085732221603394 ],
			[ 118.77895474433899, 32.08502411842346 ],
			[ 118.778954744339, 32.04388976097107 ] ]),
	id : '123456',
	name : 'pipe',
	fType : 'marker',
	population : 4000,
	rainfall : 500
});

var mpFeature = new ol.Feature({
	geometry : new ol.geom.MultiPoint([
			[ 118.78045678138733, 32.08637595176697 ],
			[ 118.77934098243713, 32.085732221603394 ],
			[ 118.77895474433899, 32.08502411842346 ],
			[ 118.778954744339, 32.04388976097107 ] ]),
	id : '123456',
	name : 'point',
	fType : 'marker',
	population : 4000,
	rainfall : 500
});

//图标数据源
/*var source_icon2 = new ol.source.Vector({
	features: [lineFeature,mpFeature],
	//features: array_markers
});*/

//图标图层
/*layer_vector_icon = new ol.layer.Vector({
	//'title': '分类1',
	//source: source_icon,
	//style: styleFunction
});*/
//overlay（覆盖物）图层组

//所有图层
var layers;
var temp_layers = [];
var isothermyAreaLayers;
/**
 * ajax查找所有图层数据
 */
$(function(){
	if(schema!="full") return;
	$.ajax({
        type: "POST",
        url: "gis/getAllLayers",
        dataType: "JSON",
        async: false,
        success: function(jsonsData){
        	layers = new ol.layer.Group({
        		title: jsonsData[0].text,
        		layers: layersGroupTrees(jsonsData[0].nodes, 0)
        	});
        	//添加覆盖物图层组
        	map.addLayer(layers);
        	//遍历所有图层，对应图层数据
        	if(temp_layers != null && temp_layers.length > 0){
        		var code;
        		var type;
        		var style;
        		var legend;
        		$.each(temp_layers, function(temp_key){
        			code = temp_layers[temp_key].get("code");
            		type = temp_layers[temp_key].get("type");
            		legend = temp_layers[temp_key].get("legends");
            		if(code.startWith("marker_equip")){//标识物的设备
            			getMarkersEquips(type, legend, style, temp_key);
        			} else if(code.startWith("marker")){//标识物
        				getMarkers(type, legend, style, temp_key);
        			} else if(code.startWith("pipeline")){//管道
        				if(isothermyAreaType == type){
        					getPipelineIsothermyAreaCoordinates(style, temp_key);
        					//setInterval("getPipelineIsothermyAreaCoordinates(" + style + ", " + temp_key + ")", 50000);
        				}else{
        					getPipelineInflexCoordinates(type, legend, style, temp_key);
        				}
					}
        		});
        	}
		}
	});
});
/**
 * 获取标识物数据，并绘制到对应图层
 * @param type
 * @param legend
 * @param style
 * @param temp_key
 */
function getMarkers(type, legend, style, temp_key){
	$.ajax({
		type: "POST",
		url: "gis/getMarkerBy?type=" + type,
		dataType: "JSON",
		async: true,
		success: function(jsonsData_marker){
			if(jsonsData_marker != null && jsonsData_marker.length > 0){
				var array_markers = new Array(jsonsData_marker.length);
				if(legend != null && legend.length > 0){
					style = new ol.style.Style({
						image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
							anchor: [0.5, 0.5],
							anchorXUnits: 'fraction',
							anchorYUnits: 'fraction',
							opacity: 1,
							src: 'filesUploads/download?ID=' + legend
						}))
					});
				}else{
					style = iconStyle;
				}
	        	for(var temp_i = 0; temp_i < jsonsData_marker.length; temp_i++){
	        		var markerFeatureTemp = new ol.Feature({
	        			geometry : new ol.geom.Point([jsonsData_marker[temp_i].M_LON, jsonsData_marker[temp_i].M_LAT]),
	        			id : jsonsData_marker[temp_i].M_ID,
	        			name : jsonsData_marker[temp_i].M_NAME,
	        			mapalarm: jsonsData_marker[temp_i].M_MAPALARM,
	        			fType : 'marker'
	        		});
	        		markerFeatureTemp.setStyle(style);
	        		array_markers[temp_i] = markerFeatureTemp;
	        	}
	        	temp_layers[temp_key].setSource(new ol.source.Vector({
	        		features: array_markers
	        	}));
			}
		}
	});
}
/**
 * 获取标识物的设备数据，并绘制到对应图层
 * @param type
 * @param legend
 * @param style
 * @param temp_key
 */
function getMarkersEquips(type, legend, style, temp_key){
	$.ajax({
		type: "POST",
		url: "gis/getMarkerEquipBy?type=" + type,
		dataType: "JSON",
		async: true,
		success: function(jsonsData_marker_equip){
			if(jsonsData_marker_equip != null && jsonsData_marker_equip.length > 0){
				var array_markers_equip = new Array(jsonsData_marker_equip.length);
				if(legend != null && legend.length > 0){
					style = new ol.style.Style({
						image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
							anchor: [0.5, 0.5],
							anchorXUnits: 'fraction',
							anchorYUnits: 'fraction',
							opacity: 1,
							src: 'filesUploads/download?ID=' + legend
						}))
					});
				}else{
					style = iconStyle;
				}
	        	for(var temp_i = 0; temp_i < jsonsData_marker_equip.length; temp_i++){
	        		var markerEquipFeatureTemp = new ol.Feature({
	        			geometry : new ol.geom.Point([jsonsData_marker_equip[temp_i].EQ_LON, jsonsData_marker_equip[temp_i].EQ_LAT]),
	        			id : jsonsData_marker_equip[temp_i].EQ_ID,
	        			name : jsonsData_marker_equip[temp_i].EQ_NAME,
	        			fType : 'equipment'
	        		});
	        		markerEquipFeatureTemp.setStyle(style);
	        		array_markers_equip[temp_i] = markerEquipFeatureTemp;
	        	}
	        	temp_layers[temp_key].setSource(new ol.source.Vector({
	        		features: array_markers_equip
	        	}));
			}
		}
	});
}
/**
 * 获取管道等温区域坐标数据，并绘制到对应图层 等温区域
 * @param style
 * @param temp_key
 */
function getPipelineIsothermyAreaCoordinates(style, temp_key){
	var isothermyAreaSource = new ol.source.Vector({
        url: 'uploadFiles/pipelineIsothermyAreaKML.kml',
        format: new ol.format.KML()
	});
	temp_layers[temp_key].setSource(isothermyAreaSource);
}
/**
 * 获取管道等温区域坐标数据，并绘制到对应图层 地震热图
 * @param style
 * @param temp_key
 */
function getPipelineIsothermyAreaCoordinates_EarthquakesHeatMap(style, temp_key){
	map.removeLayer(isothermyAreaLayers);
	var isothermyAreaSource;
	
	isothermyAreaSource = new ol.source.Vector({
        url: 'uploadFiles/def.kml',
        format: new ol.format.KML({
            extractStyles: false
          })
      });
	
	isothermyAreaLayers = new ol.layer.Heatmap({
        source: isothermyAreaSource
      });
	map.addLayer(isothermyAreaLayers);
//	temp_layers[temp_key].setSource(isothermyAreaSource);
}
/**
 * 获取管道拐点坐标，并绘制到对应图层
 * @param type
 * @param style
 * @param legend
 * @param temp_key
 */
function getPipelineInflexCoordinates(type, legend, style, temp_key){
	$.ajax({
		type: "POST",
		url: "gis/getPipelineInflexCoordinateBy?type=" + type,
		dataType: "JSON",
		async: false,
		success: function(jsonsData_pipeline){
			if(jsonsData_pipeline != null && jsonsData_pipeline.length > 0){
				var pipelines_len = jsonsData_pipeline.length;
				var array_pipelins = new Array(pipelines_len);
				var pipelineFeatureTemp = new Array(pipelines_len);
				if(legend != null && legend.length > 0){
					var array_layersLegend = legend.split(";");
					style = new ol.style.Style({
						//矢量图层填充颜色，以及透明度
						fill: lineStringStyle.getFill(),
						//边界样式
						stroke: new ol.style.Stroke({
							color: array_layersLegend[0],
							width: array_layersLegend[1],
							lineDash: array_layersLegend[2] == 'dashed' ? [0, 5, 10, 5] : undefined
						}),
						//文本样式
						text: lineStringStyle.getText()
					});
				}else{
					style = lineStringStyle;
				}
				for(var temp_i = 0; temp_i < pipelines_len; temp_i++){
					var pp_id = jsonsData_pipeline[temp_i].PP_INFO[0];
					var pp_name = jsonsData_pipeline[temp_i].PP_INFO[1];
					var pp_dep = jsonsData_pipeline[temp_i].PP_INFO[2];
					var pp_commission_date = jsonsData_pipeline[temp_i].PP_INFO[3];
					var pp_len = jsonsData_pipeline[temp_i].PP_INFO[4];
					var pp_remark = jsonsData_pipeline[temp_i].PP_INFO[5];
					var pp_inflex_coordinate = '[' + jsonsData_pipeline[temp_i].PP_INFLEXCOORDINATE + ']';
					pipelineFeatureTemp[temp_i] = new ol.Feature({
						geometry : new ol.geom.LineString(eval(pp_inflex_coordinate)),
	        			id : pp_id,
	        			name : pp_name + "<br />所属单位：" + pp_dep + "<br />管道长度：" + pp_len + " 米<br />投产日期：" + pp_commission_date,
	        			fType : 'pipeline'
	        		});
					pipelineFeatureTemp[temp_i].setStyle(style);
				}
				temp_layers[temp_key].setSource(new ol.source.Vector({
					features: pipelineFeatureTemp
	        	}));
			}
		}
	});
}
/**
 * 管道等温区域历史回放
 */
function getPipelineIsothermyAreaHistoryReview(startTime, endTime){
	alert(startTime + "---" + endTime);
	var layer_source_vector;
	var layers_pipeline;
	map.removeLayer(layers_pipeline);
	$.ajax({
		type: "POST",
		url: "gis/getHistoryReviewPipelineIsothermyAreaInflexCoordinates?PP_ID=f84b5d1f4e274d5c89c4d107ff4d6bec&date_s=" + startTime + "&date_e=" + endTime,
		dataType: "JSON",
		async: false,
		success: function(jsonData){
			var pipelineFeatureTemp = new ol.Feature({
				geometry : new ol.geom.LineString([
					                       			[ 118.78045678138733, 32.08637595176697 ],
					                    			[ 118.77934098243713, 32.085732221603394 ],
					                    			[ 118.77895474433899, 32.08502411842346 ],
					                    			[ 118.778954744339, 32.04388976097107 ] ]),
				fType : "marker"
			});
			pipelineFeatureTemp.setStyle(lineStringStyle);
			
			layer_source_vector = new ol.source.Vector({
				features: [pipelineFeatureTemp]
			});
			layers_pipeline = new ol.layer.Vector({
				source: layer_source_vector,
				style: styleFunction
			});
			map.addLayer(layers_pipeline);
		}
	});
}
/**
 * 递归解析Json数据，图层组
 * @param jsonsData Json对象数据
 * @param pId 父节点Id
 */
function layersGroupTrees(jsonsData, pId){
	var array_LayerGroups = [];
	if(jsonsData != null){
		var temp_group;
		for(var temp_i = 0; temp_i < jsonsData.length; temp_i++){
			if(jsonsData[temp_i].pId == pId){
				if(jsonsData[temp_i].nodes.length > 0){
					temp_group = new ol.layer.Group({
	        			title: jsonsData[temp_i].text,
	            		layers: layersTrees(jsonsData[temp_i].nodes, jsonsData[temp_i].id)
	        		});
					array_LayerGroups.push(temp_group);
					layersGroupTrees(jsonsData[temp_i].nodes, jsonsData[temp_i].id);
				}
			}
		}
	}
	return array_LayerGroups;
}
/**
 * 递归解析Json数据，图层集合
 * @param jsonsData Json对象数据
 * @param pId 父节点Id
 * @returns {Array}
 */
function layersTrees(jsonsData, pId){
	var array_LayerVectors = [];
	if(jsonsData != null){
		var temp_vector;
		for(var temp_i = 0; temp_i < jsonsData.length; temp_i++){
			if(jsonsData[temp_i].pId == pId){
				temp_vector = new ol.layer.Vector({
					id: jsonsData[temp_i].id,
    				title: jsonsData[temp_i].text,
    				type: jsonsData[temp_i].subtype,
    				code: jsonsData[temp_i].code,
    				legends: jsonsData[temp_i].legends,
    				style: styleFunction
    			});
				array_LayerVectors.push(temp_vector);
				temp_layers.push(temp_vector);
			}
		}
	}
	return array_LayerVectors;
}