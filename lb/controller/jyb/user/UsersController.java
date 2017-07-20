package com.maryun.lb.controller.jyb.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：UserController 创建人：ChuMingZe 创建时间：2017年2月21日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/jyb/user")
public class UsersController extends BaseController {

	/**
	 * 跳转运营人员列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/user/list");
	}
	/**
	 * 跳转导医用户管理页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toGuideLists")
	public ModelAndView toGuideLists() {
		return new ModelAndView("lb/jyb/user/guideList");
	}

	/**
	 * 跳转到浏览页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toView")
	public ModelAndView toView() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/user/view", systemServer + "jyb/user/findById", pd);
	}
	
	/**
	 * 跳转到禁言原因页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toForbidSpeakReason")
	public ModelAndView toForbidSpeakReason() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/user/edit_forbidSpeakReason", systemServer + "jyb/user/toForbidSpeakReason", pd);
	}

	/**
	 * 查询
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "jyb/user/pageSearch", pd);
	}

	/**
	 * 删除
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object toDelete() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "jyb/user/toDelete", pd);
	}

	/**
	 * 冻结、取消冻结
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toFreeze")
	@ResponseBody
	public Object toFreeze() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "jyb/user/toFreeze", pd);
	}
	
	/**
	 * 禁言、取消禁言
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toForbidSpeak")
	@ResponseBody
	public Object toForbidSpeak() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "jyb/user/toForbidSpeak", pd);
	}
}
