
package com.egolm.dealer.web;

import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.egolm.common.enums.UserType;
import com.egolm.dealer.api.AgentContractGoodsQueryApi;
import com.egolm.dealer.api.AgentContractGoodsUpdateApi;
import com.egolm.domain.TAgentContractGoods;
import com.egolm.security.utils.SecurityContextUtil;


/**   
* @Title: TAgentContractGoodsController.java 
* @Package com.egolm.dealer.web 
* @Description: TODO(经销商合同商品) 
* @author zhangyong  
* @date 2016年5月14日 上午11:23:44 
* @version V1.0   
*/
@Controller
@RequestMapping("/dealer/goods")
public class TAgentContractGoodsController {
	
	@Resource(name = "agentContractGoodsQueryApi")
	private AgentContractGoodsQueryApi agentContractGoodsQueryApi;
	@Resource(name = "agentContractGoodsUpdateApi") 
	private AgentContractGoodsUpdateApi agentContractGoodsUpdateApi;
	
	
	@RequestMapping(value="/indexPage")
	public String indexPage(HttpServletRequest request){
		String index = request.getParameter("index");
		if(!U.isNotEmpty(index)){
			index = "1";
		}
		request.setAttribute("index", index);
		return "goods/goods-putaway.jsp";
	}
	
	
	  @InitBinder("page")
	  public void initBinder1(WebDataBinder binder) {
		  binder.setFieldDefaultPrefix("page.");
	  }
	  
