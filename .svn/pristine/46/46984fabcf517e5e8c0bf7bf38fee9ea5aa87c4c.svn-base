<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <system:header/>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>常用语管理</h5>
                </div>
                <div class="ibox-content">
                    <div id="toolbar" class="btn-group">
                        <div class="pull-left form-inline form-group">
                            <input type="text" id="CONTENT" name="CONTENT" class="form-control"  placeholder="角色名称">
                            <button type="button" class="btn btn-default btn-primary" onclick="bstQuery();">
                                查询
                            </button>
                            <button type="button" class="btn btn-default btn-primary" onclick="toAdd();">
                                新增
                            </button>
                            <button type="button" class="btn btn-default btn-primary" onclick="toEdit();">
                                修改
                            </button>
                            <button type="button" class="btn btn-default btn-danger" onclick="toDel();">
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
<div id="myModal" class="modal inmodal fade" tabindex="-1" role="dialog"  aria-hidden="true">

</div>
<!-- 全局js -->
<system:jsFooter/>
<script type="text/javascript">
    $(document).ready(function () {
        $('#queryTable').bootstrapTable({
            url: 'role/pageSearch',
            toolbar:'#toolbar' ,
            columns: [ {
                field: 'ID',
                visible:false,
                halign: 'center',
            }, {
                field: 'CONTETN',
                title: '角色名称',
                align: 'right',
                halign: 'center',
            }, {
                field: 'ORDER_FILED',
                title: '角色代码',
                align: 'right',
                halign: 'center',
            } ]
        });
    });



    function toAdd(){
        window.location.href="<%=basePath%>usefulExpression/toAdd";
    }

    function toEdit(){
        var ids = getBstCheckedId('ID');
        if(!(ids.length==1)){
            layer.msg('请只选中一条信息再进行编辑。');
            return false;
        }
        window.location.href="<%=basePath%>usefulExpression/toEdit?ID="+ids[0];
    }

    function toDel(){
        var ids = getBstCheckedId('ID');
        if((ids.length<1)){
            layer.msg('请选中信息再进行删除。');
            return false;
        }
        var idsStr = ids.toString();
        layer.confirm('确认删除这些信息吗？',{
                btn:['确认','取消'],
                shade:false
            },function(){
                $.ajax({
                    type: "POST",
                    url: 'usefulExpression/delete?tm='+new Date().getTime(),
                    data: {IDS:idsStr},
                    dataType:'json',
                    //beforeSend: validateData,
                    cache: false,
                    success: function(data){
                        if(data.msg=='ok'){
                            layer.msg('删除信息成功');
                            bstQuery();
                        }else{
                            layer.msg('删除信息失败');
                        }

                    }
                });

            },function(){

            }
        );

    }
</script>

</body>
</html>
