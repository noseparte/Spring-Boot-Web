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
						<h5>活动信息</h5>
					</div>
					<div class="ibox-content">
						<form id="ActiveForm" name="ActiveForm" class="form-horizontal" method="post">
							<input type="hidden" name="A_ID" id="A_ID" value="${pd.A_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">活动名称：</label>
							    <div class="col-sm-10">
									<input type="text" class="form-control required" name="A_NAME" id="A_NAME" value="${pd.A_NAME}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动日期：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control required" name="A_START_DATE" id="A_START_DATE" placeholder="请选择活动开始日期" value="${pd.A_START_DATE}" />
								</div>
								<label class="col-sm-2 control-label">报名截止日期：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control required" name="A_APPLY_STOP" id="A_APPLY_STOP" placeholder="请选择活动报名截止日期" value="${pd.A_APPLY_STOP}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动类型：</label>
							    <div class="col-sm-4">
							    	<div class="radio radio-primary radio-inline">
                                        <input type="radio" id="A_TYPE_0" value="0" name="A_TYPE" <c:if test="${pd.A_TYPE == '0'}">checked="checked"</c:if>>
                                        <label for="A_TYPE_0"> 个人 </label>
                                    </div>
                                    <div class="radio radio-primary radio-inline">
                                        <input type="radio" id="A_TYPE_1" value="1" name="A_TYPE" <c:if test="${pd.A_TYPE == '1'}">checked="checked"</c:if>>
                                        <label for="A_TYPE_1"> 团体 </label>
                                    </div>
								</div>
								<label class="col-sm-2 control-label">报名必须上传视频：</label>
							    <div class="col-sm-4">
									<select class="form-control required" name="A_TV_NECESSARY" id="A_TV_NECESSARY" value="${pd.A_TV_NECESSARY}">
										<option value="0" <c:if test="${pd.A_TV_NECESSARY == 0}">selected="selected"</c:if>>否</option>
										<option value="1" <c:if test="${pd.A_TV_NECESSARY == 1}">selected="selected"</c:if>>是</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">报名人/团体数：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required digits" name="A_APPLY_NUM" id="A_APPLY_NUM" value="${pd.A_APPLY_NUM}" />
								</div>
								<label class="col-sm-2 control-label">团体人数：</label>
							    <div class="col-sm-4">
							    	<label class="col-sm-2 control-label">下限</label>
							    	<div class="col-sm-4">
							    		<input type="text" class="form-control digits" name="A_GROUP_LOW" id="A_GROUP_LOW" value="${pd.A_GROUP_LOW}" />
							    	</div>
									<label class="col-sm-2 control-label">上限</label>
									<div class="col-sm-4">
										<input type="text" class="form-control digits" name="A_GROUP_UP" id="A_GROUP_UP" value="${pd.A_GROUP_UP}" />
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">视频状态：</label>
							    <div class="col-sm-4">
									<select class="form-control required" name="A_VOIDE_SHOW_STATE" id="A_VOIDE_SHOW_STATE" value="${pd.A_VOIDE_SHOW_STATE}">
										<option value="0" <c:if test="${pd.A_VOIDE_SHOW_STATE == 0}">selected="selected"</c:if>>不显示</option>
										<option value="1" <c:if test="${pd.A_VOIDE_SHOW_STATE == 1}">selected="selected"</c:if>>显示</option>
									</select>
								</div>
								<label class="col-sm-2 control-label">活动状态：</label>
							    <div class="col-sm-4">
									<select class="form-control required" name="A_ACTI_SHOW_STATE" id="A_ACTI_SHOW_STATE" value="${pd.A_ACTI_SHOW_STATE}">
										<option value="0" <c:if test="${pd.A_ACTI_SHOW_STATE == 0}">selected="selected"</c:if>>不显示</option>
										<option value="1" <c:if test="${pd.A_ACTI_SHOW_STATE == 1}">selected="selected"</c:if>>显示</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">视频区域坐标(px)：</label>
							    <div class="col-sm-4">
							    	<label class="col-sm-2 control-label">距上</label>
							    	<div class="col-sm-4">
							    		<input type="text" class="form-control digits" name="A_VOIDE_AREA_TOP" id="A_VOIDE_AREA_TOP" value="${pd.A_VOIDE_AREA_TOP}" />
							    	</div>
									<label class="col-sm-2 control-label">距左</label>
									<div class="col-sm-4">
										<input type="text" class="form-control digits" name="A_VOIDE_AREA_LEFT" id="A_VOIDE_AREA_LEFT" value="${pd.A_VOIDE_AREA_LEFT}" />
									</div>
								</div>
								<label class="col-sm-2 control-label">排序：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required digits" name="A_ORDER" id="A_ORDER" value="${pd.A_ORDER}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动地点：</label>
							    <div class="col-sm-10">
									<input type="text" class="form-control required" name="A_ADDR" id="A_ADDR" value="${pd.A_ADDR}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">活动内容：</label>
								<div class="col-sm-10">
									<script id="container" name="A_CONTENT" id="A_CONTENT" type="text/plain">${pd.A_CONTENT}</script>
								</div>
							</div>
							<div class="ibox-title">
								<h5>活动图片上传</h5>
							</div>
							<div class="ibox-content">
								<div class="form-group">
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">电视海报缩略图</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12" style="height: 200px;">
												<input id="fileupload_tv_post_list" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="A_TV_POST_LIST_THUMBNAIL" id="A_TV_POST_LIST_THUMBNAIL" value="${pd.A_TV_POST_LIST_THUMBNAIL}">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">APP轮播</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="fileupload_rotation" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="A_APP_ROTATION_THUMBNAIL" id="A_APP_ROTATION_THUMBNAIL" value="${pd.A_APP_ROTATION_THUMBNAIL}">
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">电视活动海报</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="fileupload_tv_post" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="A_TV_POST_THUMBNAIL" id="A_TV_POST_THUMBNAIL" value="${pd.A_TV_POST_THUMBNAIL}">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">手机活动海报</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="fileupload_app_post" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="A_APP_POST_THUMBNAIL" id="A_APP_POST_THUMBNAIL" value="${pd.A_APP_POST_THUMBNAIL}">
											</div>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">电视评奖结果</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="fileupload_tv_award" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="A_TV_AWARD_THUMBNAIL" id="A_TV_AWARD_THUMBNAIL" value="${pd.A_TV_AWARD_THUMBNAIL}">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">手机评奖结果</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="fileupload_app_award" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="A_APP_AWARD_THUMBNAIL" id="A_APP_AWARD_THUMBNAIL" value="${pd.A_APP_AWARD_THUMBNAIL}">
											</div>
										</div>
									</div>
								</div>
								<%-- <div class="form-group">
									<!-- <label class="col-sm-2 control-label">活动海报：</label>
									<div class="col-sm-10">
										<label class="col-sm-1 control-label">电视：</label> -->
										<div class="col-sm-6">
											<input id="fileupload_tv_post" type="file" name="file" multiple class="file-loading">
											<input type="hidden" class="form-control" name="A_TV_POST_THUMBNAIL" id="A_TV_POST_THUMBNAIL" value="${pd.A_TV_POST_THUMBNAIL}">
										</div>
										<!-- <label class="col-sm-1 control-label">手机：</label> -->
										<div class="col-sm-6">
											<input id="fileupload_app_post" type="file" name="file" multiple class="file-loading">
											<input type="hidden" class="form-control" name="A_APP_POST_THUMBNAIL" id="A_APP_POST_THUMBNAIL" value="${pd.A_APP_POST_THUMBNAIL}">
										</div>
									<!-- </div> -->
								</div>
								<div class="form-group">
									<!-- <label class="col-sm-2 control-label">评奖结果：</label>
									<div class="col-sm-10">
										<label class="col-sm-1 control-label">电视：</label> -->
										<div class="col-sm-6">
											<input id="fileupload_tv_award" type="file" name="file" multiple class="file-loading">
											<input type="hidden" class="form-control" name="A_TV_AWARD_THUMBNAIL" id="A_TV_AWARD_THUMBNAIL" value="${pd.A_TV_AWARD_THUMBNAIL}">
										</div>
										<!-- <label class="col-sm-1 control-label">手机：</label> -->
										<div class="col-sm-6">
											<input id="fileupload_app_award" type="file" name="file" multiple class="file-loading">
											<input type="hidden" class="form-control" name="A_APP_AWARD_THUMBNAIL" id="A_APP_AWARD_THUMBNAIL" value="${pd.A_APP_AWARD_THUMBNAIL}">
										</div>
									<!-- </div> -->
								</div> --%>
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
		var formId = "#ActiveForm";
		$(document).ready(function(){
	    	//初始化下拉菜单
	    	//JS操作
	    	//"活动类型"为个人时，去掉验证“团体人数上限/下限”
	    	$("#A_TYPE_0").click(function(){
	    		if($("#A_TYPE_0").val() == '0'){
	    			$("#A_GROUP_LOW").removeAttr("required");
	    			$("#A_GROUP_UP").removeAttr("required");
	    			$("#A_GROUP_LOW").removeAttr("digits");
	    			$("#A_GROUP_UP").removeAttr("digits");
	    		}
	    	});
	    	//"活动类型"为团体时，添加验证“团体人数上限/下限”
	    	$("#A_TYPE_1").click(function(){
	    		if($("#A_TYPE_1").val() == '1'){
	    			$("#A_GROUP_LOW").attr("required", "");
	    			$("#A_GROUP_UP").attr("required", "");
	    			$("#A_GROUP_LOW").attr("digits", "");
	    			$("#A_GROUP_UP").attr("digits", "");
	    		}
	    	});
	    	//"视频状态"为显示时，添加验证“视频距上/距左”，为不显示时，去掉验证“视频距上/距左”
	    	$("#A_VOIDE_SHOW_STATE").click(function(){
	    		if($("#A_VOIDE_SHOW_STATE").val() == '0'){
	    			$("#A_VOIDE_AREA_TOP").removeAttr("required");
	    			$("#A_VOIDE_AREA_LEFT").removeAttr("required");
	    			$("#A_VOIDE_AREA_TOP").removeAttr("digits");
	    			$("#A_VOIDE_AREA_LEFT").removeAttr("digits");
	    		}else if($("#A_VOIDE_SHOW_STATE").val() == '1'){
	    			$("#A_VOIDE_AREA_TOP").attr("required", "");
	    			$("#A_VOIDE_AREA_LEFT").attr("required", "");
	    			$("#A_VOIDE_AREA_TOP").attr("digits", "");
	    			$("#A_VOIDE_AREA_LEFT").attr("digits", "");
	    		}
	    	});
	    	//表单提交JS验证
			$(formId).validate({
				rules: {
					A_START_DATE: {
						date: true,
						dateISO: true
					},
					A_APPLY_STOP: {
						date: true,
						dateISO: true
					},
					A_APPLY_NUM: {
						rangelength: [1, 10]
					},
					A_GROUP_LOW: {
						rangelength: [1, 10]
					},
					A_GROUP_UP: {
						rangelength: [1, 10]
					},
					A_VOIDE_AREA_TOP: {
						rangelength: [1, 10]
					},
					A_VOIDE_AREA_LEFT: {
						rangelength: [1, 10]
					},
					A_ORDER: {
						rangelength: [1, 10]
					}
				},
				messages: {
					A_START_DATE: "请输入或选择正确的活动日期格式。例如：1970-01-01",
					A_APPLY_STOP: "请输入或选择正确的活动报名截止日期格式。例如：1970-01-01",
					A_APPLY_NUM: "请输入10位以内的报名人/团体数。",
					A_GROUP_LOW: "请输入10位以内的团体人数下限。",
					A_GROUP_UP: "请输入10位以内的团体人数上限。",
					A_VOIDE_AREA_TOP: "请输入10位以内的视频距上位置。",
					A_VOIDE_AREA_LEFT: "请输入10位以内的视频距左位置。",
					A_ORDER: "请输入10位以内容的排序号。"
				}
			});
	    	//加载UEditor
			UE.getEditor('container',{
		        initialFrameWidth : '100%',
		        initialFrameHeight: 300
		    });
			//当审核状态非“未送审”时，不可修改
			if('${pd.A_ID}' != null && '${pd.A_ID}' != '' && '${pd.A_CHECK_STATE}' != '0' && '${pd.A_CHECK_STATE}' != '6'){
	    		$('#ARTICLE_TITLE').attr("readonly", 'readonly');
	    		$('#PUBLISH_NAME').attr("readonly", 'readonly');
	    		$('#PUBLISH_DEPT').attr("readonly", 'readonly');
	    		$('#ARTICLE_TYPE').attr("readonly", 'readonly');
	    		$('#EXPERT_NAME').attr("readonly", 'readonly');
	    		$('#EXPERT_DUTY').attr("readonly", 'readonly');
	    		$('#EXPERT_HOSP').attr("readonly", 'readonly');
	    		$('#EXPERT_DEPT').attr("readonly", 'readonly');
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
				url: '<%=basePath%>active/checkKeyWords?tm=' +  new Date().getTime(),
				data: $(formId).serialize(),
				dataType: 'json',
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if (data.msg == 'success') {
				        var id = $('#A_ID').val();
				    	var action = "";
				    	if(id == ""){
				    		action = "active/saveAdd";
				    	}else{
				    		action = "active/saveEdit";
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
		var picturePATH_rotation = null;
		var picturePATH_tv_post = null;
		var picturePATH_app_post = null;
		var picturePATH_tv_award = null;
		var picturePATH_app_award = null;
		var picturePATH_tv_post_list = null;
		if(null != '${pd.A_APP_ROTATION_THUMBNAIL}' && '${pd.A_APP_ROTATION_THUMBNAIL}' != ''){
			picturePATH_rotation = "filesUploads/backFile?ID=${pd.A_APP_ROTATION_THUMBNAIL}";
		}
		if(null != '${pd.A_TV_POST_THUMBNAIL}' && '${pd.A_TV_POST_THUMBNAIL}' != ''){
			picturePATH_tv_post = "filesUploads/backFile?ID=${pd.A_TV_POST_THUMBNAIL}";
		}
		if(null != '${pd.A_APP_POST_THUMBNAIL}' && '${pd.A_APP_POST_THUMBNAIL}' != ''){
			picturePATH_app_post = "filesUploads/backFile?ID=${pd.A_APP_POST_THUMBNAIL}";
		}
		if(null != '${pd.A_TV_AWARD_THUMBNAIL}' && '${pd.A_TV_AWARD_THUMBNAIL}' != ''){
			picturePATH_tv_award = "filesUploads/backFile?ID=${pd.A_TV_AWARD_THUMBNAIL}";
		}
		if(null != '${pd.A_APP_AWARD_THUMBNAIL}' && '${pd.A_APP_AWARD_THUMBNAIL}' != ''){
			picturePATH_app_award = "filesUploads/backFile?ID=${pd.A_APP_AWARD_THUMBNAIL}";
		}
		if(null != '${pd.A_TV_POST_LIST_THUMBNAIL}' && '${pd.A_TV_POST_LIST_THUMBNAIL}' != ''){
			picturePATH_tv_post_list = "filesUploads/backFile?ID=${pd.A_TV_POST_LIST_THUMBNAIL}";
		}
		var MASTER_ID = "";//master_id(参数是举例，请根据实际传参)
		var initFileName = ""//初始化照片名(参数是举例，请根据实际传参)
		var initFilePath = ""//初始化照片路径(参数是举例，请根据实际传参)
		var initFileID = ""//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
	    $("#fileupload_rotation").fileinput({
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
	    		picturePATH_rotation
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
			$("#A_APP_ROTATION_THUMBNAIL").val(ids);
	 	})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#A_APP_ROTATION_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#A_APP_ROTATION_THUMBNAIL").val("");
	 	});
		$("#fileupload_tv_post").fileinput({
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
	    		picturePATH_tv_post
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
			$("#A_TV_POST_THUMBNAIL").val(ids);
	 	})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#A_TV_POST_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#A_TV_POST_THUMBNAIL").val("");
	 	});
		$("#fileupload_app_post").fileinput({
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
	    		picturePATH_app_post
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
			$("#A_APP_POST_THUMBNAIL").val(ids);
	 	})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#A_APP_POST_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#A_APP_POST_THUMBNAIL").val("");
	 	});
		$("#fileupload_tv_award").fileinput({
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
	    		picturePATH_tv_award
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
			$("#A_TV_AWARD_THUMBNAIL").val(ids);
	 	})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#A_TV_AWARD_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#A_TV_AWARD_THUMBNAIL").val("");
	 	});
		$("#fileupload_app_award").fileinput({
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
	    		picturePATH_app_award
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
			$("#A_APP_AWARD_THUMBNAIL").val(ids);
	 	})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#A_APP_AWARD_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#A_APP_AWARD_THUMBNAIL").val("");
	 	});
		$("#fileupload_tv_post_list").fileinput({
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
	    		picturePATH_tv_post_list
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
			$("#A_TV_POST_LIST_THUMBNAIL").val(ids);
	 	})
	 	.on('fileremoved', function(event, id) {//这是上传完成后删除事件;
	 		$("#A_TV_POST_LIST_THUMBNAIL").val("");
	 	})
	 	.on('filedeleted', function(event, id) {//删除预加载的文件
	 		$("#A_TV_POST_LIST_THUMBNAIL").val("");
	 	});
		/*$("[class=file-drop-zone-title]")[0].innerText="拖拽【电视海报缩略图】文件到这里……\r\n仅限单文件上传";
		$("[class=file-drop-zone-title]")[1].innerText="拖拽【手机轮播】文件到这里……\r\n仅限单文件上传";
		$("[class=file-drop-zone-title]")[2].innerText="拖拽【电视海报】文件到这里……\r\n仅限单文件上传";
		$("[class=file-drop-zone-title]")[3].innerText="拖拽【手机海报】文件到这里……\r\n仅限单文件上传";
		$("[class=file-drop-zone-title]")[4].innerText="拖拽【电视评奖结果】文件到这里……\r\n仅限单文件上传";
		$("[class=file-drop-zone-title]")[5].innerText="拖拽【手机评奖结果】文件到这里……\r\n仅限单文件上传";*/
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>active/toLists";
		}
	</script>
</body>
</html>