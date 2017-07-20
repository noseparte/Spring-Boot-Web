package com.maryun.lb.controller.jyb.message;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * @author: Libra
 * Date: 2017年4月18日 下午4:14:11
 * Version: 1.0
 * @Description: 消息推送Controller(用户控制web跳转)
 */
@Controller
@RequestMapping(value = "/jyb/message")
public class MessageController extends BaseController{

	/**
	 * 用于跳转消息推送管理界面
	 * @return
	 */
	@RequestMapping(value = "/toList")
	public ModelAndView toList(){
		return new ModelAndView("lb/jyb/message/list");
	}
	
	/**
	 * 查询
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "deprecation" })
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "app/jyb/message/messageList", pd);
	}
	
	
	
	
	
	
}
