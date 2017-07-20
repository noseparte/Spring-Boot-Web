<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/taglib.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<system:header/>
<title>test</title>
</head>
<body>
<table class="table">
	<thead>
		<tr>
			<th>随机数0</th>
			<th>随机数1</th>
			<th>随机数2</th>
			<th>随机数3</th>
			<th>随机数4</th>
		</tr>
	</thead>
	<c:forEach items="${list}" var="li">
	<c:forEach items="${li}" var="me">
	<tbody>
		<tr>
			<th>${me.value}</th>
			<th>${me.key}</th>
			<th>${me.value}</th>
			<th>${me.key}</th>
			<th>${me.key}</th>
		</tr>
	</tbody>
	</c:forEach>
	
</c:forEach>

</table>
<input type="hidden" value="${date}" id="fir"/>
</body>
<system:jsFooter/>
<script>
var date=new Date();
var now =date.getTime();
console.log(now)
console.log(Number(document.getElementById("fir").value))
console.log(Number(now)-Number(document.getElementById("fir").value))
</script>
</html>