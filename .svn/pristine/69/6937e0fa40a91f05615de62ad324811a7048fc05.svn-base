package com.maryun.lb.controller.cms.article.health;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：HealthController 创建人：ChuMingZe 创建时间：2017年2月13日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/articleHealth")
public class HealthController extends BaseController {
	//图片地址
	@Value("${system.imageServer.uploads.basePath}")
	private String basePath;
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
		return new ModelAndView("lb/cms/article/health/list");
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
		mv.setViewName("lb/cms/article/health/checks");
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
		return new ModelAndView("lb/cms/article/health/edit");
	}

	/**
	 * 跳转到修改页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/cms/article/health/edit", systemServer + "articleHealth/findById", pd);
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
		return this.viewAndPd("lb/cms/article/health/view", systemServer + "articleHealth/findById", pd);
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
		ModelAndView re = this.viewAndPd("lb/cms/article/health/app_view", systemServer + "articleHealth/findById", pd);
		re.addObject("IMGPATH", basePath);
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
		ModelAndView re = this.viewAndPd("lb/cms/article/health/share_view", systemServer + "articleHealth/findById", pd);
		re.addObject("IMGPATH", basePath);
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
		return this.viewAndPd("lb/cms/article/backReason", systemServer + "articleHealth/toBackReason", pd);
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
		return this.pd(systemServer + "articleHealth/pageSearch", pd);
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
		pd.put("ARCHIVE_STATE", "0");
		pd.put("PUBLISH_STATE", "0");
		pd.put("DISCUSSION_STATE", "0");
		pd.put("CHECK_STATE", "0");
		return this.viewAndPd("lb/cms/article/health/list", systemServer + "articleHealth/saveAdd", pd);
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
		return this.viewAndPd("lb/cms/article/health/list", systemServer + "articleHealth/saveEdit", pd);
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
		return this.pd(systemServer + "articleHealth/checkKeyWords", pd);
	}

	/**
	 * 删除
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object delete() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "articleHealth/toDelete", pd);
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
		return this.pd(systemServer + "articleHealth/toCheck", pd);
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
		return this.pd(systemServer + "articleHealth/toPublish", pd);
	}
}