	  /**
		 * 
		* @Title: listBrandByIdAndOrgId 
		* @Description: TODO(根据经销商ID和组织机构查询品牌) 
		* @param @param request
		* @param @param page
		* @param @param writer    设定文件 
		* @return void    返回类型 
		* @throws
		 */
		@RequestMapping(value="/listBrandByIdAndOrgId")
		public void listBrandByIdAndOrgId(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
			try {
				if (page == null) {
					page = new PageSqlserver();
					page.setIndex(1L);
					page.setLimit(20);
				}else{
					page.setLimit(10);
				}
				page.setLimitKey("sBrandID");
				String nAgentID = request.getParameter("nAgentID");
				String sOrgNO = request.getParameter("sOrgNO");
				
				String sAgentBrandSelect  =  request.getParameter("sAgentBrandSelect"); //包含 商品ID/名称/条码码   用于 广告位的链接商品处
				
				Map<String,Object> paramsMap = new HashMap<String,Object>();
				paramsMap.put("nAgentID", nAgentID);
				paramsMap.put("sOrgNO", sOrgNO);
				if(U.isNotEmpty(sAgentBrandSelect)){
					paramsMap.put("sAgentBrandSelect", sAgentBrandSelect);	
				}
				Map<String, Object> dataMap = agentContractGoodsQueryApi.queryAgentContractBrandByIdAndOrgId(paramsMap, page);
				boolean result = (boolean) dataMap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList");
					page = U.objTo(dataMap.get("page"), PageSqlserver.class);
					Egox.egoxOk().setDataList(dataList).set("page", page).write(writer);
				}else{
					Egox.egoxErr().setReturnValue("根据经销商ID和组织机构获取品牌失败").write(writer);
				}
				
				
			} catch (Exception e) {
				U.logger.error("根据经销商ID和组织机构获取品牌失败",e);
				Egox.egoxErr().setReturnValue("根据经销商ID和组织机构获取品牌失败").write(writer);
			}
			
		}
	  
		/**
		 * 
		* @Title: listGoodsByIdAndOrgId 
		* @Description: TODO(根据经销商ID和组织机构查询商品) 
		* @param @param request
		* @param @param page
		* @param @param writer    设定文件 
		* @return void    返回类型 
		* @throws
		 */
		@RequestMapping(value="/listGoodsByIdAndOrgId")
		public void listGoodsByIdAndOrgId(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
			try {
				if (page == null) {
					page = new PageSqlserver();
					page.setIndex(1L);
					page.setLimit(20);
				}else{
					page.setLimit(10);
				}
				page.setLimitKey("dLastUpdateTime");
				
				String sAgentGoodsSelect  =  request.getParameter("sAgentGoodsSelect"); //包含 商品ID/名称/条码码   用于 广告位的链接商品处
				String sOrgNO = request.getParameter("sOrgNO");  //选择的区域
				String nAgentID = request.getParameter("nAgentID");
				
				Map<String,Object> paramsMap = new HashMap<String,Object>();
				
				paramsMap.put("sOrgNO", sOrgNO); 
				 
				if(U.isNotEmpty(sAgentGoodsSelect)){
					paramsMap.put("sAgentGoodsSelect", sAgentGoodsSelect);	
				}
				if(U.isNotEmpty(nAgentID)){
					paramsMap.put("nAgentID", nAgentID);	
				}
				
				Map<String, Object> dataMap = agentContractGoodsQueryApi.queryAgentContractGoods(paramsMap, page);
				boolean result = (boolean) dataMap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList");
					page = U.objTo(dataMap.get("page"), PageSqlserver.class);
					Egox.egoxOk().setDataList(dataList).set("page", page).write(writer);
				}else{
					Egox.egoxErr().setReturnValue("根据经销商ID和组织机构获取合同商品失败").write(writer);
				}
				
				
			} catch (Exception e) {
				U.logger.error("根据经销商ID和组织机构获取合同商品失败",e);
				Egox.egoxErr().setReturnValue("根据经销商ID和组织机构获取合同商品失败").write(writer);
			}
			
		}
	
	/**
	 * 
	* @Title: list 
	* @Description: TODO(根据经销商ID和组织机构查询商品) 
	* @param @param request
	* @param @param page
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/list")
	public void list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(20);
			}
			
			page.setLimitKey("dLastUpdateTime"); 
			String sOrgNO =request.getParameter("sOrgNO");
			String sCategoryNO = request.getParameter("sCategoryNO");
			String sBrandID = request.getParameter("sBrandID");
			String goodsNameOrMainBarCode = request.getParameter("goodsNameOrMainBarCode");
		  
 
			TAgentContractGoods queryAcg = new TAgentContractGoods();
			
 			
			if(U.isNotEmpty(goodsNameOrMainBarCode)){
 				queryAcg.setsGoodsDesc(goodsNameOrMainBarCode);
			}
			if(U.isNotEmpty(sCategoryNO)){
 				queryAcg.setsCategoryNO(sCategoryNO);
			}
			if(U.isNotEmpty(sBrandID)){
 				queryAcg.setsBrandID(sBrandID);
			}
			boolean isCheck = false;
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf(UserType.ADMIN)) { //管理员
				isCheck = true; 
				if(U.isNotEmpty(sOrgNO)){
 					 queryAcg.setsOrgNO(StringUtil.join("','","'","'",sOrgNO));
				 }
			}else if(userType.oneOf(UserType.OPERATOR)){//运营人员,
				 if(U.isNotEmpty(sOrgNO)){
 					 queryAcg.setsOrgNO(StringUtil.join("','","'","'",sOrgNO)); 
				 }else{
 					 queryAcg.setsOrgNO(StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds())); 
				 }
				 isCheck = true;
			}else if(userType.oneOf(UserType.AGENT)){ //经销商
				if(U.isNotEmpty(sOrgNO)){
					 queryAcg.setsOrgNO(StringUtil.join("','","'","'",sOrgNO)); 
				 }
				String nAgentID =SecurityContextUtil.getUserId();
 				queryAcg.setnAgentID(Integer.valueOf(nAgentID));
				isCheck = true;
			}else {
				 U.logger.error("广告位管理:"+userType.getDescription()+"非法访问此功能");
 			}
			
			if(isCheck){
				Map<String, Object> dataMap = agentContractGoodsQueryApi.queryAgentContractGoods(queryAcg, page);
				boolean result = (boolean)dataMap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList"); 
					page =U.objTo(dataMap.get("page"),PageSqlserver.class); 
					Egox.egoxOk().setDataList(dataList).set("page",page).set("pageTotal", page.getPageTotal()).set("pageIndex", page.getPageIndexs().length).write(writer);
				}else{
					Egox.egoxErr().setReturnValue("加载数据失败").write(writer);
				}
			}else{
				Egox.egoxErr().setReturnValue("非法请求").write(writer);
			}
			
		} catch (Exception e) {
			U.logger.error("根据经销商ID和组织机构获取合同商品失败",e);
			Egox.egoxErr().setReturnValue("根据经销商ID和组织机构获取合同商品失败").write(writer);
		} 
	}
	
	/**
	 * 
	* @Title: updateNTag 
	* @Description: TODO(商品上下架操作) 
	* @param @param request
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/updateNTag")
	public void updateNTag(HttpServletRequest request,Writer writer){
		try {
			String jsonStr = ServletUtil.readReqJson(request);
			JSONObject jsonObject = JSONObject.parseObject(jsonStr); 
			String type = (String)jsonObject.get("type");
			List acGoodList = (List)jsonObject.get("acGoodList");
			
			List<TAgentContractGoods> list = new ArrayList<TAgentContractGoods>();
			if(acGoodList != null && acGoodList.size()>0){
				 for(int i=0;i<acGoodList.size();i++){
					 JSONObject acJson = (JSONObject)acGoodList.get(i); 
					 int nTag = acJson.getIntValue("nTag");
					 int nGoodId = acJson.getIntValue("nGoodId");
					 String nAgentID = acJson.getString("nAgentID");
					 String sAgentContractNO = acJson.getString("sAgentContractNO");
					 
					 TAgentContractGoods tacGoods= new TAgentContractGoods();
					 if(type.equals("up")){
						 tacGoods.setnTag(nTag+16);
					 }else{
						 tacGoods.setnTag(nTag-16);
					 }
					 tacGoods.setnAgentID(Integer.valueOf(nAgentID));
					 tacGoods.setnGoodsID(nGoodId);
					 tacGoods.setsAgentContractNO(sAgentContractNO);
					 tacGoods.setsConfirmUser(SecurityContextUtil.getUserName()); 
					 list.add(tacGoods);
				 }
				 
				 if(list.size()>0){
					 Map<String, Object> dataMap =  agentContractGoodsUpdateApi.updateTAgentContractGoods(list);
					 boolean result = (boolean)dataMap.get("IsValid");
					 if(result){
						String returnMsg = "";
						if(type.equals("up")){
							returnMsg="商品上架成功";
						}else{
							returnMsg="商品下架成功";
						}
						Egox.egoxOk().setReturnValue(returnMsg).write(writer);
					}else{
						String returnMsg = "";
						if(type.equals("up")){
							returnMsg="商品上架失败";
						}else{
							returnMsg="商品下架失败";
						}
						Egox.egoxErr().setReturnValue(returnMsg).write(writer);
					}
				 }else{
					    String returnMsg = "";
						if(type.equals("up")){
							returnMsg="商品上架失败,未获取到要操作的商品";
						}else{
							returnMsg="商品下架失败,未获取到要操作的商品";
						}
						Egox.egoxErr().setReturnValue(returnMsg).write(writer);
				 }
			}else{
				String returnMsg = "";
				if(type.equals("up")){
					returnMsg="商品上架失败,未获取到要操作的商品";
				}else{
					returnMsg="商品下架失败,未获取到要操作的商品";
				}
				Egox.egoxErr().setReturnValue(returnMsg).write(writer);
			}
		} catch (Exception e) {
			U.logger.error("商品上下架操作失败",e);
			Egox.egoxErr().setReturnValue("操作失败").write(writer);
		}
	}
	
	
	public static void main(String[] args) {
		int i = 54|16-16;
		System.out.println(i);
	}
}
