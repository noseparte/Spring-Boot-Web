package com.maryun.controller.system.constant;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

@Controller
@RequestMapping(value = "/constant")
public class ConstantController extends BaseController {
//	String menuUrl = "constant/listSystemConstants"; // 菜单地址(权限用)
//
//	@Resource(name = "constantService")
//	private ConstantService constantService;
//
//
	@RequestMapping(value = "/listSystemConstants")
	public ModelAndView listSystemConstants() throws Exception {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/constant/systemConstant_list");
		return mv;
	}
//	
//	
//
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pd=this.getPageData();
		return this.pd(systemServer,pd);
	}
//	
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() throws Exception {
		PageData pd = new PageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/constant/systemConstant_edit");
		mv.addObject("pd", pd);
		return mv;
	}
//	
//	
//	
//
	/**
	 * 去修改系统常量
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd=this.getPageData();
		return this.viewAndPd("system/constant/systemConstant_edit", systemServer+"constant/toEdit",pd);
	}
//
//	
//	
	/** 
	 * 保存系统常量
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		PageData pd=this.getPageData();
		this.savePage(pd);
		return this.viewAndPd("system/constant/systemConstant_list", systemServer+"constant/saveAdd",pd);
	}
//
//	
//	
	/**
	 * 修改系统常量保存
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		PageData pd=this.getPageData();
		this.updatePage(pd);
		return this.viewAndPd("system/constant/systemConstant_list", systemServer+"constant/saveEdit",pd);
	}
//
//	
//	
//	
	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		PageData pd=this.getPageData();
		return this.pd(systemServer+"constant/delete",pd);
	}
}
