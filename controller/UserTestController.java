package com.maryun.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cloud.netflix.ribbon.RibbonClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.maryun.conf.ribbon.RibbonConfiguration;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import com.netflix.hystrix.contrib.javanica.annotation.HystrixCommand;
@RestController
@RequestMapping("/userTest")
@RibbonClient(name = "maryunServer", configuration = RibbonConfiguration.class)
public class UserTestController extends BaseController{
	@RequestMapping(value="/getList", method=RequestMethod.GET)
	@HystrixCommand(fallbackMethod = "commonFallback")
	public Object getList() {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("username", "hello");
		params.put("password", "password");
		String result= restTemplate.postForObject("http://maryunServer/users/findUserInfo", params,String.class);
		//String result= restTemplate.getForEntity("http://maryunServer/users/findUserInfo",String.class, params).getBody();
		return  result;
	}
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	@HystrixCommand(fallbackMethod = "commonFallback")
    public String add() {
		PageData params=new PageData();
		int id=IdGent.calc();
		params.put("username", "USER_"+id);
		params.put("password", "PASSWORD"+id);
		params.put("usertype",1);
		params.put("delstate",0);
		//String paramStr=JsonUtil.getJsonStr(params);
        //String rest= restTemplate.postForObject("http://maryunServer11/menu/getTree", params,String.class);
        List<PageData> pd=this.postForList("http://maryunServer/menu/getTree", params);
        return JSON.toJSONString(pd);
    }
	
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	@HystrixCommand(fallbackMethod = "commonFallback")
    public String delete() {
        restTemplate.delete("http://maryunServer/users/deleteUser");
        return "sucess";
    }
	
}

