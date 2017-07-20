<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<system:header/>
<!-- jsp文件头和头部 -->
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h5>代理商信息</h5>
					</div>
					<div class="ibox-content">
						<form id="AgentForm" name="AgentForm" class="form-horizontal" method="post">
							<input type="hidden" name="SP_ID" id="SP_ID" value="${pd.SP_ID}" />
							<input type="hidden" name="SYS_UI_ID" id="SYS_UI_ID" value="${pd.SYS_UI_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">公司名称：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="SP_NAME" id="GI_NAME" value="${pd.SP_NAME}" />
								</div>
								<label class="col-sm-2 control-label">负责人：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="SP_LEGAL_PERSON" id="SP_LEGAL_PERSON" value="${pd.SP_LEGAL_PERSON}" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">注册时间：</label>
							    <div class="col-sm-4">
									<input type="text" class="bootstrapdatetimepicker form-control required" name="SP_REGITER_TIME" id="SP_REGITER_TIME" placeholder="请选择注册时间" value="${pd.SP_REGITER_TIME}" />
								</div>
								<label class="col-sm-2 control-label">服务范围：</label>
								<div class="col-sm-4">
									<input type="hidden" class="form-control" name="SP_REGISTER_ADDR" value="${pd.SP_REGISTER_ADDR}" />
							    	<select class="form-control required" id="SP_REGISTER_ADDR" value="${pd.SP_REGISTER_ADDR}"
                                    	 ajax--url="dic/getDicAreaForSelect" ajax--column="ID,TEXT" disabled>
                                    	 <option value="country">全国</option>
                     				 </select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">联系方式：</label>
							    <div class="col-sm-4">
									<input type="text" class="form-control required" name="SP_PHONE" id="SP_PHONE" value="${pd.SP_PHONE}" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')"  />
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">业务范围：</label>
							    <div class="col-sm-10">
									<%-- <input type="text" class="form-control required" name="SP_SERVICE_RANGE" id="SP_SERVICE_RANGE" value="${pd.SP_SERVICE_RANGE}" /> --%>
									<textarea name="SP_SERVICE_RANGE" id="SP_SERVICE_RANGE" rows="5" cols="50" class="form-control" style="resize: none;">${pd.SP_SERVICE_RANGE}</textarea>
								</div>
								
							</div>
							<div class="form-group">
								<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">营业执照扫描件</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="SP_LICENCE" id="SP_LICENCE" value="${pd.SP_LICENCE}">
											</div>
										</div>
									</div>
									<div class="col-sm-6">
										<div class="form-group">
											<label class="col-sm-12 control-label"><p class="text-center">合同电子版</p></label>
										</div>
										<div class="form-group">
											<div class="col-sm-12">
												<input id="inpp" type="file" name="file" multiple class="file-loading">
												<input type="hidden" class="form-control" name="SP_CONTRACT" id="SP_CONTRACT" value="${pd.SP_CONTRACT}">
											</div>
										</div>
									</div>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
										<font color="red">注：用户可以通过网址<%=basePath %>登录系统，用户账号为所填写的手机号，初始密码为123456，用户可在登录后主界面的右上角点击用户名选择修改密码！</font>
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
		var formId = "#AgentForm";
		$(document).ready(function(){
	    	//表单提交JS验证
	    	$("#SP_REGISTER_ADDR").createOption();
			$(formId).validate({
				rules: {
					SP_PHONE: {
						rangelength: [11, 11],
						remote: {
							url: '/agent/selectPhone',
							type: 'POST',
							dataType: 'JSON',
							data: {
								'SP_PHONE': function() {
									return $('#SP_PHONE').val();
								},
								'ID' : function(){
									return $('#SP_ID').val();
								}
							}
						}
					}
				},
				messages: {
					SP_PHONE: "输入的手机号格式不正确，或该手机号已被注册",
				}
			});
		});
		//表单提交
	    function submitForm(){
	        var id = $('#SP_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "agent/saveAdd";
	    	}else{
	    		action = "agent/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	    //返回到列表页面 
		function goBack(){
			this.location.href="<%=basePath%>agent/toLists";
		}
		var picturePATH = '';
		var picturePATHS = '';
		var SP_LICENCE = $("#SP_LICENCE").val();
		var SP_CONTRACT = $("#SP_CONTRACT").val();
		if(SP_LICENCE != null && SP_LICENCE != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
				data: {
					"ID": SP_LICENCE,
					"MASTER_ID":SP_LICENCE
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
		if(SP_CONTRACT != null && SP_CONTRACT != ''){
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
				data: {
					"ID": SP_CONTRACT,
					"MASTER_ID":SP_CONTRACT
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					picturePATHS = data[0].PATH;
				}
			});
		}
			
		var IDSAndPid=[];
		var ids;
		var MASTER_ID=SP_LICENCE;//master_id(参数是举例，请根据实际传参)
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

	    	showDelete: true,//是否显示删除图标
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
			$("#SP_LICENCE").val(IDS);
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
	        console.log("has filedeleted")
	        var SP_LICENCE = $("#SP_LICENCE").val();
			<%-- console.log(1111111111111111111111)
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/delete',
				data: {
					"ID": SP_LICENCE
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if(data.msg == "ok"){
						$("#SP_LICENCE").val("");
						layer.msg("删除成功");
					}else{
						layer.msg("删除失败");
					}
				}
			}); --%>
		})
		.on('filecleared', function(event){ //清空的事件
			var SP_LICENCE = $("#SP_LICENCE").val();
			<%-- console.log(22222222222222222222222)
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/delete',
				data: {
					"ID": SP_LICENCE
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if(data.msg == "ok"){
						$("#SP_LICENCE").val("");
						layer.msg("删除成功");
					}else{
						layer.msg("删除失败");
					}
				}
			}); --%>
		})
		.on('fileremoved', function(event, id) {
			var SP_LICENCE = $("#SP_LICENCE").val();
			<%-- console.log(333333333333333333333333)
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/delete',
				data: {
					"ID": SP_LICENCE
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if(data.msg == "ok"){
						$("#SP_LICENCE").val("");
						layer.msg("删除成功");
					}else{
						layer.msg("删除失败");
					}
				}
			}); --%>
		})
		var MASTER_IDS=SP_CONTRACT;
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
	            {caption: initFileNames, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
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
			$("#SP_CONTRACT").val(IDS);
			
	 	})
	 	
		.on('filedeleted', function(event, id) {//删除预加载的文件
			var SP_CONTRACT = $("#SP_CONTRACT").val();
			<%-- $.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/delete',
				data: {
					"ID": SP_CONTRACT
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if(data.msg == "ok"){
						$("#SP_CONTRACT").val("");
						layer.msg("删除成功");
					}else{
						layer.msg("删除失败");
					}
				}
			}); --%>
		})
		.on('filecleared', function(event){ //清空的事件
			var SP_CONTRACT = $("#SP_CONTRACT").val();
			<%-- $.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/delete',
				data: {
					"ID": SP_CONTRACT
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if(data.msg == "ok"){
						$("#SP_CONTRACT").val("");
						layer.msg("删除成功");
					}else{
						layer.msg("删除失败");
					}
				}
			}); --%>
		})
		.on('fileremoved', function(event, id) {
			var SP_CONTRACT = $("#SP_CONTRACT").val();
			<%-- $.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/delete',
				data: {
					"ID": SP_CONTRACT
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					if(data.msg == "ok"){
						$("#SP_CONTRACT").val("");
						layer.msg("删除成功");
					}else{
						layer.msg("删除失败");
					}
				}
			}); --%>
		})
		
	</script>
</body>
</html>