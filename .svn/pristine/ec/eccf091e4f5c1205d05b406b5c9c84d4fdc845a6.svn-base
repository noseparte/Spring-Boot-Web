package com.maryun.lb.controller.cms.article.rotation;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：ArticleController 创建人：ChuMingZe 创建时间：2017年2月13日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/articleRotation")
public class RotationController extends BaseController {
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
		return new ModelAndView("lb/cms/article/rotation/list");
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
		mv.setViewName("lb/cms/article/rotation/checks");
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
		return new ModelAndView("lb/cms/article/rotation/edit");
	}

	/**
	 * 跳转到修改页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/cms/article/rotation/edit", systemServer + "articleRotation/findById", pd);
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
		ModelAndView re = this.viewAndPd("lb/cms/article/rotation/view", systemServer + "articleRotation/findById", pd);
		re.addObject("IMGPATH", basePath);
		return re;
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
		ModelAndView re = this.viewAndPd("lb/cms/article/rotation/app_view", systemServer + "articleRotation/findById", pd);
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
		ModelAndView re = this.viewAndPd("lb/cms/article/rotation/share_view", systemServer + "articleRotation/findById", pd);
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
		return this.viewAndPd("lb/cms/article/backReason", systemServer + "articleRotation/toBackReason", pd);
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
		return this.pd(systemServer + "articleRotation/pageSearch", pd);
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
		return this.viewAndPd("lb/cms/article/rotation/list", systemServer + "articleRotation/saveAdd", pd);
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
		pd.put("CHECK_STATE", "0");
		return this.viewAndPd("lb/cms/article/rotation/list", systemServer + "articleRotation/saveEdit", pd);
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
		return this.pd(systemServer + "articleRotation/checkKeyWords", pd);
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
		return this.pd(systemServer + "articleRotation/toDelete", pd);
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
		return this.pd(systemServer + "articleRotation/toCheck", pd);
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
		return this.pd(systemServer + "articleRotation/toPublish", pd);
	}
}
