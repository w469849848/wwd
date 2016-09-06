package com.egolm.advert.web;

 
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.ClassUtils;
 

public class BaseAdvertController {
	
	@Resource(name = "tOrgsQueryApi")
	private TOrgsQueryApi  tOrgsQueryApi;
	
	
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	
	/**
	 * 根据request.getParameter 取值
	 * @param request
	 * @param keyOtherName  key的前缀名
	 * @param beans
	 * @return
	 */
	public Map<String,Object> setMapByPar(HttpServletRequest request,Map<String, Object> params,String keyOtherName,String...beans){
		if(U.isNotEmpty(beans)){
			Enumeration<String> parEnu = request.getParameterNames();
			while(parEnu.hasMoreElements()){
		    	String key = (String)parEnu.nextElement();
		    	for(int i=0;i<beans.length;i++){
		    		String bean = beans[i];
		    		if(ClassUtils.checkExists(bean, key)){
			    		String value = request.getParameter(key);
				    	if(U.isNotEmpty(value.trim())){
				    		if(U.isNotEmpty(keyOtherName)){
				    			params.put(keyOtherName+"."+key,value.trim());
				    		}else{
				    			params.put(key,value.trim());
				    		}
				    		
				    	}
			    	}
		    	} 
		    }
		}
		return params;
	}
	
	/**
	 * 从request.getAttribute中取值
	 * @param request
	 * @param params
	 * @param beans
	 * @return
	 */
	public Map<String,Object> setMapByAttr(HttpServletRequest request,Map<String, Object> params,String keyOtherName,String...beans){
		if(U.isNotEmpty(beans)){
			Enumeration<String> parEnu = request.getAttributeNames();
			while(parEnu.hasMoreElements()){
		    	String key = (String)parEnu.nextElement();
		    	for(int i=0;i<beans.length;i++){
		    		String bean = beans[i];
		    		if(ClassUtils.checkExists(bean, key)){
			    		String value = (String)request.getAttribute(key);
				    	if(U.isNotEmpty(value.trim())){
				    		if(U.isNotEmpty(keyOtherName)){
				    			params.put(keyOtherName+"."+key,value.trim());
				    		}else{
				    			params.put(key,value.trim());	
				    		}
				    		
				    	}
			    	}
		    	} 
		    }
		}
		return params;
	}
	
	/**
	 * 获取经销商账号的区域权限
	 * @param userid
	 * @return  'XIAN',WUHN',SUZU'
	 */
	public String getAgentOrgNo(String userid){
		String sOrgStr ="";
		List<Map<String, Object>> dataMap = tOrgsQueryApi.queryAgentOrg(userid, 4);  //第四级的
		 
		 List<String> sOrgNOList = new ArrayList<String>();
		 if(dataMap != null && dataMap.size()>0){
			 for(Map<String,Object> data:dataMap){
				 String sOrgNo = data.get("sOrgNO").toString();
				 if(U.isNotEmpty(sOrgNo)){
					 sOrgNOList.add(sOrgNo);
				 }
			 }
		 }
		 
		 if(sOrgNOList.size()>0){
			   sOrgStr = StringUtil.join("','","'","'",sOrgNOList);
		 }
		 return sOrgStr;
	}
	 public static void main(String[] args) {
		System.out.println(StringUtil.join("','","'","'","XIAN"));
	}
}
