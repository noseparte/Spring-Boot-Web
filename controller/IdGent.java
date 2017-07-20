package com.maryun.controller;

import java.util.concurrent.atomic.AtomicInteger;

public class IdGent{
	 private static AtomicInteger count = new AtomicInteger(0);//线程安全的计数变量  
	 /** 
     * 功能：计数 
     */  
     public static int calc(){  
        return count.incrementAndGet();//自增1,返回更新值  
     }  

}
