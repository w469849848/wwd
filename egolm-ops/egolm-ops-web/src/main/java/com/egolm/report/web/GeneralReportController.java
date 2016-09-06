package com.egolm.report.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Excel;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmLogger;
import com.egolm.report.api.ReportEChartsQueryApi;
import com.egolm.report.api.TYWReportSQLQueryApi;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.tpl.utils.HttpUtils;
import com.google.common.collect.Maps;
import com.google.gson.Gson;

/**
 * 缩合报表统计
 * @author zhangyong
 *
 */

@Controller 
@RequestMapping("/data/generalReport")
public class GeneralReportController {
	
	
	@Value(value = "${idc.report.queryTitleById}")
	private  String  HTTP_IDCQUERYTITLE_BYID;  //根据ID获取报表标题
	
	@Value(value = "${idc.report.queryTitleByName}")
	private  String  HTTP_IDCQUERYTITLE_BYNAME;  //根据name获取报表标题
	
	@Value(value = "${idc.report.queryData}")
	private  String  HTTP_IDCQUERYDATA;   //统计报表内容
	
	@Value(value = "${idc.report.queryDataChart}")
	private String  HTTP_IDCQUERYDATA_CHART; //图形报表内容
	
	@Resource(name = "reportEChartsQueryApi")
	ReportEChartsQueryApi  reportEChartsQueryApi;
	
	@Resource(name = "tYWReportSQLQueryApi")
	private TYWReportSQLQueryApi tYWReportSQLQueryApi;

	/**
	 * 跳转至统计报表页
	 * @param request
	 * @return
	 */
	@RequestMapping("/index")
	public String indexPage(HttpServletRequest request){
		String moduleID = request.getParameter("moduleID"); 
		String ModuleName = request.getParameter("ModuleName");
		String type = request.getParameter("type");
		request.setAttribute("moduleID", moduleID);
		request.setAttribute("type", type);
		if(U.isNotEmpty(ModuleName)){
			try {
				ModuleName = URLDecoder.decode(ModuleName, "UTF-8"); 
				request.setAttribute("ModuleName", ModuleName);
			} catch (Exception e) { 
				U.logger.error("报表菜单名称转码失败",e);
			}
		}
		if(U.isNotEmpty(type)){
			if(type.equals("S")){    //统计
				return "/report/generalReport.jsp";
			}
			if(type.equals("G")){   //图形
				return "/report/echartReport.jsp";
			}
		}
		return "/404.jsp";
	}
	 
	
	
	@RequestMapping("/reportAlertPage")
	public String reportAlertPage(HttpServletRequest request){
		String hiddenId = request.getParameter("hiddenId");   //弹框 选择后，要隐藏在父页面的 隐藏的 ID属性
		String hiddenName = request.getParameter("hiddenName");//弹框 选择后，要显示在父页面的  ID属性
		String sqlName = request.getParameter("sqlName");   //要调用IDC 接口获取查询条件的 名称
		request.setAttribute("hiddenId", hiddenId); 
		request.setAttribute("hiddenName", hiddenName); 
		request.setAttribute("sqlName", sqlName);
		return "/report/report-alertSelect.jsp";
	}
	
	
	
