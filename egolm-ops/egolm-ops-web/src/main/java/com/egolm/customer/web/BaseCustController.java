package com.egolm.customer.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.U;

import com.egolm.common.ClassUtils;
 

public class BaseCustController {
	/**
	 * 查询条件
	 * @param request
	 * @param page
	 * @param type 用于判断是从request.getParameter 取值，还是从request.getAttribute中取值
	 * @return
	 */
	public Map<String, Object> searchSQL(HttpServletRequest request,PageSqlserver page,String type,String...beans){
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(20);
		}
		Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
	     
	    if(U.isNotEmpty(type,beans)){
	    	if(type.equals("par")){
		    	Enumeration<String> parEnu = request.getParameterNames();
			    while(parEnu.hasMoreElements()){
			    	String key = (String)parEnu.nextElement();
			    	for(int i=0;i<beans.length;i++){
			    		String bean = beans[i];
			    		if(ClassUtils.checkExists(bean, key)){
				    		String value = request.getParameter(key);
					    	if(U.isNotEmpty(value)){
					    		params.put(key,value);
					    	}
				    	}
			    	} 
			    }
		    } 
		    if(type.equals("attr")){ 
		    	Enumeration<String> arrtEnu = request.getAttributeNames();
			    while(arrtEnu.hasMoreElements()){
			    	String key = (String)arrtEnu.nextElement();
			    	for(int i=0;i<beans.length;i++){
			    		String bean = beans[i];
			    		if(ClassUtils.checkExists(bean, key)){
					    	String value = (String) request.getAttribute(key);
					    	if(U.isNotEmpty(value)){
					    		params.put(key,value);
					    	}
				    	}
			    	} 
			    }
		    }
	    } 
        return params;
	}
}
