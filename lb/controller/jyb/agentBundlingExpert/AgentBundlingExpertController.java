package com.maryun.lb.controller.jyb.agentBundlingExpert;

import java.util.Random;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * @author: Libra(Hyt)
 * Date: 2017年5月3日 上午10:07:10
 * Version: 1.0
 * @Description:  代理商绑定专家申请管理Controller
 */
@Controller
@RequestMapping(value = "jyb/bundling")
public class AgentBundlingExpertController extends BaseController{

	/**
	 * window.location.href = 'lb/jyb/agentBundlingExpert/list.jsp';
	 * @return
	 */
	@RequestMapping(value = "/toList")
	@ResponseBody
	public ModelAndView toList(){
		return new ModelAndView("lb/jyb/agentBundlingExpert/list");
	}
	
	/**
	 * 查询 、分页
	 * @return
	 */
	@RequestMapping(value = "/search")
	@ResponseBody
	public Object pageSearch(){
		PageData pd = this.getPageData();
		PageData user = getUser();
		pd.put("SYS_UI_ID", user.getString("USER_ID"));
		return this.pd(systemServer + "jyb/bundling/search", pd);
	}

	/**
	 * 跳转到专家详情页面
	 * @return
	 */
	@RequestMapping(value = "/toView")
	@ResponseBody
	public ModelAndView toView(){
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/agentBundlingExpert/view", systemServer + "jyb/bundling/findById", pd);
	}
	
	/**
	 * 绑定
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveBing")
	@ResponseBody
	public Object saveBing() throws Exception {
		PageData pd = this.getPageData();
		PageData user = getUser();
		pd.put("SYS_UI_ID", user.getString("USER_ID"));
		return this.pd(systemServer + "jyb/bundling/saveBing", pd);
	}
	
	public static void main(String[] args) {
		Random r = new Random();
		String dz = String.valueOf((r.nextInt(54) + 1));
		System.out.println(dz);
	}
	
		
}
