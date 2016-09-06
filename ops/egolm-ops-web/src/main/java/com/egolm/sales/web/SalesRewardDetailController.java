package com.egolm.sales.web;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.domain.TSalesRewardDetail;
import com.egolm.sales.api.SalesRewardDetailQueryApi;
import com.egolm.util.ExportExcelUtil;

/**
 * @Title: SalesmanController.java 
 * @Package com.egolm.sales.web 
 * @Description: 业务员奖励明细管理
 * @author yjie
 * @date 2016年5月1日 下午11:11:05
 */
@Controller
@RequestMapping("/rewarddetail")
public class SalesRewardDetailController {
	
	@Resource(name = "salesRewardDetailQueryApi")
	private SalesRewardDetailQueryApi salesRewardDetailQueryApi;
	
	@RequestMapping("/toSalesRewardDetailList")
	public ModelAndView toSalesRewardDetailList(@ModelAttribute("page") PageSqlserver pageParam,String sSalNum,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		if (pageParam == null || pageParam.getLimitKey() == null) {
			pageParam.setLimit(10);
			pageParam.setLimitKey("nRewardID DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sSalNum)){
			paramMap.put("sSalNum",sSalNum);
		}
		Map<String, Object> datas = salesRewardDetailQueryApi.querySalesRewardDetails(paramMap, pageParam);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sSalNum", sSalNum);
		mv.setViewName("/sales/salesman_rewarddetail_list");
		return mv;
	}
	
	@RequestMapping("/toDetailSalesRewardDetail")
	public ModelAndView toDetailSalesRewardDetail(Integer nSalesRewardDetailID,String type,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		TSalesRewardDetail salesRewardDetail = salesRewardDetailQueryApi.queryTSalesRewardDetailById(nSalesRewardDetailID);
		request.setAttribute("salesRewardDetail", salesRewardDetail);
		request.setAttribute("type", type);
		mv.addObject("salesRewardDetail", salesRewardDetail);
		mv.addObject("type", type);
		mv.setViewName("/sales/salesman_edit");
		
		return mv;
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
		ExportExcelUtil<TSalesRewardDetail> excelUtil=new ExportExcelUtil<TSalesRewardDetail>();
		  OutputStream out=null;
		  try {
			  		 out = response.getOutputStream();// 取得输出流   
		             response.reset();// 清空输出流  
		             response.setHeader("Content-disposition", "attachment; filename="+new String("业务员奖励明细".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		             response.setContentType("application/msexcel");// 定义输出类型
		  }  catch (IOException e) {
			  		e.printStackTrace();
		  }  
		  String[] headers ={"业务区域","业务员编号","业务员姓名","提成方式","提成比例","总业务额","提成金额","状态"};
		  String[]columns={ "sBizZone", "sSalNum", "sSalName", "sRoyaltyType","nRoyaltyRate", "nTotalBizAmount", "nCommissionAmount","nTag"};
		  List<TSalesRewardDetail> dataset = salesRewardDetailQueryApi.querySalesRewardDetailsOfExcel(paramMap, pageParam);
		  try  {
			  excelUtil.exportExcel("业务员奖励明细", headers, columns, dataset, out, "");
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
