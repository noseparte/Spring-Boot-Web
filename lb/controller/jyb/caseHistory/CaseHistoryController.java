package com.maryun.lb.controller.jyb.caseHistory;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：CaseHistoryController 创建人：ChuMingZe 创建时间：2017年2月22日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/caseHist")
public class CaseHistoryController extends BaseController {

	/**
	 * 跳转到列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/caseHistory/list");
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
		return this.viewAndPd("lb/jyb/caseHistory/view", systemServer + "caseHist/findById", pd);
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
		return this.viewAndPd("lb/jyb/caseHistory/edit", systemServer + "caseHist/findById", pd);
	}

	/**
	 * 跳转到聊天编辑页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toEditByChat")
	public ModelAndView toEditByChat() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd_commMemo = this.getPageData();
		PageData pd_caseHist = this.getPageData();
		mv.setViewName("lb/jyb/caseHistory/edit_chat");
		mv.addObject("pd_commMemo", this.pd(systemServer + "commMemo/findByUid", pd_commMemo));
		mv.addObject("pd_caseHist", this.pd(systemServer + "caseHist/findById", pd_caseHist));
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
		return this.pd(systemServer + "caseHist/pageSearch", pd);
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
		return this.viewAndPd("lb/jyb/caseHistory/edit", systemServer + "caseHist/saveAdd", pd);
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
		return this.viewAndPd("lb/jyb/caseHistory/edit", systemServer + "caseHist/saveEdit", pd);
	}
}
