package com.maryun.service.system;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.maryun.controller.base.BaseController;
import com.maryun.model.PageData;

@Service("authService")
public class AuthService extends BaseController{
	/**
	 * 为shiro获取用户的全部的permission
	 * 按钮以 "user:add" "user:edit" "user:del"的形式授权
	 * 菜单以 "url:user/listUsers" 的形式授权
	 * @param userName
	 * @return
	 * @author panglin
	 */
	public List<String> getAuthListByUser(String userName){
		PageData rolesPd =this.postForPageData(systemServer+"auth/getUrlAuthListByUser", userName);
		if(this.resSuccCode.equals(rolesPd.getString("state"))){
			List<String> authList=JSON.parseObject(rolesPd.getString("content"),new TypeReference<List<String>>() {});
			return authList;
		}else{
			return null;
		}
		
	}
//	
//	public List<String> getGlobalBtnListByUser(String userName){
//		List<String> buttonList=this.postForListStr(systemServer+"auth/getUrlAuthListByUser", userName);
//		return buttonList;
//	}
//	
//	public List<String> getURLBtnListByUser(String userName){
//		List<String> buttonList=this.postForListStr(systemServer+"auth/getURLBtnListByUser", userName);
//		return buttonList;
//	}
//	
//	/**
//	 * 获取用户的菜单权限
//	 * @param pd
//	 * @return
//	 */
//	public Map<String,String> getUrlAuthByUser(PageData pd){
//		Map<String,String> authMap = new HashMap<String, String>();
//		pd=this.postForPageData(systemServer+"auth/getUrlAuthByUser", pd);
//		return authMap;
//	}
//	
//	public List<String> getUrlAuthListByUser(String userName){
//		List<String> authList=this.postForListStr(systemServer+"auth/getUrlAuthListByUser", userName);
//		return authList;
//	}
//	
//	/**
//	 * 使用用户名获取用户的按钮权限
//	 * @param pd
//	 * @return
//	 * @author panglin
//	 */
//	public PageData getButtonAuthByUser(PageData pd){
//		PageData btnAuth=this.postForPageData(systemServer+"auth/getButtonAuthByUser", pd);
//		return btnAuth;
//	}
//	
	
	
	/**
	 * 获取用户的角色
	 * @param userName
	 * @return
	 */
	public HashSet<String> getRolesByUser(String userName){
		PageData rolesPd =this.postForPageData(systemServer+"auth/getRolesByUser", userName);
		if(this.resSuccCode.equals(rolesPd.getString("state"))){
			HashSet<String> rolesSet=JSON.parseObject(rolesPd.getString("content"),new TypeReference<HashSet<String>>() {});
			return rolesSet;
		}else{
			return null;
		}
	}
	
	
//	
//	public List<String> getRolesListByUser(String userName){
//		List<String> roleList =this.postForListStr(systemServer+"auth/getRolesByUser", userName);
//		return roleList;
//	}
//	
//	public PageData getUserByName(String userName){
//		try{
//			PageData pd=new PageData();
//			pd.put("USERNAME", userName);
//			PageData userInfo =this.postForPageData(systemServer+"user/findByUId", pd);
//			return userInfo;
//		}catch(Exception e){
//			return null;
//		}
//		
//		
//	}
	
}
