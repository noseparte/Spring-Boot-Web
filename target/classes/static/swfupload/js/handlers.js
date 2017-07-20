/* This is an example of how to cancel all the files queued up.  It's made somewhat generic.  Just pass your SWFUpload
 object in to this method and it loops through cancelling the uploads. */

var fileSuccessList = new Array();
var fileFailureList = new Array();
var instanceMap = new Object();
function cancelQueue(instance) {
	
	document.getElementById(instance.customSettings.cancelButtonId).disabled = true;
	instance.stopUpload();
	var stats;

	do {
		stats = instance.getStats();
		instance.cancelUpload();
	} while (stats.files_queued !== 0);

}

function cancelQueueById(id) {
	var instance = instanceMap[id];
	document.getElementById(instance.customSettings.cancelButtonId).disabled = true;
	if (instance != null) {
		instance.stopUpload();
		var stats;

		do {
			stats = instance.getStats();
			instance.cancelUpload();
		} while (stats.files_queued !== 0);
	}
}











function fileQueueError(file, errorCode, message) {

    try {
        var imageName = "images/error.gif";
        var errorName = "";
        if (errorCode === SWFUpload.errorCode_QUEUE_LIMIT_EXCEEDED) {
            errorName = "您上传的文件过多！";
        }

        if (errorName !== "") {
            alert(errorName);
            return;
        }
        
        switch (errorCode) {
            case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                imageName = "images/zerobyte.gif";
                break;
            case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                imageName = "images/toobig.gif";
                break;
            case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
            case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
            default:
                if(message == 1){
                    alert("每次只能上传一个！");
                }else{
//                    alert("一个");
                }
                break;
        }
       if(message != 1){
        addImage(imageName,null);
    }

    }
    catch (ex) {
        this.debug(ex);
    }

}

function fileDialogComplete(numFilesSelected, numFilesQueued) {
    try {
        if (numFilesQueued > 0) {
            this.startUpload();
        }
    }
    catch (ex) {
        this.debug(ex);
    }
}

function uploadProgress(file, bytesLoaded) {
    try {
        var percent = Math.ceil((bytesLoaded / file.size) * 100);

        var progress = new FileProgress(file, this.customSettings.upload_target);
        progress.setProgress(percent);
        if (percent === 100) {
            progress.setStatus("创建缩略图中");
            progress.toggleCancel(false, this);
        }
        else {
            progress.setStatus("上传中");
            progress.toggleCancel(true, this);
        }
    }
    catch (ex) {
        this.debug(ex);
    }
}


function uploadSuccess(file, serverData) {
	console.info(serverData);
	var imageJson=JSON.parse(serverData);

	if(imageJson.msg=='1'){
		parent.layer.msg("图片尺寸应大于30K小于10M，上传失败");
		return;
	}
	if(imageJson.msg=='2'){
		parent.layer.msg("图片应为蓝色背景，上传失败");
		return;
	}
	if(imageJson.status!=true){
		parent.layer.msg("上传失败");
		return;
	}
	var placeHolderId=this.settings.button_placeholder_id;
	var file_queue_limit=this.settings.file_queue_limit;
    addImage(imageJson.path,this.settings);
    //隐藏域添加值
    var imgPaths="#pic_path_"+placeHolderId;
    if(file_queue_limit==1){
    	 $(imgPaths).val("|" + imageJson.path);
    }else{
        var $svalue = $(imgPaths).val();
        $(imgPaths).val($svalue + "|" + imageJson.path);
    }
}

function uploadComplete(file) {
    try {

        if (this.getStats().files_queued > 0) {
            this.startUpload();
        }
        else {
            var progress = new FileProgress(file, this.customSettings.upload_target);
            progress.setComplete();
            progress.setStatus("所有图片上传成功！");
            progress.toggleCancel(false);
        }
    }
    catch (ex) {
        this.debug(ex);
    }
}

function uploadError(file, errorCode, message) {
    var imageName = "images/error.gif";
    var progress;
    try {
        switch (errorCode) {
            case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
                try {
                    progress = new FileProgress(file, this.customSettings.upload_target);
                    progress.setCancelled();
                    progress.setStatus("取消");
                    progress.toggleCancel(false);
                }
                catch (ex1) {
                    this.debug(ex1);
                }
                break;
            case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
                try {
                    progress = new FileProgress(file, this.customSettings.upload_target);
                    progress.setCancelled();
                    progress.setStatus("停止");
                    progress.toggleCancel(true);
                }
                catch (ex2) {
                    this.debug(ex2);
                }
            case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
                imageName = "images/uploadlimit.gif";
                break;
            default:
                alert(message);
                break;
        }
 
        addImage(imageName,null);

    }
    catch (ex3) {
        this.debug(ex3);
    }

}

