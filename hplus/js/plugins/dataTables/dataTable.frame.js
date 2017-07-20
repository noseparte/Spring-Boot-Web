(function($){
	$.fn.frameDataTable = function(config){
		var obj = this;
		var dataTable = $(this).DataTable({
        	"bPaginate" : true,// 分页按钮
        	"bFilter" : false,// 搜索栏
        	"iDisplayLength" : 10,// 每页显示行数
        	"bInfo" : true,
        	"bWidth":true,
        	"bProcessing" : true,
        	"sPaginationType" : "full_numbers", // 分页，一共两种样式 另一种为two_button // 是datatables默认
        	"bServerSide": true, 
        	"destroy":true,
        	"ordering":false,
        	"bRetrieve":true,
        	//"sAjaxSource": "user/pageSearch.do",//获取数据的url
        	//"fnServerData": retrieveData          //获取数据的处理函数
        	"ajax":{
        		"url":config.url,
        		"data": function ( d ) {
        	        return $.extend( {}, d,  _getQuery());
        	    }
        	},
        	"aoColumns": _makeCol(config),
           "sDom": "<'row-fluid'<'span6 actBox'><'span6'f>r>t<'row-fluid'<'span6'i><'span6 'p>>",
           "fnCreatedRow": function (nRow, aData, iDataIndex) {
               //add selected class
               $(nRow).click(function () {
                   if ($(this).hasClass('success')) {
                       $(this).removeClass('success');
                   } else {
                	   dataTable.$('tr.success').removeClass('success');
                       $(this).addClass('success');
                   }
               });
           },
           "fnInitComplete": function (oSettings, json) {
           }
        	
        });
		//表格绘制完成后的操作
		dataTable.on('draw.dt', function () {
			//设置列隐藏
			_hideCol();
			//执行回调
			_callback();
			
		});
		//设置全选
		$("#checkAll").click(function(){
			var c = this.checked;
			$('input[name="checkList"]').each(
				function(i,obj){
					obj.checked=c;
				}
			);
		});
		
		//设置不同屏幕尺寸的隐藏列，使用bootstrap样式
		function _hideCol(){
			if(config.hideCol==undefined||config.hideCol==''||config.hideCol=='0'){
				return true;
			}else{
				$(".dt tr").find("th:gt("+config.hideCol+")").addClass('hidden-xs');
				$(".dt tr").find("td:gt("+config.hideCol+")").addClass('hidden-xs');
			}
		}
		
		function _makeCol(config){
			var isCheck = config.fisrtCheck;
			var cols = new Array();
			var colName = config.columns;
			for(var i=0;i<colName.length;i++){
				if(i==0){
					if(isCheck){
						cols.push({
						    "mDataProp": colName[0],
						    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
						        $(nTd).html("<input type='checkbox' name='checkList' value='" + sData + "'>");
						    }
						});
					}else{
						cols.push({
						    "mDataProp": colName[0],
						    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
						        if(sData==undefined||sData==null){
						        	sData = '';
						        }
						    	$(nTd).html(sData);
						    }
						});
					}
				}else{
					cols.push({
					    "mDataProp": colName[i],
					    "fnCreatedCell": function (nTd, sData, oData, iRow, iCol) {
					        if(sData==undefined||sData==null){
					        	sData = '';
					        }
					    	$(nTd).html(sData);
					    }
					});
				}
			}
			return cols;
		}
		
		//设置查询条件
		function _getQuery(){
			var query = new Object();
			$(".qCol").each(function(i,obj){
				var name = $(obj).attr("id");
				query["q_"+name] = $("#"+name).val();
			});
			return query;
		}
		//回调函数
		function _callback(){
			if(config.callback!=undefined && typeof config.callback=='function'){
				config.callback();
			}else{
				return true;
			}
		}
		
		return dataTable;
	};
})(jQuery);

function getDtCheckedIds(){
	var chk_value = [];
	$('input[name="checkList"]:checked').each(function(){ 
		chk_value.push($(this).val());
	});
	return chk_value;
}