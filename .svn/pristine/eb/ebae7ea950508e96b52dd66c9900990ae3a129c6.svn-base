package com.maryun.lb.controller.jyb.accompanyInfo;


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
 * 类名称：AccompanyInfoController 创建人：SunYongLiang 创建时间：2017年2月22日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/accompanyInfos")
public class AccompanyInfosController extends BaseController{
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/accompanyInfos/list");
	}

	/**
	 * 跳转到添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		return new ModelAndView("lb/jyb/accompanyInfos/edit");
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
		return this.viewAndPd("lb/jyb/accompanyInfos/edit", systemServer + "accompanyInfo/findById", pd);
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
		return this.viewAndPd("lb/jyb/accompanyInfos/view", systemServer + "accompanyInfo/findById", pd);
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
		return this.pd(systemServer + "accompanyInfo/pageSearch", pd);
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
		String userId=UuidUtil.get32UUID();
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",",userId, PASSWORD).getBytes()));
		pd.put("STATUS", "0");
		pd.put("TYPE", "4");
		pd.put("AI_COMPANY", null);
		pd.put("AI_POST", null);
		pd.put("AI_SERVICE_COUNT", null);
		pd.put("AI_START_LEVEL", null);
		pd.put("USER_ID", userId);
		pd = this.savePage(pd);
		return this.viewAndPd("lb/jyb/accompanyInfos/list", systemServer + "accompanyInfo/saveAdd", pd);
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
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/jyb/accompanyInfos/list", systemServer + "accompanyInfo/saveEdit", pd);
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
		return this.pd(systemServer + "accompanyInfo/toDelete", pd);
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
		PageData userPd = this.postForPageData(systemServer + "accompanyInfo/selectPhone", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			userPd = JSON.parseObject(userPd.getString("content"), PageData.class);
			return Boolean.parseBoolean(userPd.getString("result"));
		}else{
			return false;
		}
	}
}
