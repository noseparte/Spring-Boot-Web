var guideArr;
function guide(){
	initGuideElm();
	initGuide();
	startGuide();
}
function initGuideElm(){
	document.getElementById("guide_alarm_batch").style.left=document.body.clientWidth-202+"px";
	document.getElementById("guide_alarmQ").style.left=document.body.clientWidth-202+"px";
	
	document.getElementById("guide_alarm_query").style.left = document.getElementById("alarmQuery").getBoundingClientRect().left+"px";
	document.getElementById("guide_alarm_query").style.top = document.getElementById("alarmQuery").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_search").style.left = document.getElementById("search_btn").getBoundingClientRect().left+"px";
	document.getElementById("guide_search").style.top = document.getElementById("search_btn").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_char").style.left = document.getElementById("char_btn").getBoundingClientRect().left+"px";
	document.getElementById("guide_char").style.top = document.getElementById("char_btn").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_tool").style.left = document.getElementById("tool_btn").getBoundingClientRect().left+"px";
	document.getElementById("guide_tool").style.top = document.getElementById("tool_btn").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_realdata").style.left = document.getElementById("realdata_btn").getBoundingClientRect().left+"px";
	document.getElementById("guide_realdata").style.top = document.getElementById("realdata_btn").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_dvscount").style.left = document.getElementById("dvscount_btn").getBoundingClientRect().left+"px";
	document.getElementById("guide_dvscount").style.top = document.getElementById("dvscount_btn").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_monitor").style.left = document.getElementById("monitor_btn").getBoundingClientRect().left+"px";
	document.getElementById("guide_monitor").style.top = document.getElementById("monitor_btn").getBoundingClientRect().top+"px";
	
	document.getElementById("guide_layer").style.left = document.getElementById("layerSwitchBtn").getBoundingClientRect().left+"px";
	document.getElementById("guide_layer").style.top = document.getElementById("layerSwitchBtn").getBoundingClientRect().top+"px";
	
}
function initGuide(){
	guideArr =new Array("","guide_alarm_query","guide_search","guide_char","guide_tool","guide_realdata",
			"guide_dvscount","guide_monitor","guide_layer","guide_alarm_batch","guide_alarmQ");
}
function startGuide() {
	var trip = new Trip([ {
		sel : $('.main.step1'),
		position : 's',
		content : '工具栏',
		delay : -1,
		showNavigation : true,
		expose : true,
		onTripEnd : function(i) {
			console.log("step " + i + " is finished");
		}
	}, {
		sel : $('.main.step2'),
		position : 's',
		content : '报警历史查询',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step3'),
		position : 's',
		content : '标识物搜索',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step4'),
		position : 's',
		content : '设备曲线图',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step5'),
		position : 's',
		content : '工具箱：绘制测量、坐标定位、图例等',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step6'),
		position : 's',
		content : '实时数据',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step7'),
		position : 's',
		content : 'DVS报警次数查询',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step8'),
		position : 's',
		content : '系统运行监控',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step9'),
		position : 's',
		content : '图层控制',
		delay : -1,
		showNavigation : true,
		expose : true
	}, {
		sel : $('.main.step10'),
		position : 'w',
		content : '报警批量处理',
		delay : -1,
		showNavigation : true,
		expose : true
	},
	 {
		sel : $('.main.step11'),
		position : 'w',
		content : '报警消息队列',
		delay : -1,
		showNavigation : true,
		expose : true
	},{
		position : 'screen-center',
		content : getAlarmPoint(),
		delay : -1,
		showNavigation : true,
		expose : false
	} 
	], {
		tripTheme : "white",
		showCloseBox:true,
		showHeader:false,
		onStart : function() {
			console.log("onStart");
		},
		onEnd : function() {
			console.log("onEnd");
			document.getElementById("guide_alarm_batch").style.display="none";
			document.getElementById("guide_alarmQ").style.display="none";
		},
		onTripStop : function(index, tripBlock) {
			console.log("onTripStop");
			document.getElementById(guideArr[index]).style.display="none";
		},
		onBeforeTripChange:function (index, tripBlock){
			console.log("onBeforeTripChange");
			if(index==9 || index==10){
				document.getElementById(guideArr[9]).style.display="";
				document.getElementById(guideArr[10]).style.display="";
				document.getElementById(guideArr[8]).style.display="none";
			}else if(index == guideArr.length){
				document.getElementById(guideArr[9]).style.display="none";
				document.getElementById(guideArr[10]).style.display="none";
			}else{
				if(document.getElementById(guideArr[index])!=null) {document.getElementById(guideArr[index]).style.display=""}
				if(index!=0){
					if(document.getElementById(guideArr[index-1])!=null) {document.getElementById(guideArr[index-1]).style.display="none"}
				}
//				if(index!=guideArr.lenght-1){
					if(document.getElementById(guideArr[index+1])!=null) {document.getElementById(guideArr[index+1]).style.display="none"}
//				}
			}
//			switch(index){
//				case 0:
//					document.getElementById("guide_alarm_query").style.display="none";
//					break;
//				case 1:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 1:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 2:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 3:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 4:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 5:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 6:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 7:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 8:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 9:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 10:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 11:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//				case 12:
//					document.getElementById("guide_alarm_query").style.display="";
//					document.getElementById("guide_search").style.display="none";
//					break;
//			}
//			if(index=="1"){
//				document.getElementById("guide_alarm_query").style.display="";
//			}else if(index=="2"){
//				document.getElementById("guide_alarm_query").style.display="none";
//				document.getElementById("guide_search").style.display="";
//			}else if(index=="3"){
//				document.getElementById("guide_search").style.display="none";
//			}else if(index=="10" || index=="11"){
//				document.getElementById("guide_alarmQ").style.display="";
//				document.getElementById("guide_alarm_batch").style.display="";
//			}else if(index=="12" || index=="9"){
//				document.getElementById("guide_alarmQ").style.display="none";
//				document.getElementById("guide_alarm_batch").style.display="none";
//			}
		},
		onTripStart:function (index, tripBlock){
			console.log("onTripStart");
		},
		onTripChange : function(index, tripBlock) {
			console.log("onTripChange");
			
		},
		backToTopWhenEnded : false,
		delay : 2000
	});

	// $(".start-demo-index").click(function() {
	trip.start();
	// });

	window.trip = trip;
}
function getAlarmPoint(){
	var html ="";
	html+='报警点标识</br>'
		 +'<div style="float:left"><ul style=" width: auto; ">'
        +'<li style="text-align: center;float:left;margin:5px"><img src="gisCommon/common/img/dvs.png"></br>震动</li>'
        +'<li style="text-align: center;float:left;margin:5px"><img src="gisCommon/common/img/dts.png"></br>温度</li>'
        +'<li style="text-align: center;;float:left;margin:5px"><img src="gisCommon/common/img/dx.png"></br>断纤</li>'
        +'<li style="text-align: center;;float:left;margin:5px"><img style="width:35px;height:30px" src="gisCommon/common/img/truck.gif"></br>过汽车</li>'
        +'<li style="text-align: center;;float:left;margin:5px"><img style="width:30px;height:30px" src="gisCommon/common/img/train.gif"></br>过火车</li></ul></div>';
	return html;
		
}
function startIntro(){
    var intro = introJs();
      intro.setOptions({
    	  showStepNumbers:false,
        steps: [
          { 
        	element: document.querySelector('.step1'),
            intro: "Hello world!"
          },
          {
            element: document.querySelector('.step2'),
            intro: "This is a tooltip."
          },
          {
            element: document.querySelector('.step3'),
            intro: "Ok, wasn't that fun?",
          },
          {
            element: '.step4',
            intro: 'More features, more fun.',
          },
          {
            element: '.step5',
            intro: "Another step.",
          },
          {
            element: '.step6',
            intro: 'Get it, use it.'
          }
        ]
      });

      intro.start();
  }
function checkNeedGuide(){
	var needGuide = getCookie("NEED_GUIDE");
	console.info("needGuide  "+needGuide);
	if(!needGuide){
		need_guide= true;
		setCookie("NEED_GUIDE","1");
	}else{
		need_guide= false;
	}
}

//if(need_guide){
	//guide();
//}