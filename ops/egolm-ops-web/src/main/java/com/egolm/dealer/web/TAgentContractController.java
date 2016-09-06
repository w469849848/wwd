package com.egolm.dealer.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageResult;
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

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.EgolmException;
import com.egolm.common.EgolmLogger;
import com.egolm.dealer.api.AgentContractAddApi;
import com.egolm.dealer.api.AgentContractApi;
import com.egolm.dealer.api.AgentContractCleanApi;
import com.egolm.dealer.api.AgentContractQueryApi;
import com.egolm.dealer.api.AgentContractUpdateApi;
import com.egolm.dealer.api.AgentQueryApi;
import com.egolm.dealer.api.CommonQueryApi;
import com.egolm.dealer.domain.contract.vo.AgentContractVO;
import com.egolm.dealer.domain.contract.vo.ContractGoodsVO;
import com.egolm.dealer.domain.contract.vo.ContractWarehouseVO;
import com.egolm.domain.TAgent;
import com.egolm.domain.TAgentContract;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.util.ExportExcelUtil;

/**
 * 
 * @Title:
 * @Description:经销商合同相关控制器
 * @author qlh
 * @date 2016年4月15日 下午1:10:09
 * @version V1.0
 * 
 */

@Controller
@RequestMapping("/dealer")
public class TAgentContractController {

	@Resource(name = "agentContractQueryApi")
	private AgentContractQueryApi agentContractQueryApi;
	
	@Resource(name = "agentContractAddApi")
	private AgentContractAddApi agentContractAddApi;
	
	
	@Resource(name = "agentContractUpdateApi")
	private AgentContractUpdateApi agentContractUpdateApi;
	
	@Resource(name = "agentContractCleanApi")
	private AgentContractCleanApi agentContractCleanApi;
	
	@Resource(name = "agentQueryApi")
	private AgentQueryApi agentQueryApi;
	
	@Resource(name = "commonQueryApi")
	private CommonQueryApi commonQueryApi;
	
	@Resource(name = "tOrgsQueryApi")
	private TOrgsQueryApi  tOrgsQueryApi;
	
	@Resource
	private AgentContractApi agentContractApi;
	
	


