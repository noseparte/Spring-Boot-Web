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
						<h5>用户病历档案及沟通备忘录信息</h5>
					</div>
					<div class="ibox-content">
						<form id="CaseHistoryForm" name="CaseHistoryForm" class="form-horizontal" method="post">
							<input type="hidden" name="CH_ID" id="CH_ID" value="${pd.CH_ID}" />
							<input type="hidden" name="UI_ID" id="UI_ID" value="${pd.UI_ID}" />
							<div class="form-group">
								<label class="col-sm-2 control-label">病情描述：</label>
							    <div class="col-sm-10">
							    	<textarea rows="3" cols="100" name="CH_ILL_DESC" id="CH_ILL_DESC" style="width:100%;">${pd.CH_ILL_DESC}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">就医历史：</label>
							    <div class="col-sm-10">
							    	<textarea rows="3" cols="100" name="CH_MEDIA_HIS" id="CH_MEDIA_HIS" style="width:100%;">${pd.CH_MEDIA_HIS}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label">过敏史：</label>
							    <div class="col-sm-10">
							    	<textarea rows="3" cols="100" name="CH_ALLERGY" id="CH_ALLERGY" style="width:100%;">${pd.CH_ALLERGY}</textarea>
								</div>
							</div>
							
							<div class="hr-line-dashed"></div>
							<div class="form-group">
								<div class="col-sm-2 col-sm-offset-5 text-center">
									<button id="btn_Save" class="btn btn-primary" type="button" onclick="submitForm();">保存内容</button>
								</div>
							</div>
						</form>
						<div class="form-group">
							<div class="form-group">
								<label class="col-sm-12 control-label"><p class="text-center">病例图片</p></label>
							</div>
							<div class="form-group">
								<div class="col-sm-12">
									<input id="inp" type="file" name="file" multiple class="file-loading">
									<%-- <input type="hidden" class="form-control" name="SP_LICENCE" id="SP_LICENCE" value="${pd.SP_LICENCE}"> --%>
								</div>
							</div>
						</div>
						<div id="toolbar" class="btn-group">
							<div class="pull-left form-inline form-group">
								<button type="button" class="btn btn-default btn-primary" onclick="toAddCommMemo();">
							       	添加
							    </button>
							    <button type="button" class="btn btn-default btn-primary" onclick="toEditCommMemo();">
							       	修改
							    </button>
							    <button type="button" class="btn btn-default btn-danger" onclick="toDeleteCommMemo();">
							       	删除
							    </button>
							</div>
						</div>
						<table id="queryTable" data-mobile-responsive="true"></table>
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
		var picturePATHs = '';
		var pictures = [];
		var formId = "#CaseHistoryForm";
		$(document).ready(function(){
			
	    	//表单提交JS验证
			$(formId).validate();
			//初始化及查询生成表格内容
			table = $(tableId).bootstrapTable(tableColumns);
			//查询图片的id
			var UI_ID = $("#UI_ID").val();
			$.ajax({
				type: "POST",
				url: '<%=basePath%>filesUploads/findByHttpIdOrMasterId',
				data: {
					"ID": UI_ID,
					"MASTER_ID":UI_ID
				},
				dataType: 'json',
				async:false,
				//beforeSend: validateData,
				cache: false,
				success: function(data) {
					for (var int = 0; int < data.length; int++) {
						pictures.unshift(data[int].PATH);
					}
				}
			});
			//上传图片
			var IDSAndPid=[];
			var ids;
			var MASTER_ID=$("#UI_ID").val();//master_id(参数是举例，请根据实际传参)
			var initFileName="timg.jpg"//初始化照片名(参数是举例，请根据实际传参)
			var initFilePath="D:\\\\20170222\\d8ed7fbd4a9b445cb446f7d727579eb2.jpg"//初始化照片路径(参数是举例，请根据实际传参)
			var initFileID= "d8ed7fbd4a9b445cb446f7d727579eb2"//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
			//console.log("srtioeort11111"+picturePATHs)
		    $("#inp").fileinput({
		    	language: 'zh', //设置语言
		    	browseClass: "btn btn-primary btn-block",
		        showCaption: false,//是否在选择按钮旁边显示文件名
		        resizeImage: true,
		        maxImageWidth: 100,
		        maxImageHeight: 100,
		        resizePreference: 'height',
		    	showUpload:true,//是否展示上传按钮
		    	showRemove:true,//是否展示移除按钮
		    	//showClose:false,//是否展示关闭按钮
		    	showDelete: true,//是否显示删除图标
		    	showZoom: false,//是否显示预览
		    	showUploadedThumbs:false,//上传完成后是否显示缩略图
		    	uploadUrl:'/filesUploads/fileUpd',//上传的url
		    	uploadAsync: false,//异步支持
		    	//previewFileType: ["text","image"],//文件類型
		    	allowedFileExtensions: ["gif", "jpeg", "tiff", "bmp",'jpg','png','psd','svg'],//允许上传的文件扩展名
		    	overwriteInitial: true,
		        initialPreviewAsData: true,
		    	initialPreview:pictures,
		        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
		           {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
		        ],
		        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
		           "ID": MASTER_ID,
		           "MASTER_ID":MASTER_ID
		        },
		        //maxFileCount: 10, //表示允许同时上传的最大文件个数
		        //showCaption: false,//是否显示标题   
		        dropZoneEnabled: true,//是否显示拖拽区域
		        //minImageWidth: 50, //图片的最小宽度
		        //minImageHeight: 50,//图片的最小高度
		        maxImageWidth: 20,//图片的最大宽度
		        maxImageHeight: 10,//图片的最大高度
		        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
		        //minFileCount: 0,
		        //enctype: 'multipart/form-data',
		        //validateInitialCount:true,
		    })
		    .on('fileuploaded', function(event, data, previewId, index) {//文件上传成功后
		    	var json=JSON.parse(data.jqXHR.responseText)[0];
		    	var IDS=json.id;	
				var PATH=json.path;//文件路径
				//console.log(PATH)
		 	})
		 	.on('filebatchuploadsuccess', function(event, data, previewId, index) {//批量上传成功 必须:uploadAsync: false
		 		//console.log('File batch upload success');
		 		ids=JSON.parse(data.jqXHR.responseText)
		 		//console.log(ids)
		 	})
		 	.on('filebatchuploadcomplete', function(event, files, extra) {//批量上传成功完成
		    	//console.log('File batch upload complete');
			})
		 	.on('fileremoved', function(event, id) {
				//console.log("file removed")
			})
			.on('filedeleted', function(event, id) {//删除预加载的文件
		        //console.log("has filedeleted")
			})
			.on('filecleared', function(event){//清空的事件
		 		for(var i=0;i<ids.length;i++){
	 			    $.ajax({
	 	 		        url:'/filesUploads/delete',
	 	 		        type:'post',
	 	 		        dataType:'json',
	 	 		        data:{"IDS":ids[i].id},
	 	 		        success:function(){	
	 	 		        },
	 	 		        error:function(){
	 	 		        	//console.log('clear has error!')
	 	 		   	    }
	 	 		    })
		 		}
			})
		});
		//表格ID
		var tableId = "#queryTable";
		//表格请求及数据
		var tableColumns = {
			url: 'commMemo/pageSearch?UI_ID=${pd.UI_ID}&tm=' + new Date().getTime(),
			toolbar:'#toolbar',
			columns: [{
		        field: 'CH_ID',
		        visible: false,
		        halign: 'center'
		    }, {
		        field: 'CH_MEMO',
		        title: '沟通备忘录',
		        align: 'left',
		        halign: 'center',
		        width: '80%'
		    }, {
		        field: 'CHANGE_TIME',
		        title: '记录时间',
		        align: 'center',
		        halign: 'center',
		        width: '15%'
		    }]
		};
		//查询刷新表格
		function searchRefreshTable(){
			//销毁表格
			$(tableId).bootstrapTable('destroy');
			$(tableId).bootstrapTable(tableColumns);
		}
		//添加沟通备忘录
		function toAddCommMemo(){
			var UI_ID = $("#UI_ID").val();
			if(UI_ID != null && UI_ID != ""){
				layer.open({
					type: 2,
					title: '添加用户沟通备忘录信息',//窗体标题
					area: ['600px', '350px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: false,//整体页面滚动条是否显示
					content: ['/commMemo/toAdd?UI_ID=' + UI_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['保存'],
					btn1: function(index, layero){
						var memo = $(layero).find("iframe")[0].contentWindow.formData();
						if(memo != null){
							$.ajax({
								type: "POST",
								url: '<%=basePath%>commMemo/saveAdd?tm=' +  new Date().getTime(),
								data: {
									UI_ID: UI_ID,
									CH_MEMO: memo
								},
								dataType: 'json',
								cache: false,
								success: function(data) {
									if (data.msg == 'success') {
										layer.msg('用户沟通备忘信息保存成功！');
										searchRefreshTable();
									} else {
										layer.msg('用户沟通备忘信息保存失败！');
									}
								}
							});
						}else{
							layer.msg('未录入与用户具体的沟通内容，无法进行保存！');
						}
					}
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//修改沟通备忘录
		function toEditCommMemo(){
			var ids = getBstCheckedId('CH_ID');
			if(!(ids.length == 1)){
				layer.msg('请只选中一条信息再进行编辑。');
				return false;
			}
			var CH_ID = ids.toString();
			if(CH_ID != null && CH_ID != ""){
				layer.open({
					type: 2,
					title: '修改用户沟通备忘录信息',//窗体标题
					area: ['600px', '350px'],//整个窗体宽、高，单位：像素px
					fix: false,//窗体位置不固定
					maxmin: true,//最大、小化是否显示
					scrollbar: false,//整体页面滚动条是否显示
					content: ['/commMemo/toEdit?CH_ID=' + CH_ID, 'no'],//URL地址
					closeBtn: 1,//显示关闭按钮
					btn: ['关闭'],
					btn1: function(index, layero){
						var memo = $(layero).find("iframe")[0].contentWindow.formData();
						if(memo != null){
							$.ajax({
								type: "POST",
								url: '<%=basePath%>commMemo/saveEdit?tm=' +  new Date().getTime(),
								data: {
									CH_ID: CH_ID,
									CH_MEMO: memo
								},
								dataType: 'json',
								cache: false,
								success: function(data) {
									if (data.msg == 'success') {
										layer.msg('用户沟通备忘信息保存成功！');
										searchRefreshTable();
									} else {
										layer.msg('用户沟通备忘信息保存失败！');
									}
								}
							});
						}else{
							layer.msg('未录入与用户具体的沟通内容，无法进行保存！');
						}
					}
				});
			}else{
				layer.msg("系统未获取到数据主键，请重新选择数据！");
			}
		}
		//删除沟通备忘录
		function toDeleteCommMemo(){
			var ids = getBstCheckedId('CH_ID');
			if((ids.length < 1)){
				layer.msg('请选中信息再进行删除。');
				return false;
			}
			var idsStr = ids.toString();
			layer.confirm('确定删除已选信息吗？', {
				btn: ['确认','取消'],
				shade: false,
				yes: function(index, layero){
					$.ajax({
						type: "POST",
						url: '<%=basePath%>commMemo/toDelete?tm=' +  new Date().getTime(),
						data: {
							IDS: idsStr
						},
						dataType: 'json',
						//beforeSend: validateData,
						cache: false,
						success: function(data) {
							if (data.msg == 'success') {
								layer.msg('删除信息成功');
								searchRefreshTable();
							} else {
								layer.msg('删除信息失败');
							}
						}
					});
				}
			});
		}
		//表单提交
	    function submitForm(){
	        var id = $('#CH_ID').val();
	    	var action = "";
	    	if(id == ""){
	    		action = "caseHist/saveAdd";
	    	}else{
	    		action = "caseHist/saveEdit";
	    	}
	    	$(formId).attr("action", action);
	    	$(formId).submit();
	    }
	</script>
</body>
</html>