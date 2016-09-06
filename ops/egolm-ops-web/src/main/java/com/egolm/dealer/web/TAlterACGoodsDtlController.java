/**   
* @Title: TAlterACGoodsDtlController.java 
* @Package com.egolm.dealer.web 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangyong  
* @date 2016年5月19日 下午2:23:59 
* @version V1.0   
*/
package com.egolm.dealer.web;

import java.io.Writer;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.egolm.dealer.api.AgentContractGoodsAddApi;
import com.egolm.dealer.api.TAlterACGoodsDtlQueryApi;
import com.egolm.dealer.api.TAlterACGoodsDtlUpdateApi;
import com.egolm.dealer.api.TAlterACGoodsQueryApi;
import com.egolm.dealer.api.TAlterACGoodsUpdateApi;
import com.egolm.domain.TAgentContractGoods;
import com.egolm.domain.TAlterACGoodsDtl;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @author admin
 *
 */

@Controller
@RequestMapping("/dealer/acGoodsDtl")
public class TAlterACGoodsDtlController {
	@Resource(name = "tAlterACGoodsDtlQueryApi")
	private TAlterACGoodsDtlQueryApi tAlterACGoodsDtlQueryApi;
	@Resource(name = "tAlterACGoodsDtlUpdateApi") 
	private TAlterACGoodsDtlUpdateApi tAlterACGoodsDtlUpdateApi;
	@Resource(name = "tAlterACGoodsQueryApi") 
	private TAlterACGoodsQueryApi tAlterACGoodsQueryApi;
	@Resource(name = "tAlterACGoodsUpdateApi") 
	private TAlterACGoodsUpdateApi tAlterACGoodsUpdateApi;
	@Resource(name = "agentContractGoodsAddApi") 
	private AgentContractGoodsAddApi  agentContractGoodsAddApi;
	
