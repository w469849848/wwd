package com.egolm.sales.web;

import java.io.Writer;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

import com.egolm.domain.TSalesManTask;
import com.egolm.sales.api.line.SalesManTaskApi;
import com.google.common.collect.Maps;

/**
 * @author yf
 * @version wx3.0
 * @2016年8月19日上午10:28:53
 */
@Controller
@RequestMapping(value = "/salesman")
public class SalesManTaskController {

	private static final Logger logger = LoggerFactory.getLogger(SalesManTaskController.class);

	@Resource
	private SalesManTaskApi salesManTaskApi;
	
	/**
	 * 查询任务列表
	 * @param writer
	 * @return
	 */
	@RequestMapping(value = "/taskList")
	public ModelAndView taskList(Writer writer,@ModelAttribute("page") PageSqlserver page,HttpServletRequest request) {
		logger.debug("into findAllTasks method...");
		ModelAndView mv = new ModelAndView("/sales/task_list.jsp");
		Map<String, Object> params = Maps.newHashMap();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateTime DESC");
		}
		String sTaskParam = request.getParameter("sTaskParam");
//		String isEnable = request.getParameter("isEnable");
		if(StringUtils.isNotBlank(sTaskParam)){
			params.put("sSalParam", sTaskParam.trim());
		}
		Map<String, Object> datas = salesManTaskApi.findAllTasks(page,params);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		return mv;
	}
	
	/**
	 * 添加任务
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/addTask")
	public ModelAndView addTask(HttpServletRequest request){
		logger.debug("into addTask method");
		ModelAndView mv = new ModelAndView("/sales/task_add.jsp");
		return mv;
	}
	
	@RequestMapping(value = "/addTask",method = RequestMethod.POST)
	@ResponseBody
	public String addTask(HttpServletRequest request,TSalesManTask tSalesManTask){
		String maxId = salesManTaskApi.findMaxTaskId();
		if(StringUtils.isNotBlank(maxId)){
			tSalesManTask.setsTaskId(maxId.equals(null)?0+"":Integer.parseInt(maxId)+1+"");
			tSalesManTask.setsTaskType(maxId.equals(null)?0+"":Integer.parseInt(maxId)+1+"");
		}else{
			tSalesManTask.setsTaskId(1+"");
			tSalesManTask.setsTaskType(1+"");
		}
		salesManTaskApi.saveTask(tSalesManTask);
		return "{\"isValid\":true}";
	}
	
	@RequestMapping(value = "/cleanTasksMan")
	public void cleanTasksMan(@RequestParam String sTaskId,Writer writer){
		logger.debug("sTaskId="+sTaskId);
		int result = salesManTaskApi.deleteTaskById(sTaskId);
		if(result>=0){
			Egox.egox().setReturnValue("删除任务成功").setIsValid(true).write(writer);
		}else{
			Egox.egox().setReturnValue("删除任务失败").setIsValid(false).write(writer);
		}
	}
	
	@RequestMapping(value = "/toEditTask")
	public ModelAndView toEditTask(@RequestParam String sTaskId){
		logger.debug("sTaskId="+sTaskId);
		ModelAndView mv = new ModelAndView("/sales/task_edit.jsp");
		TSalesManTask tSalesManTask = salesManTaskApi.findTaskByTaskId(sTaskId);
		if(tSalesManTask==null){
			return mv;
		}else{
			mv.addObject("tSalesManTask", tSalesManTask);
			return mv;
		}
	}
	
	@RequestMapping(value = "/updateTaskById")
	public void updateTaskById(TSalesManTask tSalesManTask,Writer writer){
		String sTaskId = tSalesManTask.getsTaskId();
		if(StringUtils.isNotBlank(sTaskId)){
			int result = salesManTaskApi.updateTask(tSalesManTask);
			if(result>=0){
				Egox.egoxOk().setReturnValue("修改任务成功").write(writer);
			}else{
				Egox.egoxOk().setReturnValue("修改任务失败").write(writer);
			}
		}
	}
}
