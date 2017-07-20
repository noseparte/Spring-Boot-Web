package com.maryun.lb.controller.jyb.share;

import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.maryun.utils.UuidUtil;
@Controller
@RequestMapping(value = "/share")
public class ShareController extends BaseController {
	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/share/list");
	}

	/**
	 * 跳转到图片页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toPic")
	public ModelAndView toPic() throws Exception {
		/*PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/share/picview");
		mv.addObject("pd", pd);
		return mv;*/
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/share/picview", systemServer + "share/selectPic", pd);
	}
	/**
	 * 跳转到视频页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toVideo")
	public ModelAndView toVideo() throws Exception {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/share/videoview", systemServer + "share/selectVideo", pd);
	}
	/**
	 * 跳转到点赞页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toLike")
	public ModelAndView toLike() throws Exception {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/share/likeview");
		mv.addObject("pd", pd);
		return mv;
	}
	/**
	 * 跳转到评论页面
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toComment")
	public ModelAndView toComment() throws Exception {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/share/commentview");
		mv.addObject("pd", pd);
		return mv;
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
		return this.viewAndPd("lb/jyb/share/view", systemServer + "share/findById", pd);
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
		return this.pd(systemServer + "share/pageSearch", pd);
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
		return this.pd(systemServer + "share/toDelete", pd);
	}
	/**
	 * 修改推荐状态
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/recommend")
	@ResponseBody
	public Object recommend() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "share/recommend", pd);
	}
	/**
	 * 查询视频信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectVideo")
	@ResponseBody
	public Object selectVideo() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "share/selectVideo", pd);
	}
	
	/**
	 * 查询图片信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectPic")
	@ResponseBody
	public Object selectPic() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "share/selectPic", pd);
	}
	/**
	 * 查询评论信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectDiscussion")
	@ResponseBody
	public Object selectDiscussion() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "share/selectDiscussion", pd);
	}
	/**
	 * 查询点赞信息 
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectLike")
	@ResponseBody
	public Object selectLike() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "share/selectLike", pd);
	}
}
