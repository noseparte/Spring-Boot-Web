package com.maryun.controller.system.login;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController extends BaseController{
	
	@Value("${maryun.system.theme}")
	private String theme;
	@Value("${maryun.system.homePage}")
	private String homePage;
	@Value("${maryun.system.name}")
	private String sysName;
	@Value("${maryun.system.logo}")
	private String logo;
	@Value("${system.redis.customer.pre}")
	private String customerPre;
	//@Resource
	//private RedisTemplate<String, Object> redisTemplate;
	
	/**
	 * 访问系统首页
	 */
	@RequestMapping(value="/main/{changeMenu}")
	public ModelAndView login_index(@PathVariable("changeMenu") String changeMenu){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		try{
			PageData user=this.getUser();
			if(user!=null){
				String userName=user.getString("USERNAME");
				List<PageData> menuList=null;
				PageData menuPd=this.postForPageData(systemServer+"menu/listMenuByUserName", userName);
				if(this.resSuccCode.equals(menuPd.getString("state"))){
					menuList=JSON.parseObject(menuPd.getString("content"),new TypeReference<List<PageData>>() {});
				}else{
					//return null;
				}
				System.out.println(JSON.toJSONString(menuList));
				
				String theme = "";
				if("index".equals(changeMenu)){
					if("v".equals(theme.toLowerCase())){
						mv.setViewName("system/admin/vindex");
					}else{
						mv.setViewName("system/admin/index");
					}
				}else if("indexV".equals(changeMenu)){
					mv.setViewName("system/admin/vindex");
				}else if("indexH".equals(changeMenu)){
					mv.setViewName("system/admin/index");
				}else{
					mv.setViewName("system/admin/vindex");
				}
				
				mv.addObject("user", user);
				mv.addObject("menuList", menuList);
				
				pd.put("LOGO", logo); // 读取系统名称
				pd.put("SYSNAME", sysName); // 读取系统名称
				pd.put("HOMEPAGE", homePage); // 读取系统名称
				
			}else {
				mv.setViewName("system/admin/login");// session失效后跳转登录页面
			}
		} catch(Exception e){
			mv.setViewName("system/admin/login");
		}
		mv.addObject("pd",pd);
		return mv;
	}
	@Value("${maryun.bigTitle}")
	private String bigTitle;
	@Value("${maryun.title}")
	private String title;
	@Value("${maryun.subTitle}")
	private String subTitle;
	@Value("${maryun.system.name}")
	private String systemName;
	
	/**
	 * 访问登录页
	 * @return
	 */
	@RequestMapping(value={"/","/login","/login_toLogin"})
	public ModelAndView toLogin()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("SYSNAME", systemName); //读取系统名称
		//登录页面显示名称
		pd.put("BIG_TITLE", bigTitle);
		pd.put("TITLE", title);
		pd.put("SUB_TITLE", subTitle);
		mv.addObject("pd",pd);
		mv.setViewName("system/admin/login3");
		return mv;
	}
	
	
	/**
	 * 访问登录页
	 * @return
	 */
	@RequestMapping(value="error/403")
	public ModelAndView error()throws Exception{
		ModelAndView mv = this.getModelAndView();
		mv.setViewName("error/403");
		return mv;
	}
	
    /**
	 * 请求登录，验证用户
	 */
	@RequestMapping(value="/login_login")
	@ResponseBody
	public Object login()throws Exception{
		Map<String,String> map = new HashMap<String,String>();
		PageData pd = this.getPageData();
		String errInfo = "";
		String KEYDATA[] = pd.getString("KEYDATA").replaceAll("maryunMY", "").replaceAll("maryunMY", "").split(",maryun,");
		
		if(null != KEYDATA && KEYDATA.length == 3){
			//shiro管理的session
			Subject currentUser = SecurityUtils.getSubject();  
			Session session = currentUser.getSession();
			String sessionCode = (String)session.getAttribute("sessionSecCode");		//获取session中的验证码
			
			String code = KEYDATA[2];
			if(null == code || "".equals(code)){
				errInfo = "nullcode"; //验证码为空
			}else{
				String USERNAME = KEYDATA[0];
				String PASSWORD  = KEYDATA[1];
				pd.put("USERNAME", USERNAME);
				
				if(sessionCode.equalsIgnoreCase(code)){
					pd =this.postForPageData(systemServer+"user/getUserByUderName", pd);
					if(this.resSuccCode.equals(pd.getString("state"))){
						if(pd.get("content")!=null){
							pd=JSON.parseObject(pd.getString("content"),PageData.class);
							String passwd =DigestUtils.md5DigestAsHex(String.join(",",pd.getString("USER_ID"), PASSWORD).getBytes());
							//校验密码
							if(pd.getString("PASSWORD").equals(passwd)){
								session.setAttribute("sessionUser", pd);
								session.removeAttribute("sessionSecCode");
								//shiro加入身份验证
								Subject subject = SecurityUtils.getSubject(); 
							    UsernamePasswordToken token = new UsernamePasswordToken(USERNAME, passwd); 
							    try { 
							        subject.login(token); 
							    } catch (AuthenticationException e) { 
							    	errInfo = "身份验证失败！";
							    }
							}else{
								errInfo = "usererror"; 				//用户名或密码有误
							}
						}else{
							errInfo = "usererror"; 				//用户名或密码有误
						}
						
						
					}else{
						errInfo = "usererror"; 				//用户名或密码有误
					}
					
				}else{
					errInfo = "codeerror";				 	//验证码输入有误
				}
				if(StringUtils.isBlank(errInfo)){
					errInfo = "success";					//验证成功
				}
			}
		}else{
			errInfo = "error";	//缺少参数
		}
		map.put("result", errInfo);
		return map;
	}
    
	
	
	
	
	/**
	 * 修改密码
	 * 
	 */
	@RequestMapping(value = "/saveChangePwd")
	@ResponseBody
	public Object saveChangePwd() throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		PageData pd = this.getPageData();
		PageData user = this.getUser();
		String errInfo = "";
		String PWD = pd.getString("PWD");
		String NEWPWD = pd.getString("NEWPASSWORD");
		String PASSWORD =DigestUtils.md5DigestAsHex(String.join(",",user.getString("USER_ID"), PWD).getBytes());
		user.put("PASSWORD", PASSWORD);
		pd =this.postForPageData(systemServer+"user/getUserByNameAndPwd", user);
		if (pd != null) {
			String newPwd = DigestUtils.md5DigestAsHex(String.join(",",user.getString("USER_ID"), NEWPWD).getBytes());// 密码加密
			user.put("PASSWORD", newPwd);
			try {
				pd =this.postForPageData(systemServer+"user/editPwd", user);
				if(this.resSuccCode.equals(pd.getString("state"))){
					errInfo = "success";
				}else{
					errInfo = "error";
				}
			}catch (Exception e) {
				errInfo = "error";
			}
		}
		else {
			errInfo = "pwderror"; // 密码有误
		}
		map.put("result", errInfo);
		return map;
	}

	/**
	 * 去修改用户页面
	 */
	@RequestMapping(value = "/toChangePwd")
	public ModelAndView toChangePwd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getUser();
		mv.addObject("pd", pd);
		mv.setViewName("system/user/user_pwd_edit");
		return mv;
	}
	
	
	
	
    @RequestMapping(value="/logout",method=RequestMethod.GET)  
    public String logout(RedirectAttributes redirectAttributes ){ 
        //使用权限管理工具进行用户的退出，跳出登录，给出提示信息
        SecurityUtils.getSubject().logout();  
        redirectAttributes.addFlashAttribute("message", "您已安全退出");  
        return "redirect:/login";
    }
    
    /**
     * 
     * @Description: 客服人员配置
     * @param pd    
     * @return void    
     * @throws
     */
    public void customerList(PageData pd){
    	String type=pd.getString("TYPE");
    	if("6".equals(type)){
//    		ListOperations<String, Object> list = redisTemplate.opsForList();
//    		list.rightPush(customerPre, pd);
    	}
    }
}
