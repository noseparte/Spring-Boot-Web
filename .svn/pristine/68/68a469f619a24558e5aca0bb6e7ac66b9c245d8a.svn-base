package com.maryun.lb.controller.jyb.agent;

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
@RequestMapping(value = "/agent")
public class AgentController extends BaseController {
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/agent/list");
	}

	/**
	 * 跳转到添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/jyb/agent/edit", systemServer + "agent/findByArea", pd);
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
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/jyb/agent/edit", systemServer + "agent/findById", pd);
	}

	/**
	 * 跳转到浏览页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toView")
	public ModelAndView toView() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/agent/view", systemServer + "agent/findById", pd);
	}
	/**
	 * 跳转图片详情页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toPicView")
	public ModelAndView toPicView() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("lb/jyb/agent/picview");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 跳转退回理由详情页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toResonView")
	public ModelAndView toResonView() throws Exception {
		ModelAndView mv = new ModelAndView();
		PageData pd = this.getPageData();
		mv.setViewName("lb/jyb/agent/resonview");
		mv.addObject("pd", pd);
		return mv;
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
		pd = this.updatePage(pd);
		return this.pd(systemServer + "agent/pageSearch", pd);
	}

	/**
	 * 添加
	 * 
	 * @return
	 * @throws Exception
	 */
	@Value("${system.initialization.password}")
	public String PASSWORD;
	@RequestMapping(value = "/saveAdd")
	public ModelAndView saveAdd() throws Exception {
		PageData pd = this.getPageData();
		String uiserId=UuidUtil.get32UUID();
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",",uiserId,PASSWORD).getBytes()));
		pd.put("STATUS", "0");
		pd.put("TYPE", "3");
		pd.put("USER_ID", uiserId);
		pd = this.savePage(pd);
		return this.viewAndPd("lb/jyb/agent/list", systemServer + "agent/saveAdd", pd);
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
		String uiserId=UuidUtil.get32UUID();
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",",uiserId,PASSWORD).getBytes()));
		pd.put("STATUS", "0");
		pd.put("TYPE", "3");
		pd.put("USER_ID", uiserId);
		return this.viewAndPd("lb/jyb/agent/list", systemServer + "agent/saveEdit", pd);
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
		return this.pd(systemServer + "agent/toDelete", pd);
	}
	/**
	 * 查询下拉列表代理商信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getAllAgent")
	@ResponseBody
	public Object getAllAgent() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "agent/getAllAgent", pd);
	}
	/**
	 * 查询手机号是否被占用
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectPhone")
	@ResponseBody
	public Object selectPhone() throws Exception {
		PageData pd = this.getPageData();
		PageData userPd = this.postForPageData(systemServer + "agent/selectPhone", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			userPd = JSON.parseObject(userPd.getString("content"), PageData.class);
			return Boolean.parseBoolean(userPd.getString("result"));
		}else{
			return false;
		}
	}
	
}
