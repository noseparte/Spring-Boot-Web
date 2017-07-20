<%@ page language="java"
    pageEncoding="GBK"
    import="java.io.*"
    import="java.net.URLEncoder"
%>
<%	
	//获得参数
	String filePath=request.getParameter("filePath");
	String fileName = "";
	if(filePath==null){
		return;
	}
	System.err.println("filePath   "+filePath);

	File f = new File(filePath);
	if(f.exists()){
		String filenamedisplay = URLEncoder.encode(fileName,"UTF-8");  
		//下载
		response.reset();
		//response.setContentType("image/jpeg");
		response.setContentType("application/pdf");
		//response.setHeader("Content-Disposition", "attachment;filename="+ filenamedisplay);
		//response.setHeader("Content-Disposition", "inline;filename="+ filenamedisplay);
		response.setHeader("cache-control", "no-cache");
		response.setContentLength((int)f.length());
		//设置输出流
		OutputStream os = response.getOutputStream();
		InputStream is = new FileInputStream(f);
		byte buffer[] = new byte[1024];
		int l = 0;
		//写出
		while((l=is.read(buffer))>0) os.write(buffer,0,l);
		os.flush();
		is.close();
		os.close();
		out.clear();
		out = pageContext.pushBody();
		
	}else{
		%>
		<script charset="gb2312">
		alert('文件不存在!');
		</script>
		<%
	}
%>

