package com.maryun.lb.controller.jyb.hospitalExpertTmp;

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
 * @version 1.2
 */
@Controller
@RequestMapping(value = "/hospitalExpertTmp")
public class HospitalExpertTmpController extends BaseController {

	/**
	 * 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/hospitalExpertTmp/list");
	}

	/**
	 * 跳转列表浏览页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toListPreview")
	public ModelAndView toListPreview() {
		return new ModelAndView("lb/jyb/hospitalExpertTmp/listPreview");
	}

	/**
	 * 跳转编辑页面去添加
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toAdd")
	@ResponseBody
	public ModelAndView toAdd() {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/hospitalExpertTmp/add");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 跳转编辑页面去修改
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toEdit")
	@ResponseBody
	public ModelAndView toEdit() {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/hospitalExpertTmp/edit", systemServer + "hospitalExpertTmp/findById", pd);
	}

	/**
	 * 跳转到预览页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toMergeLists")
	public ModelAndView toMergeLists() {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/hospitalExpertTmp/editPreview", systemServer + "hospitalExpertTmp/findById", pd);
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

		String userId = UuidUtil.get32UUID();

		pd.put("HE_SUBMIT", "0");
		pd.put("HE_AUDIT", "0");
		pd.put("HE_MERGE", "0");
		pd.put("HE_TEMPLATE", "0");
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",", userId, PASSWORD).getBytes()));
		pd.put("STATUS", "0");
		pd.put("TYPE", "5");
		pd.put("HEL_ID", UuidUtil.get32UUID());
		pd.put("USER_ID", userId);
		return this.viewAndPd("lb/jyb/hospitalExpertTmp/list", systemServer + "hospitalExpertTmp/saveAdd", pd);
	}

	/**
	 * 修改专家
	 * @return
	 */
	@RequestMapping(value = "/saveEdit")
	@ResponseBody
	public Object saveEdit() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		String userId = UuidUtil.get32UUID();
		pd.put("PASSWORD", DigestUtils.md5DigestAsHex(String.join(",", userId, PASSWORD).getBytes()));
		pd.put("STATUS", "0");
		pd.put("TYPE", "5");
		pd.put("USER_ID", userId);
		return this.viewAndPd("lb/jyb/hospitalExpertTmp/list", systemServer + "hospitalExpertTmp/saveEdit", pd);
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
		return this.pd(systemServer + "hospitalExpertTmp/checkKeyWords", pd);
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
		return this.viewAndPd("lb/cms/article/backReason", systemServer + "hospExpLib/toBackReason", pd);
	}

	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearch")
	@ResponseBody
	public Object pageSearch() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "hospitalExpertTmp/pageSearch", pd);
	}
	/**
	 * 查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/pageSearchs")
	@ResponseBody
	public Object pageSearchs() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospitalExpertTmp/pageSearch", pd);
	}

	/**
	 * 合并查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/mergePageSearch")
	@ResponseBody
	public Object mergePageSearch() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospExpLib/mergePageSearch", pd);
	}

	/**
	 * 重复专家查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/mergeViewPageSearch")
	@ResponseBody
	public Object mergeViewPageSearch() {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospExpLib/mergeViewPageSearch", pd);
	}

	/**
	 * 设置专家模板
	 * @return
	 */
	@RequestMapping(value = "/setTemplate")
	@ResponseBody
	public Object setTemplate() {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "hospExpLib/setTemplate", pd);
	}

	/**
	 * 删除
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toDelete")
	@ResponseBody
	public Object toDelete() {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "hospitalExpertTmp/toDelete", pd);
	}

	/**
	 * 更改提交状态
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toSubmission")
	@ResponseBody
	public Object toSubmission() {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "hospitalExpertTmp/toSubmission", pd);
	}

	/**
	 * 提交
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSubmit")
	@ResponseBody
	public Object toSubmit() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "hospitalExpertTmp/toSubmit", pd);
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
		PageData userPd = this.postForPageData(systemServer + "hospitalExpertTmp/selectPhone", pd);
		if (this.resSuccCode.equals(userPd.getString("state"))) {
			userPd = JSON.parseObject(userPd.getString("content"), PageData.class);
			return Boolean.parseBoolean(userPd.getString("result"));
		}
		else {
			return false;
		}
	}
	/**
	 * 查询状态是否提交
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/selectStatus")
	@ResponseBody
	public Object selectStatus() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospitalExpertTmp/selectStatus", pd);
	}
}