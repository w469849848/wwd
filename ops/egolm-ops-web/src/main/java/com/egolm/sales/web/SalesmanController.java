package com.egolm.sales.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.egolm.common.EgolmException;
import com.egolm.common.enums.UserType;
import com.egolm.customer.api.IShopInfo;
import com.egolm.dealer.api.AgentQueryApi;
import com.egolm.domain.TYWSalesMan;
import com.egolm.member.api.user.UserApi;
import com.egolm.sales.api.SalesManAddApi;
import com.egolm.sales.api.SalesManCleanApi;
import com.egolm.sales.api.SalesManQueryApi;
import com.egolm.sales.api.SalesManUpdateApi;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.util.ExportExcelUtil;
import com.egolm.util.PageUtil;
/**
 * @Title: SalesmanController.java 
 * @Package com.egolm.sales.web 
 * @Description: 业务员管理
 * @author yjie
 * @date 2016年5月1日 下午11:11:05
 */
@Controller
@RequestMapping("/salesman")
public class SalesmanController {
	
	private Logger logger  = LoggerFactory.getLogger(getClass());
	
	@Resource(name = "salesManQueryApi")
	private SalesManQueryApi salesManQueryApi;
	
	@Resource(name = "salesManAddApi")
	private SalesManAddApi  salesManAddApi;
	
	@Resource(name = "salesManUpdateApi")
	private SalesManUpdateApi  salesManUpdateApi;
	
	@Resource(name = "salesManCleanApi")
	private SalesManCleanApi  salesManCleanApi;
	
	@Resource(name = "agentQueryApi")
	private AgentQueryApi agentQueryApi;
	
	@Resource(name = "idShopApi")
	private IShopInfo shopApi;
	
	@Resource
	private UserApi userApi;
	
	@RequestMapping("/toSalesManList")
	public ModelAndView toSalesManList(@ModelAttribute("page") PageSqlserver page,String sSalParam,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateTime DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sSalParamTrim = StringUtils.trim(sSalParam);
		String nTag = request.getParameter("nTag");
		if(StringUtils.isNotBlank(sSalParamTrim)) {
			paramMap.put("sSalChineseName",sSalParamTrim);
			paramMap.put("sSalNum",sSalParamTrim);
		}
		paramMap.put("nTag",nTag);
		
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		Map<String, Object> datas = salesManQueryApi.querySalesMans(regionIds, paramMap, page);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sSalParamTrim", sSalParamTrim);
		mv.addObject("nTag", nTag);
		mv.setViewName("/sales/salesman_list.jsp");
		return mv;
	}
	
