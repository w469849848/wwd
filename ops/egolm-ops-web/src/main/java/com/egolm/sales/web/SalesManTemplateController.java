package com.egolm.sales.web;

import java.io.Writer;
import java.util.Map;

import javax.annotation.Resource;
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

import com.egolm.domain.TSalesManTemplate;
import com.egolm.sales.api.line.SalesManTaskApi;
import com.egolm.sales.api.line.SalesManTemplateApi;
import com.google.common.collect.Maps;

/**
 * @author yf
 * @version wx3.0
 * @2016年8月19日上午10:32:43
 */
@Controller
@RequestMapping(value = "/salesman")
public class SalesManTemplateController {

	private static final Logger logger = LoggerFactory.getLogger(SalesManTemplateController.class);

	@Autowired
	SalesManTemplateApi salesManTemplateApi;
	
	@Resource
	private SalesManTaskApi salesManTaskApi;
	
	/**
	 * 查询模板列表
	 * @return
	 */
	@RequestMapping(value = "/templateList")
	public ModelAndView findAllTemplates(Writer writer,@ModelAttribute("page") PageSqlserver page,HttpServletRequest request){
		logger.debug("into findAllTemplates method...");
		ModelAndView mv = new ModelAndView("/sales/template_list.jsp");
		Map<String, Object> params = Maps.newHashMap();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateTime DESC");
		}
		String sSalParam = request.getParameter("sSalParam");
		if(StringUtils.isNotBlank(sSalParam)){
			params.put("sSalParam", sSalParam);
		}
		Map<String, Object> datas = salesManTemplateApi.findAllTemplates(page,params);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		return mv;
	}
	
	/**
	 * 添加模板
	 * @return
	 */
	@RequestMapping(value = "/addTemplate")
	public ModelAndView addTemplate(){
		ModelAndView mv = new ModelAndView("/sales/template_add.jsp");
		//查询所有任务
		Map<String, Object> params = Maps.newHashMap();
		Map<String, Object> datas = salesManTaskApi.findAllTasks(null, params);
		mv.addObject("datas", datas);
		return mv;
	}
	
	@RequestMapping(value = "/addTemplate",method = RequestMethod.POST)
	@ResponseBody
	public String addTemplate(TSalesManTemplate tSalesmanTemplate){
		String maxId = salesManTemplateApi.findMaxId();
		if(StringUtils.isNoneBlank(maxId)){
			tSalesmanTemplate.setsTemplateId(Integer.parseInt(maxId)+1);
		}else{
			tSalesmanTemplate.setsTemplateId(1);	
		}
		salesManTemplateApi.addTemplate(tSalesmanTemplate);
		return "{\"isValid\":true}";
	}
	
	@RequestMapping(value = "/cleanTemplateById")
	public void cleanTemplateById(@RequestParam String templateId,Writer writer){
		logger.debug("templateId="+templateId);
		int result = salesManTemplateApi.deleteTemplateById(templateId);
		if(result>=0){
			Egox.egox().setReturnValue("删除模板成功").setIsValid(true).write(writer);;
		}else{
			Egox.egox().setReturnValue("删除模板失败").setIsValid(false).write(writer);;
		}
	}

	@RequestMapping(value = "/toEditTemplate")
	public ModelAndView toEditTemplate(@RequestParam String sTemplateId){
		logger.debug("sTemplateId="+sTemplateId);
		//查询所有任务
		Map<String, Object> datas = salesManTaskApi.findAllTasks(null, null);
		ModelAndView mv = new ModelAndView("/sales/template_edit.jsp");
		TSalesManTemplate tSalesmanTemplate = salesManTemplateApi.findTemplateById(sTemplateId);
		mv.addObject("tSalesmanTemplate", tSalesmanTemplate);
		mv.addObject("datas", datas);
		return mv;
	}
	
	@RequestMapping(value = "/updateTemplate")
	public void updateTemplate(TSalesManTemplate tSalesmanTemplate,Writer writer){
		int result = salesManTemplateApi.updateTemplate(tSalesmanTemplate);
		if(result>=0){
			Egox.egoxOk().setReturnValue("修改模板成功").setIsValid(true).write(writer);;
		}else{
			Egox.egoxOk().setReturnValue("修改模板失败").setIsValid(false).write(writer);;
		}
	}
}
