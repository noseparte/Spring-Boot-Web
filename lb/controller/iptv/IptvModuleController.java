package com.maryun.lb.controller.iptv;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UuidUtil;

/**
 * 类名称：AgentController 创建人：SunYongLiang 创建时间：2017年2月21日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/iptvModule")
public class IptvModuleController extends BaseController {
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/iptv/list");
	}

	/**
	 * 跳转到添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		return new ModelAndView("lb/iptv/edit");
	}

	/**
	 * 跳转到修改页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/iptv/edit", systemServer + "iptvModule/findById", pd);
	}

	

	/**
	 * 查询
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "iptvModule/pageSearch", pd);
	}

	/**
	 * 添加
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/iptv/list", systemServer + "iptvModule/saveAdd", pd);
	}

	/**
	 * 修改
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveEdit")
	public ModelAndView saveEdit() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.viewAndPd("lb/iptv/list", systemServer + "iptvModule/saveEdit", pd);
	}

	/**
	 * 删除
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object toDelete() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "iptvModule/toDelete", pd);
	}
	
}
