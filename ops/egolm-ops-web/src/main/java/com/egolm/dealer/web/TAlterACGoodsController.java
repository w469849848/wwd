
package com.egolm.dealer.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.enums.UserType;
import com.egolm.dealer.api.TAlterACGoodsQueryApi;
import com.egolm.security.utils.SecurityContextUtil;

/**   
* @Title: TAlterACGoodsController.java 
* @Package com.egolm.dealer.web 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangyong  
* @date 2016年5月19日 上午11:37:22 
* @version V1.0   
*/
@Controller
@RequestMapping("/dealer/acGoods")
public class TAlterACGoodsController {
	@Resource(name = "tAlterACGoodsQueryApi")
	private TAlterACGoodsQueryApi tAlterACGoodsQueryApi;
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc ");
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			String selectNo = request.getParameter("selectNo");
			if(U.isNotEmpty(selectNo)){
				params.put("selectNo", selectNo);
			}
			String sCategoryNO = request.getParameter("sCategoryNO"); //
			if(U.isNotEmpty(sCategoryNO)){
				params.put("sCategoryNO",sCategoryNO);
			}
			String nTag = request.getParameter("nTag");
			if(U.isNotEmpty(nTag) && !"-1".equals(nTag)){
				params.put("nTag", nTag);
			}
			
			String sOrgNO = request.getParameter("sOrgNO");
			 
			
			boolean isSelect = false;
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf( UserType.ADMIN)) { //管理员
				if(U.isNotEmpty(sOrgNO)){
					params.put("sOrgNO", StringUtil.join("','","'","'",sOrgNO));
				}
				isSelect = true;
			}else if(userType.oneOf(UserType.OPERATOR)){  //运营人员
 				if(U.isNotEmpty(sOrgNO)){ 
					params.put("sOrgNO", StringUtil.join("','","'","'",sOrgNO));	
				}else{
					params.put("sOrgNO", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));	
 				}
				
			}else if(userType.oneOf(UserType.AGENT)){  //经销商
				String nAgentID = SecurityContextUtil.getUserId(); 
				if(U.isNotEmpty(nAgentID)){
					isSelect = true;
					params.put("nAgentID", nAgentID);	
				}else{
 					U.logger.error("商品审核:经销商"+SecurityContextUtil.getUserName()+"权限配置异常"); 
				}
				if(U.isNotEmpty(sOrgNO)){ 
					params.put("sOrgNO", StringUtil.join("','","'","'",sOrgNO));	
				}else{
					params.put("sOrgNO", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));	
 				}
			}else{
				U.logger.error("商品审核:"+userType.getDescription()+"权限配置异常,非法访问");  
			}
			
			if(isSelect){
				Map<String, Object> resultmap = tAlterACGoodsQueryApi.queryTAlterACGoods(params, page);
				boolean result = (boolean)resultmap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");
					
					page =U.objTo(resultmap.get("page"),PageSqlserver.class);
					map.put("aCGoodsList", dataList);
					map.put("page", page);
					map.put("selectNo", selectNo);
					map.put("sCategoryNO", sCategoryNO);
					map.put("nTag",nTag);
					map.put("sOrgNO", sOrgNO);
				}
			} 
			
		} catch (Exception e) { 
			U.logger.error("获取商品导入审核数据出错,", e);
		}
		ModelAndView mv = new ModelAndView("/goods/goods-audit.jsp", map);
		return mv;
	}
}
