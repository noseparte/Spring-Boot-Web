package com.maryun.lb.controller.jyb.active;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ActiveController 创建人：ChuMingZe 创建时间：2017年2月23日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/active")
public class ActiveController extends BaseController {
	//app下载地址
			@Value("${system.app.download.url}")
			private String appDownloadUrl;
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/active/list");
	}

	/**
	 * 跳转审核列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toCheckLists")
	public ModelAndView toCheckLists() {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/active/checks");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳转到添加页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		PageData pd = this.getPageData();
		pd.put("A_TYPE", "0");
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/active/edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳转到修改页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/active/edit", systemServer + "active/findById", pd);
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
		return this.viewAndPd("lb/jyb/active/view", systemServer + "active/findById", pd);
	}
	/**
	 * 跳转到浏览页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toAppView")
	public ModelAndView toAppView() throws Exception {
		PageData pd = this.getPageData();
		ModelAndView re = this.viewAndPd("lb/jyb/active/app_view", systemServer + "active/findById", pd);
		re.addObject("appDownloadUrl", appDownloadUrl);
		return re;
	}
	/**
	 * 跳转到浏览页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toShareView")
	public ModelAndView toShareView() throws Exception {
		PageData pd = this.getPageData();
		ModelAndView re = this.viewAndPd("lb/jyb/active/share_view", systemServer + "active/findById", pd);
		re.addObject("appDownloadUrl", appDownloadUrl);
		return re;
	}
	/**
	 * 跳转到退回原因页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toBackReason")
	public ModelAndView toBackReason() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/cms/article/backReason", systemServer + "active/toBackReason", pd);
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
		return this.pd(systemServer + "active/pageSearch", pd);
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
		// “排序”为空时，设初始值为9999999999
		// if("".equals(pd.getString("A_ORDER"))){
		// pd.remove("A_ORDER");
		// pd.put("A_ORDER", "9999999999");
		// }
		// “活动类型”为个人时，“团体人数上限/下限”设初始值为0
		if ("0".equals(pd.getString("A_TYPE"))) {
			pd.remove("A_GROUP_UP");
			pd.remove("A_GROUP_LOW");
			pd.put("A_GROUP_UP", "0");
			pd.put("A_GROUP_LOW", "0");
		}
		// "视频状态"为显示时，添加验证“视频距上/距左”，为不显示时，去掉验证“视频距上/距左”
		if ("0".equals(pd.getString("A_VOIDE_SHOW_STATE"))) {
			pd.remove("A_VOIDE_AREA_TOP");
			pd.remove("A_VOIDE_AREA_LEFT");
			pd.put("A_VOIDE_AREA_TOP", "0");
			pd.put("A_VOIDE_AREA_LEFT", "0");
		}
		pd.put("A_ACTI_SHOW_STATE", "0");
		pd.put("A_PUBLISH_STATE", "0");
		pd.put("A_CHECK_STATE", "0");
		return this.viewAndPd("lb/jyb/active/list", systemServer + "active/saveAdd", pd);
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
		// “排序”为空时，设初始值为9999999999
		// if("".equals(pd.getString("A_ORDER"))){
		// pd.remove("A_ORDER");
		// pd.put("A_ORDER", "9999999999");
		// }
		// “活动类型”为个人时，“团体人数上限/下限”设初始值为0
		if ("0".equals(pd.getString("A_TYPE"))) {
			pd.remove("A_GROUP_UP");
			pd.remove("A_GROUP_LOW");
			pd.put("A_GROUP_UP", "0");
			pd.put("A_GROUP_LOW", "0");
		}
		// "视频状态"为显示时，添加验证“视频距上/距左”，为不显示时，去掉验证“视频距上/距左”
		if ("0".equals(pd.getString("A_VOIDE_SHOW_STATE"))) {
			pd.remove("A_VOIDE_AREA_TOP");
			pd.remove("A_VOIDE_AREA_LEFT");
			pd.put("A_VOIDE_AREA_TOP", "0");
			pd.put("A_VOIDE_AREA_LEFT", "0");
		}
		return this.viewAndPd("lb/jyb/active/list", systemServer + "active/saveEdit", pd);
	}

	/**
	 * 查找是否含有关键词
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/checkKeyWords")
	@ResponseBody
	public Object checkKeyWords() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "active/checkKeyWords", pd);
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
		return this.pd(systemServer + "active/toDelete", pd);
	}

	/**
	 * 审核
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toCheck")
	@ResponseBody
	public Object toCheck() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "active/toCheck", pd);
	}

	/**
	 * 发布、取消发布
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toPublish")
	@ResponseBody
	public Object toPublish() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "active/toPublish", pd);
	}
}
