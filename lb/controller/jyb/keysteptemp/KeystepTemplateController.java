package com.maryun.lb.controller.jyb.keysteptemp;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ArticleController 创建人：ChuMingZe 创建时间：2017年2月13日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/keysteptemp")
public class KeystepTemplateController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {

		// String uri = getRequest().getRequestURI();
		// PageData pd = this.getPageData();
		// pd = this.postForPageData(systemServer + "hospitalGuide/toLists",
		// pd);
		//
		// ModelAndView mv = this.getModelAndView();
		// mv.addObject("pd", pd);

		return new ModelAndView("lb/jyb/keysteptemp/list");
	}
	
	/**
	 * 跳转新增页
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {

		// String uri = getRequest().getRequestURI();
		// PageData pd = this.getPageData();
		// pd = this.postForPageData(systemServer + "hospitalGuide/toLists",
		// pd);
		//
		// ModelAndView mv = this.getModelAndView();
		// mv.addObject("pd", pd);

		return new ModelAndView("lb/jyb/keysteptemp/edit");
	}
	/**
	 * 跳转到修改页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/keysteptemp/edit", systemServer + "pc/keysteptemp/toEdit", pd);
	}

	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "pc/keysteptemp/pageSearch", pd);
	}
	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object toDelete() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "pc/keysteptemp/delete", pd);
	}
	/**
	 * 添加
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.viewAndPd("lb/jyb/keysteptemp/list", systemServer + "pc/keysteptemp/saveAdd", pd);
	}

	/**
	 * 修改
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/jyb/keysteptemp/list", systemServer + "pc/keysteptemp/saveEdit", pd);
	}
}
