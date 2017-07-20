    (function($){
            $.fn.extend({
                createOption:function(){
                	var $select=$(this);
                	var selectVal=$select.attr("value");
                	var url=$select.attr("ajax--url");
                	var column=$select.attr("ajax--column");
                	var dicCode =$select.attr("dicCode");
                	
                	
                	if (column==undefined||column==""){ 
                		column="ID,TEXT";
                	}
                	var t_id=column.split(",")[0];
                	var t_text=column.split(",")[1];
                	
                	if(dicCode==undefined||dicCode==''){
                		//如果url为空则返回
                    	if (url==undefined||url==""){ 
                    		return;
                    	}
                		$.ajax({
                            type: "POST",
                            url:url,
                            async: false,//要指定不能异步
                            dataType:"json",
                            success: function(data) {
                            	var options='';
                            	 $.each(data,function(n,value){
                            		 var id=value[t_id];
                            		 var text=value[t_text];
                            		 
                            		 var selected='';
                            		 if(selectVal==id){
                            			 selected='selected=" "';
                            		 }
                            		options=options+'<option value="'+id+'"'+selected+'>'+text+'</option>';
              			        });
                            	 $select.append(options); 
                            }
                        });
                	}else{
                		$.ajax({
                            type: "POST",
                            url:"dic/getDicByCode",
                            data:{"code":dicCode},
                            async: false,//要指定不能异步
                            dataType:"json",
                            success: function(data) {
                            	var arr = data.split(',');
                            	var options='';
                            	 $.each(arr,function(n,value){
                            		 var optionArr = value.split(':');
                            		 var id=optionArr[0];
                            		 var text=optionArr[1];
                            		 var selected='';
                            		 if(selectVal==id){
                            			 selected='selected=" "';
                            		 }
                            		options=options+'<option value="'+id+'"'+selected+'>'+text+'</option>';
              			        });
                            	 $select.append(options); 
                            }
                        });
                	}
                }
            });    
        })(jQuery);