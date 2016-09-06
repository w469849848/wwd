/**   
* @Title: TSalesOrderSubDtlController.java 
* @Package com.egolm.order.web 
* @Description: TODO(用一句话描述该文件做什么) 
* @author zhangyong  
* @date 2016年5月23日 下午5:28:09 
* @version V1.0   
*/
package com.egolm.order.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.order.api.TSalesOrderSubDtlQueryApi;
import com.egolm.order.api.TSalesOrderSubQueryApi; 
/**
 * @author admin
 *
 */
@Controller
@RequestMapping("/order/tSalesOrderSubDtl")
public class TSalesOrderSubDtlController {
	@Resource(name = "tSalesOrderSubQueryApi")
	private TSalesOrderSubQueryApi tSalesOrderSubQueryApi;

	@Resource(name = "tSalesOrderSubDtlQueryApi")
	private TSalesOrderSubDtlQueryApi tSalesOrderSubDtlQueryApi;
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page){
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc");
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			String nAgentID= StringUtils.trim(request.getParameter("nAgentID"));
			String sSubOrderID= StringUtils.trim(request.getParameter("sSubOrderID"));
			 
			String orderDetailQueryMsg = StringUtils.trim(request.getParameter("orderDetailQueryMsg"));
			if(U.isNotEmpty(orderDetailQueryMsg)){
				params.put("orderDetailQueryMsg", orderDetailQueryMsg);
			}
			 
			Map<String, Object> tSalesOrderSubMap = tSalesOrderSubQueryApi.queryTSalesOrderSubById(sSubOrderID);
			boolean orderResult = (boolean)tSalesOrderSubMap.get("IsValid");
			if(orderResult){
				Map<String, Object> orderMap = (Map<String, Object>)tSalesOrderSubMap.get("DataList");
				map.put("tSalesOrderSubMap", orderMap);
			}
			
 			Map<String, Object> resultmap = tSalesOrderSubDtlQueryApi.queryTSalesOrderSubDtlBySubOrderId(params,sSubOrderID, nAgentID, page);
 			boolean result = (boolean)resultmap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");
				
				page =U.objTo(resultmap.get("page"),PageSqlserver.class);
				map.put("orderSubDtlList", dataList);
				map.put("page", page); 
				map.put("orderDetailQueryMsg", orderDetailQueryMsg);
			}
			
		} catch (Exception e) { 
			U.logger.error("订单详情查询出错,", e);
		}
		ModelAndView mv = new ModelAndView("/order/order-detail.jsp", map);
		return mv;
	}
}
