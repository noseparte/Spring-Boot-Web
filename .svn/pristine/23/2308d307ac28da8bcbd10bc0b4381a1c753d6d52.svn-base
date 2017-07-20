package com.maryun.lb.controller.jyb.hospitalGuide;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UrlDecode;

/**
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/hospitalGuide")
public class HospitalGuideController extends BaseController {

	/**
	 * 跳转列表页面(中间不用传任何参数)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/hospitalGuide/list");
	}

	/**
	 * 订单查询(页面所有的参数可以在pd中找到)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pd = this.getPageData();
		//return this.pd(systemServer + "hospitalGuide/pageSearch", UrlDecode.urlDecode(pd));
		return this.pd(systemServer + "hospitalGuide/pageSearch",pd);
	}

	/**
	 * 用户信息沟通备忘录
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearch_MEMO")
	@ResponseBody
	public Object pageSearch_MEMO() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospitalGuide/pageSearch_MEMO", pd);
	}

	/**
	 * 历史订单查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearch_historyorder")
	@ResponseBody
	public Object pageSearch_historyorder() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospitalGuide/pageSearch_historyorder", pd);
	}

	/**
	 * 订单详情页面的用户历史订单查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_uinameDesc")
	public ModelAndView toLists_uinameDesc() {
		// 页面传过来的参数
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		Object data = this.pd(systemServer + "hospitalGuide/uinameDesc", pd);
		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/uinamelist");
		// 返回数据给前台
		mv.addObject("data", data);
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 订单详情页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_onumDesc")
	public ModelAndView toLists_onumDesc() {
		// 页面传过来的参数
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		Object data = this.pd(systemServer + "hospitalGuide/onumDesc", pd);
		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/onumlist");
		// 返回数据给前台
		mv.addObject("data", data);
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳转到订单查询专家库列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_expertLibs")
	public ModelAndView toLists_expertLibsDesc() {
		// 页面传过来的参数
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		Object data = this.pd(systemServer + "hospitalGuide/expertLibsDesc", pd);
		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/expertLibslist");
		// 返回数据给前台
		mv.addObject("data", data);
		return mv;
	}

	/**
	 * 跳转到订单查询代理商列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_sp")
	public ModelAndView toLists_spDesc() {
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		Object data = this.pd(systemServer + "hospitalGuide/spDesc", pd);
		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/splist");
		// 返回数据给前台
		mv.addObject("data", data);
		return mv;
	}

	/**
	 * 跳转到订单查询陪诊人员列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_accompany")
	public ModelAndView toLists_accompanyDesc() {
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		Object data = this.pd(systemServer + "hospitalGuide/accompanyDesc", pd);
		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/accompanylist");
		// 返回数据给前台
		mv.addObject("data", data);
		return mv;
	}

	/**
	 * 跳转到订单查询就诊过程记录列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_keyNode")
	public ModelAndView toLists_keyNodeDesc() {
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		Object data = this.pd(systemServer + "hospitalGuide/keyNodeDesc", pd);
		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/keyNodelist");
		// 返回数据给前台
		mv.addObject("data", data);
		return mv;
	}

	/**
	 * 跳转到订单查询评价信息列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists_eval")
	public ModelAndView toLists_evalDesc() {
		PageData pd = this.getPageData();
		// 后台传过来的参数(调用前台数据)
		// 评价内容数据
		Object data = this.pd(systemServer + "hospitalGuide/evalDesc", pd);
		// 评价星级数据
		Object datalevel = this.pd(systemServer + "hospitalGuide/evallevelDesc", pd);

		ModelAndView mv = new ModelAndView("lb/jyb/hospitalGuide/evallist");
		// 返回数据给前台
		mv.addObject("data", data);
		mv.addObject("datalevel", datalevel);
		return mv;
	}

}
