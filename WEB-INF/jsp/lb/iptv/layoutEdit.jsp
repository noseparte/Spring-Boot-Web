<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
<link href="plugins/bigcolorpicker/jquery.bigcolorpicker.css"
	rel="stylesheet">
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>陪诊信息</h5>
					</div>
					<div class="ibox-content">
						<form id="GuideForm" name="GuideForm" class="form-horizontal" method="post">
							<input type="hidden" name="IL_ID" id="IL_ID" value="${pd.IL_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">布局名称：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_NAME" id="IL_NAME" value="${pd.IL_NAME}" />
								</div>
								<label class="col-sm-2 control-label">终端版本：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_TERMINAL_VERSION" id="IL_TERMINAL_VERSION"  value="${pd.IL_TERMINAL_VERSION}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">布局版本：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_VERSION" id="IL_VERSION"  value="${pd.IL_VERSION}" />
								</div>
								<label class="col-sm-2 control-label">图片起始X坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_BLOCK_X" id="IL_BLOCK_X" value="${pd.IL_BLOCK_X}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">tab页签起始X坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_TAB_X" id="IL_TAB_X" value="${pd.IL_TAB_X}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
								<label class="col-sm-2 control-label">tab页签起始Y坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required " name="IL_TAB_Y" id="IL_TAB_Y" value="${pd.IL_TAB_Y}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">logo起始X坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_LOGO_X" id="IL_LOGO_X" value="${pd.IL_LOGO_X}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
								<label class="col-sm-2 control-label">logo起始Y坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required " name="IL_LOGO_Y" id="IL_LOGO_Y" value="${pd.IL_LOGO_Y}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">搜索按钮X坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="IL_SEARCH_X" id="IL_SEARCH_X" value="${pd.IL_SEARCH_X}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
								<label class="col-sm-2 control-label">搜索按钮Y坐标：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required " name="IL_SEARCH_Y" id="IL_SEARCH_Y" value="${pd.IL_SEARCH_Y}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
								</div>
							</div>
							<div class="form-group">
								<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">背景图片</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" name="IL_BG_IMAGE" id="IL_BG_IMAGE" value="${pd.IL_BG_IMAGE }">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">光晕图片</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inpp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" name="IL_HALO_IMAGE" id="IL_HALO_IMAGE" value="${pd.IL_HALO_IMAGE }">
											</div>
										</div>
									</div>
							</div>
							<div class="form-group">
								<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">LOGO</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inppp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" name="IL_LOGO_URL" id="IL_LOGO_URL" value="${pd.IL_LOGO_URL }">
											</div>
										</div>
									</div>
							</div>
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
									<button id="btn_Cancel" class="btn btn-white" type="button" onclick="goBack();">取消</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 全局js -->
    <system:jsFooter/>
    <script src="plugins/bigcolorpicker/jquery.bigcolorpicker.min.js"></script>
	<!-- 自定义js -->
	<script type="text/javascript">
		//表单ID
		var formId = "#GuideForm";
		$(document).ready(function(){
			$(formId).validate(); 
		});
		//表单提交
	    function submitForm(){
	        var id = $('#IL_ID').val();
	    	if(id == ""){
	    		action = "iptvLayout/saveAdd";
	    	}else{
	    		action = "iptvLayout/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
		//查询手机号是否被注册
	    //返回到列表页面 
		function goBack(){
			window.location.href="<%=basePath%>iptvLayout/toLists";
		}
		
		
		var picturePATH = '';
		var picturePATHS = '';
		var picturePATHSS = '';
		var IL_BG_IMAGE = $("#IL_BG_IMAGE").val();
		var IL_HALO_IMAGE = $("#IL_HALO_IMAGE").val();
		var IL_LOGO_URL = $("#IL_LOGO_URL").val();
		if(IL_BG_IMAGE != null && IL_BG_IMAGE != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
				data: {
					"ID": IL_BG_IMAGE,
					"MASTER_ID":IL_BG_IMAGE
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					picturePATH = data[0].PATH;
					initFileName = data[0].FILE_NAME;
				}
			});
		}
		if(IL_HALO_IMAGE != null && IL_HALO_IMAGE != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
				data: {
					"ID": IL_HALO_IMAGE,
					"MASTER_ID":IL_HALO_IMAGE
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					picturePATHS = data[0].PATH;
					initFileName = data[0].FILE_NAME;
				}
			});
		}
		if(IL_LOGO_URL != null && IL_LOGO_URL != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
				data: {
					"ID": IL_LOGO_URL,
					"MASTER_ID":IL_LOGO_URL
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					picturePATHSS = data[0].PATH;
					initFileName = data[0].FILE_NAME;
				}
			});
		}
			
		var IDSAndPid=[];
		var ids;
		var MASTER_ID=IL_BG_IMAGE;//master_id(参数是举例，请根据实际传参)
		var initFileName=""//初始化照片名(参数是举例，请根据实际传参)
		var initFilePath="D:\\\\20170222\\d8ed7fbd4a9b445cb446f7d727579eb2.jpg"//初始化照片路径(参数是举例，请根据实际传参)
		var initFileID= "d8ed7fbd4a9b445cb446f7d727579eb2"//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
	    $("#inp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:true,//是否展示移除按钮
	    	//showClose:false,//是否展示关闭按钮

	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: true,//异步支持
	    	//previewFileType: ["text","image"],//文件類型
	    	allowedFileExtensions: ["gif", "jpeg", "tiff", "bmp",'jpg','png','psd','svg'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	        initialPreviewAsData: true,
	    	initialPreview: [//初始化预览
	    		picturePATH
	        ],
	        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	            {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
	        ],
	        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
	        	"IDS": MASTER_ID,
	            "MASTER_ID":MASTER_ID
	        },
	        //maxFileCount: 10, //表示允许同时上传的最大文件个数
	        //showCaption: false,//是否显示标题   
	        //dropZoneEnabled: false//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //minFileCount: 0,
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    }).on('fileselect', function(event, numFiles, label) {//选择文件时
	    	$(this).fileinput("upload");//选择完文件后立即上传
	    })
	    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
			var IDS=JSON.parse(data.jqXHR.responseText)[0].id;
			var path=JSON.parse(data.jqXHR.responseText)[0].path;
			picturePATH = path;
			/* $("#I_IDY").val(IDS);
			console.log(IDS); */
			$("#IL_BG_IMAGE").val(IDS);
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
	        $("#IL_BG_IMAGE").val("");
		})
		.on('filecleared', function(event){ //清空的事件
			$("#IL_BG_IMAGE").val("");
		})
		.on('fileremoved', function(event, id) {
			$("#IL_BG_IMAGE").val("");
		})
		
		
		
		var MASTER_IDS=IL_HALO_IMAGE;
		var initFileNames=""
	    $("#inpp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:true,//是否展示移除按钮
	    	//showClose:false,//是否展示关闭按钮

	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: true,//异步支持
	    	//previewFileType: ["text","image"],//文件類型
	    	allowedFileExtensions: ["gif", "jpeg", "tiff", "bmp",'jpg','png','psd','svg'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	        initialPreviewAsData: true,
	    	initialPreview: [//初始化预览
	    		picturePATHS
	        ],
	        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	            {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
	        ],
	        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
	        	"IDS": MASTER_IDS,
	            "MASTER_ID":MASTER_IDS
	        },
	        //maxFileCount: 10, //表示允许同时上传的最大文件个数
	        //showCaption: false,//是否显示标题   
	        //dropZoneEnabled: false//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //minFileCount: 0,
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    }).on('fileselect', function(event, numFiles, label) {//选择文件时
	    	$(this).fileinput("upload");//选择完文件后立即上传
	    })
	    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
			var IDS=JSON.parse(data.jqXHR.responseText)[0].id;
			var path=JSON.parse(data.jqXHR.responseText)[0].path;
			picturePATHS = path;
			/* $("#I_IDY").val(IDS);
			console.log(IDS); */
			$("#IL_HALO_IMAGE").val(IDS);
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
	        $("#IL_HALO_IMAGE").val("");
		})
		.on('filecleared', function(event){ //清空的事件
			$("#IL_HALO_IMAGE").val("");
		})
		.on('fileremoved', function(event, id) {
			$("#IL_HALO_IMAGE").val("");
		})
		
		
		var MASTER_IDSES=IL_LOGO_URL;
		var initFileNamess=""
	    $("#inppp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload:false,//是否展示上传按钮
	    	showRemove:true,//是否展示移除按钮
	    	//showClose:false,//是否展示关闭按钮

	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: true,//异步支持
	    	//previewFileType: ["text","image"],//文件類型
	    	allowedFileExtensions: ["gif", "jpeg", "tiff", "bmp",'jpg','png','psd','svg'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	        initialPreviewAsData: true,
	    	initialPreview: [//初始化预览
	    		picturePATHSS
	        ],
	        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	            {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
	        ],
	        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
	        	"IDS": MASTER_IDSES,
	            "MASTER_ID":MASTER_IDSES
	        },
	        //maxFileCount: 10, //表示允许同时上传的最大文件个数
	        //showCaption: false,//是否显示标题   
	        //dropZoneEnabled: false//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //minFileCount: 0,
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    }).on('fileselect', function(event, numFiles, label) {//选择文件时
	    	$(this).fileinput("upload");//选择完文件后立即上传
	    })
	    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
			var IDS=JSON.parse(data.jqXHR.responseText)[0].id;
			var path=JSON.parse(data.jqXHR.responseText)[0].path;
			picturePATHS = path;
			/* $("#I_IDY").val(IDS);
			console.log(IDS); */
			$("#IL_LOGO_URL").val(IDS);
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
	        $("#IL_LOGO_URL").val("");
		})
		.on('filecleared', function(event){ //清空的事件
			$("#IL_LOGO_URL").val("");
		})
		.on('fileremoved', function(event, id) {
			$("#IL_LOGO_URL").val("");
		})
		
	</script>
</body>
</html>