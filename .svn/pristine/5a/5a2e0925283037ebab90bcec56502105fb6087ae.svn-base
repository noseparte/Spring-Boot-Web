package com.maryun.controller.system.cuntomer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：AppCustomerController 创建人：ChuMingZe 创建时间：2017年3月30日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/app/im")
public class AppCustomerController extends BaseController {

	/**
	 * 客服人员上线
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/customerOnline")
	@ResponseBody
	public Object customerOnline() throws Exception {
		PageData pd = this.getPageData();
		return this.postForPageData(systemServer + "app/im/customerOnline", pd);
	}
	
	/**
	 * 客服人员下线
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/customerOffline")
	@ResponseBody
	public Object customerOffline() throws Exception {
		PageData pd = this.getPageData();
		return this.postForPageData(systemServer + "app/im/customerOffline", pd);
	}
	
	/**
	 * 查询当前导医已被分配任务
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/customerTitles")
	@ResponseBody
	public Object customerTitles() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "app/im/customerTitles", pd);
	}
	
	/**
	 * 发送消息
	 * @param pd
	 * @return
	 */
	@RequestMapping(value = "/customerSendMsg")
	@ResponseBody
	public Object customerSendMsg() throws Exception {
		PageData pd = this.getPageData();
		return this.postForPageData(systemServer + "app/im/customerSendMsg", pd);
	}
}
