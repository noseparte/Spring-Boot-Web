package com.maryun.lb.controller.jyb.activeGroupRelate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ActiveGroupRelateController 创建人：ChuMingZe 创建时间：2017年2月26日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/actGropRela")
public class ActiveGroupRelateController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/actGropRela/list", systemServer + "actGropRela/getActiveAndAppleInfo", pd);
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
		mv.setViewName("lb/jyb/actGropRela/list_actHis");
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
		return this.pd(systemServer + "actGropRela/pageSearch", pd);
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
		return this.pd(systemServer + "actGropRela/pageSearchByActHis", pd);
	}
	
	/**
	 * 选取、取消选取
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSelect")
	@ResponseBody
	public Object toSelect() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "actGropRela/toSelect", pd);
	}
}
