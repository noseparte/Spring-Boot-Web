<script src="hplus/js/jquery.min.js" ></script>
<script src="hplus/js/bootstrap.min.js" ></script>
<script src="hplus/js/plugins/bootstrap-table/bootstrap-table_pegasus.js" ></script>
<script src="hplus/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.js"></script>
<script src="hplus/js/plugins/bootstrap-table/extensions/mobile/bootstrap-table-mobile.js"></script>
<script src="hplus/js/plugins/layer/layer.min.js"></script>
<script src="hplus/js/plugins/validate/jquery.validate.min.js"></script>
<script src="hplus/js/plugins/validate/messages_zh.min.js"></script>
<script src="hplus/js/plugins/jqtips/jquery.tips.js"></script>
<!-- layim -->
<script src="hplus/js/plugins/layim/layui.js"></script>
<!-- <script src="plugins/requirejs/require.js"></script> -->

<!-- 附件上传 -->
<!-- <script src="hplus/js/plugins/webuploader/webuploader.js"></script> -->
<!-- <script src="hplus/js/plugins/webuploader/webuploader_pegasus.js"></script> -->

<script type="text/javascript">
	var loadingCssHtml= 
		  "<div class=\"sk-spinner sk-spinner-fading-circle\">"
	    + "<div class=\"sk-circle1 sk-circle\"></div>"
	    + "<div class=\"sk-circle2 sk-circle\"></div>"
	    + "<div class=\"sk-circle3 sk-circle\"></div>"
	    + "<div class=\"sk-circle4 sk-circle\"></div>"
	    + "<div class=\"sk-circle5 sk-circle\"></div>"
	    + "<div class=\"sk-circle6 sk-circle\"></div>"
	    + "<div class=\"sk-circle7 sk-circle\"></div>"
	    + "<div class=\"sk-circle8 sk-circle\"></div>"
	    + "<div class=\"sk-circle9 sk-circle\"></div>"
	    + "<div class=\"sk-circle10 sk-circle\"></div>"
	    + "<div class=\"sk-circle11 sk-circle\"></div>"
	    + "<div class=\"sk-circle12 sk-circle\"></div>"
	    + "</div>";
	
	$(document).ready(function () {
		var msg = '${msg}';
		if(msg!=''){
			if(msg=='ok'||msg=='success'){
				layer.msg('\u64cd\u4f5c\u6210\u529f');
			}else{
				layer.msg('\u64cd\u4f5c\u5931\u8d25');
			}
		}
	});
	
	function showProgress(progress){
		$(".hplusProgress").show();
		var progressHtml = $(".hplusProgress").html();
		if(progress>100){
			progress=100;
		}
		if(progress<0){
			progress=0;
		}
		if(progressHtml==''){
			var html = "<div class=\"background\"></div>"
			         + "<div class=\"progress progress-striped active progressRow\">"
			         + "<div id=\"progressBar\" class=\"progress-bar progress-bar-primary\" style=\"width:"+progress+"%\"></div>"
			         + "</div>";
			$(".hplusProgress").html(html)         
		}else{
			$("#progressBar").css("width",progress+"%");
		}
	}
	
	function closeProgress(){
		$(".hplusProgress").hide();
		$(".hplusProgress").html('')
	}
	
</script>