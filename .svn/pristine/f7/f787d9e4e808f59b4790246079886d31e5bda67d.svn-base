package com.maryun.controller.system.error;

import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.autoconfigure.web.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.maryun.controller.base.BaseController;

@Controller
public class IndexController implements ErrorController{

    private static final String PATH = "/error";

    @RequestMapping(value = PATH)
    public ModelAndView error() {
    	ModelAndView mv=new ModelAndView();
    	mv.setViewName("system/error");
        return mv;
    }

    @Override
    public String getErrorPath() {
        return PATH;
    }
}
