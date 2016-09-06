package com.egolm.report.web;

import java.io.Writer;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.egolm.common.enums.UserType;
import com.egolm.report.api.TCustAccessLogQueryApi;
import com.egolm.report.api.TCustTrafficAnalysisQueryApi;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * 店铺流量统计
 * @author zhangyong
 *
 */
@Controller 
@RequestMapping("/data/shopFlowReport")
public class TrafficAnalysisController {

	@Resource(name = "tCustAccessLogQueryApi")
	TCustAccessLogQueryApi tCustAccessLogQueryApi;
	@Resource(name = "tCustTrafficAnalysisQueryApi")
	TCustTrafficAnalysisQueryApi tCustTrafficAnalysisQueryApi;
	
	
	@RequestMapping("/index")
	public String flowIndexPage(){
		return "/report/traffic-analysis.jsp";
	}
	
	
	public void loadShopType(){
		
	}
	
	
	/**
	 * 统计今日、昨日、上周同期、前7天日均
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/loadDateFlow")
	public void loadDateFlow(HttpServletRequest request,Writer writer){
		String sScopeTypeID = request.getParameter("sScopeTypeID");
		String sAccessMode = request.getParameter("sAccessMode"); //
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("sOrgsNO", SecurityContextUtil.getRegionId());
		params.put("selectTime",DateUtil.formatDate(new Date()));
		params.put("sAccessMode",sAccessMode); //终端类型 
		params.put("sScopeTypeID", sScopeTypeID); //店铺类型
		
	    if(SecurityContextUtil.getUserType().oneOf(UserType.AGENT)){
	    	params.put("nAgentID", SecurityContextUtil.getUserId());
	    }
		
		JSONArray jsonStrs = new JSONArray();
		 
		 //当日的结果
		 Map<String,Object>  sameDayMap=null;
				 
		Map<String, Object> resultMap =  this.tCustAccessLogQueryApi.queryTCustAccessLog(params);
		boolean result = (boolean)resultMap.get("IsValid");
		if(result){
			sameDayMap=(Map<String,Object>)resultMap.get("DataList");
			sameDayMap.put("dayName", "今日");
			 jsonStrs.add(sameDayMap); 
		}else{ 
		}
		
		//昨日的结果
		Map<String,Object> yesterdayParams = new HashMap<String,Object>();
		yesterdayParams.put("sOrgsNO", SecurityContextUtil.getRegionId());
		yesterdayParams.put("selectTime",DateUtil.format(DateUtil.day(new Date(), -1), DateUtil.FMT_DATE));   
		yesterdayParams.put("sAccessMode",sAccessMode);
		params.put("sScopeTypeID", sScopeTypeID); //店铺类型
		Map<String, Object> yesterdayMap = tCustTrafficAnalysisQueryApi.queryTCustTrafficAnalysis(yesterdayParams); 
		boolean yesterdayResult = (boolean)yesterdayMap.get("IsValid");
		if(yesterdayResult){
			 List<Map<String,Object>> yesListMap=(List<Map<String,Object>>)yesterdayMap.get("DataList");
			 if(yesListMap != null && yesListMap.size()>0){
				 Map<String,Object> yesMap = yesListMap.get(0);
				 yesMap.put("dayName", "昨日");
				 System.out.println("昨日的结果=="+yesMap);
				 jsonStrs.add(yesMap); 
			 } 
			 
		}else{ 
		}
		
		//上周同期的结果
		Map<String,Object> lastWeekParams = new HashMap<String,Object>();
		lastWeekParams.put("sOrgsNO", SecurityContextUtil.getRegionId());
		lastWeekParams.put("selectTime",DateUtil.format(DateUtil.day(new Date(), -7), DateUtil.FMT_DATE)); 
		lastWeekParams.put("sAccessMode",sAccessMode);
		params.put("sScopeTypeID",sScopeTypeID); //店铺类型
		Map<String, Object> lastWeekyMap = tCustTrafficAnalysisQueryApi.queryTCustTrafficAnalysis(lastWeekParams); 
		boolean lastWeekResult = (boolean)lastWeekyMap.get("IsValid");
		if(lastWeekResult){
			List<Map<String,Object>> lastWeekListMap=(List<Map<String,Object>>)lastWeekyMap.get("DataList");
			if(lastWeekListMap != null && lastWeekListMap.size()>0){
				 Map<String,Object> lastWeekMap = lastWeekListMap.get(0);
				 lastWeekMap.put("dayName", "上周同期");
				 System.out.println("上周同期的结果=="+lastWeekMap);
				 jsonStrs.add(lastWeekMap);
			 }  
		}else{
			 
		}
		
		
		//前6天的总合
		Map<String,Object> sixDayParams = new HashMap<String,Object>();
		sixDayParams.put("sOrgsNO", SecurityContextUtil.getRegionId());
 		sixDayParams.put("sAccessMode",sAccessMode);
		Map<String, Object> sixDayMap = tCustTrafficAnalysisQueryApi.queryTCustTrafficAnalysisBySixDay(sixDayParams); 
 		boolean sixDayResult = (boolean)sixDayMap.get("IsValid");
		if(sixDayResult){
			List<Map<String,Object>> sixDayListMap=(List<Map<String,Object>>)sixDayMap.get("DataList");
 			if(sixDayListMap != null && sixDayListMap.size()>0){
				 Map<String,Object> sixDayRMap = sixDayListMap.get(0);
				
				 System.out.println("前6天的总合=="+sixDayRMap);
				 Map<String,Object> avgMap = new HashMap<String,Object>();
				 avgMap.put("dayName", "前7天日均");	
				 avgMap.put("sOrgsNO", SecurityContextUtil.getRegionId());
				 avgMap.put("sAccessMode",sAccessMode);
				 if(sameDayMap != null){ //当日不为空，计算7天的平均
					 Integer pv = To.objTo(sameDayMap.get("pv"), Integer.class, 0) + To.objTo(sixDayRMap.get("pv"), Integer.class, 0);
					 Integer uv = To.objTo(sameDayMap.get("uv"), Integer.class, 0) + To.objTo(sixDayRMap.get("uv"), Integer.class, 0);
					 Integer ip = To.objTo(sameDayMap.get("ip"), Integer.class, 0) + To.objTo(sixDayRMap.get("ip"), Integer.class, 0);
					 BigDecimal bounceRate = To.objTo(sameDayMap.get("bounceRate"), BigDecimal.class, new BigDecimal(0)).add(To.objTo(sixDayRMap.get("bounceRate"), BigDecimal.class, new BigDecimal(0)));
					 BigDecimal siteVisitDepth = To.objTo(sameDayMap.get("siteVisitDepth"), BigDecimal.class, new BigDecimal(0)).add(To.objTo(sixDayRMap.get("siteVisitDepth"), BigDecimal.class, new BigDecimal(0)));
					 BigDecimal custTakeRates = To.objTo(sameDayMap.get("custTakeRates"), BigDecimal.class, new BigDecimal(0)).add(To.objTo(sixDayRMap.get("custTakeRates"), BigDecimal.class, new BigDecimal(0)));
					 avgMap.put("pv", pv/7);
					 avgMap.put("uv", uv/7);
					 avgMap.put("ip", ip/7);
					 avgMap.put("custTakeRates", custTakeRates.divide(new BigDecimal(7),2));
					 avgMap.put("siteVisitDepth", siteVisitDepth.divide(new BigDecimal(7),2));
					 avgMap.put("bounceRate", bounceRate.divide(new BigDecimal(7),2));
					 jsonStrs.add(avgMap);
				 } 
			 }  
		}else{
			 
		}
		 Egox.egoxOk().setDataList(jsonStrs).write(writer);
	}
	
	/**
	 * 统计最近7天被访问的宝贝TOP10
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/loadTopTenGoods")
	public void loadTopTenGoods(HttpServletRequest request,Writer writer){
		String sScopeTypeID = request.getParameter("sScopeTypeID");
		String sAccessMode = request.getParameter("sAccessMode"); //
		
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("sOrgsNO", SecurityContextUtil.getRegionId());
		params.put("selectTime",DateUtil.formatDate(new Date()));
		params.put("sAccessMode",sAccessMode);   //终端类型 
		params.put("sScopeTypeID", sScopeTypeID); //店铺类型
		params.put("nAgentID", SecurityContextUtil.getUserId()); //经销商ID
		
		 Map<String, Object> dataMap = tCustAccessLogQueryApi.queryTopTenGoods(params);
		 boolean result = (boolean)dataMap.get("IsValid");
		 if(result){
			 List<Map<String,Object>> resultList=(List<Map<String,Object>>)dataMap.get("DataList");
			 Egox.egoxOk().setDataList(resultList).write(writer);
		 }else{
			 Egox.egoxErr().setReturnValue("统计最近7天被访问的宝贝TOP10失败").write(writer);
		 }
	}
	/**
	 * 统计首页最近7天访客地区TOP10   
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/loadTopTenZone")
	public void loadTopTenZone(HttpServletRequest request,Writer writer){
		String sScopeTypeID = request.getParameter("sScopeTypeID"); 
		String sAccessMode = request.getParameter("sAccessMode"); //
		Map<String,Object> params = new HashMap<String,Object>();
 		params.put("sAccessMode",sAccessMode);  //终端类型
		params.put("sScopeTypeID", sScopeTypeID); //店铺类型 
		 Map<String, Object> dataMap = tCustAccessLogQueryApi.queryTopTenZone(params);
		 boolean result = (boolean)dataMap.get("IsValid");
		 if(result){
			 List<Map<String,Object>> resultList=(List<Map<String,Object>>)dataMap.get("DataList");
			 Egox.egoxOk().setDataList(resultList).write(writer);
		 }else{
			 Egox.egoxErr().setReturnValue("统计首页最近7天访客地区TOP10失败").write(writer);
		 }
	}
	
	
	
	@RequestMapping("/loadLineMsg")
   public void loadLineMsg(HttpServletRequest request,Writer writer){
		String sScopeTypeID = request.getParameter("sScopeTypeID");
		String  selectDateType = request.getParameter("selectDateType");  //查询日期类型 
		String sAccessMode = request.getParameter("sAccessMode"); // 终端类型
		if(selectDateType.equals("day")){   //按天查询

			String[] dateTimeStr = new String[7];
			String[] pvStr = new String[7];
			String[] uvStr = new String[7];
			String[] ipStr = new String[7];
			 
			
			//前6天的PV,UV,IP
			Map<String,Object> sixdayParams = new HashMap<String,Object>();
			sixdayParams.put("sOrgsNO", SecurityContextUtil.getRegionId());
			sixdayParams.put("selectDate",6);   
			sixdayParams.put("sAccessMode",sAccessMode);
			sixdayParams.put("sScopeTypeID", sScopeTypeID); //店铺类型
			Map<String, Object> sixdayMap = tCustTrafficAnalysisQueryApi.querySixTCustTrafficAnalysis(sixdayParams); 
			boolean sixdayResult = (boolean)sixdayMap.get("IsValid");
			if(sixdayResult){
				 List<Map<String,Object>> sixListMap=(List<Map<String,Object>>)sixdayMap.get("DataList");
				 System.out.println("前6天天的PV :"+sixdayMap);
				 if(sixListMap != null && sixListMap.size()>0){
					 for(int i = 0;i<sixListMap.size();i++){
						 Map<String,Object> mapList = sixListMap.get(i);
						 dateTimeStr[i]=mapList.get("sixTime")+"";
						 pvStr[i]=mapList.get("pv")+"";
						 uvStr[i]=mapList.get("uv")+"";
						 ipStr[i]=mapList.get("ip")+""; 
					 }
				 } 
			}else{ 
			} 
			
			//当天的PV ,UV ,IP
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("sOrgsNO", SecurityContextUtil.getRegionId());
			params.put("selectTime",DateUtil.formatDate(new Date()));
			params.put("sAccessMode",sAccessMode);
			params.put("sScopeTypeID", sScopeTypeID); //店铺类型
		
			Map<String, Object> resultMap =  this.tCustAccessLogQueryApi.querySameDayPvUvIp(params);
			boolean result = (boolean)resultMap.get("IsValid");
			if(result){
				 Map<String,Object> sameDayMap=(Map<String,Object>)resultMap.get("DataList");   //{indexPv=0, indexUv=0, ip=0}
				 System.out.println("当天的PV :"+sameDayMap);  
				 /*sameDayMap.put("dateTime", DateUtil.format(new Date(), DateUtil.FMT_DATE));
				 jsonStrs.add(sameDayMap);*/
				 dateTimeStr[6]  =DateUtil.format(new Date(), DateUtil.FMT_DATE)+"";
				 pvStr[6]  =sameDayMap.get("pv")+"";
				 uvStr[6]  =sameDayMap.get("uv")+"";
				 ipStr[6]  =sameDayMap.get("ip")+"";
				 
			}else{ 
			}
			JSONArray jsonStrs = new JSONArray();
			Map<String,Object> returnMap = new HashMap<String,Object>();
			 
			returnMap.put("xAxis", dateTimeStr);
			returnMap.put("pv", pvStr);
			returnMap.put("uv", uvStr);
			returnMap.put("ip", ipStr);
			jsonStrs.add(returnMap);
			Egox.egoxOk().setDataList(jsonStrs).write(writer);
		}
		
		
		if(selectDateType.equals("hour")){  //按小时查询
			
			
			
		    String hh = DateUtil.format(new Date(), DateUtil.FMT_HH);   //当天 的小时
		    int hour = To.objTo(hh, Integer.class, 0)+1;
		    String[] dateTimeStr = new String[hour];
			String[] pvStr = new String[hour];
			String[] uvStr = new String[hour];
			String[] ipStr = new String[hour];
			 
			
			Map<String,Object> params = new HashMap<String,Object>();
			params.put("sOrgsNO", SecurityContextUtil.getRegionId()); 
			params.put("sAccessMode",sAccessMode);
			params.put("sScopeTypeID", sScopeTypeID); //店铺类型
		
			Map<String, Object> resultMap =  this.tCustAccessLogQueryApi.queryTCustAccessLogByHours(params);
			boolean result = (boolean)resultMap.get("IsValid");
			if(result){
				 List<Map<String,Object>>  dataList=(List<Map<String,Object>>)resultMap.get("DataList");   //{indexPv=0, indexUv=0, ip=0}
				 System.out.println("按小时的  :"+dataList);  
			     
				 if(dataList != null && dataList.size()>0){
					 for(int i=0;i<hour;i++){
						 boolean isExists = false;
						 for(Map<String,Object> data:dataList){
							 String selectHour = data.get("selectHour")+"";
							 if(selectHour.equals(i+"")){
								 isExists = true;
								 dateTimeStr[i]  =selectHour+"时";
								 pvStr[i]  =data.get("pv")+"";
								 uvStr[i]  =data.get("uv")+"";
								 ipStr[i]  =data.get("ip")+"";
							 }
						 }
						 if(!isExists){
							 dateTimeStr[i]  =i+"时";
							 pvStr[i]  ="0";
							 uvStr[i]  ="0";
							 ipStr[i]  ="0";
						 }
					 }
				 }else{
					 for(int i=0;i<hour;i++){
						 dateTimeStr[i]  =i+"时";
						 pvStr[i]  ="0";
						 uvStr[i]  ="0";
						 ipStr[i]  ="0";
					 }
				 }
			}else{
				for(int i=0;i<hour;i++){
					 dateTimeStr[i]  =i+"";
					 pvStr[i]  ="0";
					 uvStr[i]  ="0";
					 ipStr[i]  ="0";
				 }
			}
			JSONArray jsonStrs = new JSONArray();
			Map<String,Object> returnMap = new HashMap<String,Object>();
			 
			returnMap.put("xAxis", dateTimeStr);
			returnMap.put("pv", pvStr);
			returnMap.put("uv", uvStr);
			returnMap.put("ip", ipStr);
			jsonStrs.add(returnMap);
			Egox.egoxOk().setDataList(jsonStrs).write(writer);
		}
		
   }
	
	public static void main(String[] args) {
		 Date startTime = DateUtil.start(new Date());
		 for(long i = 0; i < 24; i++) {
			 Date currentTime = new Date(startTime.getTime() + (i*1000*60*60));
			 System.out.println(U.format(currentTime));
		 }
		 
		 String hh = DateUtil.format(new Date(), DateUtil.FMT_HH);
		 System.out.println(hh);
	}
}
