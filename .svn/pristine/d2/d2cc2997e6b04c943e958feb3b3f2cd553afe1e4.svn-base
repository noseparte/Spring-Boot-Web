package com.maryun.lb.controller.jyb.activeUserRelate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ActiveUserRelateController 创建人：ChuMingZe 创建时间：2017年2月26日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/actUserRela")
public class ActiveUserRelateController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/actUserRela/list", systemServer + "actUserRela/getActiveAndAppleInfo", pd);
	}

	/**
	 * 跳转到参与历史活动列表页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toActHisLists")
	public ModelAndView toActHisLists() throws Exception {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/actUserRela/list_actHis");
		mv.addObject("pd", pd);
		return mv;
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
		return this.pd(systemServer + "actUserRela/pageSearch", pd);
	}
	
	/**
	 * 查询个人参与历史活动
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pageSearchByActHis")
	@ResponseBody
	public Object pageSearchByActHis() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "actUserRela/pageSearchByActHis", pd);
	}

	/**
	 * 选取、取消选取
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSelect")
	@ResponseBody
	public Object toSelect() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "actUserRela/toSelect", pd);
	}
}
