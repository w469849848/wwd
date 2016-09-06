package com.egolm.tpl.utils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.Key;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Hex;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.HTTP;
import org.apache.http.util.EntityUtils;
import org.springframework.plugin.util.RSAUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.egolm.config.core.reader.ConfigReader;
import com.egolm.config.core.utils.ConfigPath;
import com.egolm.tpl.web.TplSettingPopController;

public class HttpHandler {
	
	public static String token;
	public static String publicKey;
	public static String version;
	public static String username="web";
	public static String password="123456";
	public static String HTTP_HOST="http://demo.egolm.com";
	public static String tokenUrl=HTTP_HOST+"/egolm-token-web/api/token/current";
	public static String publicKeyUrl=HTTP_HOST+"/egolm-token-web/api/token/public";
	
	private static final String APPLICATION_JSON = "application/json";
	private static final String CONTENT_TYPE_TEXT_JSON = "text/json";
	
	public static int i=0;
	
	static{
		init();
	}
	
	public static JSONObject post(String url){
		return post(url,null);
	}
	
	
	public static JSONObject post(String url,Map<String,String> params){
		String result=null;
		CloseableHttpClient httpClient =HttpClients.createDefault();
	    try {
	        HttpPost post = new HttpPost(url);
	        post.addHeader("token", token);
	        System.out.println("add header: token="+token);
	        //创建参数列表
	        List<NameValuePair> list = new ArrayList<NameValuePair>();
	        
	        if(params!=null){
	        	 Set<String> keySet = params.keySet();  
	 	        for(String key : keySet) {  
	 	        	list.add(new BasicNameValuePair(key, params.get(key)));  
	 	        }  
	        }
	        //url格式编码
	        UrlEncodedFormEntity uefEntity = new UrlEncodedFormEntity(list,"UTF-8");
	        post.setEntity(uefEntity);
	        //执行请求
	        CloseableHttpResponse httpResponse = httpClient.execute(post);
	        try{
	            HttpEntity entity = httpResponse.getEntity();
	            if (null != entity){
	            	result = EntityUtils.toString(entity,"UTF-8");
	            }
	        } finally{
	            httpResponse.close();
	        }
	         
	    } catch( UnsupportedEncodingException e){
	        e.printStackTrace();
	    }
	    catch (IOException e) {
	        e.printStackTrace();
	    }
	    finally{
	        try{
	        	if (httpClient != null){
	        		httpClient.close();
	            }            
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	    System.out.println("request url==="+url);
	    System.out.println("result=="+result);
	    if(result!=null){
	    	JSONObject json = JSON.parseObject(result);
	    	if("999".equals(json.getString("statusCode"))&&i==0){
	    		HttpHandler.init();
	    		i=1;
	    		return post(url,params);
	    	}
	    	i=0;
	    	//需增加对token过期的处理程序
	    	return json;
	    }
	    return null;
	}
	
	public static JSONObject postWithJSON(String url,String paramjson){
		String result=null;
		 //DefaultHttpClient httpClient = new DefaultHttpClient();
		 CloseableHttpClient httpClient =HttpClients.createDefault();
	    try {
	    	String encoderJson = URLEncoder.encode(paramjson, HTTP.UTF_8);
	        HttpPost post = new HttpPost(url);
	        post.addHeader("token", token);
	        post.addHeader(HTTP.CONTENT_TYPE, APPLICATION_JSON);
	        StringEntity se = new StringEntity(encoderJson);
	        se.setContentType(CONTENT_TYPE_TEXT_JSON);
	        se.setContentEncoding(new BasicHeader(HTTP.CONTENT_TYPE, APPLICATION_JSON));
	        post.setEntity(se);
	        //执行请求
	        CloseableHttpResponse httpResponse = httpClient.execute(post);
	        try{
	            HttpEntity entity = httpResponse.getEntity();
	            if (null != entity){
	            	result = EntityUtils.toString(entity,"UTF-8");
	            }
	        } finally{
	            httpResponse.close();
	        }
	    } catch( UnsupportedEncodingException e){
	        e.printStackTrace();
	    }
	    catch (IOException e) {
	        e.printStackTrace();
	    }
	    finally{
	        try{
	        	if (httpClient != null){
	        		httpClient.close();
	            }            
	        } catch(Exception e){
	            e.printStackTrace();
	        }
	    }
	    System.out.println("request url==="+url);
	    System.out.println("result=="+result);
	    if(result!=null){
	    	JSONObject json = JSON.parseObject(result);
	    	if("999".equals(json.getString("statusCode"))&&i==0){
	    		HttpHandler.init();
	    		i=1;
	    		return postWithJSON(url,paramjson);
	    	}
	    	i=0;
	    	//需增加对token过期的处理程序
	    	return json;
	    }
	    return null;
	}
	
	
	
	public static void init(){
		
		ConfigPath cpath=ConfigPath.cpath("G:tpl.properties");
		HttpHandler.username=ConfigReader.getProperty(cpath,"tpl.username", "");
		HttpHandler.password=ConfigReader.getProperty(cpath,"tpl.password", "");
		HttpHandler.publicKeyUrl=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.publicKeyUrl", "");
		HttpHandler.tokenUrl=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.tokenUrl", "");
		
		TplSettingPopController.HTTP_AD=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_ad", "");
		TplSettingPopController.HTTP_AP=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_ap", "");
		TplSettingPopController.HTTP_APID=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_apid", "");
		TplSettingPopController.HTTP_BRAND=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_brand", "");
		TplSettingPopController.HTTP_CATEGORY=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_category", "");
		TplSettingPopController.HTTP_PRODUCT=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_product", "");
		TplSettingPopController.HTTP_ZONE=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_zone", "");
		TplSettingPopController.HTTP_QUERY_AP_STATUS=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_query_ap_status", "");;
		TplSettingPopController.HTTP_UPDATE_AP_STATUS=ConfigReader.getProperty(cpath,"tpl.host", "")+ConfigReader.getProperty(cpath,"tpl.http_update_ap_status", "");;
		JSONObject json = post(publicKeyUrl);
		publicKey=json.getString("publicKey");
		version=json.getString("version");
		
		Key key;
		try {
			key = RSAUtil.getRSAPublicKey(Hex.decodeHex(publicKey.toCharArray()));
			String encryptUsername=RSAUtil.encryptHex(key, username);
			String encryptPassword=RSAUtil.encryptHex(key, password);
			String encryptVersion=RSAUtil.encryptHex(key, version);
			Map<String, String> params=new HashMap<String, String>();
			params.put("username", encryptUsername);
			params.put("password",encryptPassword);
			params.put("version",encryptVersion);
			
			JSONObject tokenJson = post(tokenUrl, params);
			token = tokenJson.getString("token");
		} catch (DecoderException e) {
			e.printStackTrace();
		}
		
		
	}
	
	
}
