<%@ page language="java" contentType="text/html; charset=UTF-8"
	import="com.baidu.ueditor.ActionEnter"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%

    request.setCharacterEncoding( "utf-8" );
	response.setHeader("Content-Type" , "text/html");
	
	String rootPath = application.getRealPath( "/" );
	//String saveRootPath="D:/work/tomcat/apache-tomcat-8.0.36/webapps/lbanerTest/images";
	String saveRootPath="D:/tomcat7/webapps/lbaner/images";
	//String saveRootPath="/root/tomcat8/webapps/lbaner/images";
	String str = new ActionEnter( request, rootPath,saveRootPath ).exec();
	System.err.println(str);
	out.write( str );
	
%>