	@RequestMapping("/agentContractList")
	public ModelAndView agentContractList(@ModelAttribute("page") PageSqlserver page,String sAgentContractNO,String sComID,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateDate DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sAgentContractNO)){
			paramMap.put("sAgentContractNO",sAgentContractNO);
		}
		if(U.isNotEmpty(sComID)){
			paramMap.put("sAgentContractTypeID",sComID);
		} 
		if(SecurityContextUtil.getRegionIds().size()>0){
			paramMap.put("sOrgNO",listToString(SecurityContextUtil.getRegionIds()));
		}
		
		
		Map<String, Object> contractTypeDatas = commonQueryApi.queryCONT("AgentContractType");
		request.setAttribute("contractTypeDatas", contractTypeDatas.get("DataList"));
		
		
		Map<String, Object> datas = agentContractQueryApi.queryAgentContracts(paramMap, page);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.setViewName("/dealer/dealer_contract_list.jsp");
		return mv;
	}
	@RequestMapping("/agentContractAdd")
	public String agentContractAdd(HttpServletRequest request) {
		Map<String, Object> agentDatas = agentQueryApi.queryAgents();
		request.setAttribute("agentDatas", agentDatas.get("DataList"));
		return "/dealer/dealer_contract_add.jsp";
	}
	
	@RequestMapping("/agentContractSubmit")
	public void agentContractSubmit(AgentContractVO tAgentContract, HttpServletRequest request,Writer writer) {
		String userId = SecurityContextUtil.getUserName();
		tAgentContract.setSAgentContractNO(String.valueOf(U.random(4)));
		Date date = new Date();
		tAgentContract.setNTag(0);//数据状态 
		tAgentContract.setNContractTag(2);//合同状态
		tAgentContract.setDCreateDate(date);
		tAgentContract.setSCreateUser(SecurityContextUtil.getUserName());
		tAgentContract.setDChangeDate(date);
		tAgentContract.setSChangeUser(SecurityContextUtil.getUserName());
		tAgentContract.setDLastUpdateTime(date);
		Map<String, Object> returnMsg = agentContractAddApi.createTAgentContract(userId, tAgentContract);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping("/agentContractEdit")
	public ModelAndView agentContractEdit(String sAgentContractNO,String type, HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		//获取经销商合同数据
		TAgentContract tAgentContract = agentContractQueryApi.queryTAgentContractByNo(sAgentContractNO);
		//获取经销商数据
		TAgent tAgent = agentQueryApi.queryTAgentById(tAgentContract.getNAgentID());
		
		Map<String, Object> org = tOrgsQueryApi.queryTOrg(tAgentContract.getSOrgNO());
		//获取所有经销商数据
		Map<String, Object> agentDatas = agentQueryApi.queryAgents();
		
		List<ContractWarehouseVO> warehouses = agentContractApi.queryContractWarehouses(tAgentContract.getSAgentContractNO());
		request.setAttribute("agentDatas", agentDatas.get("DataList"));
		mv.addObject("tAgent", tAgent);
		mv.addObject("tAgentContract", tAgentContract);
		mv.addObject("type", type);
		mv.addObject("org", org);
		mv.addObject("warehouses", warehouses);
		if(type.equals("edit")){
			mv.setViewName("/dealer/dealer_contract_edit.jsp");
		}else if(type.equals("detail")){
			mv.setViewName("/dealer/dealer_contract_detail.jsp");
		}
		return mv;
	}
	
	@RequestMapping("/contractGoods")
	public void contractGoods(String sAgentContractNO, Long index, Integer limit, Writer writer) {
		// 获取经销商商品信息
		Page pager = new PageSqlserver();
		pager.setIndex(null == index ? 1L : index);
		pager.setLimit(null == limit ? 10 : limit);
		try {
			PageResult<ContractGoodsVO> contractGoods = agentContractQueryApi.queryTAgentContractGoodsByNo(sAgentContractNO, pager);
			Egox.egoxOk().setDataList(contractGoods).setReturnValue("查询合同商品成功").write(writer);
		} catch (EgolmException e) {
			EgolmLogger.DealerLogger.error("", e);
			Egox.egoxErr().setReturnValue(e.getMessage()).write(writer);
		} catch (Throwable e) {
			EgolmLogger.DealerLogger.error("", e);
			Egox.egoxErr().setReturnValue("系统异常").write(writer);
		}
	}
	
	@RequestMapping("/agentContractUpdate")
	public void agentContractUpdate(AgentContractVO tAgentContract, HttpServletRequest request,Writer writer) {
		String userId = SecurityContextUtil.getUserName();
		Date date = new Date();
		tAgentContract.setDChangeDate(date);
		tAgentContract.setSChangeUser(SecurityContextUtil.getUserName());
		tAgentContract.setDLastUpdateTime(date);
		Map<String, Object> returnMsg = agentContractUpdateApi.updateTAgentContract(userId, tAgentContract);
		Egox.egox(returnMsg).write(writer);
	}
	@RequestMapping("/agentContractClean")
	public void agentContractDelete(String sAgentContractNO,HttpServletRequest request,Writer writer) {
		Map<String, Object> returnMsg = agentContractCleanApi.cleanTAgentContract(sAgentContractNO);
		Egox.egox(returnMsg).write(writer);
	}
	@RequestMapping("/agentContractBatchClean")
	public void agentContractBatchDelete(String batchNo,HttpServletRequest request,Writer writer) {
		if(U.isNotEmpty(batchNo)){
			String [] noArr= batchNo.split(",");
			for (String no : noArr) {   
				  System.out.println(no);
			}   
		}
		//Map<String, Object> returnMsg = agentContractCleanApi.cleanTAgentContract(sAgentContractNO);
		//Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping(value="/contract/exprotExcel")
    @ResponseBody 
    public String exprotExcel(HttpServletResponse response,@ModelAttribute("page") PageSqlserver pageParam,String sAgentContractNO,String sComID,HttpServletRequest request) {
		if (pageParam == null || pageParam.getLimitKey() == null) {
			pageParam.setLimit(10);
			pageParam.setLimitKey("sAgentContractNO DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sAgentContractNO)){
			paramMap.put("sAgentContractNO",sAgentContractNO);
		}
		if(U.isNotEmpty(sComID)){
			paramMap.put("sComID",sComID);
		}
		ExportExcelUtil<TAgentContract> excelUtil=new ExportExcelUtil<TAgentContract>();
		  OutputStream out=null;
		  try {
			  		 out = response.getOutputStream();// 取得输出流   
		             response.reset();// 清空输出流  
		             response.setHeader("Content-disposition", "attachment; filename="+new String("经销商合同列表".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		             response.setContentType("application/msexcel");// 定义输出类型
		  }  catch (IOException e) {
			  		e.printStackTrace();
		  }  
		  String[] headers ={"经销商合同编号","组织结构编码","联系人","联系人电话"};
		  String[]columns={ "sAgentContractNO", "sOrgNO", "sPaytContact", "sPaytContactTel"};
		  List<TAgentContract> dataset = agentContractQueryApi.queryAgentContractOfExcel(paramMap, pageParam);
		  try  {
			  excelUtil.exportExcel("经销商合同列表", headers, columns, dataset, out, "");
			  out.close();
		  } catch (Exception e1)  {
			  e1.printStackTrace();
		  }
		  return null;
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
			mv.setViewName("/dealer/dealer_list_layer.jsp");
			return mv;
		}
		public static String listToString(List<String> stringList){
	        if (stringList==null) {
	            return null;
	        }
	        String temp="";
	        for (String string : stringList) {
	        	temp+="'"+string+"',";
	        }
	        return temp.substring(0, temp.length() -1).toString();
	    }
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
		dateFormat.setLenient(false);  
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true)); 
	}
	
	
	

}
