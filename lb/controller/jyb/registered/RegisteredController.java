package com.maryun.lb.controller.jyb.registered;

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
 * 类名称：HospitalExpertTmpController 创建人：SunYoingLiang 创建时间：2017年2月20日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/registered")
public class RegisteredController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() {
		return new ModelAndView("lb/jyb/registered/edit");
	}
	
	
	/**
	 * 添加专家
	 * @return
	 */
	@Value("${system.initialization.password}")
	public String PASSWORD;
	@RequestMapping(value = "/saveAdd")
	public Object saveAdd() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		String USER_ID=UuidUtil.get32UUID();
		pd.put("UI_FORBID_SPEAK", "0");
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",",USER_ID,PASSWORD).getBytes()));
		pd.put("UI_ID", UuidUtil.get32UUID());
		pd.put("USER_ID", USER_ID);
		pd.put("TYPE", "1");
		pd.put("STATUS", "0");
		return this.viewAndPd("lb/jyb/registered/edit", systemServer + "registered/saveAdd", pd);
	}
	/**
	 * 发送验证码
	 * @return
	 */
	@RequestMapping(value = "/sendCode")
	@ResponseBody
	public Object sendCode() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "registered/sendCode", pd);
	}
	/**
	 * 验证验证码
	 * @return
	 */
	@RequestMapping(value = "/verification")
	@ResponseBody
	public Object verification() {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "registered/verification", pd);
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
		PageData userPd = this.postForPageData(systemServer + "registered/selectPhone", pd);
		if(this.resSuccCode.equals(userPd.getString("state"))){
			userPd = JSON.parseObject(userPd.getString("content"), PageData.class);
			return Boolean.parseBoolean(userPd.getString("result"));
		}else{
			return false;
		}
	}
}