package com.maryun.controller.base;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.maryun.model.PageData;
import com.maryun.utils.UuidUtil;

public class BaseController {
	
	private static final long serialVersionUID = 6357869213649815390L;
	
	@Autowired
    public RestTemplate restTemplate;
	
	
	//系统服务地址
	public String resSuccCode="200";

	/**
	 * 得到PageData
	 */
	public PageData getPageData() {
		try {
			return new PageData(this.getRequest());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * 得到ModelAndView
	 */
	public ModelAndView getModelAndView() {
		return new ModelAndView();
	}

	/**
	 * 得到request对象
	 */
	public HttpServletRequest getRequest() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		return request;
	}
	
	/**
	 * 得到32位的uuid
	 * @return
	 */
	public String get32UUID(){
		
		return UuidUtil.get32UUID();
	}
	
	public String commonFallback() {
		return "some exception occur call fallback method.";
	}
	/**
	 * 请求服务
	 * @param URI
	 * @param param
	 * @return
	 */
	public String postForString(String URI,Object param){
        String rest= restTemplate.postForObject(URI, param,String.class);
        return rest;
	}
	
	public PageData postForPageData(String URI,Object param){
		PageData pd=null;
		try{
		String rest= restTemplate.postForObject(URI, param,String.class);
		pd=JSON.parseObject(rest, PageData.class);
		
		//PageData pd=JsonUtil.getPageDataFromJsonObjStr(rest);
		}catch(Exception e){
			e.printStackTrace();
			PageData<String ,String > pageData = new PageData<String ,String >();
			pageData.put("state",500);
			pageData.put("msg", "服务器错误");
			return pageData;
		}
        return pd;
	}
	
	public List<PageData> postForList(String URI,Object param){
		String rest= restTemplate.postForObject(URI, param,String.class);
		//List<PageData> pd=JsonUtil.getListFromJsonArrStr(rest, PageData.class);
		List<PageData> pd=JSON.parseObject(rest,new TypeReference<List<PageData>>() {});
        return pd;
	}
	
	public List<String> postForListStr(String URI,Object param){
		String rest= restTemplate.postForObject(URI, param,String.class);
		List<String> pd=JSON.parseObject(rest,new TypeReference<List<String>>() {});
        return pd;
	}
	
	
	public Object postForObject(String URI,Class param){
		Object rest= restTemplate.postForObject(URI, param,param);
        return rest;
	}
	//系统服务地址
	@Value("${maryun.server.system}")
	public String systemServer;
	
	public PageData savePage(PageData pd){
		PageData user=getUser();
		pd.put("DEL_STATE","1");//1 有效，0或者null 无效
		pd.put("CREATE_UID", user.getString("USER_ID"));
		pd.put("CREATE_TIME", new Date());
		pd.put("CHANGE_UID", user.getString("USER_ID"));
		pd.put("CHANGE_TIME", new Date());
		return pd;
	}
	
	public PageData updatePage(PageData pd){
		PageData user=getUser();
		pd.put("CHANGE_UID", user.getString("USER_ID"));
		pd.put("CHANGE_TIME", new Date());
		return pd;
	}
	
	/**
	 * 获取用户信息
	 * @return
	 */
	public PageData getUser(){
		Session session = getSession();
		PageData user = (PageData)session.getAttribute("sessionUser");
		return user;
	}
	
	/**
	 * 获取session信息
	 * @return
	 */
	public Session getSession(){
		Subject currentUser = SecurityUtils.getSubject();  
		Session session = currentUser.getSession();
		return session;
	}
	
	

	/**
	 * 返回modelandview
	 * @param viewName(页面名字)
	 * @param systemServer(应用名字)
	 * @return
	 */
	@SuppressWarnings("finally")
	public ModelAndView viewAndPd(String viewName,String uri,PageData pd){
		//接收服务器失败抛出的错误
		try {
			pd=this.postForPageData(uri, pd);
		}catch (Exception e) {
			e.printStackTrace();
			pd.put("state", 500);
			pd.put("msg", "服务器错误");
		}
			ModelAndView mv = this.getModelAndView();
			int state = (int) pd.get("state");
			String msg = (String) pd.get("msg");
			Object returnPd = pd.get("content");
			//除了返回200，都是失败的请求
			if(state!=200){
				mv.setViewName(systemServer+"error");
				return mv;
			}
			mv.setViewName(viewName);
			mv.addObject("pd",returnPd);
	  		return mv;
	}
	/**
	 * 只返回pd
	 * @param pd
	 * @param systemServer(应用的名字)
	 * @return
	 */
	@Deprecated
	public Object pd(String uri,PageData pd){
		//接收服务器失败抛出的错误
		try {
			pd=this.postForPageData(uri, pd);
		} catch (Exception e) {
			e.printStackTrace();
			pd.put("state", 500);
			pd.put("msg", "服务器错误");
		}
			int state = (int) pd.get("state");
			String msg = (String) pd.get("msg");
			
			if(state!=200){
				PageData returnPd=new PageData();
				returnPd.put("state", state);
				returnPd.put("msg", msg);
				return returnPd;
			}
			return pd.get("content");
		
	}
}
