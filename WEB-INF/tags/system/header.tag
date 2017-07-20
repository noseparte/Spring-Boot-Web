<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
basePath = basePath +"";
%>
<base href="<%=basePath%>">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<%-- <title>${pd.SYSNAME}</title> --%>
 <!--[if lt IE 8]>
 <meta http-equiv="refresh" content="0;ie.html" />
 <![endif]-->
<link href="hplus/css/bootstrap.min.css"  rel="stylesheet">
<link rel="stylesheet" href="plugins/gallery/css/jquery.fancybox.min.css">
<link href="hplus/css/plugins/bootstrap-table/bootstrap-table.css"  rel="stylesheet">
<link href="hplus/css/font-awesome.min.css"  rel="stylesheet">
<link href="hplus/css/animate.min.css" rel="stylesheet">
<link href="hplus/css/style.min.css" rel="stylesheet">
<link href="hplus/css/plugins/toastr/toastr.min.css" rel="stylesheet">
<link href="hplus/css/pegoe.css" rel="stylesheet">
<link href="hplus/css/plugins/switchery/switchery.css" rel="stylesheet">
<link href="hplus/css/plugins/awesome-bootstrap-checkbox/awesome-bootstrap-checkbox.css" rel="stylesheet">
<!-- iCheck -->
<link href="hplus/css/plugins/iCheck/custom.css" rel="stylesheet" type="text/css" />
<!-- 附件上传 -->
<link href="hplus/css/plugins/webuploader/webuploader.css" rel="stylesheet"> 
<link href="hplus/css/plugins/webuploader/webuploader_pegasus.css" rel="stylesheet"> 
<!-- select2 -->
<link href="hplus/css/plugins/select2/select2.min.css" rel="stylesheet"> 
<!-- jquery datetimepicker -->
<link href="hplus/css/plugins/datetimepicker/jquery.datetimepicker.css" rel="stylesheet">
<link href="plugins/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
<!-- pwdAlert -->
<link href="plugins/pwdAlert/css/main.css" rel="stylesheet" />
<!-- bootstrap datapicker -->
<link href="hplus/css/plugins/datapicker/bootstrap-datetimepicker.css" rel="stylesheet">
<!-- layim -->
<link href="hplus/js/plugins/layim/css/layui.css" rel="stylesheet" />
<!-- swfupload -->
<!-- <link href="hplus/js/plugins/swfupload/css/default.css" rel="stylesheet" type="text/css" /> -->