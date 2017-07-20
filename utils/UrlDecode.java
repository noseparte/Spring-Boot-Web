package com.maryun.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.maryun.model.PageData;

public class UrlDecode {
	@SuppressWarnings("deprecation")
	public static PageData urlDecode(PageData pd){
		PageData paged=new PageData();
		Set entrySet = pd.entrySet();
		Iterator iterator = entrySet.iterator();
		while(iterator.hasNext()){
			Map.Entry<Object, Object> next = (Entry<Object, Object>)iterator.next();
			String value = (String) next.getValue();
			String dv="";
			try {
				dv = URLDecoder.decode(new String(value.getBytes("iso-8859-1"),"utf-8"), "UTF-8");
				dv = URLDecoder.decode(dv,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			paged.put(next.getKey(), dv);
		}
		
		return paged;
	}
}
