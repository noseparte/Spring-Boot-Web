package com.maryun.lb.controller.jyb.userShare;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：UserShareController 创建人：ChuMingZe 创建时间：2017年3月6日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/userShare")
public class UserShareController extends BaseController {

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
		return this.pd(systemServer + "userShare/pageSearch", pd);
	}

	/**
	 * 推荐、取消推荐
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toRecommend")
	@ResponseBody
	public Object toRecommend() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "userShare/toRecommend", pd);
	}
}
