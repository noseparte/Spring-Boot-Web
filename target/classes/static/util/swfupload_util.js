var showImagePath="*.jpg;*.png;*.gif;*.bmp;*.jepg";
var fileSizeLimit="1024000";
function initUpload(params) {
	var filetype=params.file_types;
	if(filetype==''||filetype==null||filetype==undefined){
		filetype='*.jpg;*.png;*.gif;*.bmp;*.jepg';
	}
	if(params.file_upload_limit==undefined||params.file_upload_limit==''||params.file_upload_limit==null){
		params.file_upload_limit=0;
	}
	
	//上传limit
	if(params.fileSizeLimit==undefined||params.fileSizeLimit==''||params.fileSizeLimit==null){
		params.fileSizeLimit=fileSizeLimit;
	}
	
	//队列1，每次只能上传1个,若是1个以上，上传后的样式是叠加图片
	if(params.file_queue_limit==undefined||params.file_queue_limit==''||params.file_queue_limit==null){
		params.file_queue_limit=0;
	}
	
	//上传组件处理类
	if(params.upload_url==undefined||params.upload_url==''||params.upload_url==null){
		params.upload_url="/upload/uploadFile";
	}
	
	//上传参数
	if(params.post_params==undefined||params.post_params==''||params.post_params==null){
		params.post_params={"ftype" : 1 };
	}
	
	//上传参数
	if(params.show_delete_img==undefined||params.show_delete_img==''||params.show_delete_img==null){
		params.show_delete_img="show";
	}
	
	//上传按钮是否可用
	if(params.button_disabled==undefined||params.button_disabled==''||params.button_disabled==null){
		params.button_disabled=false;
	}
	
	//预先加载
	if(params.preview!=undefined&&params.preview!=""&&params.preview==null){
		 var id=params.id;
		 var imgPaths=params.preview.split("|");
		 for(var path in imgPaths){
			 addImage(id,path);
		 }
		 $("#pic_path_"+id).val(params.preview);
	}
	
	var upload = new SWFUpload(
			{
				upload_url : params.upload_url,
				post_params :params.post_params ,
				use_query_string : true, 
				file_size_limit : params.fileSizeLimit, //最大100M
				// 上传文件的名称
				file_post_name : "file",
				file_types : filetype, //设置选择文件的类型
				file_types_description : "文件上传", //描述文件类型
				file_upload_limit :params.file_upload_limit, //0代表不受上传个数的限制
				file_queue_limit : params.file_queue_limit,
				file_queue_error_handler : fileQueueError,
				file_dialog_complete_handler : fileDialogComplete, //当关闭选择框后,做触发的事件
				upload_progress_handler : uploadProgress, //处理上传进度
				upload_error_handler : uploadError, //错误处理事件
				upload_success_handler : uploadSuccess, //上传成功够,所处理的时间
				upload_complete_handler : uploadComplete, //上传结束后,处理的事件
				button_id:params.id,
				button_placeholder_id :params.id,
				button_width : params.button_width,
				button_height : params.button_height,
				button_text : params.buttonIdHtml,
				button_text_css : params.button_text_css,
				button_text_style:params.button_text_style,
				show_delete_img:params.show_delete_img,
				image_width:params.image_width,
				image_height:params.image_height,
				button_text_style :params.button_text_style,
				button_text_top_padding : params.button_text_top_padding,
				button_text_left_padding : params.button_text_left_padding,
				button_window_mode : SWFUpload.WINDOW_MODE.TRANSPARENT,
				button_cursor : SWFUpload.CURSOR.HAND,
				button_disabled :params.button_disabled ,  
				flash_url : "/zs/common/swfupload/js/swfupload.swf",
				//是否开启日志
				debug : false
			});
	instanceMap[params.id] = upload;
}

function doCallback(fn,args){
	fn.apply(this, args);  
}

//加载图片
function loadZSImages(placeHolderId,imagePath,settings){
	var pic_path="#pic_path_"+placeHolderId;
	settings.button_placeholder_id=placeHolderId;
	$(pic_path).val(imagePath);
	var imageList=imagePath.split("|");
	for (var i=0; i<imageList.length;i++){
		var realImageStr=$.trim(imageList[i]);
		if(realImageStr!=''){
			addImage(realImageStr,settings);
		}
	}
}

 