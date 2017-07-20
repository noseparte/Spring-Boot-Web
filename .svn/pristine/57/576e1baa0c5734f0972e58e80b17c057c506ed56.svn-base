package com.maryun.lb.controller.jyb.commMemo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：CommunicateMemoController 创建人：ChuMingZe 创建时间：2017年2月22日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/commMemo")
public class CommunicateMemoController extends BaseController {
	
	/**
	 * 跳转到列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("lb/jyb/commMemo/list");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 跳转到添加页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() throws Exception {
		PageData pd = this.getPageData();
		ModelAndView mv = new ModelAndView("lb/jyb/commMemo/edit");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 跳转到编辑页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/commMemo/edit", systemServer + "commMemo/findById", pd);
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
		return this.pd(systemServer + "commMemo/pageSearch", pd);
	}
	
	/**
	 * 添加
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAdd")
	@ResponseBody
	public Object saveAdd() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "commMemo/saveAdd", pd);
	}
	
	/**
	 * 修改
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveEdit")
	@ResponseBody
	public Object saveEdit() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "commMemo/saveEdit", pd);
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
		return this.pd(systemServer + "commMemo/toDelete", pd);
	}
}