function addImage(imagePath,setting) {
	if(setting==null){return;}
	var placeHolderId=setting.button_placeholder_id;
	var file_upload_limit=setting.file_upload_limit;
	var showImg=setting.show_delete_img;  //是否显示删除按钮
	var fileType=imagePath.split(".")[1];
	var newElement="";
	if(showImagePath.indexOf(fileType)>=0){
		newElement = "<li><a class='content' href='" + imagePath + "' data-lightbox='example-set' ><img class='example-image' style='width:"+setting.image_width+"px;height:"+setting.image_height+"px' realPath='"+imagePath+"' src='" + imagePath + "'  /></a>";
		if(showImg=='show'){
			newElement+="<img class='button'  src='/zs/common/swfupload/images/fancy_close.png'/>";
		}
		newElement+="</li>"
	}else{
		newElement = "<li><a class='content' href='" + imagePath + "' ><img class='example-image' style='width:"+setting.image_width+"px;height:"+setting.image_height+"px' realPath='"+imagePath+"' src='/zs/common/swfupload/images/file.png' /></a>";
		if(showImg=='show'){
			newElement+="<img class='button'  src='/zs/common/swfupload/images/fancy_close.png'/>";
		}
		newElement+="</li>"
	}
    //var newElement = "<li><a class=' content' href='" + imagePath + "' data-lightbox='example-set' ><img class='example-image' realPath='"+imagePath+"' src='" + imagePath + "' style=\"width:100px;height:100px;\" /></a><img class='button' src='/zs/common/swfupload/images/fancy_close.png'/></li>";
    var picId="#pic_list_"+placeHolderId;
    if(setting.file_queue_limit == 1){
        $(picId).html(newElement);
    }else{
        $(picId).append(newElement);
    }
    if(showImg=='show'){
    	
        $(picId+" img.button").last().bind("click", function(){
        	var imgPathInp="#pic_path_"+placeHolderId;
        	var imgPath=$(imgPathInp).val();
        	var imgPath_del=imgPath.replace(new RegExp("\\|"+imagePath, 'g'), "");
        	$(imgPathInp).val(imgPath_del);
            $(this).parent().remove();
            
        });
    }
}


function fadeIn(element, opacity) {
    var reduceOpacityBy = 5;
    var rate = 30; // 15 fps
    if (opacity < 100) {
        opacity += reduceOpacityBy;
        if (opacity > 100) {
            opacity = 100;
        }

        if (element.filters) {
            try {
                element.filters.item("DXImageTransform.Microsoft.Alpha").opacity = opacity;
            }
            catch (e) {
                element.style.filter = 'progid:DXImageTransform.Microsoft.Alpha(opacity=' + opacity + ')';
            }
        }
        else {
            element.style.opacity = opacity / 100;
        }
    }

    if (opacity < 100) {
        setTimeout(function () {
            fadeIn(element, opacity);
        }, rate);
    }
}

function FileProgress(file, targetID) {
    this.fileProgressID = "divFileProgress";

    this.fileProgressWrapper = document.getElementById(this.fileProgressID);
    if (!this.fileProgressWrapper) {
        this.fileProgressWrapper = document.createElement("div");
        this.fileProgressWrapper.className = "progressWrapper";
        this.fileProgressWrapper.id = this.fileProgressID;

        this.fileProgressElement = document.createElement("div");
        this.fileProgressElement.className = "progressContainer";

        var progressCancel = document.createElement("a");
        progressCancel.className = "progressCancel";
        progressCancel.href = "#";
        progressCancel.style.visibility = "hidden";
        progressCancel.appendChild(document.createTextNode(" "));

        var progressText = document.createElement("div");
        progressText.className = "progressName";
        progressText.appendChild(document.createTextNode(file.name));

        var progressBar = document.createElement("div");
        progressBar.className = "progressBarInProgress";

        var progressStatus = document.createElement("div");
        progressStatus.className = "progressBarStatus";
        progressStatus.innerHTML = "&nbsp;";

        this.fileProgressElement.appendChild(progressCancel);
        this.fileProgressElement.appendChild(progressText);
        this.fileProgressElement.appendChild(progressStatus);
        this.fileProgressElement.appendChild(progressBar);

        this.fileProgressWrapper.appendChild(this.fileProgressElement);

        document.getElementById(targetID).appendChild(this.fileProgressWrapper);
        fadeIn(this.fileProgressWrapper, 0);

    }
    else {
        this.fileProgressElement = this.fileProgressWrapper.firstChild;
        this.fileProgressElement.childNodes[1].firstChild.nodeValue = file.name;
    }

    this.height = this.fileProgressWrapper.offsetHeight;

}

FileProgress.prototype.setProgress = function (percentage) {
    this.fileProgressElement.className = "progressContainer green";
    this.fileProgressElement.childNodes[3].className = "progressBarInProgress";
    this.fileProgressElement.childNodes[3].style.width = percentage + "%";
};
FileProgress.prototype.setComplete = function () {
    this.fileProgressElement.className = "progressContainer blue";
    this.fileProgressElement.childNodes[3].className = "progressBarComplete";
    this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setError = function () {
    this.fileProgressElement.className = "progressContainer red";
    this.fileProgressElement.childNodes[3].className = "progressBarError";
    this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setCancelled = function () {
    this.fileProgressElement.className = "progressContainer";
    this.fileProgressElement.childNodes[3].className = "progressBarError";
    this.fileProgressElement.childNodes[3].style.width = "";

};
FileProgress.prototype.setStatus = function (status) {
    this.fileProgressElement.childNodes[2].innerHTML = status;
};


FileProgress.prototype.toggleCancel = function (show, swfuploadInstance) {
    this.fileProgressElement.childNodes[0].style.visibility = show ? "visible" : "hidden";
    if (swfuploadInstance) {
        var fileID = this.fileProgressID;
        this.fileProgressElement.childNodes[0].onclick = function () {
            swfuploadInstance.cancelUpload(fileID);
            return false;
        };
    }
};
