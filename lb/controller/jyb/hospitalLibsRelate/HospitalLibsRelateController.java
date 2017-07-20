package com.maryun.lb.controller.jyb.hospitalLibsRelate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UrlDecode;

/**
 * 类名称：HospitalLibsRelateController 创建人：ChuMingZe 创建时间：2017年2月17日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/hospExpLibRela")
public class HospitalLibsRelateController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/hospitalLibsRelate/list");
	}

	/**
	 * 跳转绑定专家列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toBingLists")
	public ModelAndView toBingLists() {
		PageData pd = this.getPageData();
		pd.put("bingState", "1");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/hospitalLibsRelate/list_experts");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 跳转取消绑定专家列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toCancelBingLists")
	public ModelAndView toCancelBingLists() {
		PageData pd = this.getPageData();
		pd.put("bingState", "2");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/hospitalLibsRelate/list_experts");
		mv.addObject("pd", pd);
		return mv;
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
		return this.pd(systemServer + "hospExpLibRela/pageSearch", pd);
	}

	/**
	 * 分页查询专家库审核通过数据
	 * 
	 * @return
	 */
	@RequestMapping(value = "/expertsPageSearch")
	@ResponseBody
	public Object expertsPageSearch() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospExpLibRela/expertsPageSearch", pd);
	}

	/**
	 * 绑定
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveBing")
	@ResponseBody
	public Object saveBing() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospExpLibRela/saveBing", pd);
	}
	
	/**
	 * 取消绑定
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveCancelBing")
	@ResponseBody
	public Object saveCancelBing() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospExpLibRela/saveCancelBing", pd);
	}

	/**
	 * 删除
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object toDelete() {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "hospExpLibRela/toDelete", pd);
	}
}
