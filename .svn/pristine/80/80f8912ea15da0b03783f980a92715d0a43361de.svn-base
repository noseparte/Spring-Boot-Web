jQuery(function() {
	
	var $ = jQuery;    // just in case. Make sure it's not an other libaray.
	if(!$("#uploader.wu-example")){
		return false;
	} 
    
        var $wrap = $('#uploader'),

        // 图片容器
        $queue = $('<ul class="filelist"></ul>')
            .appendTo( $wrap.find('.queueList') ),

        // 状态栏，包括进度和控制按钮
        $statusBar = $wrap.find('.statusBar'),

        // 文件总体选择信息。
        $info = $statusBar.find('.info'),

        // 上传按钮
        $upload = $wrap.find('.uploadBtn'),

        // 没选择文件之前的内容。
        $placeHolder = $wrap.find('.placeholder'),

        // 总体进度条
        $progress = $statusBar.find('.progress').hide(),
        
        //隐藏文本域
        $fileHiddenId=$('#fileHiddenId');
        $fileMasterid=$('#fileMasterid');
        $uploadedFileId=$('#uploadedFileId');
        // 添加的文件数量
        fileCount = 0,

        // 添加的文件总大小
        fileSize = 0,

        // 优化retina, 在retina下这个值是2
        ratio = window.devicePixelRatio || 1,

        // 缩略图大小
        thumbnailWidth = 110 * ratio,
        thumbnailHeight = 110 * ratio,

        // 可能有pedding, ready, uploading, confirm, done.
        state = 'pedding',

        // 所有文件的进度信息，key为file id
        percentages = {},

        supportTransition = (function(){
            var s = document.createElement('p').style,
                r = 'transition' in s ||
                      'WebkitTransition' in s ||
                      'MozTransition' in s ||
                      'msTransition' in s ||
                      'OTransition' in s;
            s = null;
            return r;
        })(),
        
        // WebUploader实例
        uploader;

    if ( !WebUploader.Uploader.support() ) {
        alert( 'Web Uploader 不支持您的浏览器！如果你使用的是IE浏览器，请尝试升级 flash 播放器');
        throw new Error( 'WebUploader does not support the browser you are using.' );
    }
    
    var roleId=$fileMasterid.val();
	  if(roleId!=''){
		  $.ajax({
				type: "POST",
				url: 'filesUploads/listData?tm='+new Date().getTime(),
		    	data: {MASTER_ID:roleId},
				dataType:'json',
				cache: false,
				success: function(data){
					$.each(data, function(i,n){
						n.id=n.ID;
						n.name=n.FILE_NAME;
						n.size=n.FILE_SIZE;
						n.type=n.FILE_TYPE;
						n.filePaht='filesUploads/download?ID='+n.ID;
						n.rotation=0;
						n.loaded=1;
						var file=new WebUploader.File(n);
						file.state="complete";
						file.fileId=n.ID;
						fileQueued(file);
						
						//保存已经上传文件id 2016/04/28 lgq
						if($uploadedFileId){
							$uploadedFileId.val($uploadedFileId.val()+file.fileId+",");
						}
						
						
					});
				}
			});
	  }
	  
	  
    // 实例化
    uploader = WebUploader.create({
        pick: {
            id: '#filePicker',
            label: '点击选择文件'
        },
        dnd: '#uploader .queueList',
        paste: document.body,

        // swf文件路径
        swf: 'hplus/js/plugins/webuploader/Uploader.swf',

        disableGlobalDnd: true,
        //sendAsBinary:true,
        chunked: true,
        server: 'filesUploads/fileUpd',
        fileNumLimit: 300,
        compressSize:1024,
        compress:{
            width: 800,
            height: 800
        },
        formData:{
        	MASTER_ID:$fileMasterid.val()
        }
    });

    // 添加“添加文件”的按钮，
    uploader.addButton({
        id: '#fileSelect',
        label: '继续添加'
    });
    
    
    // 当有文件添加进来时执行，负责view的创建
    function addFile( file ) {
    	//file.state="inited";
        var $li = $( '<li id="' + file.id + '"><p class="title" style="word-wrap: break-word;">' + file.name + '</p>' +
                '<p class="imgWrap"></p><p class="progress"><span></span></p></li>' ),
                
            $btns = $('<div class="file-panel" ><span class="cancel">删除</span>' +
                '<span class="rotateRight">向右旋转</span><span class="rotateLeft">向左旋转</span></div>').appendTo( $li ),
            $prgress = $li.find('p.progress span'),
            $wrap = $li.find( 'p.imgWrap' ),
            $info = $('<p class="error"></p>'),
            $title=$li.find('p.title'),
            showError = function( code ) {
                switch( code ) {
                    case 'exceed_size':
                        text = '文件大小超出';
                        break;

                    case 'interrupt':
                        text = '上传暂停';
                        break;

                    default:
                        text = '上传失败，请重试';
                        break;
                }
                $info.text( text ).appendTo( $li );
            };
            
        if ( file.getStatus() === 'invalid' ) {
            showError( file.statusText );
        } else {
            //$wrap.text( '预览中' );
            uploader.makeThumb( file, function( error, src ) {
                if ( error ) {
                    //$wrap.text( '不能预览' );
                	$title.removeClass("title");
                    return;
                }
                var img = $('<img src="'+src+'">');
                $wrap.empty().append( img );
            }, thumbnailWidth, thumbnailHeight );
            percentages[ file.id ] = [ file.size, 0 ];
            file.rotation = 0;
        }
        
        file.on('statuschange', function( cur, prev ) {
            if ( prev === 'progress' ) {
                $prgress.hide().width(0);
            } else if ( prev === 'queued' ) {
                //$li.off( 'mouseenter mouseleave' );
                //$btns.remove();
            }

            // 成功
            if ( cur === 'error' || cur === 'invalid' ) {//错误或者初始状态
                showError( file.statusText );
                percentages[ file.id ][ 1 ] = 1;
            } else if ( cur === 'interrupt' ) {//上传中断，可续传。
                showError( 'interrupt' );
            } else if ( cur === 'queued' ) {//已经进入队列, 等待上传
                percentages[ file.id ][ 1 ] = 0;
            } else if ( cur === 'progress' ) {//上传中
                //$info.remove();
                //$prgress.css('display', 'block');
            } else if ( cur === 'complete' ) {//上传完成,修改文件标示为成功
                //$li.append( '<span class="success"></span>' );
                uploadSuccess();
            }
            $li.removeClass( 'state-' + prev ).addClass( 'state-' + cur );
        });
        
      //修改页面 文件状态为上传成功
        if(file.state== 'complete'){
        	uploadSuccess();
        }
        
        //上传成功后修改样式和添加删除按钮
        function uploadSuccess(){
        	//增加成功表示
	       	$li.append( '<span class="success"></span>' );
	       	//增加删除按钮
	       	$li.find('div.file-panel').append('<span class="download">下载</span>');
        }
        
        

        $li.on( 'mouseenter', function() {
            $btns.stop().animate({height: 30});
        });

        $li.on( 'mouseleave', function() {
            $btns.stop().animate({height: 0});
        });

        $btns.on( 'click', 'span', function() {
            var index = $(this).index(),
                deg;
            switch ( index ) {
                case 0:
                	//判断文件状态，如果文件是已经上传成功的文件则请求删除
                	if(file.state=='complete'){
                		var fileId=file.fileId;
                		var newFileId=$fileHiddenId.val().replace(fileId+",","");  
                		$fileHiddenId.val(newFileId);
                		
                		
                		//删除保存已经上传文件id 2016/04/28 lgq
						if($uploadedFileId){
							$uploadedFileId.val($uploadedFileId.val().replace(fileId+",",""));
						}
                		
                		//删除文件
                		$.ajax({
        					type: "POST",
        					url: 'filesUploads/delete?tm='+new Date().getTime(),
        			    	data: {IDS:fileId},
        					dataType:'json',
        					cache: false,
        					success: function(data){
        						if(data.msg=='ok'){
        							layer.msg('删除文件成功');
        							uploader.removeFile(file);
        						}else{
        							layer.msg('删除文件失败');
        						}
        						
        					}
        				});
                	}else{
                		uploader.removeFile( file );
                	}
                    return;

                case 1:
                    file.rotation += 90;
                    break;

                case 2:
                    file.rotation -= 90;
                    break;
                case 3://下载
                	window.open("filesUploads/download?ID="+file.fileId);
                	break;
            }

            if ( supportTransition ) {
                deg = 'rotate(' + file.rotation + 'deg)';
                $wrap.css({
                    '-webkit-transform': deg,
                    '-mos-transform': deg,
                    '-o-transform': deg,
                    'transform': deg
                });
            } else {
                $wrap.css( 'filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
            }

        });

        $li.appendTo( $queue );
    }

    // 负责view的销毁
    function removeFile( file ) {
        var $li = $('#'+file.id);
        delete percentages[ file.id ];
        updateTotalProgress();
        $li.off().find('.file-panel').off().end().remove();
    }
    
    //文件上传进度
    function updateTotalProgress() {
        var loaded = 0,
            total = 0,
            spans = $progress.children(),
            percent;

        $.each( percentages, function( k, v ) {
            total += v[ 0 ];
            loaded += v[ 0 ] * v[ 1 ];
        } );

        percent = total ? loaded / total : 0;

        spans.eq( 0 ).text( Math.round( percent * 100 ) + '%' );
        spans.eq( 1 ).css( 'width', Math.round( percent * 100 ) + '%' );
        updateStatus();
    }
    
    
    function updateStatus() {
        var text = '', stats;

        if ( state === 'ready' ) {
            text = '选中' + fileCount + '个文件，共' +
                    WebUploader.formatSize( fileSize ) + '。';
        } else if ( state === 'confirm' ) {
            stats = uploader.getStats();
            if ( stats.uploadFailNum ) {
                text = '已成功上传' + stats.successNum+ '个文件，'+
                    stats.uploadFailNum + '个文件上传失败，<a class="retry" href="#">重新上传</a>失败文件或<a class="ignore" href="#">忽略</a>'
            }

        } else {
            stats = uploader.getStats();
            text = '共' + fileCount + '个（' +
                    WebUploader.formatSize( fileSize )  +
                    '），已上传' + stats.successNum + '个';

            if ( stats.uploadFailNum ) {
                text += '，失败' + stats.uploadFailNum + '个';
            }
        }

        $info.html( text );
    }

    function setState( val ) {
        var file, stats;
        if ( val === state ) {
            return;
        }
        $upload.removeClass( 'state-' + state );
        $upload.addClass( 'state-' + val );
        state = val;
        switch ( state ) {
            case 'pedding':
                $placeHolder.removeClass( 'element-invisible' );
                $queue.parent().removeClass('filled');
                $queue.hide();
                $statusBar.addClass( 'element-invisible' );
                uploader.refresh();
                break;

            case 'ready':
                $placeHolder.addClass( 'element-invisible' );
                $( '#fileSelect' ).removeClass( 'element-invisible');
                $queue.parent().addClass('filled');
                $queue.show();
                $statusBar.removeClass('element-invisible');
                uploader.refresh();
                break;

            case 'uploading':
                //$( '#fileSelect' ).addClass( 'element-invisible' );
                $progress.show();
                $upload.text( '暂停上传' );
                break;

            case 'paused':
                $progress.show();
                $upload.text( '继续上传' );
                break;

            case 'confirm':
                $progress.hide();
                //$upload.text( '开始上传' ).addClass( 'disabled' );
                $upload.text( '开始上传' );
                stats = uploader.getStats();
                if ( stats.successNum && !stats.uploadFailNum ) {
                    setState( 'finish' );
                    return;
                }
                break;
            case 'finish':
                stats = uploader.getStats();
                if ( stats.successNum ) {
                    layer.msg('上传成功');
                } else {
                    // 没有成功的图片，重设
                    state = 'done';
                    location.reload();
                }
                break;
        }
        updateStatus();
    }

    uploader.onUploadProgress = function( file, percentage ) {
        var $li = $('#'+file.id),
            $percent = $li.find('.progress span');

        $percent.css( 'width', percentage * 100 + '%' );
        percentages[ file.id ][ 1 ] = percentage;
        updateTotalProgress();
    };
    
    //当文件被加入队列以后触发
    uploader.onFileQueued = function( file ) {
    	file.state="inited";
    	fileQueued(file);
    };
    
    function fileQueued(file){
        fileCount++;
        fileSize += file.size;
        if ( fileCount === 1 ) {
            $placeHolder.addClass( 'element-invisible' );
            $statusBar.show();
        }
        addFile( file );
        setState( 'ready' );
        updateTotalProgress();
    }
    
    //当文件被移除队列后触发
    uploader.onFileDequeued = function( file ) {
        fileCount--;
        fileSize -= file.size;

        if ( !fileCount ) {
            setState( 'pedding' );
        }
        removeFile( file );
        updateTotalProgress();
    };
    
    
    //点击事件
    uploader.on( 'all', function( type, object, data) {
        var stats;
        switch( type ) {
            case 'uploadFinished':
                setState( 'confirm' );
                break;

            case 'startUpload':
                setState( 'uploading' );
                break;

            case 'stopUpload':
                setState( 'paused' );
                break;
            case 'uploadSuccess':
            	//文件上传成功，则更新文件属性，同时更新隐藏字段id
            	object.state='complete';
            	object.fileId=data[0].id;
            	var val=$fileHiddenId.val()+object.fileId+",";
            	$fileHiddenId.val(val);
            	
            	//保存已经上传文件id 2016/04/28 lgq
				if($uploadedFileId){
					$uploadedFileId.val($uploadedFileId.val()+object.fileId+",");
				}
            	
                break;
        }
    });

    uploader.onError = function( code ) {
        //alert( 'Eroor: ' + code );
    };

    $upload.on('click', function() {
        if ( $(this).hasClass( 'disabled' ) ) {
            return false;
        }

        if ( state === 'ready' ) {
            uploader.upload();
        } else if ( state === 'paused' ) {
            uploader.upload();
        } else if ( state === 'uploading' ) {
            uploader.stop();
        }
    });

    $info.on( 'click', '.retry', function() {
        uploader.retry();
    } );

    $info.on( 'click', '.ignore', function() {
        alert( 'todo' );
    } );

    $upload.addClass( 'state-' + state );
    updateTotalProgress();
});