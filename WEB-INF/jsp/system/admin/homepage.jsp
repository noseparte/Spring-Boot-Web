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
            <div class="col-lg-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-content text-center p-md">
                        <h2><span class="text-navy">欢迎使用派科森J2EE开发框架</span></h2>
                        <p>
                            提供两种主要布局可供选择
                        </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-content text-center p-md">

                        <h4 class="m-b-xxs">上下式布局（可选布局）<span class="label label-primary">新</span></h4>
                        <p>可选择的配置选项</p>
                        <span class="simple_tag">滚动导航栏(Scroll navbar)</span>
                        <span class="simple_tag">顶部固定导航栏(Top fixed navbar)</span>
                        <span class="simple_tag">盒式布局(Boxed layout)</span>
                        <span class="simple_tag">滚动页脚(Scroll footer)</span>
                        <span class="simple_tag">固定页脚(Fixed footer)</span>
                        <div class="m-t-md">
                            <p>点击以下图片查看效果：</p>
                            <div class="p-lg ">
                                <a href="javascript:;" onclick="openFrame('main/indexV')">
                                    <img class="img-responsive img-shadow" src="static/images/indexV.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="col-sm-6">
                <div class="ibox float-e-margins">
                    <div class="ibox-content text-center p-md">

                        <h4 class="m-b-xxs">左右式布局（经典布局）</h4>
                        <p>可选择的配置选项</p>
                        <span class="simple_tag">折叠菜单(Collapse menu)</span>
                        <span class="simple_tag">滚动菜单栏(Scroll navbar)</span>
                        <span class="simple_tag">固定顶部菜单栏(Top fixed navbar)</span>
                        <span class="simple_tag">盒式布局(Boxed layout)</span>
                        <div class="m-t-md">
                            <p>点击以下图片查看效果：</p>
                            <div class="p-lg">
                                <a href="javascript:;" onclick="openFrame('main/indexH')">
                                    <img class="img-responsive img-shadow" src="static/images/indexH.png" alt="">
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <system:jsFooter/>
    <script type="text/javascript">
    	function openFrame(url){
    		parent.window.location.href='<%=basePath%>'+url;
    	}
    </script>
</body>

</html>