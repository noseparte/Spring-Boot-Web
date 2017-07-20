package com.maryun.controller.system.menu;

import java.util.HashMap;
import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.BootstrapUtils;
import com.maryun.utils.UuidUtil;

/**
 * 
 * @ClassName: MenuController
 * @Description: TODO
 * @author "PangLin"
 * @date 2015年11月30日 下午1:45:00
 *
 */
@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {
	@RequestMapping(value = "/listMenus")
	public ModelAndView listMenus() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/menu/menu_list");
		return mv;
	}

	@RequestMapping(value = "/getTree")
	@ResponseBody
	public Object getmenuTree() throws Exception {
		PageData menuPd=this.postForPageData(systemServer+"menu/getTree", new PageData());
		if(this.resSuccCode.equals(menuPd.getString("state"))){
			return menuPd.getString("content");
		}else{
			return null;
		}
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("pid", pd.getString("pid"));
		mv.setViewName("system/menu/menu_add");
		return mv;
	}

	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		
		PageData menuPd=this.postForPageData(systemServer+"menu/toEdit", pd);
		if(this.resSuccCode.equals(menuPd.getString("state"))){
			List menuList=JSON.parseObject(menuPd.getString("content"),List.class) ;
			if (menuList.size() > 0)
				mv.addObject("menu", menuList.get(0));
			else
				mv.addObject("menu", new HashMap());
		}else{
			mv.addObject("menu", new HashMap());
		}
		//List<PageData> menuList=this.postForList(systemServer+"menu/toEdit", pd);
		mv.setViewName("system/menu/menu_edit");
		return mv;
	}

	@RequestMapping(value = "/saveAdd")
	@ResponseBody
	public Object saveAdd() throws Exception {
		PageData pd = this.getPageData();
		this.savePage(pd);
		return this.postForString(systemServer+"menu/saveAdd", pd);
	}

	@RequestMapping(value = "/saveEdit")
	@ResponseBody
	public Object saveEdit() throws Exception {
		PageData pd = this.getPageData();
		this.updatePage(pd);
		this.postForString(systemServer+"menu/saveEdit", pd);
		return true;
	}

	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		PageData pd = this.getPageData();
		PageData deleteMsg=this.postForPageData(systemServer+"menu/delete", pd);
		if(this.resSuccCode.equals(deleteMsg.getString("state"))){
			return deleteMsg.getString("content");
		}else{
			return null;
		}
		
	}

	@RequestMapping(value = "/getSubTree")
	@ResponseBody
	public Object getSubTree() throws Exception {
		PageData pd = this.getPageData();
		//List<PageData> menuTree=this.postForList(systemServer+"menu/getSubTree", pd);
		
		PageData treePd=this.postForPageData(systemServer+"menu/getSubTree", pd);
		if(this.resSuccCode.equals(treePd.getString("state"))){
			return treePd.getString("content");
		}else{
			return null;
		}
	}

}
