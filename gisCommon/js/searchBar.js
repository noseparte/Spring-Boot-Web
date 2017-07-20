var resultTbl;
function searchMap() {
	var sTxt = $('#searchInput').val();
	var rows = new Array();
	for ( var i = 0; i < temp_layers.length; i++) {

		if (temp_layers[i].getProperties().code.startWith("marker")) {
			if (temp_layers[i].getSource() == null) {
				continue;
			}
			for ( var j = 0; j < temp_layers[i].getSource().getFeatures().length; j++) {
				var feature = temp_layers[i].getSource().getFeatures()[j];
				if (feature.getProperties().name.indexOf(sTxt) >= 0) {
					var row = new Object();
					row.name = feature.getProperties().name;
					row.type = feature.getProperties().fType;

					if (feature.getGeometry() instanceof ol.geom.Point) {
						var coor = feature.getGeometry().getCoordinates();
						row.lng = coor[0];
						row.lat = coor[1];
					}
					rows[rows.length] = row;
				}
			}
		}
	}
	showResult(rows);
}
function initResultTbl(rows) {
	resultTbl = $('#searchResultTable').bootstrapTable({
		url : undefined,
		data : rows,
		showCheckbox : false,
		showRefresh : false,
		showColumns : false,
		showToggle : false,
		clickToSelect : false,
		striped : false,
		sidePagination:"client",

		onLoadSuccess : function(data) {
			// processCheckbox(data);
		},
		onClickCell : function(field, value, row, $element) {
			// $('.seleceRow').removeClass('seleceRow');
			// $element.parent().addClass('seleceRow');
			// showAlarmPoint(row)
			showPopup([ row.lng, row.lat ],row.name);
			locationMap([ row.lng, row.lat ]);

		},
		columns : [ {
			field : 'id',
			visible : false,
			halign : 'center',
		}, {
			field : 'lng',
			visible : false,
			halign : 'center',
		}, {
			field : 'lat',
			visible : false,
			halign : 'center',
		}, {
			field : 'name',
			title : '名称',
			align : 'center',
			halign : 'center',
			width : '200px'
		}, {
			field : 'type',
			title : '类型',
			align : 'center',
			halign : 'center',
			width : '90px'
		} ]
	});
	$('#searchResultTable').on('click-row.bs.table',
			function(e, row, $element) {
				$('.seleceRow').removeClass('seleceRow');
				$element.addClass('seleceRow');
			});
}

function showResult(rows) {
	if (resultTbl) {
		//clearResult();
		resultTbl.bootstrapTable("load",rows);
	} else {
		initResultTbl(rows);
	}

}
function clearResult() {
	if (resultTbl) {
		resultTbl.bootstrapTable('removeAll');
		overlay.setPosition(undefined);
        closer.blur();
	}
}