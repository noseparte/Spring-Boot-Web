package com.maryun.lb.controller.platform.bankaccount;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：BankAccountController 创建人：SunYongLiang 创建时间：2017年2月14日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/bankaccount")
public class BankAccountController extends BaseController {


	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public ModelAndView pageSearch() {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/platform/bankaccount/edit",systemServer+"bankaccount/pageSearch", pd);
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
		return this.viewAndPd("lb/platform/bankaccount/edit", systemServer+"bankaccount/saveAdd", pd);
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
		return this.viewAndPd("lb/platform/bankaccount/edit", systemServer+"bankaccount/saveEdit", pd);
	}

}
