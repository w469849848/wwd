package com.egolm.tpl.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.Proxy;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.plugin.util.Net;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;

import com.alibaba.fastjson.JSONObject;
import com.egolm.common.InterfaceAccessException;

/** 
 * 项目名称：wxshop
 * 功能描述:  
 * 创建人: zhangzhi 
 * 创建时间: 2015年11月28日 下午1:33:03 
 * 版本: V1.0 
 */
public class HttpUtils {
    private static RequestConfig requestConfig;
    static {
        RequestConfig.Builder configBuilder = RequestConfig.custom();
        // 设置连接超时
        configBuilder.setConnectTimeout(10*1000);
        // 设置读取超时
        configBuilder.setSocketTimeout(10*10000);
        requestConfig = configBuilder.build();
    }

   /**
    * 发送无参数的GET请求
    */
    public static String doGet(String url) {
        return doGet(url,null);
    }

    /**
     * 发送有参数的GET请求，参数为MAP key-value格式
     */
    public static String doGet(String url, Map<String, String> params) {
        List<String> paramList=new ArrayList<String>();
        if(params!=null){
        	 for (String key : params.keySet()) {
             	paramList.add(key+"="+params.get(key));
             }
             if(paramList.size()>0){
             	if(url.indexOf("?")==-1){
             		url=url+"?"+StringUtil.join("&",paramList);
             	}else{
             		url=url+"&"+StringUtil.join("&",paramList);
             	}
             }
        }
        U.logger.info("url:"+url);
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url.replaceAll(" ", "%20")); 
        httpGet.setConfig(requestConfig);
         CloseableHttpResponse response = null;
        HttpEntity entity = null;
        try {
        	response = httpclient.execute(httpGet);
            entity = response.getEntity();
            String result =  EntityUtils.toString(entity, "UTF-8");
            
            U.logger.info("response result="+result);
            return result;
        } catch (Exception e) {
            throw new InterfaceAccessException(e);
        } finally {
        	try {
	       		if(entity!=null){
	       			EntityUtils.consume(entity);
	       		}
			} catch (IOException e) {
				e.printStackTrace();
			}
        	try {
        		if(response!=null){
        			response.close();
        		}
			} catch (IOException e) {
				e.printStackTrace();
			}
        	
        	try {
        		httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    }
    
    /**
     * 发送有参数的GET请求，参数为MAP key-value格式
     */
    public static String doGetNoToken(String url, Map<String, String> params) {
        List<String> paramList=new ArrayList<String>();
        if(params!=null){
        	 for (String key : params.keySet()) {
             	paramList.add(key+"="+params.get(key));
             }
             if(paramList.size()>0){
             	if(url.indexOf("?")==-1){
             		url=url+"?"+StringUtil.join("&",paramList);
             	}else{
             		url=url+"&"+StringUtil.join("&",paramList);
             	}
             }
        }
        U.logger.info("url:"+url);
        
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpGet httpGet = new HttpGet(url.replaceAll(" ", "%20")); 
        httpGet.setConfig(requestConfig);
         CloseableHttpResponse response = null;
        HttpEntity entity = null;
        try {
        	response = httpclient.execute(httpGet);
            entity = response.getEntity();
            String result =  EntityUtils.toString(entity, "UTF-8");
             
            U.logger.info("response result="+result);
            return result;
        } catch (Exception e) {
            throw new InterfaceAccessException(e);
        } finally {
        	try {
	       		if(entity!=null){
	       			EntityUtils.consume(entity);
	       		}
			} catch (IOException e) {
				e.printStackTrace();
			}
        	try {
        		if(response!=null){
        			response.close();
        		}
			} catch (IOException e) {
				e.printStackTrace();
			}
        	
        	try {
        		httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    }
    
 

    /**
     * 发送无参数的POST请求
     */
    public static String doPost(String url) {
        return doPost(url, null);
    }

    /**
     * 发送有参数的POST请求，参数为MAP key-value格式
     */
    public static String doPost(String url, Map<String, String> params) {
    	CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(url);
        httpPost.setConfig(requestConfig);
        CloseableHttpResponse response = null;
        HttpEntity entity = null;
        U.logger.info("url"+url);
        U.logger.info("params:"+params);
        try {
        	List<NameValuePair> pairList = new ArrayList<NameValuePair>();
            if(params!=null){
                  for (Map.Entry<String, String> entry : params.entrySet()) {
                      NameValuePair pair = new BasicNameValuePair(entry.getKey(), entry.getValue().toString());
                      pairList.add(pair);
                  }
            }
            httpPost.setEntity(new UrlEncodedFormEntity(pairList, Charset.forName("UTF-8")));
             response = httpClient.execute(httpPost);
            entity = response.getEntity();
            String result = EntityUtils.toString(entity, "UTF-8");
            
            U.logger.info("response result="+result);
            return result;
        } catch (Exception e) {
        	throw new InterfaceAccessException(e);
        }finally{
        	try {
	       		if(entity!=null){
	       			EntityUtils.consume(entity);
	       		}
			} catch (IOException e) {
				e.printStackTrace();
			}
        	
        	try {
        		if(response!=null){
        			response.close();
        		}
			} catch (IOException e) {
				e.printStackTrace();
			}
        	
        	try {
				httpClient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    }
    
    
    /**
     * 发送有参数的POST请求，参数为json格式
     */
    public static String doPostForJson(String url, String json) {
    	Map<String, String> map = new HashMap<String, String>();
    	U.logger.info("url:"+url);
        U.logger.info("params:"+json);
     	String result =  Net.post(url, json, map);
    	 
    	U.logger.info("response result="+result);
    	return result;
    }
    
    public static String get(String requestUrl, String charsetName, Map<String,String> params, Proxy proxy) {
		HttpURLConnection connection = null;
		try {
			List<String> paramList=new ArrayList<String>();
	        if(params!=null){
	        	 for (String key : params.keySet()) {
	             	paramList.add(key+"="+params.get(key));
	             }
	             if(paramList.size()>0){
	             	if(requestUrl.indexOf("?")==-1){
	             		requestUrl=requestUrl+"?"+StringUtil.join("&",paramList);
	             	}else{
	             		requestUrl=requestUrl+"&"+StringUtil.join( "&",paramList);
	             	}
	             }
	        }
	        URL getUrl = new URL(requestUrl);
			connection = (HttpURLConnection)(proxy == null ? getUrl.openConnection() : getUrl.openConnection(proxy));
			connection.setRequestMethod("GET");
			connection.setRequestProperty("Accept-Charset", charsetName);
			connection.setRequestProperty("Content-Type", charsetName);
			U.logger.info("url:"+requestUrl);
	        U.logger.info("params:"+params);
	        //connection.setRequestProperty("token", RSAOPT.getToken());
	        
			connection.connect();
			String result = responseBody(connection, charsetName);
			U.logger.info("response result="+result);
			return result;
		} catch (Exception e) {
			throw new RuntimeException(e);
		} finally {
			connection.disconnect();
		}
	}
	
	private static String responseBody(HttpURLConnection connection, String charsetName) {
		try {
			byte[] bytes = streamToBytes(connection.getInputStream());
			String strHtml = null;
			Map<String, List<String>> responseHeaders = connection.getHeaderFields();
			List<String> contentTypes = responseHeaders.get("Content-Type");
			String responseCharsetName = null;
			String contentType = (contentTypes != null && contentTypes.size() > 0) ? contentTypes.get(0) : "";
			String[] typeArray = contentType.split(";");
			for(String type : typeArray){
				if(type.startsWith("charset=")) {
					responseCharsetName = type.split("=", 2)[1];
				} else if(type.startsWith("encoding=")) {
					responseCharsetName = type.split("=", 2)[1];
				}
			}
			if(responseCharsetName != null && responseCharsetName.trim().length() > 0) {
				strHtml = new String(bytes, "UTF-8");
				String regex = "charset=([^\"'>]+)";
				Pattern pattern = Pattern.compile(regex);
				Matcher matcher = pattern.matcher(strHtml);
				while(matcher.find()) {
					String metaCharsetName = matcher.group(1);
					if(metaCharsetName != null && metaCharsetName.trim().length() > 0) {
						responseCharsetName = metaCharsetName;
					}
				}
			}
			if(responseCharsetName != null && responseCharsetName.trim().length() > 0) {
				return strHtml;
			} else {
				return new String(bytes, charsetName);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public static byte[] streamToBytes(InputStream instream) {
		byte[] bytes = null;
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream(102400);
			byte[] b = new byte[102400];
			int n;
			while ((n = instream.read(b)) != -1) {
				baos.write(b, 0, n);
			}
			instream.close();
			baos.close();
			bytes = baos.toByteArray();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return bytes;
	}

	public static boolean isTockenOverGap(String result){
		JSONObject object = JSONObject.parseObject(result);
		Boolean isValid = (Boolean)object.getBoolean("IsValid");
		if(isValid==null || !isValid) {
			String statusCode = (String)object.getString("statusCode");
			if("999".equals(statusCode)){ //tocken已经过期
				return true;
			}
		}
		return false;
	}
    
    public static void main(String[] args) {
    	doPostForJson("http://10.10.0.4:9099/egolm-cart-web/api/cart/update","{'userNo':'cs','zoneNo':'HUNA','override':0,'productList':[{'productId':'35790411','qty':20}]}");
	}
}