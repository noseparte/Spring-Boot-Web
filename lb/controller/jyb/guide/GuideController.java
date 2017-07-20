package com.maryun.lb.controller.jyb.guide;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UuidUtil;

/**
 * 类名称：GuideController 创建人：ChuMingZe 创建时间：2017年2月21日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/guide")
public class GuideController extends BaseController {
	//系统初始化密码
	@Value("${system.initialization.password}")
	public String sysInitPass;
	
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/guide/list");
	}

	/**
	 * 跳转到添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		return new ModelAndView("lb/jyb/guide/edit");
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
		return this.viewAndPd("lb/jyb/guide/edit", systemServer + "guide/findById", pd);
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
		return this.viewAndPd("lb/jyb/guide/view", systemServer + "guide/findById", pd);
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
		return this.pd(systemServer + "guide/pageSearch", pd);
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
		pd = this.savePage(pd);
		String s_userId =  UuidUtil.get32UUID();
		pd.put("USER_ID", s_userId);
		pd.put("USERNAME", pd.getString("GI_EMP_NUM"));
		//pd.put("PASSWORD", new SimpleHash("SHA-1", pd.getString("GI_EMP_NUM"), sysInitPass).toString());
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",",s_userId, sysInitPass).getBytes()));
		pd.put("isHasByUserName", Boolean.parseBoolean(this.pd(systemServer + "user/hasU", pd).toString()));
		return this.viewAndPd("lb/jyb/guide/list", systemServer + "guide/saveAdd", pd);
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
		pd.put("USERNAME", pd.getString("GI_EMP_NUM"));
		pd.put("USER_ID", pd.getString("SYS_UI_ID"));
		pd.put("isHasByUserName", Boolean.parseBoolean(this.pd(systemServer + "user/hasU", pd).toString()));
		return this.viewAndPd("lb/jyb/guide/list", systemServer + "guide/saveEdit", pd);
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
		return this.pd(systemServer + "guide/toDelete", pd);
	}
}
