package com.maryun.controller.system.button;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UrlDecode;

/**
 * 类名称：ButtonController 创建人：MARYUN 创建时间：2016年1月18日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/button")
public class ButtonController extends BaseController {
	String menuUrl = "button/listButtons"; // 菜单地址(权限用)
//	@Resource(name = "userService")
//	private UserService userService;
//	@Resource(name = "buttonService")
//	private ButtonService buttonService;
//	@Resource(name = "menuService")
//	private MenuService menuService;
//
	@RequestMapping(value = "/listButtons")
	public ModelAndView listButtons() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("system/button/button_list");
		return mv;
	}
//
//
//	
//	@RequestMapping(value = "/pageSearch")
//	@ResponseBody
//	public Object pageSearch() {
//		PageData pd = this.getPageData();
//		Map dataTable=null;
//		List<PageData> buttonList = null;
//		try {
//			buttonList = buttonService.listPdPageRole(pd);
//			// 分页信息结果集整合到分页框架
//			PageInfo pi = new PageInfo(buttonList);
//			// 查询结果与分页信息封装为bootstrampTable认可结构
//			dataTable = BootstrapUtils.parsePage2BootstrmpTable(pi.getTotal(), buttonList);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return dataTable;
//	}
//	
//	
//
//	@RequestMapping(value = "/toAdd")
//	public ModelAndView toAdd() {
//		PageData pd = new PageData();
//		ModelAndView mv = this.getModelAndView();
//		mv.setViewName("system/button/button_add");
//		mv.addObject("pd", pd);
//		return mv;
//	}
//
//	/**
//	 * 去修改按钮页面
//	 */
//	@RequestMapping(value = "/toEdit")
//	public ModelAndView toEdit() throws Exception {
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = this.getPageData();
//		pd = buttonService.findById(pd);
//		mv.setViewName("system/button/button_edit");
//		mv.addObject("pd", pd);
//		return mv;
//	}
//
//	/**
//	 * 保存用户
//	 */
//	@RequestMapping(value = "/saveAdd")
//	public ModelAndView saveAdd() throws Exception {
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd.put("BUTTON_ID", UuidUtil.get32UUID()); // ID
//
//		if (null == buttonService.findById(pd)) {
//			buttonService.saveButton(pd);
//			mv.addObject("msg", "success");
//		} else {
//			mv.addObject("msg", "failed");
//		}
//		mv.setViewName("system/button/button_list");
//		return mv;
//	}
//
//	/**
//	 * 修改按钮
//	 */
//	@RequestMapping(value = "/saveEdit")
//	public ModelAndView saveEdit() throws Exception {
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		buttonService.editButton(pd);
//		mv.addObject("msg", "success");
//		mv.setViewName("system/button/button_list");
//		return mv;
//	}
//
//	/**
//	 * 批量删除
//	 */
//	@RequestMapping(value = "/delete")
//	@ResponseBody
//	public Object delete() {
//		PageData pd = new PageData();
//		Map<String, Object> map = new HashMap<String, Object>();
//		try {
//			pd = this.getPageData();
//			String BUTTON_IDS = pd.getString("IDS");
//			if (null != BUTTON_IDS && !"".equals(BUTTON_IDS)) {
//				String ArrayBUTTON_IDS[] = BUTTON_IDS.split(",");
//				buttonService.deleteAllButtons(ArrayBUTTON_IDS);
//				map.put("msg", "ok");
//			} else {
//				map.put("msg", "no");
//			}
//		} catch (Exception e) {
//		} finally {
//		}
//		return map;
//	}
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pd=this.getPageData();
		return this.pd(systemServer+"button/pageSearch",UrlDecode.urlDecode(pd));
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("system/button/button_add");
		return mv;
	}
	
	/**
	 * 去修改按钮页面
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd=this.getPageData();
		return this.viewAndPd("system/button/button_edit",systemServer+"button/toEdit",pd);
	}
	
	/**
	 * 保存用户
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		PageData pd=this.getPageData();
		this.savePage(pd);
		return this.viewAndPd("system/button/button_list", systemServer+"button/saveAdd",pd);
	}
	
	/**
	 * 修改按钮
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		PageData pd=this.getPageData();
		this.updatePage(pd);
		return this.viewAndPd("system/button/button_list", systemServer+"button/saveEdit",pd);
	}
	
	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		PageData pd=this.getPageData();
		return this.pd(systemServer+"button/delete",pd);
	}
}
