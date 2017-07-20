package com.maryun.controller.system.usefulExpressions;

import com.maryun.controller.base.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author SR
 */
@RequestMapping("usefulExpressions")
@Controller
public class UsefulExpressionsController extends BaseController{

    /**
     * 列表查看以及搜索
     * @return
     */
    @RequestMapping("list")
    public ModelAndView list(){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("system/usefulExpressions/usefulExpressions_list");
        return mv;
    }

    /**
     * 修改页面
     * @return
     */
    @RequestMapping("toEdit")
    public ModelAndView toEdit(){
        return this.viewAndPd("system/usefulExpressions/usefulExpressions_edit",
                systemServer+"usefulExpressions/toEdit",
                this.getPageData());
    }

    /**
     * 保存修改
     * @return
     */
    @RequestMapping("saveEdit")
    public Object saveEdit(){
        return this.pd(systemServer+"usefulExpressions/saveEdit",this.getPageData());
    }

    /**
     * 去新增页面
     * @return
     */
    @RequestMapping("toAdd")
    public ModelAndView toAdd(){
        ModelAndView mv=new ModelAndView();
        mv.setViewName("system/usefulExpressions/usefulExpressions_toAdd");
        return mv;
    }


    /**
     * 保存新增
     * @return
     */
    @RequestMapping("saveAdd")
    public Object saveAdd(){
        return viewAndPd("system/usefulExpressions/usefulExpressions_list",
                systemServer+"usefulExpressions/saveAdd",
                this.getPageData());
    }

    /**
     * 删除
     * @return
     */
    @RequestMapping("delete")
    public Object delete(){
        return pd(systemServer+"usefulExpressions/delete",this.getPageData());
    }
}
