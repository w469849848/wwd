package com.egolm.advert.web;

import java.io.Writer;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Json;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.advert.api.TShopAdContractAddApi;
import com.egolm.advert.api.TShopAdContractQueryApi;
import com.egolm.advert.api.TShopAdContractUpdateApi;
import com.egolm.common.enums.UserType;
import com.egolm.domain.TShopAdContract;
import com.egolm.security.utils.SecurityContextUtil;
 
/**
 * 
* Title:  广告合同控制器 
* Description:
* Company: 万店易购投资管理有限公司
* @author zhangyong
* @date 2016年5月4日
 */
@Controller
@RequestMapping("/media/mediaContract")
public class TShopAdContractController extends BaseAdvertController {
	@Resource(name = "tShopAdContractAddApi")
	private TShopAdContractAddApi tShopAdContractAddApi;
	@Resource(name = "tShopAdContractQueryApi")
	private TShopAdContractQueryApi tShopAdContractQueryApi;
	@Resource(name = "tShopAdContractUpdateApi")
	private TShopAdContractUpdateApi tShopAdContractUpdateApi;
	
	@RequestMapping(value = "/addIndex")
	public String adVertIndex(){
		return "/media/add-media-contract.jsp";
	}
	
	@RequestMapping(value="/listToJson")
	public void listToJson(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		ModelAndView mv = list(request, page);
		Map<String,Object> map = mv.getModel();
		List<Map<String, Object>> dataList =  (List<Map<String, Object>>) map.get("advContractList");
		Egox.egoxOk().setDataList(dataList).write(writer);
	}
	
	
	
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page){
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc");
		String sContractNO = request.getParameter("sContractNO");
		
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			params = setMapByPar(request, params,null, "com.egolm.domain.TShopAdContract");
			
			String sOrgNO = request.getParameter("sOrgNO"); //广告新增会传区域
			
			boolean isSelect = false;
			UserType userType = SecurityContextUtil.getUserType(); //用户类型
			if (userType.oneOf(UserType.ADMIN)) {  //管理员
				isSelect = true;
				if(U.isNotEmpty(sOrgNO)){
					params.put("sOrgNO", StringUtil.join("','","'","'",sOrgNO));
				}
			}else if(userType.oneOf(UserType.OPERATOR)){ //运营人员
				
				if(U.isNotEmpty(sOrgNO)){
					params.put("sOrgNO", StringUtil.join("','","'","'",sOrgNO));
				}else{
					List<String> sOrgNOList = SecurityContextUtil.getRegionIds();
					if(sOrgNOList != null && sOrgNOList.size()>0){
						
						params.put("sOrgNO", StringUtil.join("','","'","'",sOrgNOList));
					}else{
						U.logger.error("广告合同管理:运营人员"+SecurityContextUtil.getUserName()+"权限配置异常");
					}
				}
				isSelect = true;
			}else if(userType.oneOf(UserType.AGENT)){
				String nAgentID =  SecurityContextUtil.getUserId(); 
				if(U.isNotEmpty(nAgentID)){
					isSelect = true;
					params.put("nAgentID", nAgentID);	
				}else{
					U.logger.error("广告合同管理:经销商"+SecurityContextUtil.getUserName()+"权限配置异常"); 
				}				
			}else{
				U.logger.error("广告合同管理:"+userType.getDescription()+","+SecurityContextUtil.getUserName()+"非法访问此功能"); 
			}
			if(isSelect){ 
				
				Map<String, Object> resultmap = tShopAdContractQueryApi.query(params, page);
				boolean result = (boolean)resultmap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");
					page =U.objTo(resultmap.get("page"),PageSqlserver.class);
					map.put("advContractList", dataList);
					map.put("page", page);
				}		
			}
			
		} catch (Exception e) { 
			U.logger.error("广告合同查询请求出错,", e);
		}
		map.put("sContractNO", sContractNO);
		ModelAndView mv = new ModelAndView("/media/mediaContract-manage.jsp", map);
		return mv;
	}
	
	@RequestMapping(value="/add", method =RequestMethod.POST)
	public void add(HttpServletRequest request,Writer writer) { 
		 try {
			 String jsonStr = ServletUtil.readReqJson(request);
			 Map<String, Object> map = Json.toMap(jsonStr);
			 String  nContractID   = (String)map.get("nContractID"); 
			 String  nAgentID = (String)map.get("nAgentID");
			 String  sOrgNO = (String)map.get("sOrgNO");
			 String sOrgNODesc = (String)map.get("sOrgNODesc");
			 String  sContractNO   = (String)map.get("sContractNO"); 
			 String  sTradeModeID   = (String)map.get("sTradeModeID"); 
			 String  sTradeMode   = (String)map.get("sTradeMode"); 
			 String  dActiveDate   = (String)map.get("dActiveDate"); 
			 String  dExpireDate   = (String)map.get("dExpireDate"); 
			 String  nRatio   = (String)map.get("nRatio"); 
			 String  sTaxTypeID   = (String)map.get("sTaxTypeID"); 
			 String  sTaxType   = (String)map.get("sTaxType"); 
			 String  nTaxRate   = (String)map.get("nTaxRate"); 
			 String  nTaxPct   = (String)map.get("nTaxPct"); 
			 String  sPaytTermID   = (String)map.get("sPaytTermID"); 
			 String  sPaytTerm   = (String)map.get("sPaytTerm"); 
			 String  nPaytDay   = (String)map.get("nPaytDay"); 
			 String  sPaytContact   = (String)map.get("sPaytContact"); 
			 String  sPaytContactTel   = (String)map.get("sPaytContactTel"); 
			 String  sPaytModeID   = (String)map.get("sPaytModeID"); 
			 String  sPaytMode   = (String)map.get("sPaytMode"); 
			 String  sBankAccountNO   = (String)map.get("sBankAccountNO"); 
			 String  sBankAccount   = (String)map.get("sBankAccount"); 
			 String  sBank   = (String)map.get("sBank"); 
			 String  sTaxCode   = (String)map.get("sTaxCode"); 
			 String  sPaytCenterNO   = (String)map.get("sPaytCenterNO"); 
			 String  nContractTag   = (String)map.get("nContractTag"); 
			 String  sMemo   = (String)map.get("sMemo"); 
			 String sCreateUser = SecurityContextUtil.getUserName();
			 
			 TShopAdContract tShopAdContract = new TShopAdContract();
			 
			 if(StringUtil.isNotEmpty(nContractID)){ //合同ID不为空
				 Map<String,Object> idMap = this.tShopAdContractQueryApi.queryTShopAdContractById(nContractID);
				 boolean idResult = (boolean)idMap.get("IsValid");
				 if(idResult){
					 Map<String,Object> dataMap = (Map<String,Object>)idMap.get("DataList");
					 tShopAdContract = To.mapTo(dataMap, TShopAdContract.class);
				 }else{
					 Egox.egoxErr().setReturnValue("广告位合同不存在,更新失败").write(writer);
					 return ;
				 }
			 } 
			 tShopAdContract.setNAgentID(Integer.valueOf(nAgentID));
			 tShopAdContract.setSOrgNO(sOrgNO);
			 tShopAdContract.setSOrgNODesc(sOrgNODesc);
			 tShopAdContract.setSContractNO(sContractNO);
			 tShopAdContract.setSTradeModeID(sTradeModeID);
			 tShopAdContract.setSTradeMode(sTradeMode);
			 tShopAdContract.setDActiveDate(DateUtil.parse(dActiveDate, DateUtil.FMT_DATE));
			 tShopAdContract.setDExpireDate(DateUtil.parse(dExpireDate, DateUtil.FMT_DATE));
			 tShopAdContract.setNRatio(To.objTo(nRatio, BigDecimal.class, new BigDecimal(0)));
			 tShopAdContract.setSTaxTypeID(sTaxTypeID);
			 tShopAdContract.setSTaxType(sTaxType);
			 tShopAdContract.setNTaxRate(To.objTo(nTaxRate, BigDecimal.class, new BigDecimal(0)));
			 tShopAdContract.setNTaxPct(To.objTo(nTaxPct, BigDecimal.class, new BigDecimal(0)));
			 tShopAdContract.setSPaytTermID(sPaytTermID);
			 tShopAdContract.setSPaytTerm(sPaytTerm);
			 tShopAdContract.setNPaytDay(To.objTo(nPaytDay, BigDecimal.class, new BigDecimal(0)));
			 tShopAdContract.setSPaytContact(sPaytContact);
			 tShopAdContract.setSPaytContactTel(sPaytContactTel);
			 tShopAdContract.setSPaytModeID(sPaytModeID);
			 tShopAdContract.setSPaytMode(sPaytMode);
			 tShopAdContract.setSBankAccountNO(sBankAccountNO);
			 tShopAdContract.setSBankAccount(sBankAccount);
			 tShopAdContract.setSBank(sBank);
			 tShopAdContract.setSTaxCode(sTaxCode);
			 tShopAdContract.setSPaytCenterNO(sPaytCenterNO);
			 tShopAdContract.setNContractTag(Integer.valueOf(nContractTag));
			 tShopAdContract.setSMemo(sMemo);
			 tShopAdContract.setSCreateUser(sCreateUser); 
			 
			 if(StringUtil.isNotEmpty(nContractID)){
				 Map<String,Object> resultMap = this.tShopAdContractUpdateApi.updateTShopAdContract(tShopAdContract);
				 Egox.egox(resultMap).write(writer);				 
			 }else{
				 Map<String,Object> resultMap = this.tShopAdContractAddApi.createTShopAdContract(tShopAdContract);
				 Egox.egox(resultMap).write(writer);
			 } 
		} catch (Exception e) { 
			U.logger.error("广告合同新增出错,", e);
			Egox.egoxErr().setReturnValue("广告合同操作失败").write(writer);
		} 
	}
	
	/**
	 *  活动详情
	* @Title: loadDetailMsgById 
	* @Description: TODO(这里用一句话描述这个方法的作用) 
	* @param @param request
	* @param @return    设定文件 
	* @return ModelAndView    返回类型 
	* @throws
	 */
	@RequestMapping(value="/loadDetailMsgById")
	public ModelAndView loadDetailMsgById(HttpServletRequest request){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			ModelAndView mv = loadMsgById(request);
			Map<String,Object> map = mv.getModel();
			Map<String, Object> dataMap =  (Map<String, Object>) map.get("advContractData");
			returnMap.put("advContractData", dataMap);
		} catch (Exception e) {
			U.logger.error("获取广告位合同信息出错,", e);
		}
		ModelAndView returnMv = new ModelAndView("/media/mediaContract-detail.jsp",returnMap);
		return returnMv;
	}
	
	/**
	 * 根据ID获取合同
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/loadMsgById")
	public ModelAndView loadMsgById(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String nContractID = request.getParameter("id");
			Map<String, Object> resultMap = this.tShopAdContractQueryApi.queryTShopAdContractById(nContractID);
			 boolean result = (boolean)resultMap.get("IsValid");
			 if(result){
				 map.put("advContractData", resultMap.get("DataList"));
			 }
			
		} catch (Exception e) { 
			U.logger.error("获取广告位合同信息出错,", e);
		}
		ModelAndView mv = new ModelAndView("/media/add-media-contract.jsp", map);
		return mv;
	}
	
	@RequestMapping(value="/delete")
	public void delete(HttpServletRequest request,Writer writer){
		try {
			String nContractID = request.getParameter("id");
			if(StringUtil.isNotEmpty(nContractID)){
				TShopAdContract tShopAdContract = new TShopAdContract();
				tShopAdContract.setNContractID(Integer.valueOf(nContractID));
				tShopAdContract.setSConfirmUser(SecurityContextUtil.getUserName());
				Map<String,Object> resultMap = (Map<String,Object>)tShopAdContractUpdateApi.deleteTShopAdContractById(tShopAdContract);
				Egox.egox(resultMap).setReturnValue("广告合同删除成功").write(writer);
			}else{
				Egox.egoxErr().setReturnValue("广告合同ID为空,删除失败").write(writer);
			}
			
		} catch (Exception e) {
			 U.logger.error("删除广告合同失败",e);
			 Egox.egoxErr().setReturnValue("广告合同删除失败").write(writer);
		}
	}
}
