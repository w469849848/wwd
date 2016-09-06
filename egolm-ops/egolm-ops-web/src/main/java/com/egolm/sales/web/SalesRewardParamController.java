package com.egolm.sales.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.domain.TSalesRewardParam;
import com.egolm.sales.api.SalesRewardParamAddApi;
import com.egolm.sales.api.SalesRewardParamCleanApi;
import com.egolm.sales.api.SalesRewardParamQueryApi;
import com.egolm.sales.api.SalesRewardParamUpdateApi;
import com.egolm.util.ExportExcelUtil;

/**
 * @Title: SalesmanController.java 
 * @Package com.egolm.sales.web 
 * @Description: 奖励参数管理
 * @author yjie
 * @date 2016年5月1日 下午11:11:05
 */
@Controller
@RequestMapping("/salesreward")
public class SalesRewardParamController {
	
	@Resource(name = "salesRewardParamQueryApi")
	private SalesRewardParamQueryApi salesRewardParamQueryApi;
	
	@Resource(name = "salesRewardParamAddApi")
	private SalesRewardParamAddApi  salesRewardParamAddApi;
	
	@Resource(name = "salesRewardParamUpdateApi")
	private SalesRewardParamUpdateApi  salesRewardParamUpdateApi;
	
	@Resource(name = "salesRewardParamCleanApi")
	private SalesRewardParamCleanApi  salesRewardParamCleanApi;
	
	@RequestMapping("/toSalesRewardParamList")
	public ModelAndView toSalesRewardParamList(@ModelAttribute("page") PageSqlserver pageParam,String sRoyaltyType,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		if (pageParam == null || pageParam.getLimitKey() == null) {
			pageParam.setLimit(10);
			pageParam.setLimitKey("nSalRoyID DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sRoyaltyType)){
			paramMap.put("sRoyaltyType",sRoyaltyType);
		}
		Map<String, Object> datas = salesRewardParamQueryApi.querySalesRewardParams(paramMap, pageParam);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sRoyaltyType", sRoyaltyType);
		mv.setViewName("/sales/reward_param_list");
		return mv;
	}
	
	@RequestMapping("/toAddSalesRewardParam")
	public String toAddSalesRewardParam(HttpServletRequest request) {
		
		
		return "/sales/reward_param_add";
	}
	
	@RequestMapping("/toEditSalesRewardParam")
	public ModelAndView toEditSalesRewardParamagentEdit(Integer nSalRoyID,String type,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		TSalesRewardParam salesRewardParam = salesRewardParamQueryApi.queryTSalesRewardParamById(nSalRoyID);
		request.setAttribute("reward", salesRewardParam);
		request.setAttribute("type", type);
		mv.addObject("reward", salesRewardParam);
		mv.addObject("type", type);
		mv.setViewName("/sales/reward_param_edit");
		
		return mv;
	}
	
	@RequestMapping("/saveSalesRewardParam")
	public void saveSalesRewardParam(TSalesRewardParam tSalesRewardParam ,HttpServletRequest request,Writer writer) {
		tSalesRewardParam.setNTag(1);
		tSalesRewardParam.setNSalRoyID(3);
		tSalesRewardParam.setSOrgName("22222");
		tSalesRewardParam.setDCreateTime(new Date());
		tSalesRewardParam.setNCreateUserID(11);
		tSalesRewardParam.setDModifyTime(new Date());
		Map<String, Object> returnMsg = salesRewardParamAddApi.createTSalesRewardParam(tSalesRewardParam);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping("/updateSalesRewardParam")
	public void updateSalesRewardParam(TSalesRewardParam tSalesRewardParam,HttpServletRequest request,Writer writer) {
		TSalesRewardParam tSales_Man = salesRewardParamQueryApi.queryTSalesRewardParamById(tSalesRewardParam.getNSalRoyID());
		tSales_Man.setNTag(1);
		tSales_Man.setDCreateTime(new Date());
		tSales_Man.setNCreateUserID(11);
		tSales_Man.setDModifyTime(new Date());
		tSales_Man.setSModifyUserName("周杰伦");
		Map<String, Object> returnMsg = salesRewardParamUpdateApi.updateTSalesRewardParam(tSales_Man);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping("/cleanSalesRewardParam")
	public void cleanSalesRewardParam(Integer nSalRoyID,HttpServletRequest request,Writer writer) {
		Map<String, Object> returnMsg = salesRewardParamCleanApi.cleanTSalesRewardParam(nSalRoyID);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping(value="/exprotExcel")
    @ResponseBody 
    public String exprotExcel(HttpServletResponse response,@ModelAttribute("page") PageSqlserver pageParam,String sSalChineseName,HttpServletRequest request) {
		if (pageParam == null || pageParam.getLimitKey() == null) {
			pageParam.setLimit(10);
			pageParam.setLimitKey("nSalID DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sSalChineseName)){
			paramMap.put("sSalChineseName",sSalChineseName);
		}
		ExportExcelUtil<TSalesRewardParam> excelUtil=new ExportExcelUtil<TSalesRewardParam>();
		  OutputStream out=null;
		  try {
			  		 out = response.getOutputStream();// 取得输出流   
		             response.reset();// 清空输出流  
		             response.setHeader("Content-disposition", "attachment; filename="+new String("奖励参数列表".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		             response.setContentType("application/msexcel");// 定义输出类型
		  }  catch (IOException e) {
			  		e.printStackTrace();
		  }  
		  String[] headers ={"业务区域","提成方式","提成比例","创建时间","修改时间","备注","状态"};
		  String[]columns={ "sBizZone", "sRoyaltyType", "nRoyaltyRate", "dCreateTime","dModifyTime", "sMemo", "nTag"};
		  List<TSalesRewardParam> dataset = salesRewardParamQueryApi.querySalesRewardParamsOfExcel(paramMap, pageParam);
		  try  {
			  excelUtil.exportExcel("奖励参数列表", headers, columns, dataset, out, "");
			  out.close();
		  } catch (Exception e1)  {
			  e1.printStackTrace();
		  }
		  return null;
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	
}
