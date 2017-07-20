package com.maryun.lb.controller.jyb.group;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：GroupController 创建人：ChuMingZe 创建时间：2017年2月26日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/group")
public class GroupController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/group/list");
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
		return this.pd(systemServer + "group/pageSearch", pd);
	}

	/**
	 * 删除
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object delete() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "group/toDelete", pd);
	}
}
