package com.maryun.lb.controller.jyb.hospitalGuide;

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
@RequestMapping(value = "/expertLibsRelate")
public class ExpertLibsRelateController extends BaseController {

	/**
	 * 跳转弹窗页面(中间不用传任何参数)
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toPoputs")
	public ModelAndView toPoputs() {
		PageData pd = this.getPageData();
		ModelAndView mv = new ModelAndView ();
		mv.setViewName("lb/jyb/hospitalGuide/experlibsrelate");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 查询列表内容
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findAgents")
	@ResponseBody
	public Object findAgents() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer+"experLibsRelate/findAgents", pd);
	}
	/**
	 * 审核是否已经付款
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toCheck")
	@ResponseBody
	public Object toCheck() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "experLibsRelate/toCheck", pd);
	}
	/**
	 * 保存
	 * 
	 * @return
	 */
	@RequestMapping(value = "/saveEdit")
	@ResponseBody
	public Object saveEdit() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "experLibsRelate/saveEdit", pd);
	}
	/**
	 * 修改
	 * 
	 * @return
	 */
	@RequestMapping(value = "/saveAdd")
	@ResponseBody
	public Object saveAdd() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "experLibsRelate/saveAdd", pd);
	}
	/**
	 * 推送信息到代理商
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pushSP")
	@ResponseBody
	public Object pushSP() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "experLibsRelate/pushSP", pd);
	}
}
