/**
 * common.js
 *
 */

/*-------------------------------------------------------------------------------------

重置页面元素尺寸

-------------------------------------------------------------------------------------*/

$(function() {
	//uiReszie();
	//alert("asdf")
});
//$(window).on('load resize', uiReszie);
function uiReszie(){
	cMap = window.cMap || {};
	cMap.Config = cMap.Config || {};
	cMap.Config.Ui = cMap.Config.Ui || {};
	var win_w = $(window).width();
	var win_h = $(window).height();
	if (win_w < 1000)win_w = 1000;
	if (win_h < 400)win_h = 400;
	var con_h = win_h;
	$('body').css({
		width : win_w,
		height : win_h
	});
	$('.container').css({
		width : win_w,
		height : con_h
	});
	var uphd = $('.upanel-hd').height();
	$('.upanel-bd').css({
		height : win_h - uphd
	});
	$('.linkage,.map').css({
		height: con_h
	});
	$('.mod-datalist').css({
		'max-height': con_h - 100 + 'px'
	});
	cMap.Config.Ui = {
		win_w : win_w,
		win_h : win_h,
		con_h : con_h
	};
	$(document).trigger('resize.complete', [ cMap.Config.Ui ]);
	$(window).trigger('resize.complete', [ cMap.Config.Ui ]);
}

/*-------------------------------------------------------------------------------------

点击托管

-------------------------------------------------------------------------------------*/


$(document).on( 'click','a[href],.userpanel li,.schinput input,.mb-btn,.mod-maptool .item,.channel-list .item,.select-list li,.side-toggle a,.close-cbox,.mod-usernews .tab li,.mod-usershare .tab li,.mod-guide,.mod-links button,.mod-links tr,.linkage-btn,.icon_on',function(event){
	if(this.id==="layerSwitchBtn"){
		return;
	}
	var $this = $(this),
		$panel = $('.panel-wrap'),
		_pitem = '.panel-item',
		$bxtab = $('.box-tab'),
		$scbar = $('.mod-searchbar'),
		$sidet = $('.side-toggle');

	//侧边控制面板
	var pn = pn || {};
	pn = {
		openPanel : function(){
			$bxtab.find('li').removeClass('on');
			$this.addClass('on');
			$sidet.show();
			$panel.stop().animate({'margin-left':'0'});
		//	$scbar.stop().animate({'left':'417px'});
			if( !$panel.find(_pitem).eq(o).is('panel-on') ){
				$panel.find(_pitem).removeClass('panel-on');
				$panel.find(_pitem).eq(o).addClass('panel-on');
			}
		},
		closePanel : function(){
			$bxtab.find('li').removeClass('on');
			$panel.stop().animate({'margin-left':'-350px'},function(){
				$panel.find(_pitem).eq(o).removeClass('panel-on');
			});
			//$scbar.stop().animate({'left':'67px'});
			$sidet.hide();
		}
	}

	//侧边收起按钮
	if( $this.is('.side-toggle a') ){
		$this.parent().hide();
		pn.closePanel();
	}
	
	//侧边按钮
	if( $this.is('.box-tab li') ){
		var o = $this.index();
		if( !$this.is('.on') ){
			pn.openPanel();
		}else{
			pn.closePanel();
		}
	}

	//消息切换
	if( $this.is('.mod-usernews .tab li') ){
		$('.mod-usernews .tab li').removeClass('on');
		$this.addClass('on');
		var o = $this.index();
		$('.mod-usernews .panels .panel').removeClass('on');
		$('.mod-usernews .panels').find('.panel').eq(o).addClass('on');
	}

	//分享内容
	if( $this.is('.mod-usershare .tab li') ){
		$('.mod-usershare .tab li').removeClass('on');
		$this.addClass('on');
		var o = $this.index();
		$('.mod-usershare .box-list').removeClass('on');
		$('.mod-usershare').find('.box-list').eq(o).addClass('on');
	}

	//收起按钮
	if( $this.is('.upanel-close') ){
		pn.closePanel();
	}

	//搜索框
	if( $this.is('.schinput input') ){
		$this.parent().addClass('schinput-focus');
		$(this).on('keyup paste', function(){
			if( $this.val().length > 0 ){
				$this.siblings('.reset').show();
			}else{
				$('.mod-searchresult').slideUp();
				$this.siblings('.reset').hide();
			}
		});
		$this.blur(function(){
			$this.parent().removeClass('schinput-focus');
		});
//		pn.closePanel();
	}
	if( $this.is('.reset') ){
		$this.siblings('input').val('').focus();
		$('.mod-searchresult').slideUp();
		$this.hide();
	}

	if( $this.is('.schbtn') ){
		$('.mod-searchresult').slideDown();
	}

	//小工具按钮
	var mb = mb || {};
	mb = {
		showBox : function(){
			$this.parents('.mod-menubtn').addClass('mb-open');
			$this.parent().siblings().removeClass('mb-item-on');
			$this.parent().addClass('mb-item-on');
			$('.mb-arw').animate({left:left+8},200);
		},
		hideBox : function(){
			$this.parents('.mod-menubtn').removeClass('mb-open');
			$this.parent().removeClass('mb-item-on');
		}

	}
	if( $this.is('.mb-btn') ){
		var left = $this.position().left;
		if( !$this.parent().is('.mb-help') ){
			if( !$this.parent().is('.mb-item-on') ){
				mb.showBox();
				if($this[0].id =="alarmQuery"){
					setHisLayerVisible(true);
				}else{
					setHisLayerVisible(false);
				}
			}else{
				mb.hideBox();
				setHisLayerVisible(false);
			}
		}else{
			$this.parent().siblings().removeClass('mb-item-on');
			mb.hideBox();
		}
		//帮助
		if( $this.parent().is('.mb-help') ){
			if( !$('.mod-guide').is('.show') ){
				$('.mod-guide').addClass('show');
			}else{
				$('.mod-guide').removeClass('show');
			}
		}
	}
	//点击帮助图层
	if( $this.is('.mod-guide') ){
		$this.removeClass('show');
	}

	//小工具缩略图点击
	if( $this.is('.mod-maptool .item') ){
		if( !$this.is('.item-on') ){
			$this.addClass('item-on');
		}else{
			$this.removeClass('item-on');
		}
	}

	//查询切换
	if( $this.is('.channel-list .item') ){
		if( !$this.is('.item-on') ){
			$('.channel-list .item').removeClass('item-on');
			$this.addClass('item-on');
			var o = $this.index();
			$('.channel-con').find('.con-item').removeClass('con-item-on');
			$('.channel-con').find('.con-item').eq(o).addClass('con-item-on');
		}
	}

	//地图点击现实框
	if( $this.is('.select-list li') ){
		$('.click-box').show();
	}

	//弹出窗口
	if( $this.is('.close-cbox') ){
		$this.parent().hide();
	}

	//管控按钮
	if( $this.is('.mod-links .submitbtn4') ){
		$('.addcoor').hide();
	}
	if( $this.is('.mod-links .submitbtn1') ){
		$('.addcoor').show();
	}
	if( $this.is('.mod-links tr') ){
		$('.mod-links tr').removeClass('select');
		$this.addClass('select');
	}

	//切换地图
	if( $this.is('.linkage-btn') ){
		/*if( !$('.linkage').is('.show') ){
			$('.linkage').addClass('show');
			$('.map').css('width','50%');
		}else{
			$('.linkage').removeClass('show');
			$('.map').css('width','100%');
		}*/
		
	}

});

