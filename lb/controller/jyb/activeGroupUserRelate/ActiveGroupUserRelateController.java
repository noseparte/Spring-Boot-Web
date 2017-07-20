package com.maryun.lb.controller.jyb.activeGroupUserRelate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ActiveGroupUserRelateController 创建人：ChuMingZe 创建时间：2017年2月26日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/actGropUserRela")
public class ActiveGroupUserRelateController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/actGropUserRela/list", systemServer + "actGropUserRela/getActiveAndAppleInfo", pd);
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
		return this.pd(systemServer + "actGropUserRela/pageSearch", pd);
	}
}
