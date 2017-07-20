var currWinX;
var currWinY;
var currRow;
var currCol;
var totalRow;
var totalCol;
var winArr = new Array();
var mapDiv = $("#map");
var testwin ;
var testindex;
// testindex = layer.open({
//    type: 1, 
//    area:['100px','100px'],
//    skin: 'layui-layer-rim',
//    content: '传入任意的文本或html',
//    shade:false,
//    offset:['100px','200px'],
//    success:function(layero){
//    	//testwin=this;
//    }
//});
//获取目录树数据
function getTreeData() {
	if(schema=="full"){
		$.ajax({
			type: 'POST',
			url: 'gis/getTreeCharts',
			dataType: 'JSON',
			async: false,
			success: function(jsonData){
				$('#jstree_demo_div').treeview({
					data: jsonData, 
					showIcon: false,
					showCheckbox: true,
					onNodeChecked: function(event, node) {
				            //$('#checkable-output').prepend('<p>' + node.text + ' was checked</p>');
						openCharWin(node.id, node.text, node.nodeId, $('#jstree_demo_div').treeview('getParent', node.nodeId).id);
				    },
				    onNodeUnchecked: function (event, node) {
				        //$('#checkable-output').prepend('<p>' + node.text + ' was unchecked</p>');
				    	closeCharWin(node.id)
				    }
				});
			}
		});
	}
	  // Some logic to retrieve, or generate tree structure
	/*var data =  [
	             {
	                 text: 'Parent 1',
	                 href: '#parent1',
	                 id:   '1111',
	                 tags: ['4'],
	                 showCheckbox:false,
	                 nodes: [
	                   {
	                     text: 'Child 1',
	                     href: '#child1',
	                     id:   '1122',
	                     tags: ['2'],
	                     showCheckbox:false,
	                     nodes: [
	                       {
	                         text: 'Grandchild 1',
	                         id:   '123',
	                         href: '#grandchild1',
	                         showCheckbox:true,
	                         tags: ['0']
	                       },
	                       {
	                         text: 'Grandchild 2',
	                         id:   '124',
	                         href: '#grandchild2',
	                         showCheckbox:true,
	                         tags: ['0']
	                       }
	                     ]
	                   },
	                   {
	                     text: 'Child 2',
	                     id:   '125',
	                     href: '#child2',
	                     showCheckbox:true,
	                     tags: ['0']
	                   }
	                 ]
	               },
	               {
	                 text: 'Parent 2',
	                 id:   '126',
	                 href: '#parent2',
	                 showCheckbox:true,
	                 tags: ['0']
	               },
	               {
	                 text: 'Parent 3',
	                 id:   '127',
	                 href: '#parent3',
	                 showCheckbox:true,
	                  tags: ['0']
	               },
	               {
	                 text: 'Parent 4',
	                 id:   '128',
	                 href: '#parent4',
	                 showCheckbox:true,
	                 tags: ['0']
	               },
	               {
	                 text: 'Parent 5',
	                 id:   '129',
	                 href: '#parent5',
	                 showCheckbox:true,
	                 tags: ['0']
	               }
	             ];
	  return data;*/
	}
	var charWinMap = new Object();
	var charWinCount = 0;
	var preNode;
	var preId;
	function changeCheckbox(index){
		var obj;
		//找到关闭的win
		for(var i=0;i<winArr.length;i++){
			if(winArr[i].index==index){
				obj = winArr[i];
				break;
			}
		}
		if(obj){
			console.info(obj);
			//改变checkbox状态，同时会触发tree的onNodeUnchecked方法
			$('#jstree_demo_div').treeview('toggleNodeChecked', obj.nodeId);
		}
		//charWinCount--;
		//arrange(obj.id);
	}
	var winObjArr=new Array();
	function openCharWin(id, title, nodeId, pid){
		var pos = calculate_position(charWinCount);
		charWinCount++;
		//页面层
		var index = layer.open({
		    type: 2,
		    title:title,
		    skin: 'layui-layer-rim', //加上边框
		    area: [charWin_width+"px", charWin_height+"px"], //宽高
		    offset: pos,
		    closeBtn: 1,
		    move:false,
		    maxmin: true,
		    //content: 'html内容',
		    content: ['gis/toGisCharts?id=' + id + '&pid=' + pid, 'no'],
		    shade: 0,
		    success: function(layero){
		    	//winArr[charWinCount-1] = this;
		    	//testwin = this;
		    	//alert(123)
		    	winObjArr[winObjArr.length] =layero;
		    },
		    cancel:function(index){
		    	//alert(index);
		    	changeCheckbox(index);
		    	//var node = $('#jstree_demo_div').treeview('getNode', 4);
		    	
		    	//node.state.checked=false;
		    	//alert(node.text);
		    	//console.info(node);
		    	
				
		    }
		});
		testindex = index;
//		var duLinkNode = new Object();
//		duLinkNode.index = index;
//		duLinkNode.id = id;
//		if(preNode!=null){
//			duLinkNode.preNode=preNode;
//		}
//		preNode=duLinkNode;
//		if(preId!=null){
//			charWinMap[preId].nextNode = duLinkNode;
//		}
//		preId= id;
//		charWinMap[id] = duLinkNode;
		var obj = new Object();
		obj.id=id;
		obj.index= index;
		obj.nodeId = nodeId;
		winArr[charWinCount-1]=obj;
		//序号
		charWinMap[id] =index;
		//showSize();
		
		
	}
	function closeCharWin(id){
		layer.close(charWinMap[id]);
		charWinCount--;
		arrange(id);
		
	}
	getTreeData();
	/*if(schema=="full"){
		$('#jstree_demo_div').treeview({
			data: getTreeData(), 
			showIcon:false,
			showCheckbox:true,
			onNodeChecked: function(event, node) {
		            //$('#checkable-output').prepend('<p>' + node.text + ' was checked</p>');
				//alert(node.nodeId)
				openCharWin(node.id, node.text,node.nodeId);
		    },
		    onNodeUnchecked: function (event, node) {
		        //$('#checkable-output').prepend('<p>' + node.text + ' was unchecked</p>');
		    	//  alert(node.id);
		    	closeCharWin(node.id)
		    }
		});
	}*/
	function showSize(){
		
		var    s  =  "网页可见区域宽："+  document.body.clientWidth;
		s  +=  "\r\n网页可见区域高："+  document.body.clientHeight;
		s  +=  "\r\n网页可见区域宽："+  document.body.offsetWidth  +"  (包括边线的宽123)";
		s  +=  "\r\n网页可见区域高："+  document.body.offsetHeight  +"  (包括边线的宽)";
		s  +=  "\r\n网页正文全文宽："+  document.body.scrollWidth;
		s  +=  "\r\n网页正文全文高："+  document.body.scrollHeight;
		s  +=  "\r\n网页被卷去的高："+  document.body.scrollTop;
		s  +=  "\r\n网页被卷去的左："+  document.body.scrollLeft;
		s  +=  "\r\n网页正文部分上："+  window.screenTop;
		s  +=  "\r\n网页正文部分左："+  window.screenLeft;
		s  +=  "\r\n屏幕分辨率的高："+  window.screen.height;
		s  +=  "\r\n屏幕分辨率的宽："+  window.screen.width;
		s  +=  "\r\n屏幕可用工作区高度："+  window.screen.availHeight;
		s  +=  "\r\n屏幕可用工作区宽度："+  window.screen.availWidth;
		s  +=  "\r\nmapDiv宽度"+mapDiv.css("width");
		s  +=  "\r\nmapDiv高度"+mapDiv.css("height");
		alert(s);
		
	}
	function calculate_position(targetWinNO){
		totalRow = Math.floor(mapDiv.css("height").replace("px","")/charWin_height);
		//alert(mapDiv.css("height").replace("px","")+" "+charWin_height+" "+totalRow);
		currRow = targetWinNO%totalRow+1;
		currCol = Math.floor(targetWinNO/totalRow)+1;
		//alert("  currCol="+currCol+"  currRow="+currRow);
		var x=charWin_width * currCol;
		var y = charWin_height * currRow;
		var positonObj = new Object();
		positonObj.x = mapDiv.css("width").replace("px","") - x;
		positonObj.y = mapDiv.css("height").replace("px","") -  y;
		//alert(x+"   "+y +"    pos.x="+positonObj.x+"    pos.y="+positonObj.y);
		return [positonObj.y,positonObj.x];
	}
	function getStyleAfterCal(targetWinNO){
		var pos = calculate_position(targetWinNO);
		var styleObj = new Object();
		styleObj.top=pos[0]+"px";
		styleObj.left=pos[1]+"px";
		return styleObj;
	}
	function arrange(id/*id 或者 index*/){
		var targetNO=null;
		for(var i=0;i<winArr.length;i++){
			if(id==winArr[i].id || id == winArr[i].index){
				targetNO = i;
				winArr.splice(i,1);
				winObjArr.splice(i,1);
				i--;
				continue;
			}
			if(targetNO != null){
				layer.style(winArr[i].index,getStyleAfterCal(i));
			}
		}
//		winArr.splice(no, 1);
//		for(var i=0;i<winArr.length;i++){
//			if(i>=no){
//				layer.style(winArr[i],getStyleAfterCal(i));
//			}
//		}
		
	}
	function arrangeAll(){
		for(var i=0;i<winObjArr.length;i++){
			getSizeAfterResize(winObjArr[i][0],winArr[i].index);
		}
	}
	function getSizeAfterResize(winObj,index){
		var y = winObj.style.top.replace("px","")*1 - map_height_change;
		var x = winObj.style.left.replace("px","") *1 - map_width_change;
		var styleObj1 = new Object();
		styleObj1.top=0+"px";
		styleObj1.left=0+"px";
		layer.style(index,styleObj1);
		
	}