package com.maryun.conf.shiro;

import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;

import java.util.LinkedHashMap;
import java.util.Map;
 
/**
 * Shiro 配置
 *
Apache Shiro 核心通过 Filter 来实现，就好像SpringMvc 通过DispachServlet 来主控制一样。
既然是使用 Filter 一般也就能猜到，是通过URL规则来进行过滤和权限校验，所以我们需要定义一系列关于URL的规则和访问权限。
 */
@Configuration
public class ShiroConfiguration {
	 /**
     * ShiroFilterFactoryBean 处理拦截资源文件问题。
     * 注意：单独一个ShiroFilterFactoryBean配置是或报错的，以为在
     * 初始化ShiroFilterFactoryBean的时候需要注入：SecurityManager
     *
        Filter Chain定义说明
       1、一个URL可以配置多个Filter，使用逗号分隔
       2、当设置多个过滤器时，全部验证通过，才视为通过
       3、部分过滤器可指定参数，如perms，roles
     *
     */
    @Bean
    public ShiroFilterFactoryBean shirFilter(SecurityManager securityManager){
       System.out.println("ShiroConfiguration.shirFilter()");
       ShiroFilterFactoryBean shiroFilterFactoryBean  = new ShiroFilterFactoryBean();
        // 必须设置 SecurityManager 
       shiroFilterFactoryBean.setSecurityManager(securityManager);
       
       
       // 如果不设置默认会自动寻找Web工程根目录下的"/login.jsp"页面
       shiroFilterFactoryBean.setLoginUrl("/login_toLogin");
       // 登录成功后要跳转的链接
       shiroFilterFactoryBean.setSuccessUrl("/main/index");
       //未授权界面;
       shiroFilterFactoryBean.setUnauthorizedUrl("/error/403");
       
       //拦截器.
       Map<String,String> filterChainDefinitionMap = new LinkedHashMap<String,String>();
      
       //配置退出过滤器,其中的具体的退出代码Shiro已经替我们实现了
       filterChainDefinitionMap.put("/logout", "logout");
       filterChainDefinitionMap.put("/login_**", "anon");
       filterChainDefinitionMap.put("/hplus/*/**", "anon");
       filterChainDefinitionMap.put("/plugins/*/**", "anon");
       filterChainDefinitionMap.put("/demo/*/**", "anon");
       filterChainDefinitionMap.put("/code*", "anon");
       filterChainDefinitionMap.put("/static/*/**", "anon");
       filterChainDefinitionMap.put("/uploadFiles/uploadImgs/** ", "anon");
       filterChainDefinitionMap.put("/articleHealth/toAppView", "anon");
       filterChainDefinitionMap.put("/active/toAppView", "anon");
       filterChainDefinitionMap.put("/articleRotation/toAppView", "anon");
       filterChainDefinitionMap.put("/articleHealth/toShareView", "anon");
       filterChainDefinitionMap.put("/active/toShareView", "anon");
       filterChainDefinitionMap.put("/articleRotation/toShareView", "anon");
       filterChainDefinitionMap.put("/images/*/**", "anon");
       //<!-- 过滤链定义，从上向下顺序执行，一般将 /**放在最为下边 -->:这是一个坑呢，一不小心代码就不好使了;
        //<!-- authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问-->
       filterChainDefinitionMap.put("/**", "authc");
       
       shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
       return shiroFilterFactoryBean;
    }
    
    
    /**
     * 凭证匹配器
     * （由于我们的密码校验交给Shiro的SimpleAuthenticationInfo进行处理了
     *  所以我们需要修改下doGetAuthenticationInfo中的代码;
     * ）
     * @return
     */
    @Bean
    public HashedCredentialsMatcher hashedCredentialsMatcher(){
       HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
       hashedCredentialsMatcher.setHashAlgorithmName("md5");//散列算法:这里使用MD5算法;
       hashedCredentialsMatcher.setHashIterations(1);//散列的次数，比如散列两次，相当于 md5(md5(""));
       return hashedCredentialsMatcher;
    }
   
    
    
    /**
     * 身份认证realm;
     * (这个需要自己写，账号密码校验；权限等)
     * @return
     */
    @Bean
    public ShiroRealm myShiroRealm(){
       ShiroRealm myShiroRealm = new ShiroRealm();
       //myShiroRealm.setCredentialsMatcher(hashedCredentialsMatcher());
       return myShiroRealm;
    }
    
    @Bean
    public SecurityManager securityManager(){
       DefaultWebSecurityManager securityManager =  new DefaultWebSecurityManager();
       //设置realm.
       securityManager.setRealm(myShiroRealm());
       return securityManager;
    }
    
    
    /**
     * Shiro生命周期处理器
     * @return
     */
    @Bean
    public LifecycleBeanPostProcessor lifecycleBeanPostProcessor(){
        return new LifecycleBeanPostProcessor();
    }
    /**
     * 开启Shiro的注解(如@RequiresRoles,@RequiresPermissions),需借助SpringAOP扫描使用Shiro注解的类,并在必要时进行安全逻辑验证
     * 配置以下两个bean(DefaultAdvisorAutoProxyCreator(可选)和AuthorizationAttributeSourceAdvisor)即可实现此功能
     * @return
     */
    @Bean
    @DependsOn({"lifecycleBeanPostProcessor"})
    public DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator(){
        DefaultAdvisorAutoProxyCreator advisorAutoProxyCreator = new DefaultAdvisorAutoProxyCreator();
        advisorAutoProxyCreator.setProxyTargetClass(true);
        return advisorAutoProxyCreator;
    }
    @Bean
    public AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor(){
        AuthorizationAttributeSourceAdvisor authorizationAttributeSourceAdvisor = new AuthorizationAttributeSourceAdvisor();
        authorizationAttributeSourceAdvisor.setSecurityManager(securityManager());
        return authorizationAttributeSourceAdvisor;
    }

 

    
}
