<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link href="/hplus/css/bootstrap.min.css"  rel="stylesheet">
<link href="/plugins/bootstrap-fileinput/css/fileinput.min.css" rel="stylesheet">
<!--
 jsp文件头和头部 -->
</head>

<body>
			<label class="control-label">请选择上传文件</label>
			<input id="inp" type="file" name="file" multiple class="file-loading">
			<label class="control-label">请选择上传文件</label>
			<input id="inp2" type="file" name="file" multiple class="file-loading">
</body>


<!-- 全局js -->
<!-- 附件上传 
<script src="hplus/js/plugins/webuploader/webuploader_pegasus.js"></script>-->
<!-- 自定义js 
<script src="hplus/js/content.min.js"></script>-->
<script src="/hplus/js/jquery.min.js" ></script>
<script src="/plugins/bootstrap-fileinput/js/plugins/canvas-to-blob.min.js"></script>
<script src="/plugins/bootstrap-fileinput/js/plugins/sortable.min.js"></script>
<script src="/plugins/bootstrap-fileinput/js/plugins/purify.min.js"></script>
<script src="/plugins/bootstrap-fileinput/js/fileinput.js"></script>
<script src="/hplus/js/bootstrap.min.js" ></script>
<script src="/plugins/bootstrap-fileinput/js/locales/zh.js"></script>
<script src="/plugins/bootstrap-fileinput/themes/fa/theme.js"></script>

