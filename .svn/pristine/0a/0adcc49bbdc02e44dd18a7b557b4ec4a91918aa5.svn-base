package com.maryun.lb.controller.jyb.feedBack;

import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UuidUtil;
@Controller
@RequestMapping(value = "/feedBack")
public class FeedBackController extends BaseController {
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/feedBack/list");
	}

	/**
	 * 跳转到图片页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toPic")
	public ModelAndView toPic() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/feedBack/picview", systemServer + "feedBack/selectPic", pd);
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
		return this.pd(systemServer + "feedBack/pageSearch", pd);
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
		return this.pd(systemServer + "feedBack/toDelete", pd);
	}
	
	/**
	 * 查询图片信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectPic")
	@ResponseBody
	public Object selectPic() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "share/selectPic", pd);
	}
}
