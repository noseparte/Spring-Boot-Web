package com.maryun.lb.controller.jyb.hospDept;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
/**
 * 
 * @ClassName: DictionariesController
 * @Description: TODO
 * @author SunYongLiang
 * @date 2017年2月26日 
 *
 */
@Controller
@RequestMapping("/hospDept")
public class HospDeptController extends BaseController {
	/**
	 * 查找全部科室信息
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getHospDeptForSelect")
	@ResponseBody
	public Object getHospDeptForSelect() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospDept/getAllHospDept", pd);
	}
	/**
	 * 跳转到列表页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toLists")
	public ModelAndView toLists() {
		return new ModelAndView("lb/jyb/hospDept/list");
	}
	/**
	 * 查询并且显示在列表中
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listPage")
	@ResponseBody
	public Object findPage() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospDept/listPage", pd);
	}
	/**
	 * 同步科室
	 * 
	 * @return
	 * @throws Exception
	 */
	//同步数据类型
	@Value("${lbaner.sync.type}")
	public String syncType;
	@RequestMapping(value = "/toSyncHospDept")
	@ResponseBody
	public Object toSyncHospDept() throws Exception {
		String s_flag = syncType;
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		Object obj = null;
		if("TongZhou".equals(s_flag)){
			obj = this.saveAddTongZhou(pd);
		}else if("ByTue".equals(s_flag)){
			obj = this.saveAddByTu(pd);
		}else if("XiWeiEr".equals(s_flag)){
			obj = this.saveAddByXiWeiEr(pd);
		}
		return obj;
	}
	/**
	 * 同步同洲数据
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAddTongZhou")
	@ResponseBody
	public Object saveAddTongZhou(PageData pd) throws Exception {
		pd = this.getPageData();
		pd = this.savePage(pd);
		pd.put("SyncType", "hospDept");
		//科室
		pd.put("TYPE", "0");
		//对应关联表数据
		pd.put("Mapping", true);
		
		/*//不分页
		pd.put("pageNumber", "0");*/
		//数据
		pd.put("lists", this.pd(systemServer + "hospDept/listPage", pd).toString());
		this.pd(systemServer + "video/toSyncVideoByTongZhou", pd);
		return this.pd(systemServer + "hospDept/listPage", pd);
	}
	/**
	 * 同步百途数据
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAddByTu")
	@ResponseBody
	public Object saveAddByTu(PageData pd) throws Exception {
		pd = this.getPageData();
		pd = this.savePage(pd);
		pd.put("SyncType", "hospDept");
		//科室
		pd.put("TYPE", "0");
		//对应关联表数据
		pd.put("Mapping", true);
		/*Object obj = this.pd(systemServer+"hospDept/saveAddByTu", pd);*/
		//不分页
		pd.put("pageNumber", "0");
		//数据
		pd.put("lists", this.pd(systemServer + "hospDept/listPage", pd).toString());
		this.pd(systemServer + "video/toSyncVideoByByTue", pd);
		return this.pd(systemServer + "hospDept/listPage", pd);
	}
	/**
	 * 同步西维尔科室
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAddByXiWeiEr")
	@ResponseBody
	public Object saveAddByXiWeiEr(PageData pd) throws Exception {
		pd = this.getPageData();
		pd = this.savePage(pd);
		pd.put("SyncType", "hospDept");
		//科室
		pd.put("TYPE", "0");
		//对应关联表数据
		pd.put("Mapping", true);
		/*Object obj = this.pd(systemServer+"hospDept/saveAddByXiWeiEr", pd);*/
		//不分页
		pd.put("pageNumber", "0");
		//数据
		pd.put("lists", this.pd(systemServer + "hospDept/listPage", pd).toString());
		this.pd(systemServer + "video/toSyncVideoByXiWeiEr", pd);
		return this.pd(systemServer + "hospDept/listPage", pd);
	}
	/**
	 * 编辑页面显示以前图片
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/show")
	@ResponseBody
	public Object show() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "hospDept/saveAdd", pd);
	}
	/**
	 * 跳转到编辑图片页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toEdit")
	public ModelAndView toEdit() {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/hospDept/edit");
		mv.addObject("pd",pd);
		return mv;
	}
	/**
	 * 跳转到添加页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSaveEdit")
	public ModelAndView toSaveEdit() {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/hospDept/saveEdit");
		mv.addObject("pd",pd);
		return mv;
	}
	/**
	 * 跳转到添加页面
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSaveEdits")
	public ModelAndView toSaveEdits() {
		PageData pd = this.getPageData();
		return this.viewAndPd("lb/jyb/hospDept/saveEdit", systemServer + "hospDept/selectById", pd);
	}
	/**
	 * 增加科室
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveAddLocation")
	@ResponseBody
	public Object saveAddLocation() throws Exception {
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		return this.pd(systemServer + "hospDept/saveAddLocation", pd);
	}
	/**
	 * 修改科室
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveEditLocation")
	@ResponseBody
	public Object saveEditLocation() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "hospDept/saveEditLocation", pd);
	}
	/**
	 * 删除科室
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteMany")
	@ResponseBody
	public Object deleteMany() throws Exception {
		PageData pd = this.getPageData();
		pd = this.updatePage(pd);
		return this.pd(systemServer + "hospDept/deleteMany", pd);
	}
}