	@RequestMapping(value="/toDtlPage")
	public String toIndexPage(HttpServletRequest request){
		String sPaperNO  = request.getParameter("sPaperNO");  //表头
		request.setAttribute("sPaperNO", sPaperNO);
		return "/goods/good-audit-detail.jsp";
	}
	
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	@RequestMapping(value="/searchList")
	public void searchList(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){ 
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(20);
		}
		page.setLimitKey("dLastUpdateTime");
		try {
 			String sPaperNO = request.getParameter("sPaperNO");
 			String goodsNameOrMainBarCode = request.getParameter("goodsNameOrMainBarCode"); 
 			 
 			String sCategoryNO = request.getParameter("sCategoryNO");
 			 
 			String sBrandID = request.getParameter("sBrandID");
 			
 			TAlterACGoodsDtl tAlterACGoodsDtl = new TAlterACGoodsDtl(); 
 			tAlterACGoodsDtl.setSPaperNO(sPaperNO);
 			tAlterACGoodsDtl.setSGoodsDesc(goodsNameOrMainBarCode);
 			tAlterACGoodsDtl.setSCategoryNO(sCategoryNO);
 			tAlterACGoodsDtl.setSBrandID(sBrandID);
 			
 			
 			Map<String, Object> resultmap = tAlterACGoodsDtlQueryApi.queryTAlterACGoodsDtl(tAlterACGoodsDtl, page);
			boolean result = (boolean)resultmap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList"); 
				page =U.objTo(resultmap.get("page"),PageSqlserver.class); 
				Egox.egoxOk().setDataList(dataList).set("page",page).set("sPaperNO",sPaperNO).set("pageTotal", page.getPageTotal()).set("pageIndex", page.getPageIndexs().length).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("加载数据失败").write(writer);
			}
			
		} catch (Exception e) { 
			U.logger.error("获取商品导入变更明细出错,", e);
			Egox.egoxErr().setReturnValue("加载数据失败").write(writer);
		}
	}
	
	
	
	
	@RequestMapping(value="/list")
	public void list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		 
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(20);
		}
		page.setLimitKey("dLastUpdateTime");
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			String sPaperNO = request.getParameter("sPaperNO");
			if(U.isNotEmpty(sPaperNO)){
				params.put("sPaperNO", sPaperNO);
			}
			
 			Map<String, Object> resultmap = tAlterACGoodsDtlQueryApi.queryTAlterACGoodsDtl(params, page);
			boolean result = (boolean)resultmap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList"); 
				page =U.objTo(resultmap.get("page"),PageSqlserver.class); 
				Egox.egoxOk().setDataList(dataList).set("page",page).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("加载数据失败").write(writer);
			}
			
		} catch (Exception e) { 
			U.logger.error("获取商品导入变更明细出错,", e);
			Egox.egoxErr().setReturnValue("加载数据失败").write(writer);
		}
		 
	}
	
	/**
	 * 
	* @Title: auditAcGoodsDtl 
	* @Description: TODO(审核商品) 
	* @param @param request
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/auditAcGoodsDtl")
	public void auditAcGoodsDtl(HttpServletRequest request,Writer writer){
		 
		try {
			String jsonStr = ServletUtil.readReqJson(request);
			JSONObject jsonObject = JSONObject.parseObject(jsonStr); 
			String sPaperNO = (String)jsonObject.get("sPaperNO");
			String auditType = (String)jsonObject.get("auditType");
			
			 List goodsDtlList = (List)jsonObject.get("tGoodsList");
			 
			 Map<String,Object> queryAcGoodsMap = new HashMap<String,Object>();
			 queryAcGoodsMap.put("sPaperNO", sPaperNO);
			 Map<String,Object>  acGoodsMap =  tAlterACGoodsQueryApi.queryTAlterACGoods(queryAcGoodsMap);
			 boolean acGoodsResult  = (boolean)acGoodsMap.get("IsValid");
			 if(!acGoodsResult){
				 Egox.egoxErr().setReturnValue("商品审核失败,审核录入单未找到或已被删除。").write(writer);
				 return;
			 }
			 int nAgentID = 0;
			 List<Map<String,Object>>  acGoodsResultMap = (List<Map<String,Object>>)acGoodsMap.get("DataList");
			 if(acGoodsResultMap != null && acGoodsResultMap.size()>0){
				 Map<String,Object> resultMap = acGoodsResultMap.get(0);
				 nAgentID = (int)resultMap.get("nAgentID");  //获取到录入单的经销商ID
			 }
			 
			 List<TAlterACGoodsDtl> acgdList = new ArrayList<TAlterACGoodsDtl>();
			 if(goodsDtlList != null && goodsDtlList.size()>0){
				 for(int i=0;i<goodsDtlList.size();i++){
					 JSONObject dtlJson = (JSONObject)goodsDtlList.get(i); 
					 String nGoodId = (String)dtlJson.get("nGoodId");
					 String errMsg = (String)dtlJson.get("errMsg");
					 
					 TAlterACGoodsDtl acgd = new TAlterACGoodsDtl();
					 if(auditType.equals("succ")){
						 acgd.setNTag(2);
						 acgd.setNGoodsTag(2);
					 }else{
						 acgd.setNTag(8);
						 acgd.setNGoodsTag(0);
					 }
					 
					 acgd.setSMemo(errMsg);
					 acgd.setSConfirmUser(SecurityContextUtil.getUserName());
					 acgd.setSPaperNO(sPaperNO);
					 acgd.setNGoodsID(Integer.valueOf(nGoodId));
					 
					 acgdList.add(acgd);
				 }
				 if(acgdList.size()>0){
					 Map<String,Object> resutlMap = this.tAlterACGoodsDtlUpdateApi.updateTAlterACGoodsDtlNTag(acgdList);
					 boolean result = (boolean)resutlMap.get("IsValid");
					 if(result){
						//更新表头状态
						 Map<String,Object> countResultMap = tAlterACGoodsDtlQueryApi.queryTAlterACGoodsDtlNTagCount(sPaperNO);
						 boolean countResult = (boolean)countResultMap.get("IsValid");
						 if(countResult){
							 Map<String, Object> countMap = (Map<String, Object>)countResultMap.get("DataList");
						
							 int allNum = (int)countMap.get("allNum");
							 int succNum = (int)countMap.get("succNum");
							 int failNum = (int)countMap.get("failNum");
							 int acGoodNTag = 0;
							 if(allNum == succNum){
								 acGoodNTag = 2; // 审核通过
							 }else 	 if(allNum == failNum){
								 acGoodNTag = 16; //审核不通过
							 }else{
								 if(succNum >0 && failNum >0){
									 acGoodNTag = 8; //部分通过
								 }else{
									 if(succNum ==0 && failNum >0){
										 acGoodNTag = 16; //审核不通过
									 }
									 if(succNum >0 && failNum ==0){
										 acGoodNTag = 8; //部分通过
									 }
								 }
							 }
							 this.tAlterACGoodsUpdateApi.updateTAlterACGoodsNTagById(sPaperNO, acGoodNTag);
						 }
						 //取出审核通过的数据，将其写入tAgentContractGoods
						 Map<String,Object> succDataMap = this.tAlterACGoodsDtlQueryApi.queryTAlterACGoodsDtlByNoAndNTag(sPaperNO,2);
						 boolean succDataResult = (boolean)succDataMap.get("IsValid");
						 if(succDataResult){
							 List<Map<String,Object>> succDataList = (List<Map<String,Object>>)succDataMap.get("DataList");
							 if(succDataList !=null && succDataList.size()>0){
								 List<TAgentContractGoods> acGoodsList = new ArrayList<TAgentContractGoods>();
								 for(Map<String,Object> map:succDataList){
									 TAgentContractGoods tAgentContractGoods = new TAgentContractGoods();
									 tAgentContractGoods.setsAgentContractNO((String)map.get("sAgentContractNO"));
									 tAgentContractGoods.setnGoodsID((int)map.get("nGoodsID"));
									 tAgentContractGoods.setnAgentID(nAgentID); 
									 tAgentContractGoods.setsGoodsNO((String)map.get("sGoodsNO"));
									 tAgentContractGoods.setsCategoryNO((String)map.get("sCategoryNO"));
									 tAgentContractGoods.setsBrandID((String)map.get("sBrandID"));
									 tAgentContractGoods.setsBrand((String)map.get("sBrand"));
									 tAgentContractGoods.setsOrgNO((String)map.get("sOrgNO"));
									 tAgentContractGoods.setsMainBarcode((String)map.get("sMainBarcode"));
									 tAgentContractGoods.setsGoodsDesc((String)map.get("sGoodsDesc"));
									 tAgentContractGoods.setsSpec((String)map.get("sSpec"));
									 tAgentContractGoods.setsUnit((String)map.get("sUnit"));
									 tAgentContractGoods.setnMinSaleQty(To.objTo(map.get("nMinSaleQty"), BigDecimal.class));
									 tAgentContractGoods.setnSaleUnits(To.objTo(map.get("nSaleUnits"), BigDecimal.class));
									 tAgentContractGoods.setsHome((String)map.get("sHome"));
									 tAgentContractGoods.setnSalePrice(To.objTo(map.get("nSalePrice"), BigDecimal.class));
									 tAgentContractGoods.setnRealSalePrice(To.objTo(map.get("nRealSalePrice"), BigDecimal.class));
									 tAgentContractGoods.setnLifeCycle((int)map.get("nLifeCycle"));
									 tAgentContractGoods.setsMemo((String)map.get("sMemo"));
									 tAgentContractGoods.setnTag(To.objTo(map.get("nGoodsTag"), Integer.class));
									 tAgentContractGoods.setsCreateUser((String)map.get("sCreateUser"));  
									 tAgentContractGoods.setdCreateDate((Date)map.get("dCreateDate"));
									 tAgentContractGoods.setsConfirmUser(SecurityContextUtil.getUserName());
									 tAgentContractGoods.setdConfirmDate(DateUtil.parse(DateUtil.format(new Date()), DateUtil.FMT_DATE_SECOND));
									 tAgentContractGoods.setdLastUpdateTime(DateUtil.parse(DateUtil.format(new Date()), DateUtil.FMT_DATE_SECOND));
									 acGoodsList.add(tAgentContractGoods);
								 }
								 if(acGoodsList.size()>0){
									 Map<String,Object> acGoodsCreateMap =  agentContractGoodsAddApi.createAgentContractGoodsAddApi(SecurityContextUtil.getUserName(), acGoodsList);	 
									 boolean acGoodsCreateResult = (boolean)acGoodsCreateMap.get("IsValid");
									 if(acGoodsCreateResult){
										 if(auditType.equals("succ")){
											 Egox.egoxOk().setReturnValue("经销商合同商品资料审核成功").write(writer);
										 }else{
											 Egox.egoxOk().setReturnValue("经销商合同商品资料驳回成功").write(writer);
										 }
										 
									 }else{
										 if(auditType.equals("succ")){
											 Egox.egoxErr().setReturnValue("经销商合同商品资料审核失败").write(writer);
										 }else{
											 Egox.egoxErr().setReturnValue("经销商合同商品资料驳回失败").write(writer);
										 }
										 
									 }
								 } 
							 }else{
								 if(auditType.equals("succ")){
									 Egox.egoxOk().setReturnValue("经销商合同商品资料审核成功").write(writer);
								 }else{
									 Egox.egoxOk().setReturnValue("经销商合同商品资料驳回成功").write(writer);
								 }
							 }
						 }else{
							 Egox.egoxErr().setReturnValue("经销商合同商品资料审核成功,商品数据写入失败").write(writer);
						 } 
					 }else{
						Egox.egoxErr().setReturnValue("经销商合同商品资料审核失败").write(writer); 
					 }
				 }else{
					 Egox.egoxErr().setReturnValue("经销商合同商品资料审核失败").write(writer); 
				 }
			 }else{
				 Egox.egoxErr().setReturnValue("经销商合同商品资料审核失败").write(writer); 
			 }
		} catch (Exception e) {
			U.logger.error("经销商合同商品资料审核失败",e);
			Egox.egoxErr().setReturnValue("经销商合同商品资料审核失败").write(writer); 
		}
	}
	
	public static void main(String[] args) {
		int i = 0|16+16;
		System.out.println(i);
	}
}
