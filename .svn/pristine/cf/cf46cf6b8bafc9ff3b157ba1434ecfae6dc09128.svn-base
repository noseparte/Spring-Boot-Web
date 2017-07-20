package com.maryun.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ValidatesController 创建人：ChuMingZe 创建时间：2017年2月21日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/validates")
public class ValidatesController extends BaseController {

	/**
	 * 验证身份证
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/validateIdCard")
	@ResponseBody
	public boolean validateIdCard() throws Exception {
		PageData pd = this.getPageData();
		return Boolean.parseBoolean(this.pd(systemServer + "validates/validateIdCard", pd).toString());
	}
}
