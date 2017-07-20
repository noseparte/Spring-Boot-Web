<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	 <system:header/>
	<!-- jsp文件头和头部 -->
	</head> 
<body class="gray-bg" style="width:390px">
	<div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content icons-box" style="padding:0 0 0;">
                        <div class="bs-glyphicons">
                            <ul class="bs-glyphicons-list">

                                <li style="width:130px;height:130px;padding:0px;">
                                    <div style="width:130px;height:150px;padding:0px">
							            <pre style="padding:0px;margin:0 0 10px;border:0px;">内存占用比例</pre>
							            <input id="knob1" class="knob"data-width="80" data-min="-100" data-angleOffset="90"  data-fgColor="#46B753" data-displayPrevious=true value="60">
							        </div>
                                </li>

                                <li style="width:130px;height:130px;padding:0px;">
                                    <div style="width:130px;height:150px;padding:0px">
							            <pre style="padding:0px;margin:0 0 10px;border:0px;">硬盘占用比例</pre>
							            <input id="knob2" class="knob"data-width="80" data-min="-100" data-angleOffset="90" data-skin="tron" data-displayPrevious=true value="44">
							        </div>
                                </li>

                                <li style="width:130px;height:130px;padding:0px;">
                                	<pre style="padding:0px;margin:0 0 10px;border:0px;">网络运行情况</pre>
                                    <span data-diameter="80" class="updating-chart">5,3,9,6,5,9,7,3,5,2,5,3,9,6,5,9,7,3,5,2</span>
                                </li>

                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 全局js -->
    <system:jsFooter/>
    <script src="hplus/js/plugins/knob/jquery.knob.js"></script> 
    <script src="hplus/js/plugins/peity/jquery.peity.min.js"></script> 
    <!-- 自定义js -->
	<script type="text/javascript">
		$(function(){
		    $("#knob1").knob();
			$("#knob2").knob();
			
			var i=$(".updating-chart").peity("line",{fill:"#1ab394",stroke:"#169c81",width:80,height:30});
			setInterval(function(){var t=Math.round(10*Math.random()),a=i.text().split(",");a.shift(),a.push(t),i.text(a.join(",")).change()},1e3)
			
			
			
			$(".peity").css("margin-top","20px");
			
			
			setInterval(function(){$("#knob1").val(60+Math.round(10*Math.random())).trigger('change');},2000)
			setInterval(function(){$("#knob2").val(40+Math.round(10*Math.random())).trigger('change');},2000)
			
		});
		
	</script>
		
	</body>
</html>

