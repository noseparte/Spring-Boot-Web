package com.maryun.lb.controller.jyb.agentBundlingExpAuditing;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * @author: Libra(Hyt)
 * Date: 2017年5月5日 上午9:19:25
 * Version: 1.0
 * @Description: 代理商绑定专家申请审核Controller
 */
@Controller
@RequestMapping(value = "jyb/audit")
public class AgentBundlingExpAuditingController extends BaseController{


	/**
	 * 跳转到代理商绑定专家申请审核列表页面
	 * 	当前展示 代理商列表
	 * @return
	 */
	@RequestMapping(value = "/toList")
	@ResponseBody
	public ModelAndView toList(){
		return new ModelAndView("lb/jyb/agentBundlingExpAuditing/list");
	}
	
	/**
	 * 展示代理商列表
	 * @return
	 */
	@RequestMapping(value = "/search")
	@ResponseBody
	public Object pagesearch(){
		PageData pd = this.getPageData();
		return this.pd(systemServer + "jyb/audit/search", pd);
	}
	
	/**
	 * 跳转到代理商绑定专家申请的列表页
	 * @return
	 */
	@RequestMapping(value = "/toView")
	@ResponseBody
	public ModelAndView toView(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("lb/jyb/agentBundlingExpAuditing/view");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 专家列表页面
	 * @return
	 */
	@RequestMapping(value = "/saveView")
	@ResponseBody
	public Object saveView(){
		PageData pd = this.getPageData();
		return this.pd(systemServer + "jyb/audit/viewList",pd);
	}
	
	/**
	 * 跳转到退回页面
	 * @return
	 */
	@RequestMapping(value = "toBackReason")
	@ResponseBody
	public ModelAndView toBackReason(){
		return new ModelAndView("lb/jyb/agentBundlingExpAuditing/backReason");
	}
	
	/**
	 * 管理员审核
	 * @return
	 */
	@RequestMapping(value = "toCheck")
	@ResponseBody
	public Object toCheck(){
		PageData pd = this.getPageData();
		return this.pd(systemServer + "jyb/audit/toCheck",pd);
	}
	
	
}
