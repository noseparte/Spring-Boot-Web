package com.maryun.controller.system.role;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UrlDecode;

@Controller
@RequestMapping(value = "/role")
public class RoleController extends BaseController {
	String menuUrl = "role/listRoles"; // 菜单地址(权限用)

//	@Resource(name = "roleService")
//	private RoleService roleService;
//	@Resource(name = "menuService")
//	private MenuService menuService;
//	@Resource(name = "buttonService")
//	private ButtonService buttonService;
//
	@RequestMapping(value = "/listRoles")
	public ModelAndView listRoles() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("system/role/role_list");
		return mv;
	}
//
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pd = this.getPageData();
		return this.pd(systemServer+"role/pageSearch",UrlDecode.urlDecode(pd));
	}
//
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		ModelAndView mv=new ModelAndView();
		mv.setViewName("system/role/role_add");
		return mv;
	}
//
	/**
	 * 去修改页面
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("system/role/role_edit", systemServer+"role/toEdit",pd);
	}
//
	/**
	 * 保存角色
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		PageData pd = this.getPageData();
		this.savePage(pd);
		return this.viewAndPd("system/role/role_list", systemServer+"role/saveAdd",pd);
	}
//
	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		PageData pd = this.getPageData();
		this.updatePage(pd);
		return this.viewAndPd("system/role/role_list", systemServer+"role/saveEdit",pd);
	}
//
	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		PageData pd = this.getPageData();
		return this.pd(systemServer+"role/delete",pd);
	}
//
	/**
	 * 角色用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toUser")
	public ModelAndView toUser() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("system/role/role_user", systemServer+"role/toUser",pd);
	}
//
	/**
	 * 角色菜单
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toMenu")
	public ModelAndView toMenu() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("roleid", pd.getString("ROLEID"));
		mv.setViewName("system/role/role_menu");
		return mv;
	}
//
	/**
	 * 构造角色按钮
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toButton")
	public ModelAndView toButton() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("roleid", pd.getString("ROLE_ID"));
		mv.setViewName("system/role/role_button");
		return mv;
	}
//
	/**
	 * 构造treegrid结构
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTreeGrid")
	@ResponseBody
	public Object getButtonTreeGrid() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer+"role/getTreeGrid",pd);
	}
//
	/**
	 * 够造角色菜单bootstrap treeview插件
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTree")
	@ResponseBody
	public Object getMenuTree() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer+"role/getTree",pd);
	}

	/**
	 * 用户操作
	 */
	@RequestMapping(value = "/editUser")
	@ResponseBody
	public Object editUser() {
		PageData pd = this.getPageData();
		this.updatePage(pd);
		return this.pd(systemServer+"role/editUser",pd);
	}
//
//
	/**
	 * 菜单操作
	 */
	@RequestMapping(value = "/editMenu")
	@ResponseBody
	public Object editMenu() {
		PageData pd = this.getPageData();
		this.updatePage(pd);
		return this.pd(systemServer+"role/editMenu",pd);
	}
//	
//	
//
	/**
	 * 按钮操作
	 */
	@RequestMapping(value = "/editButton")
	@ResponseBody
	public Object editButton() {
		PageData pd = this.getPageData();
		this.updatePage(pd);
		return this.pd(systemServer+"role/editButton",pd);
	}
}
