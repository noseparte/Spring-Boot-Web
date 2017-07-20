<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>APP图片轮播</h5>
					</div>
					<div class="ibox-content">
						<form id="ArticleRotationForm" name="ArticleRotationForm" class="form-horizontal" method="post">
							<input type="hidden" name="ARTICLE_ID" id="ARTICLE_ID" value="${pd.ARTICLE_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">标题：</label>
							    <div class="col-sm-10">
									<input type="text" class="form-control required" name="ARTICLE_TITLE" id="ARTICLE_TITLE" value="${pd.ARTICLE_TITLE}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">发表人：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control" name="PUBLISH_NAME" id="PUBLISH_NAME" value="${pd.PUBLISH_NAME}" />
								</div>
								<label class="col-sm-2 control-label">发表单位：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control" name="PUBLISH_DEPT" id="PUBLISH_DEPT" value="${pd.PUBLISH_DEPT}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">文章类型：</label>
							    <div class="col-sm-4">
							    	<select class="form-control required" name="ARTICLE_TYPE" id="ARTICLE_TYPE" value="${pd.ARTICLE_TYPE}"
				                         ajax--url="dic/getDicForSelect?code=articleType" ajax--column="ID,TEXT">
					                 </select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">内容：</label>
								<div class="col-sm-10">
									<script name="ARTICLE_CONTENTS" id="ARTICLE_CONTENTS" type="text/plain">${pd.ARTICLE_CONTENTS}</script>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">APP轮播缩略图：</label>
								<div class="col-sm-10">
									<input id="inp" type="file" name="file" multiple class="file-loading">
									<input type="hidden" class="form-control required" name="PHOTO_THUMBNAIL" id="PHOTO_THUMBNAIL" value="${pd.PHOTO_THUMBNAIL}">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">备注：</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" name="REMARKS" id="REMARKS" value="${pd.REMARKS}">
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
	<!-- 自定义js -->
	<script type="text/javascript">
		//表单ID
		var formId = "#ArticleRotationForm";
		$(document).ready(function(){
	    	//初始化下拉菜单
	    	$("#ARTICLE_TYPE").createOption();
	    	//表单提交JS验证
			$(formId).validate();
	    	//加载UEditor
			UE.getEditor('ARTICLE_CONTENTS',{
				initialFrameWidth: '100%',
		        initialFrameHeight: 300
		    });
	    	//当审核状态非“未送审”时，不可修改
			if('${pd.ARTICLE_ID}' != null && '${pd.ARTICLE_ID}' != '' && '${pd.CHECK_STATE}' != '0' && '${pd.CHECK_STATE}' != '6' && '${pd.PUBLISH_STATE}' != '0'){
	    		$('#ARTICLE_TITLE').attr("readonly", 'readonly');
	    		$('#PUBLISH_NAME').attr("readonly", 'readonly');
	    		$('#PUBLISH_DEPT').attr("readonly", 'readonly');
	    		$('#ARTICLE_TYPE').attr("readonly", 'readonly');
	    		$('#ARTICLE_CONTENTS').attr("readonly", 'readonly');
	    		$('#PHOTO_THUMBNAIL').attr("readonly", 'readonly');
	    		$('#REMARKS').attr("readonly", 'readonly');
	    		$('#btn_Save').attr("disabled", true); 
	    	}
		});
		//表单提交
	    function submitForm(){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>articleRotation/checkKeyWords?tm=' +  new Date().getTime(),
				data: $(formId).serialize(),
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
						var id = $('#ARTICLE_ID').val();
				    	var action = "";
						if(id == ""){
				    		action = "articleRotation/saveAdd";
				    	}else{
				    		action = "articleRotation/saveEdit";
				    	}
				    	$(formId).attr("action", action);
				    	$(formId).submit();
					} else {
						layer.msg(data.error_tip);
					}
				}
			});
			
	    }
	    var IDSAndPid = [];
		var picturePATH = null;
		if(null != '${pd.PHOTO_THUMBNAIL}' && '${pd.PHOTO_THUMBNAIL}' != ''){
			picturePATH = "filesUploads/backFile?ID=${pd.PHOTO_THUMBNAIL}";
		}
		var MASTER_ID = "";//master_id(参数是举例，请根据实际传参)
		var initFileName = ""//初始化照片名(参数是举例，请根据实际传参)
		var initFilePath = ""//初始化照片路径(参数是举例，请根据实际传参)
		var initFileID = ""//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
	    $("#inp").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	showUpload: false,//是否展示上传按钮
	    	showRemove: false,//是否展示移除按钮
	    	//showClose: false,//是否展示关闭按钮
	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: true,//异步支持
	    	//previewFileType: ["text","image"],//文件類型
	    	allowedFileExtensions: ["gif", "jpeg", 'jpg', 'png'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	        initialPreviewAsData: true,
			//初始化预览
	    	initialPreview: [
	    		picturePATH
	        ],
			//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	        initialPreviewConfig: [{
        		caption: initFileName, 
				width: "120px",
				url: '/filesUploads/delete',
				showDelete: true,
				key: 1,
				extra: {
					id: '20e3a27be3d84329833c200772d21a0b'
				}        
			}],
			//上传时附加的参数额外的参数，注意，此处jquery无效。
			uploadExtraData: {
				"MASTER_ID": MASTER_ID
	        },
	        maxFileCount: 1, //表示允许同时上传的最大文件个数
	        minFileCount: 0, //表示允许同时上传的最小文件个数
	        //showCaption: false,//是否显示标题   
	        //dropZoneEnabled: false//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    })
	    .on('fileselect', function(event, numFiles, label) {//选择文件时
	    	//选择完文件后立即上传
	    	$(this).fileinput("upload");
	    })
	    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
	    	var json = JSON.parse(data.jqXHR.responseText)[0];
	    	var ids = json.id;	
			var path = json.path;//文件路径
			$("#PHOTO_THUMBNAIL").val(ids);
	 	})
	 	.on('filebatchuploadsuccess', function(event, data, previewId, index) {//批量上传成功 必须:uploadAsync: false
	 		//var ids = JSON.parse(data.jqXHR.responseText)
	 	})
	 	.on('filebatchuploadcomplete', function(event, files, extra) {//批量上传成功完成
	    	
		})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#PHOTO_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#PHOTO_THUMBNAIL").val("");
	 	})
		.on('filecleared', function(event){//清空的事件
			
		})
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>articleRotation/toLists";
		}
	</script>
</body>
</html>