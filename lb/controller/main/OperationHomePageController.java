package com.maryun.lb.controller.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：OperationHomePageController 创建人：dingqiao 创建时间：2017年3月1日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/operation/main")
public class OperationHomePageController extends BaseController {

	/**
	 * 跳转到主页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toHomePage")
	public ModelAndView toHomePage() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/main/operation_homepage", systemServer + "operation/main/getStatisticalBasisData", pd);
	}
	/**
	 * 二级运营人员跳转到主页面跳转到主页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toHomePageSecondary")
	public ModelAndView toHomePageSecondary() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.viewAndPd("lb/main/operation_homepageSecondary", systemServer + "operation/main/getStatisticalBasisData", pd);
	}

	/**
	 * 跳转到运动主页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSportHomePage")
	public ModelAndView toSportHomePage() throws Exception {
		return new ModelAndView("lb/main/operation_homepage_sport");
	}

	/**
	 * 获取近6个月注册新用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSixMonthNewRegUser")
	@ResponseBody
	public Object getSixMonthNewRegUser() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getSixMonthNewRegUser", pd);
	}

	/**
	 * 获取近6个月运动用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSixMonthSportUser")
	@ResponseBody
	public Object getSixMonthSportUser() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getSixMonthSportUser", pd);
	}

	/**
	 * 获取近6个月就医宝用户
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getSixMonthJiuYiBaoUser")
	@ResponseBody
	public Object getSixMonthJiuYiBaoUser() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getSixMonthJiuYiBaoUser", pd);
	}

	/**
	 * 获取最近1年每月订单数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearOrderForMonth")
	@ResponseBody
	public Object getOneYearOrderForMonth() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "operation/main/getOneYearOrderForMonth", pd);
	}

	/**
	 * 获取最近1年每月付款数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearMoneyForMonth")
	@ResponseBody
	public Object getOneYearMoneyForMonth() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "operation/main/getOneYearMoneyForMonth", pd);
	}

	/**
	 * 获取最近1年每月发贴数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearPostsForMonth")
	@ResponseBody
	public Object getOneYearPostsForMonth() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearPostsForMonth", pd);
	}

	/**
	 * 获取最近1年每月转发数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearForwardForMonth")
	@ResponseBody
	public Object getOneYearForwardForMonth() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearForwardForMonth", pd);
	}

	/**
	 * 获取最近1年转发平台数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearForwardSys")
	@ResponseBody
	public Object getOneYearForwardSys() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearForwardSys", pd);
	}

	/**
	 * 获取最近1年每月团体活动数量
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearGroupActiveForMonth")
	@ResponseBody
	public Object getOneYearGroupActiveForMonth() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearGroupActiveForMonth", pd);
	}

	/**
	 * 获取最近1年每月个人活动数量
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearPersonActiveForMonth")
	@ResponseBody
	public Object getOneYearPersonActiveForMonth() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearPersonActiveForMonth", pd);
	}

	/**
	 * 获取最近1年每月团体活动参与人数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearGroupActiveUsersForMonth")
	@ResponseBody
	public Object getOneYearGroupActiveUsersForMonth() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearGroupActiveUsersForMonth", pd);
	}

	/**
	 * 获取最近1年每月个人活动参与人数
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getOneYearPersonActiveUsersForMonth")
	@ResponseBody
	public Object getOneYearPersonActiveUsersForMonth() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getOneYearPersonActiveUsersForMonth", pd);
	}

	/**
	 * 获取所有就医宝用户年龄分布
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getJiuYiBaoUserAges")
	@ResponseBody
	public Object getJiuYiBaoUserAges() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "operation/main/getJiuYiBaoUserAges", pd);
	}
}