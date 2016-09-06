package com.egolm.sales.web;

import java.io.Writer;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.domain.TSalesManDailyLine;
import com.egolm.sales.api.line.SalesManDailyLineApi;
import com.egolm.sales.api.line.SalesManTemplateApi;
import com.google.common.collect.Maps;

/**
 * @author yf
 * @version wx3.0
 * @2016年8月19日上午10:39:57
 */
@Controller
@RequestMapping(value = "/salesman")
public class SalesManLineManagerController {

	private static final Logger logger = LoggerFactory.getLogger(SalesManLineManagerController.class);
	
	@Autowired
	SalesManDailyLineApi salesManDailyLineApi;
	
	@Autowired
	SalesManTemplateApi salesManTemplateApi;
	
	/**
	 * 查询所有线路
	 * @return
	 */
	@RequestMapping(value = "/lineList")
	public ModelAndView lineList(Writer writer,@ModelAttribute("page") PageSqlserver page,HttpServletRequest request){
		logger.debug("into lineList method...");
		ModelAndView mv = new ModelAndView("/sales/line_list.jsp");
		Map<String, Object> params = Maps.newHashMap();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateTime DESC");
		}
		String sSalParam = request.getParameter("sSalParam");
		if(StringUtils.isNotBlank(sSalParam)){
			params.put("sSalParam", sSalParam.trim());
		}
		Map<String, Object> datas = salesManDailyLineApi.findAllLines(page,params);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		return mv;
	}
	
	/**
	 * 添加线路
	 * @return
	 */
	@RequestMapping(value = "/toAddLine",method = RequestMethod.POST)
	@ResponseBody
	public String toAddLine(HttpServletRequest request,TSalesManDailyLine tSalesManDailyLine){
		String maxId = salesManDailyLineApi.findMaxId();
		if(StringUtils.isNotBlank(maxId)){
			tSalesManDailyLine.setsLineId(Integer.parseInt(maxId)+1+"");
		}else{
			tSalesManDailyLine.setsLineId("1");
		}
		salesManDailyLineApi.addLine(tSalesManDailyLine);
		return "{\"isValid\":true}";
	}
	
	/**
	 * 删除线路数据
	 */
	@RequestMapping(value = "/cleanLinesMan")
	public void cleanLinesMan(@RequestParam String sLineId,Writer writer){
		logger.debug("sLineId="+sLineId);
		int result = salesManDailyLineApi.deleteLineById(sLineId);
		if(result>=0){
			Egox.egox().setReturnValue("删除线路成功").setIsValid(true).write(writer);
		}else{
			Egox.egox().setReturnValue("删除线路失败").setIsValid(false).write(writer);
		}
	}
	
	@RequestMapping(value = "/toEditLine")
	public ModelAndView toEditLine(@RequestParam String sLineId,Writer writer){
		logger.debug("into toEditLine method...");
		logger.debug("sLineId="+sLineId);
		ModelAndView mv = new ModelAndView("/sales/line_edit.jsp");
		TSalesManDailyLine tSalesManDailyLine = salesManDailyLineApi.findLineById(sLineId);
		if(tSalesManDailyLine!=null){
			mv.addObject("tSalesManDailyLine", tSalesManDailyLine);
			return mv;
		}else{
			return mv;
		}
	}
	
	@RequestMapping(value = "/updateLine")
	public void updateLine(TSalesManDailyLine tSalesManDailyLine,Writer writer){
		logger.debug("into updateLine method...");
		int result = salesManDailyLineApi.updateLine(tSalesManDailyLine);
		if(result>=0){
			Egox.egoxOk().setReturnValue("修改线路成功").setIsValid(true).write(writer);;
		}else{
			Egox.egoxErr().setReturnValue("修改线路失败").setIsValid(false).write(writer);
		}
	}
}
