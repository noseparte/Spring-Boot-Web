package com.maryun.controller.system.push;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.maryun.controller.base.BaseController;
@RestController
@RequestMapping("/push")
public class PushController extends BaseController{
	@RequestMapping("/alertTitleMSg")
	public Object alertTitleMSg(){
		return this.pd(systemServer+"push/alertTitleMSg", getPageData());
	}
}
