

var draw_source1 = new ol.source.Vector();
var draw_vector1 = new ol.layer.Vector({
	source : draw_source1,
	style : new ol.style.Style({
		fill : new ol.style.Fill({
			color : 'rgba(255, 255, 255, 0.2)'
		}),
		stroke : new ol.style.Stroke({
			color : '#ffcc33',
			width : 2
		}),
		image : new ol.style.Circle({
			radius : 7,
			fill : new ol.style.Fill({
				color : '#ffcc33'
			})
		})
	})
});

/**
 * The help tooltip element.
 * 
 * @type {Element}
 */
var helpTooltipElement1;

/**
 * Overlay to show the help messages.
 * 
 * @type {ol.Overlay}
 */
var helpTooltip1;





/**
 * Handle pointer move.
 * 
 * @param {ol.MapBrowserEvent}
 *            evt The event.
 */
var pointerMoveHandler1 = function(evt) {
	if (evt.dragging) {
		return;
	}
	/** @type {string} */
	var helpMsg = 'Click to start drawing';


	helpTooltipElement.innerHTML = helpMsg;
	helpTooltip.setPosition(evt.coordinate);

	$(helpTooltipElement).removeClass('hidden');
};








var draw1; // global so we can remove it later

/**
 * Format length output.
 * 
 * @param {ol.geom.LineString}
 *            line The line.
 * @return {string} The formatted length.
 */


function addInteraction1() {
	
	draw1 = new ol.interaction.Draw({
		source : draw_source1,
	//	geometryFunction:geometryFunction,
		type : /** @type {ol.geom.GeometryType} */
		('Point'),
		style : new ol.style.Style({
			fill : new ol.style.Fill({
				color : 'rgba(255, 255, 255, 0.2)'
			}),
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
					color : 'rgba(255, 255, 255, 0.2)'
				})
			})
		})
	});
	map.addLayer(draw_vector1);
	map.addInteraction(draw1);


	
}

/**
 * Creates a new help tooltip
 */
function createHelpTooltip1() {
	if (helpTooltipElement) {
		helpTooltipElement.parentNode.removeChild(helpTooltipElement);
	}
	helpTooltipElement = document.createElement('div');
	helpTooltipElement.className = 'tooltip hidden';
	helpTooltip = new ol.Overlay({
		element : helpTooltipElement,
		offset : [ 15, 0 ],
		positioning : 'center-left'
	});
	map.addOverlay(helpTooltip);
}


//�رջ��Ʋ���
function removeInteraction1(){
	map.removeInteraction(draw1);
}
function clearResult(){
}
var geometryFunction =(function(coordinates, geometry){
	//alert(geometry);
	return geometry
	//var a = coordinates;
	
})
