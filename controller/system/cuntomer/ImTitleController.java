package com.maryun.controller.system.cuntomer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
/**
 * 
 * @ClassName: ImTitleController 
 * @Description: Imtitle
 * @author SR 
 * @date 2017年2月28日
 */
@Controller
@RequestMapping("imTitle")
class ImTitleController extends BaseController{
	/**
	 * 
	 * @Description:到首页
	 * @return    
	 * @return ModelAndView    
	 * @throws
	 */
	@RequestMapping("listImTitle")
	public ModelAndView listImTitle(){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("system/customer/imTitle_list");
		return mv;
	}
	/**
	 * 
	 * @Description: 列表查询
	 * @return    
	 * @return Object    
	 * @throws
	 */
	@RequestMapping("pageSearch")
	public Object pageSearch(){
		return this.pd(systemServer+"imTitle/PageSearch", getPageData());
	}
	
	/**
	 * 
	 * @Description: 去修改页面
	 * @return    
	 * @return ModelAndView    
	 * @throws
	 */
	@RequestMapping("toEdit")
	public ModelAndView toEdit(){
		return this.viewAndPd("system/customer/imTitle_edit", systemServer+"ImTitle/toEdit", getPageData());
	}
	/**
	 * 
	 * @Description: 保存修改
	 * @return    
	 * @return Object    
	 * @throws
	 */
	@RequestMapping("saveEdit")
	public Object saveEdit(){
		return this.pd(systemServer+"imTitle/saveEdit", getPageData());
	}
	/**
	 * 
	 * @Description: 去新增页面
	 * @return    
	 * @return ModelAndView    
	 * @throws
	 */
	@RequestMapping("toAdd")
	public ModelAndView toAdd(){
		ModelAndView mv=new ModelAndView();
		mv.setViewName("system/customer/imTitle_edit");
		return mv;
	}
	/**
	 * 
	 * @Description:保存修改
	 * @return    
	 * @return Object    
	 * @throws
	 */
	@RequestMapping("saveAdd")
	public Object saveAdd(){
		return this.pd(systemServer+"imTitle/saveAdd", getPageData());
	}
	/**
	 * 
	 * @Description: 删除
	 * @return    
	 * @return Object    
	 * @throws
	 */
	@RequestMapping("delete")
	public Object delete(){
		return this.pd(systemServer+"imTitle/delete", getPageData());
	}
}