//小工具缩略图悬浮
$('.mod-maptool .item').hover(
	function(){
		$(this).addClass('item-hv');
	},function(){
		$(this).removeClass('item-hv');
	}
);

/*======================= 临时代码，正式应用时删除 =======================*/

$('.mod-userlogin .submitbtn').click(function(){
	$('.mod-userlogin').hide();
	$('.mod-usermy').show();
	return false;
});
$('.btn-logout').click(function(){
	$('.mod-userlogin').show();
	$('.mod-usermy').hide();
	return false;
});

//Select 样式
/*$(".my-select").chosen({
    disable_search_threshold: 10,
    no_results_text: "Oops, nothing found!",
    width: "100%",
    height: "35px"
});*/

//树状样式
 /*$('#jstree_demo_div').jstree({'plugins':["wholerow","checkbox"], 'core' : {
	'data' : [
			'url' :"" ,
			  'data' : function (node) {
			    return { 'id' : node.id };
			  }
	          
	          { "id" : "ajson1", "parent" : "#", "text" : "Simple root node" ,"li_attr":{"type":"pipe"} },
	          { "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
	          { "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
	          { "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
		//第一个分类
		{
			"text" : "基础路网"},
		{
			"text" : "控规", },
		{
			"text" : "征迁", //第一层
			"children" : [ //第一层节点
				{ "text" : "征迁" }, //第二层
				{ "text" : "重复征迁" }, //第二层
				]

		},
		{
			"text" : "招拍挂", },
		{
			"text" : "资金", //第一层
			"children" : [ //第一层节点
				{ "text" : "征迁资金" }, //第二层
				{ "text" : "招拍挂资金" }, 
				{ "text" : "项目道路资金" }, //第二层
				],
				 'state' : {
			           'opened' : true,
			           'selected' : false
			         }

		},
		{
			"text":"重点道路","id":"123321qwe","li_attr":{"type":"pipe"}
		},

		{
			"text" : "项目", 
		
			"children" : [ //第一层节点
				{ "text" : "薛馆路",  //第二层。'state' : { opened : true } 控制打开节点
					"children" : [ //第三层节点
						{ "text" : "项目道路" }, //第三层
						{ "text" : "示意线" }, //第三层
                        { "text" : "绿化带" }, //第三层
                        { "text" : "项目桥梁" }, //第三层
                        { "text" : "项目管线" }, //第三层
					]
				},
				{ "text" : "高速公路连接线",  //第二层。'state' : { opened : true } 控制打开节点
					"children" : [ //第三层节点
						{ "text" : "项目道路" }, //第三层
						{ "text" : "示意线" }, //第三层
                        { "text" : "项目桥梁" }, //第三层
                        { "text" : "项目路灯" }, //第三层
                        { "text" : "项目管线" }, //第三层
					]
				},

			]
		},
		{
			"text" : "土地利用", },
		{
			"text" : "卫片影像", //第一层
			"children" : [ //第一层节点
				{ "text" : "201510" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				{ "text" : "201504" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				{ "text" : "2014" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				{ "text" : "2013" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				{ "text" : "2012" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				{ "text" : "2008" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				{ "text" : "2006" , "icon" : "gisCommon/common/frame/css/tree-icon.png" },
				]

		},
		

		

	]
}}).bind('click.jstree', function(event) {
    var eventNodeName = event.target.nodeName;
    alert($(event.target).attr('id')+"  "+$(event.target).parents('li').attr('type'));
   // alert(event.target.className);
    var node=$('#jstree_demo_div').find("[id='"+$(event.target).parents('li').attr('id')+"']")
    
    var isChecked=false;
    var ids="";
    if (eventNodeName == 'I') {
    	if(event.target.parentElement.className.indexOf("clicked")>0){
    		isChecked=true;
    	}
    } else if (eventNodeName == 'A') {                   
    	if(event.target.className.indexOf("clicked")>0){
    		isChecked=true;
    	}
    }  
    alert(isChecked)
    });*/