	//用于选择业务员界面-选择经销商弹出界面
	@RequestMapping(value = "/toAgentList", produces = { "application/json;charset=UTF-8" })
	public ModelAndView toAgentList(@ModelAttribute("page") PageSqlserver page,String sAgentParam,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("sAgentNO DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sAgentParamTrim = StringUtils.trim(sAgentParam);
		if(StringUtils.isNotBlank(sAgentParamTrim)) {
			paramMap.put("sAgentName",sAgentParamTrim);
			paramMap.put("sAgentNO",sAgentParamTrim);
		}
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		Map<String, Object> datas = agentQueryApi.queryAgents(regionIds, paramMap, page);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sAgentName", sAgentParamTrim);
		mv.setViewName("/sales/dealer_list_for_salesman.jsp");
		return mv;
	}
	
	@RequestMapping("/toAddSalesMan")
	public ModelAndView toAddSalesMan(HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		mv.addObject("sSalNum", String.valueOf(U.random(4)));
		mv.setViewName("/sales/salesman_add.jsp");
		return mv;
	}
	
	@RequestMapping("/toEditSalesMan")
	public ModelAndView toEditSalesManagentEdit(String nSalesManID,String type,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		TYWSalesMan salesMan = salesManQueryApi.queryTSalesManById(nSalesManID);
		request.setAttribute("salesMan", salesMan);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		request.setAttribute("createTime", sdf.format(salesMan.getDCreateTime()));
		request.setAttribute("type", type);
 		mv.addObject("salesMan", salesMan);
		mv.addObject("type", type);
		mv.setViewName("/sales/salesman_edit.jsp");
		
		return mv;
	}
	
	@RequestMapping("/saveSalesMan")
	public void saveSalesMan(TYWSalesMan tSalesMan ,HttpServletRequest request,Writer writer) {
		try {
			Map<String, Object> resultMap = new HashMap<String, Object>();
			tSalesMan.setDModifyTime(new Date());
			if(StringUtils.isNotEmpty(tSalesMan.getSSaleId())){
				tSalesMan.setDModifyTime(new Date());
				tSalesMan.setNTag(0);//默认为已启用
				tSalesMan.setSModifyUserName(SecurityContextUtil.getUserName());
				tSalesMan.setNModifyUserID(SecurityContextUtil.getUserId());
				resultMap = salesManUpdateApi.updateTSalesMan(tSalesMan);
			}else{
				tSalesMan.setSSaleId(UUID.randomUUID().toString().replaceAll("-", ""));
				tSalesMan.setNTag(0);//默认为已启用
				tSalesMan.setSCreateUserName(SecurityContextUtil.getUserName());
				tSalesMan.setDCreateTime(new Date());
				tSalesMan.setNCreateUserID(SecurityContextUtil.getUserId());
				resultMap = salesManAddApi.createTSalesMan(tSalesMan);
			}
		    boolean result = (boolean)resultMap.get("IsValid");
            if(result){
            	Egox.egoxOk().setReturnValue("业务员保存成功").write(writer);
            }else{
            	Egox.egoxErr().setReturnValue("业务员保存失败").write(writer);
            }
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("业务员操作失败").write(writer);
			U.logger.error("业务员操作出错,", e);
		}
	}

	@RequestMapping("/cleanSalesMan")
	public void cleanSalesMan(String sSaleId,HttpServletRequest request,Writer writer) {
		Map<String, Object> returnMsg = salesManCleanApi.cleanTSalesMan(sSaleId);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping("/batchExamine")
	public void batchExamine(String roleIds,String driverState,HttpServletRequest request,Writer writer) {
		if(StringUtils.isNotEmpty(roleIds)){
			String tSalIds [] = roleIds.split(",");
			Map<String, Object> returnMsg = salesManUpdateApi.updateBatchTSalesManStatus(tSalIds, driverState);
			Egox.egox(returnMsg).write(writer);
		}else{
			Egox.egoxErr().setReturnValue("业务员操作失败").write(writer);
		}
	}
	
	@RequestMapping(value="/exprotExcel")
    @ResponseBody 
    public String exprotExcel(HttpServletResponse response,@ModelAttribute("page") PageSqlserver pageParam,String saleManIds,String sSalParam,HttpServletRequest request) {
		if (pageParam == null || pageParam.getLimitKey() == null) {
			pageParam.setLimit(10);
			pageParam.setLimitKey("dCreateTime DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		String sSalParamTrim = StringUtils.trim(sSalParam);
		if(StringUtils.isNotBlank(sSalParamTrim)) {
			paramMap.put("sSalChineseName",sSalParamTrim);
			paramMap.put("sSalNum",sSalParamTrim);
		}
		if(U.isNotEmpty(saleManIds)){
			paramMap.put("saleManIds",saleManIds);
		}
		ExportExcelUtil<TYWSalesMan> excelUtil=new ExportExcelUtil<TYWSalesMan>();
		  OutputStream out=null;
		  try {
			  		 out = response.getOutputStream();// 取得输出流   
		             response.reset();// 清空输出流  
		             response.setHeader("Content-disposition", "attachment; filename="+new String("业务员列表".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		             response.setContentType("application/msexcel");// 定义输出类型
		  }  catch (IOException e) {
			  		e.printStackTrace();
		  }  
		  String[] headers ={"业务员编号","业务员姓名","英文名字","业务区域","业务员类型","手机号码","所属单位","创建时间","修改时间","备注","状态"};
		  String[]columns={ "sSalNum", "sSalChineseName", "sSalEngName", "sSalBizZone","sSalType", "sSalTelNo", "sSalOrgName", "dCreateTime", "dModifyTime", "sSalMemo","sTagText"};
		  List<TYWSalesMan> dataset = salesManQueryApi.querySalesMansOfExcel(paramMap, pageParam);
		  try  {
			  if(CollectionUtils.isNotEmpty(dataset)){
				  for (TYWSalesMan tSalesMan : dataset) {
					 if(null!=tSalesMan.getNTag()) 
						 if(tSalesMan.getNTag()==0) tSalesMan.setSTagText("已启用");
					 	 if(tSalesMan.getNTag()==1) tSalesMan.setSTagText("已禁用");
				  }
			  }
			  excelUtil.exportExcel("业务员列表", headers, columns, dataset, out, "yyyy-MM-dd HH:mm");
			  out.close();
		  } catch (Exception e1)  {
			  e1.printStackTrace();
		  }
		  return null;
	}
	
	@RequestMapping("/initSalOrgTree")
	public void initSalOrgTree(HttpServletRequest request,Writer writer) {
		try {
			Map<String, Object> resultMap =  salesManQueryApi.initSalOrgTree();
		    boolean result = (boolean)resultMap.get("IsValid");
		    List<Map<String, Object>> DataList =(List<Map<String, Object>>) resultMap.get("DataList");
            if(result){
            	Egox.egoxOk().setReturnValue(JSON.toJSONString(DataList)).write(writer);
            }else{
            	Egox.egoxErr().setReturnValue("获取业务区域失败").write(writer);
            }
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("获取业务区域操作失败").write(writer);
			U.logger.error("获取业务区域操作出错,", e);
		}
	}
	
	/**
	 * 选择业务员窗口
	 * @param request
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/salesmanNOList")
	public ModelAndView salesmanNOList(HttpServletRequest request){
		ModelAndView mv  = new ModelAndView("/sales/salesman-select.jsp");
		Map<String, Object> paramMap = ServletUtil.readReqMap(request);
		String sSalChineseName = (String)paramMap.get("sSalChineseName");
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		Map<String, Object> datas = salesManQueryApi.querySalesMans(regionIds, paramMap, PageUtil.wrapperPager(paramMap, "sOrgNO asc", "sSalChineseName asc"));
		mv.addObject("datas", datas);
		mv.addObject("page", (Page) datas.get("page"));
		mv.addObject("datas", datas);
		mv.addObject("sSalChineseName", sSalChineseName);
		mv.addObject("saleNO",request.getParameter("saleNO"));
		return mv;
	}
	
	@RequestMapping("/batchUpdateShopSalesMan")
	public void batchUpdateShopSalesMan(HttpServletRequest request,Writer writer) {
		String salesManNO = request.getParameter("salesManNO");
		String salesManNO2 = request.getParameter("salesManNO2");
		if(StringUtils.isNotEmpty(salesManNO) && StringUtils.isNotEmpty(salesManNO2)){
			Map<String, Object> returnMsg = shopApi.updateShopSalesManNO2(salesManNO2, salesManNO);
			Egox.egox(returnMsg).write(writer);
		}else{
			Egox.egoxErr().setReturnValue("业务员操作失败").write(writer);
		}
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	
	@ResponseBody
	@RequestMapping("/batchResetPassword")
	public Rjx batchResetPassword(String[] saleIds, String newPassword) {
		try {
			String id = SecurityContextUtil.getUserId();
			userApi.setPassword(id, UserType.SALESMAN, Arrays.asList(saleIds), newPassword);
			return Rjx.jsonOk();
		} catch (EgolmException e) {
			logger.error("", e.getMessage());
			return Rjx.jsonErr().setMessage(e.getMessage());
		} catch (Exception e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage("系统异常");
		}
	}
	
}







