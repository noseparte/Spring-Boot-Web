package com.maryun.controller.system.dept;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
//import com.maryun.service.system.dept.DeptService;
import com.maryun.utils.BootstrapUtils;
//import com.maryun.utils.ListUtil;
import com.maryun.utils.UuidUtil;

@Controller
@RequestMapping("/dept")
public class DeptController extends BaseController {
	String menuUrl = "dept/listDepts"; //菜单地址(权限用)
	
//	@Resource(name="deptService")
//	private DeptService deptService;
//	
	@RequestMapping(value="/listDepts")
	public String listDepts(Model model) {
		return "system/dept/dept_list";
	}
//	
	@RequestMapping(value="/toAdd")
	public ModelAndView toAdd(){
		PageData pd=this.getPageData();
		return this.viewAndPd("system/dept/dept_add", systemServer+"dept/toAdd",pd);
		
	}
//	
	@RequestMapping(value="/toEdit")
	public ModelAndView  toEdit() throws Exception{
		PageData pd=this.getPageData();
		return this.viewAndPd( "system/dept/dept_edit",systemServer+"dept/toEdit",pd);
	}
//	
	@RequestMapping(value="/getTree")
	@ResponseBody
	public Object getDeptTree() throws Exception{
		PageData pd=this.getPageData();
		return pd(systemServer+"dept/getTree",pd);
	}
//	
	@RequestMapping(value="/saveAdd")
	@ResponseBody
	public Object saveAdd() throws Exception{
		PageData pd=this.getPageData();
//		this.savePage(pd);
		return pd(systemServer+"dept/saveAdd",pd);
	}
//	
	@RequestMapping(value="/saveEdit")
	@ResponseBody
	public Object saveEdit() throws Exception{
		PageData pd=this.getPageData();
//		this.updatePage(pd);
		return pd(systemServer+"dept/saveEdit",pd);
	}
//	
	@RequestMapping(value="/delete")
	@ResponseBody
	public Object delete(){
		PageData pd=this.getPageData();
		return pd(systemServer+"dept/delete",pd);
	}
}
