package com.maryun.controller.system.user;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UrlDecode;



/**
 * 类名称：UserController 创建人：MARYUN 创建时间：2014年6月28日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/user")
public class UserController extends BaseController {

	String menuUrl = "user/listUsers"; // 菜单地址(权限用)
	
	@RequestMapping(value = "/listUsers")
	public ModelAndView listUsers() {
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/user/user_list");
		return mv;
	}

	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pad = this.getPageData();
		PageData pd = UrlDecode.urlDecode(pad);
		List userList = null;
		try {
			PageData userPd=this.postForPageData(systemServer+"user/pageSearch", pd);
			if(this.resSuccCode.equals(userPd.getString("state"))){
				return userPd.getString("content");
			}else{
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		PageData pd = new PageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("system/user/user_add");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改用户页面
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		//pd=this.postForPageData(systemServer+"user/toEdit", pd);
		PageData userPd=this.postForPageData(systemServer+"user/toEdit", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			userPd=JSON.parseObject(userPd.getString("content"),PageData.class);
		}else{
			userPd=null;
		}
		mv.setViewName("system/user/user_edit");
		mv.addObject("pd",userPd);
		return mv;
	}

	/**
	 * 其他页面增加用户时，自动添加系统用户
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAddByOtherType")
	@ResponseBody
	public Object saveAddByOtherType() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "user/saveAddByOtherType", pd);
	}
	
	/**
	 * 保存用户
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		//pd=this.postForPageData(systemServer+"user/saveAdd", pd);
		
		this.savePage(pd);
		pd.put("USER_ID", this.get32UUID()); // ID
		pd.put("LAST_LOGIN", ""); // 最后登录时间
		pd.put("IP", ""); // IP
		pd.put("STATUS", "0"); // 状态
		pd.put("SKIN", "default"); // 默认皮肤
		
		
		String passwd =DigestUtils.md5DigestAsHex(String.join(",",pd.getString("USER_ID"), pd.getString("PASSWORD")).getBytes());
		pd.put("PASSWORD", passwd);
		PageData userPd=this.postForPageData(systemServer+"user/saveAdd", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			mv.addObject(userPd.getString("content"));
		}
		mv.setViewName("system/user/user_list");
		return mv;
	}

	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String password=pd.getString("PASSWORD");
		if (StringUtils.isNotBlank(password)) {
			
			String passwd =DigestUtils.md5DigestAsHex(String.join(",",pd.getString("USER_ID"), password).getBytes());
			pd.put("PASSWORD", passwd);
		}
		this.updatePage(pd);
		PageData userPd=this.postForPageData(systemServer+"user/saveEdit", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			mv.addObject(userPd.getString("content"));
		}
		mv.setViewName("system/user/user_list");
		return mv;
	}

	/**
	 * 批量删除
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public Object delete() {
		PageData pd = this.getPageData();
		//pd=this.postForPageData(systemServer+"user/delete", pd);
		
		PageData userPd=this.postForPageData(systemServer+"user/delete", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			return userPd.get("content");
		}else{
			return null;
		}
	}

	
	/**
	 * 判断用户名是否存在
	 */
	@RequestMapping(value = "/hasU")
	@ResponseBody
	public boolean hasU() {
		PageData pd = this.getPageData();
		PageData userPd = this.postForPageData(systemServer + "user/hasU", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			userPd = JSON.parseObject(userPd.getString("content"), PageData.class);
			return Boolean.parseBoolean(userPd.getString("result"));
		}else{
			return false;
		}
	}
	/*@RequestMapping(value = "/hasU")
	@ResponseBody
	public Object hasU() {
		PageData pd = this.getPageData();
		//pd=this.postForPageData(systemServer+"user/hasU", pd);
		PageData userPd=this.postForPageData(systemServer+"user/hasU", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			return userPd.get("content");
		}else{
			return null;
		}
	}*/

	/**
	 * 判断邮箱是否存在
	 */
	@RequestMapping(value = "/hasE")
	@ResponseBody
	public Object hasE() {
		PageData pd = this.getPageData();
//		pd=this.postForPageData(systemServer+"user/hasE", pd);
//		return pd;
		PageData userPd=this.postForPageData(systemServer+"user/hasE", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			return userPd.get("content");
		}else{
			return null;
		}
	}

	/**
	 * 判断编码是否存在
	 */
	@RequestMapping(value = "/hasN")
	@ResponseBody
	public Object hasN() {
		PageData pd = this.getPageData();
//		pd=this.postForPageData(systemServer+"user/hasN", pd);
//		return pd;
		
		PageData userPd=this.postForPageData(systemServer+"user/hasN", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			return userPd.get("content");
		}else{
			return null;
		}
		
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,
				true));
	}
	@RequestMapping(value = "/updateGuide")
	@ResponseBody
	public void updateGuide() {
		PageData pd = this.getPageData();
		this.updatePage(pd);
		pd=this.postForPageData(systemServer+"user/updateGuide", pd);
		
//		PageData userPd=this.postForPageData(systemServer+"user/updateGuide", pd);
//		if(this.resSuccCode.equals(userPd.getString("state"))){
//			return userPd.get("content");
//		}else{
//			return null;
//		}
		
	}
	
	/**
	 * 班组选择菜单
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toDeptSelect")
	public ModelAndView toDeptSelect() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		mv.addObject("DEPT_ID", pd.getString("DEPT_ID"));
		mv.setViewName("system/user/user_dept");
		return mv;
	}
	
	
	/**
	 * 够造班组树bootstrap treeview插件
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTree")
	@ResponseBody
	public Object getDeptTree() throws Exception {
		PageData pd = this.getPageData();
		//String pdStr=this.postForString(systemServer+"user/updateGuide", pd);
		
		PageData userPd=this.postForPageData(systemServer+"user/getTree", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			return userPd.get("content");
		}else{
			return null;
		}
	}

	
	/**
	 * 修改用户
	 */
	@RequestMapping(value = "/showRP")
	public ModelAndView showRP() throws Exception {
		PageData pd  = this.getPageData();
		return this.viewAndPd("system/user/user_rpList", systemServer+"user/showRP", pd);
	}


}