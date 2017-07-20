package com.maryun.utils;


import com.maryun.model.PageData;
/**
 * RestController返回结果
 * @author <a href="mailto:shiran@maryun.net">shiran</a>
 * @version 2017年2月10日
 *
 */
public class WebResult {
	
//	//状态码
//	private Integer state;
//	//信息
//	private String msg;
//	//数据
//	private PageData pd;
//	
	

	//请求成功,不反回任何值
	public static PageData requestSuccess(){
		PageData pageData=new PageData();
		pageData.put("state", 200);
		pageData.put("msg", "success");
		pageData.put("content", null);
		return pageData;
	}
	
	//请求成功,返回带数据
	public static PageData requestSuccess(Object pd){
		PageData pageData=new PageData();
		pageData.put("state", 200);
		pageData.put("msg", "success");
		pageData.put("content", pd);
		return pageData;
	}
	
	//请求失败,返回带数据
	public static PageData requestFailed(Integer state,String msg,Object pd){
		PageData pageData=new PageData();
		pageData.put("state", state);
		pageData.put("msg", msg);
		pageData.put("content", pd);
		return pageData;
	}
}
