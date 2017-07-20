package com.maryun.conf;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;

public class UrlFilter implements Filter{

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest srequset, ServletResponse sresponse, FilterChain filterChain)
			throws IOException, ServletException {
		//new两个，一个用来遍历，一个用来换数据
		CumServlet cumRequestWrapper=new CumServlet((HttpServletRequest) srequset);
		CumServlet cumRequestWrapper2=new CumServlet((HttpServletRequest) srequset);
		Iterator<Entry<String, String[]>> iterator = cumRequestWrapper.getParams().entrySet().iterator();
		while(iterator.hasNext()){
			Entry<String, String[]> next = iterator.next();
			String key = next.getKey();
			//解码两次
			String decode = URLDecoder.decode(next.getValue()[0], "utf-8");
			String decode2 = URLDecoder.decode(decode, "utf-8");
			cumRequestWrapper2.addParameter(key, decode2);
		}
        filterChain.doFilter(cumRequestWrapper2, sresponse);  
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
	}

}
