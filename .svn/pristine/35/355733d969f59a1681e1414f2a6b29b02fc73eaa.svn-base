package com.maryun.lb.controller.jyb.videos;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

/**
 * 类名称：VideosController 创建人：ChuMingZe 创建时间：2017年2月27日
 * 
 * @version
 */
@Controller
@RequestMapping(value = "/video")
public class VideosController extends BaseController {

	//同步数据类型
	@Value("${lbaner.sync.type}")
	public String syncType;
		
	/**
	 * 跳转选取官方视频列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toSelOfficeLists")
	public ModelAndView toSelOfficeLists() {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/active/list_sel_office");
		mv.addObject("pd", pd);
		return mv;
	}
	
	/**
	 * 跳转选取网友上传视频列表页面
	 * 
	 * @return
	 */
	@RequestMapping(value = "/toSelNetLists")
	public ModelAndView toSelNetLists() {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("lb/jyb/active/list_sel_net");
		mv.addObject("pd", pd);
		return mv;
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
		return this.pd(systemServer + "video/pageSearch", pd);
	}
	
	/**
	 * 保存选取视频数据
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveSel")
	@ResponseBody
	public Object saveSelect() throws Exception {
		PageData pd = this.getPageData();
		return this.pd(systemServer + "video/saveSel", pd);
	}
	
	/**
	 * 同步视频
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toSyncVideo")
	@ResponseBody
	public Object toSyncVideo() throws Exception {
		String s_flag = syncType;
		PageData pd = this.getPageData();
		pd = this.savePage(pd);
		Object obj = null;
		if("TongZhou".equals(s_flag)){
			obj = this.toSyncVideoByTongZhou(pd);
		}else if("ByTue".equals(s_flag)){
			obj = this.toSyncVideoByByTue(pd);
		}else if("XiWeiEr".equals(s_flag)){
			obj = this.toSyncVideoByXiWeiEr(pd);
		}
		return obj;
	}
	
	/**
	 * 同步视频-同洲
	 * @return
	 * @throws Exception
	 */
	private Object toSyncVideoByTongZhou(PageData pd) throws Exception {
		if("hospExpert".equals(pd.getString("SyncType"))){//同步专家视频
			//专家
			pd.put("TYPE", "1");
			//对应关联主键表数据
			pd.put("Mapping", true);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
			//审核通过
			pd.put("HEL_AUDIT", "4");
			//不分页
			pd.put("pageNumber", "0");
			pd.put("lists", this.pd(systemServer + "hospExpLib/pageSearch", pd).toString());
		}else if("hospDept".equals(pd.getString("SyncType"))){//同步科室视频
			//科室
			pd.put("TYPE", "0");
			//对应关联表数据
			pd.put("Mapping", true);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
		}else if("actives".equals(pd.getString("SyncType"))){//同步活动视频
			//活动
			pd.put("TYPE", "2");
			//对应关联主键表数据
			pd.put("Mapping", false);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
		}
		return this.pd(systemServer + "video/toSyncVideoByTongZhou", pd);
	}
	
	/**
	 * 同步视频-百途
	 * @return
	 * @throws Exception
	 */
	private Object toSyncVideoByByTue(PageData pd) throws Exception {
		if("hospExpert".equals(pd.getString("SyncType"))){//同步专家视频
			//专家
			pd.put("TYPE", "1");
			//对应关联主键表数据
			pd.put("Mapping", true);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
			//审核通过
			pd.put("HEL_AUDIT", "4");
			//不分页
			pd.put("pageNumber", "0");
			pd.put("lists", this.pd(systemServer + "hospExpLib/pageSearch", pd).toString());
		}else if("hospDept".equals(pd.getString("SyncType"))){//同步科室视频
			//科室
			pd.put("TYPE", "0");
			//对应关联表数据
			pd.put("Mapping", true);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
		}else if("actives".equals(pd.getString("SyncType"))){//同步活动视频
			//活动
			pd.put("TYPE", "2");
			//对应关联主键表数据
			pd.put("Mapping", false);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
		}
		return this.pd(systemServer + "video/toSyncVideoByByTue", pd);
	}
	
	/**
	 * 同步视频-西维尔
	 * @return
	 * @throws Exception
	 */
	private Object toSyncVideoByXiWeiEr(PageData pd) throws Exception {
		if("hospExpert".equals(pd.getString("SyncType"))){//同步专家视频
			//专家
			pd.put("TYPE", "1");
			//对应关联主键表数据
			pd.put("Mapping", true);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
			//审核通过
			pd.put("HEL_AUDIT", "4");
			//不分页
			pd.put("pageNumber", "0");
			pd.put("lists", this.pd(systemServer + "hospExpLib/pageSearch", pd).toString());
		}else if("hospDept".equals(pd.getString("SyncType"))){//同步科室视频
			//科室
			pd.put("TYPE", "0");
			//对应关联表数据
			pd.put("Mapping", true);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
		}else if("actives".equals(pd.getString("SyncType"))){//同步活动视频
			//活动
			pd.put("TYPE", "2");
			//对应关联主键表数据
			pd.put("Mapping", false);
			//存储视频与关联主键对应关系表
			pd.put("Relate", false);
		}
		return this.pd(systemServer + "video/toSyncVideoByXiWeiEr", pd);
	}
}
