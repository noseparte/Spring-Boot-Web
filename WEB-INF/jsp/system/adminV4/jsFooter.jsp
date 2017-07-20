<script src="hplus/v4/js/jquery.min.js-v=2.1.4.js"></script>
<script src="hplus/v4/js/bootstrap.min.js-v=3.3.5.js"></script>
<script src="hplus/v4/js/plugins/layer/layer.min.js"></script>
<script src="hplus/v4/js/plugins/validate/jquery.validate.min.js"></script>
<script src="hplus/v4/js/plugins/validate/messages_zh.min.js"></script>
<script type="text/javascript" src="static/js/jquery.tips.js"></script>

<script type="text/javascript">
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
</script>