	/**
	 * 获取ID 获取IDC返回的报表标题
	 * @param request
	 * @return
	 */
	@RequestMapping("/idcTitleById")
	@ResponseBody
	public String idcTitleById(HttpServletRequest request){
		
		try {
			Map<String,String> params = new HashMap<String,String>();
			String moduleID = request.getParameter("moduleID");
			params.put("moduleID",moduleID); 
			//用于记录日志
			String url = HTTP_IDCQUERYTITLE_BYID; 
			String requestUrl = requestUrl(url,params);
			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"根据ID:"+moduleID+"获取报表标题的请求:"+requestUrl);
			String result = HttpUtils.doGet(HTTP_IDCQUERYTITLE_BYID,params);
			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"根据ID:"+moduleID+"获取报表标题的响应:"+result);
			return result;
		} catch (Exception e) {
			U.logger.error("获取IDC报表查询条件数据异常",e);
		}
		return null; 
	}
	/**
	 * 获取ID 获取IDC返回的报表标题
	 * @param request
	 * @return
	 */
	@RequestMapping("/idcTitleByName")
	@ResponseBody
	public String idcTitleByName(HttpServletRequest request){
		
		try {
			Map<String,String> params = new HashMap<String,String>();
			String queryName = request.getParameter("queryName");
			params.put("queryName",queryName); 
			//用于记录日志
			String url = HTTP_IDCQUERYTITLE_BYNAME; 
			String requestUrl = requestUrl(url,params);
			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"根据名称:"+queryName+"获取报表标题的请求:"+requestUrl);
			String result = HttpUtils.doGet(HTTP_IDCQUERYTITLE_BYNAME,params);
			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"根据名称:"+queryName+"获取报表标题的响应:"+result);
			return result;
		} catch (Exception e) {
			U.logger.error("获取IDC报表查询条件数据异常",e);
		}
		return null; 
	}
	
	/**
	 * 获取IDC返回的图形 报表内容
	 * @param request
	 * @return
	 */
	@RequestMapping("/idcEchartMsg")
	@ResponseBody
	public String idcEchartMsg(HttpServletRequest request){
		try {
			 Map<String,String> params = new HashMap<String,String>();
			
			//用于记录日志
			params = setMapByPar(request,params);
			String url = HTTP_IDCQUERYDATA_CHART; 
 			String requestUrl = requestUrl(url,params);
 			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"获取图形报表参数名为:"+params.get("queryName")+"内容的请求:"+requestUrl);
			String result = HttpUtils.doGet(HTTP_IDCQUERYDATA_CHART,params);
			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"获取图形报表参数名为:"+params.get("queryName")+"内容的响应:"+result);
			return result; 
			/*
			try {
				String filePath = "d:/echart.txt";
				String encoding="UTF-8"; 
				File file=new File(filePath);
				if(file.isFile() && file.exists()){ //判断文件是否存在
				    InputStreamReader read = new InputStreamReader(new FileInputStream(file),encoding);//考虑到编码格式
				    BufferedReader bufferedReader = new BufferedReader(read);
				    String jsonStr = "";
				    String lineTxt = null; 
				    while((lineTxt = bufferedReader.readLine()) != null){
				    	jsonStr +=lineTxt.trim();
				    } 
	  			    List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
	 			   Map<String,Object> map = new HashMap<String,Object>();
	 			   map.put("chartType", "bar");
	 			   map.put("chartOption", jsonStr);
	 			   
	 			  Map<String,Object> map2 = new HashMap<String,Object>();
				   map2.put("chartType", "bar");
				   map2.put("chartOption", jsonStr);
				   
				   list.add(map2);
				   list.add(map);
	 			    String s = Egox.egoxOk().setDataList(list).toString();
	 			    String r = Egox.egoxOk().set("data", s).toString();
	 			   System.out.println(r);
	 			    return r;
				}
			}catch (Exception e) {
				 U.logger.error("获取IDC报表查询数据异常",e);
			
			}*/
			
			
		} catch (Exception e) {
			U.logger.error("获取IDC报表数据异常",e);
		}
		return null;
	}
	
	
	
	
	/**
	 * 获取IDC返回的统计 报表内容
	 * @param request
	 * @return
	 */
	@RequestMapping("/idcReportMsg")
	@ResponseBody
	public String idcReportMsg(HttpServletRequest request){
		return idcData(request);
	}
	
	
	public  String  idcData(HttpServletRequest request){
		try {
			Map<String,String> params = new HashMap<String,String>();
			params = setMapByPar(request,params);
			//用于记录日志
			String url = HTTP_IDCQUERYDATA; 
			String requestUrl = requestUrl(url,params);
 			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"获取统计报表参数名为:"+params.get("queryName")+"内容的请求:"+requestUrl);
			String result = HttpUtils.doGet(HTTP_IDCQUERYDATA,params);
			EgolmLogger.IdcLogger.info("用户:"+SecurityContextUtil.getUserName()+"获取统计报表参数名为:"+params.get("queryName")+"内容的响应:"+result);
			return result;
		} catch (Exception e) {
			U.logger.error("获取IDC报表数据异常",e);
		}
		return null;
		 
	}
	
	
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	/*@RequestMapping("/loadMsg")
	public void loadMsg(HttpServletRequest request,Writer writer, @ModelAttribute("page")PageSqlserver page){
		String sReportSortField = request.getParameter("sReportSortField"); //排序字段
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
			page.setLimitKey(sReportSortField);
		} 
		
		String nAgentID = SecurityContextUtil.getUserId();
		String menuId = request.getParameter("menuId");
		
		Map<String,String> params = new HashMap<String,String>();
		
		params= setMapByPar(request,params);
		if(U.isNotEmpty(nAgentID)){
			if(StringUtil.isInt(nAgentID.trim())){
				params.put("nAgentID", nAgentID);	
			} 
		} 
		
		Map<String,Object> dataMap = reportEChartsQueryApi.queryReportSQLData(params, menuId, page);
		
		boolean result = (boolean)dataMap.get("IsValid");
		if(result){
			List<Map<String,Object>> dataList = (List<Map<String,Object>>)dataMap.get("DataList");
			page = U.objTo(dataMap.get("page"), PageSqlserver.class);
			String sReportTitle = (String) dataMap.get("sReportTitle");
			Egox.egoxOk().setDataList(dataList).set("page", page).set("sReportTitle", sReportTitle).write(writer);			
		}else{
			Egox.egoxErr().setReturnValue("数据统计异常").write(writer);
		}
	}*/ 
	
	@RequestMapping(value="/exportExcel")
	public void exportExcel(HttpServletRequest request,HttpServletResponse response){
		String sMenuName = request.getParameter("sMenuName");
		if(!U.isNotEmpty(sMenuName)){
			sMenuName = System.nanoTime()+"";
		}else{
			try {
				  sMenuName = URLDecoder.decode(sMenuName, "UTF-8"); 
				} catch (Exception e) { 
				U.logger.error("报表菜单名称转码失败",e);
				sMenuName = System.nanoTime()+"";
			}
		}
	
		
		Gson gson = new Gson();
		String idcJson = idcData(request);
		LinkedHashMap<String,Object> allLikedMap = gson.fromJson(idcJson, LinkedHashMap.class);
		 
		Map<String,Object> dataObject = (Map<String,Object>)allLikedMap.get("data");
		
		//标题MAY 
		Map<String,Object> dictionaryObj = (Map<String,Object>)dataObject.get("dictionary");
 		
		String[] titles = new String[dictionaryObj.size()]; //标题
 		String[] columns=new String[dictionaryObj.size()];  //列名
		
		
		//集合MAP
		List<Map<String,Object>> dataList = (List<Map<String,Object>>)dataObject.get("dataList");
		  
		 
		if(dataList != null && dataList.size()>0){
			int i =0;
			Map<String,Object> titleMap = dataList.get(0); //取出集合中的一条，设置标题的顺序
			for(Map.Entry<String,Object> titleM:titleMap.entrySet()){
				String key = titleM.getKey();
				String value = dictionaryObj.get(key)+"";
				if(dictionaryObj.containsKey(key)){
					titles[i]=value;
					columns[i]=key;
 					i++;
				}
			}
			
			
 		   OutputStream out=null;
		   try {
			  	out = response.getOutputStream();// 取得输出流   
		        response.reset();// 清空输出流  
		        response.setHeader("Content-disposition", "attachment; filename="+new String(sMenuName.getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		        response.setContentType("application/msexcel");// 定义输出类型
		   }  catch (IOException e) {
			  		e.printStackTrace();
		   }  
 		   
 	 	   try  {
 			  Excel.excel(out, columns, titles, null, dataList);
			  out.close();
		   } catch (Exception e1)  {
			  e1.printStackTrace();
		   }  
		}				
	}
	 
	/**
	 * 设置请求参数
	 * @param request
	 * @param params
	 * @return
	 */
	public Map<String,String> setMapByPar(HttpServletRequest request,Map<String, String> params){
		Enumeration<String> parEnu = request.getParameterNames();
		while(parEnu.hasMoreElements()){
	    	String key = (String)parEnu.nextElement();
	    	String value = request.getParameter(key);
	    	 
	    	params.put(key,value.trim());	 
	    	 	    	
	    }
		return params;
	}
	
	/*
	 * 拼装请求的URL  用于记日志
	 */
	public String requestUrl(String url, Map<String, String> params){
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
	    return url;
	}
	@RequestMapping("/print")
	public ModelAndView print(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/report/print.jsp");
		Map<String, Object> params = ServletUtil.readReqMap(request);
		if (MapUtils.isEmpty(params)) {
			params = Maps.newHashMap();
		}
		mv.addObject("params", params);
		return mv;
	}
	
	public static void main(String[] args) {
		try {
			String filePath = "d:/echart.txt";
			String encoding="UTF-8"; 
			File file=new File(filePath);
			if(file.isFile() && file.exists()){ //判断文件是否存在
			    InputStreamReader read = new InputStreamReader(new FileInputStream(file),encoding);//考虑到编码格式
			    BufferedReader bufferedReader = new BufferedReader(read);
			    String jsonStr = "";
			    String lineTxt = null; 
			    while((lineTxt = bufferedReader.readLine()) != null){
			    	jsonStr +=lineTxt.trim();
			    } 
  			    List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
 			   Map<String,Object> map = new HashMap<String,Object>();
 			   map.put("chartType", "bar");
 			   map.put("chartOption", jsonStr);
 			   
 			  Map<String,Object> map2 = new HashMap<String,Object>();
			   map2.put("chartType", "bar");
			   map2.put("chartOption", jsonStr);
			   
			   list.add(map2);
			   list.add(map);
 			    String s = Egox.egoxOk().setDataList(list).toString();
 			    String r = Egox.egoxOk().set("data", s).toString();
 			   System.out.println(r);
 			    
			}
		}catch (Exception e) {
			 U.logger.error("获取IDC报表查询数据异常",e);
		
		}
	}
}
