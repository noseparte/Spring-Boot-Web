package com.maryun.lb.controller.jyb.image;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UuidUtil;
@Controller
@RequestMapping(value = "/image")
public class ImageController extends BaseController {
	/**
	 * 跳转管理页面
	 * 
	 * @return
	 */
	@Value("${system.tv.background.young}")
	public String TVYoung;
	@Value("${system.tv.background.old}")
	public String TVOld;
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData ();
		TVYoung = "young";
		TVOld = "old";
		pd.put("TVYoung",TVYoung );
		pd.put("TVOld",TVOld );
		mv.addObject("pd", pd);
		mv.setViewName("lb/jyb/image/edit");
		return mv;
	}


	/**
	 * 查询
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findAll")
	@ResponseBody
	public Object findAll() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "image/findAll", pd);
	}

	
	

	/**
	 * 添加老年版图片
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveOld")
	public Object saveOld() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		pd.put("I_TYPE", '3');
		pd.put("I_ID", UuidUtil.get32UUID());
		return this.pd(systemServer + "image/saveOld", pd);
	}
	/**
	 * 添加青年版图片
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveYoung")
	public Object saveYoung() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		pd.put("I_TYPE", '2');
		pd.put("I_ID", UuidUtil.get32UUID());
		return this.pd(systemServer + "image/saveYoung", pd);
	}
	/**
	 * 根据科室的OMSID查询图片
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/findByOMS")
	@ResponseBody
	public Object findByOMS() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "image/findByOMS", pd);
	}
	/**
	 * 保存科室图标
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public Object save() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		pd.put("I_TYPE", '4');
		pd.put("I_ID", UuidUtil.get32UUID());
		return this.pd(systemServer + "image/save", pd);
	}
}