<script type="text/javascript">
	$(function(){
		$("[class=file-drop-zone-title]")[0].innerText="我是第一个";
		$("[class=file-drop-zone-title]")[1].innerText="我是第二个";
	})
	var IDSAndPid=[];
	var ids;
	var MASTER_ID=234;//master_id(参数是举例，请根据实际传参)
	var initFileName="timg.jpg"//初始化照片名(参数是举例，请根据实际传参)
	var initFilePath="D:\\\\20170222\\d8ed7fbd4a9b445cb446f7d727579eb2.jpg"//初始化照片路径(参数是举例，请根据实际传参)
	var initFileID= "d8ed7fbd4a9b445cb446f7d727579eb2"//初始化照片id，如果多的话可设置为数组(参数是举例，请根据实际传参)
    $("#inp").fileinput({
    	language: 'zh', //设置语言
    	browseClass: "btn btn-primary btn-block",
        showCaption: false,//是否在选择按钮旁边显示文件名
        resizeImage: true,
        maxImageWidth: 100,
        maxImageHeight: 100,
        resizePreference: 'height',
    	//showUpload:false,//是否展示上传按钮
    	//showRemove:false,//是否展示移除按钮
    	//showClose:false,//是否展示关闭按钮
    	//showDelete: false,//是否显示删除图标
    	showUploadedThumbs:false,//上传完成后是否显示缩略图
    	uploadUrl:'/filesUploads/fileUpd',//上传的url
    	uploadAsync: false,//异步支持
    	showUploadedThumbs:false,
    	//previewFileType: ["text","image"],//文件類型
    	//allowedFileExtensions: ["txt", "md", "ini", "text",'jpg','png'],//允许上传的文件扩展名
    	overwriteInitial: true,
        initialPreviewAsData: true,
    	initialPreview: [//初始化预览
    		'http://127.0.0.1:8080/1.jpg'
        ],
        initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
           {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: false ,showZoom: false,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
        ],
        uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
           "IDS": 'c539604f49af42c4adc2a9c0376f66f0'
        },
        //maxFileCount: 10, //表示允许同时上传的最大文件个数
        //showCaption: false,//是否显示标题   
        dropZoneEnabled: true//是否显示拖拽区域
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
    	var json=JSON.parse(data.jqXHR.responseText)[0];
    	var IDS=json.id;	
		var PATH=json.path;//文件路径
		console.log(PATH)
 	})
 	.on('filebatchuploadsuccess', function(event, data, previewId, index) {//批量上传成功 必须:uploadAsync: false
 		console.log('File batch upload success');
 		ids=JSON.parse(data.jqXHR.responseText)
 		console.log(ids)
 	})
 	.on('filebatchuploadcomplete', function(event, files, extra) {//批量上传成功完成
    console.log('File batch upload complete');
    
	})
 	.on('fileremoved', function(event, id) {
// 		var hasGotTemp=getTemp(id,IDSAndPid);
// 		if(hasGotTemp==null){
// 			alert("没有找到对应的值")
// 		}else{
// 			var IDS=hasGotTemp
 //		    $.ajax({
// 		        url:'/filesUploads/delete',
// 		        type:'post',
 //		        dataType:'json',
 //		        data:{"IDS":IDS},
 //		        success:function(){
 //		        	console.log('remove has success!');
 //		        	var willRemoveTemp=removeTemp(id,IDSAndPid);
 //		        	if(willRemoveTemp==null){
 //		        		alert("没有找到对应的值1")
// 		        	}else{
 //		        		IDSAndPid.del(willRemoveTemp);
 //		        	}	
 //		        },
 //		        error:function(){
 //		        	console.log('remove has error!')
 //		   	    }
 //		    })
 //		}
	console.log("file removed")
	})
	.on('filedeleted', function(event, id) {//删除预加载的文件
        console.log("has filedeleted")
	})
	.on('filecleared', function(event){//清空的事件
		//var IAPL=IDSAndPid.length;
		//循环删除
		//for(var i=0;i<IAPL;i++){
		//	var willDelete=IDSAndPid[i].value;
		//    $.ajax({
 		 //       url:'/filesUploads/delete',
 		 //       type:'post',
 		//        dataType:'json',
 		//        data:{"IDS":willDelete},
 		//        success:function(){
 		//        	console.log('clear has success!');
 		//        	var willRemoveTemp=removeTemp(id,IDSAndPid);
 		//        	if(willRemoveTemp==null){
 		//        		alert("没有找到对应的值2")
 		//        	}else{
 		//        		IDSAndPid.del(willRemoveTemp);
 		//        	}	
 		//        },
 		//        error:function(){
 		 //       	console.log('clear has error!')
 		//   	    }
 		//    })
 		for(var i=0;i<ids.length;i++){
 			console.log(ids[i].id)
 			    $.ajax({
 	 		        url:'/filesUploads/delete',
 	 		        type:'post',
 	 		        dataType:'json',
 	 		        data:{"IDS":ids[i].id},
 	 		        success:function(){
 	 		        	console.log('clear has success!');
 	 		        	//var willRemoveTemp=removeTemp(id,IDSAndPid);
 	 		        	//if(willRemoveTemp==null){
 	 		        	//	alert("没有找到对应的值2")
 	 		        	//}else{
 	 		        	//	IDSAndPid.del(willRemoveTemp);
 	 		        	//}	
 	 		        },
 	 		        error:function(){
 	 		        	console.log('clear has error!')
 	 		   	    }
 	 		    })
 		}
		
		//清空数组
		//for(var i=0;i<IAPL;i++){
			//IDSAndPid.del[0]
		//}
	})
	//找array中json的key对应的value。找到返回value，找不到为null
	function getTemp(id,array){
		console.log(id)
		for(var i=0;i<array.length;i++){
			console.log('循环次数'+i)
			if(array[i].id !=null && array[i].id !='undefined' && array[i].id !=''){
				console.log("结果"+array[i][id])
				return array[i][id]
			}
		}
		return null;
	}
	//找到要删除元素的下标,找到返回下标，找不到为null
	function removeTemp(id,array){
		var time=-1;
		for(var i=0;i<array.length;i++){
			if(array[i].id!=null && array[i].id!='undefiend' && array[i].id!=''){
				time=i
			}
		}
		if(time==-1){
			return null;
		}
		return time;
	}
	//给arry增加根据下标删除方法
	Array.prototype.del = function(dx) { 
		if(isNaN(dx)||dx>this.length){return false;} 
		this.splice(dx,1); 
	} 
	 $("#inp2").fileinput({
	    	language: 'zh', //设置语言
	    	browseClass: "btn btn-primary btn-block",
	        showCaption: false,//是否在选择按钮旁边显示文件名
	    	//showUpload:false,//是否展示上传按钮
	    	//showRemove:false,//是否展示移除按钮
	    	//showClose:false,//是否展示关闭按钮
	    	//showDelete: false,//是否显示删除图标
	    	//showZoom: false//是否显示预览
	    	showUploadedThumbs:false,//上传完成后是否显示缩略图
	    	uploadUrl:'/filesUploads/fileUpd',//上传的url
	    	uploadAsync: false,//异步支持
	    	dropZoneEnabled: false,
	    	//previewFileType: ["text","image"],//文件類型
	    	//allowedFileExtensions: ["txt", "md", "ini", "text",'jpg','png'],//允许上传的文件扩展名
	    	overwriteInitial: true,
	       // initialPreviewAsData: true,
	    	//initialPreview: [//初始化预览
	    	//	'backFile?ID=fd972569d6a7438886ce6a3b6a755219'
	        //]
	        //initialPreviewConfig: [//初始化设置 {标题 宽度 删除的url 是否顯示刪除 顺序  扩展字符}
	        //   {caption: initFileName, width: "120px",url:'/filesUploads/delete',showDelete: true ,key:1,extra: {id: '20e3a27be3d84329833c200772d21a0b'}}        
	        //],
	        //uploadExtraData: {//上传时附加的参数额外的参数，注意，此处jquery无效。
	        //    "MASTER_ID": MASTER_ID
	        //}
	        //maxFileCount: 10, //表示允许同时上传的最大文件个数
	        //showCaption: false,//是否显示标题   
	        dropZoneEnabled: true//是否显示拖拽区域
	        //minImageWidth: 50, //图片的最小宽度
	        //minImageHeight: 50,//图片的最小高度
	        //maxImageWidth: 1000,//图片的最大宽度
	        //maxImageHeight: 1000,//图片的最大高度
	        //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
	        //minFileCount: 0,
	        //enctype: 'multipart/form-data',
	        //validateInitialCount:true,
	    })
</script>

</html>
