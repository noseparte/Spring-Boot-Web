//download by http://www.codefans.net
//点击效果
(function($){
	$.fn.scrollPlug = function(o){
        o = $.extend({  
            speed:      parseInt($(this).attr('speed')) || 30, // 滚动速度  
            step:       parseInt($(this).attr('step')) || 1, // 滚动步长  
            direction:  $(this).attr('direction') || 'up', // 滚动方向  
            pause:      parseInt($(this).attr('pause')) || 1000, // 停顿时长
			heightVle:  '',
			widthVle:   ''
        }, o || {});
		var dIndex = jQuery.inArray(o.direction, ['right', 'down']); 
		if (dIndex > -1) {  
            o.direction = ['left', 'up'][dIndex];  
            o.step = -o.step;  
        };
		var mid; 
		var ki          = 0;
        var div         = $(this);
        var divWidth    = div.innerWidth();
        var divHeight   = div.innerHeight();  
        var ul          = $("ul", div);  
        var li          = $("li", ul);  
        var liSize      = li.size();  
        var liWidth     = o.widthVle  = li.width();
        var liHeight    = o.heightVle = li.height();
        var width       = liWidth * liSize;  
        var height      = liHeight * liSize;
		clearInterval(mid);	
		var scrollHandle = function() {// 滚动   
            if(o.direction == 'left'){  
                var l = div.scrollLeft(); 
				div.scrollLeft(l + o.step);
				ki += Math.abs(o.step);
                if(ki >= liWidth) _stop();  
            }else{
				var t = div.scrollTop();
				ki += Math.abs(o.step);
				div.scrollTop(t + o.step);
                if(ki >= liHeight) _stop();
            }; 
        };
		var _stop = function(){
			ki = 0;
			clearInterval(mid);	
		};
		mid = setInterval(scrollHandle, o.speed); 		
	};	  
})(jQuery);