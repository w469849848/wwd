
package com.egolm.order.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmException;
import com.egolm.common.EgolmLogger;
import com.egolm.common.enums.UserType;
import com.egolm.domain.TSalesOrderSub;
import com.egolm.order.api.TSalesOrderSubQueryApi;
import com.egolm.order.api.TSalesOrderSubStatusAddApi;
import com.egolm.order.api.TSalesOrderSubUpdateApi;
import com.egolm.order.domain.enums.OrderStatus;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.util.ExportExcelUtil;
import com.google.common.collect.Maps;

/**
 * @Title: TSalesOrderSubController.java
 * @Package com.egolm.order.web
 * @Description: TODO(订单表头查询控制器)
 * @author zhangyong
 * @date 2016年5月23日 下午3:21:00
 * @version V1.0
 */
@Controller
@RequestMapping("/order/tSalesOrderSub")
public class TSalesOrderSubController {

	@Resource(name = "tSalesOrderSubQueryApi")
	private TSalesOrderSubQueryApi tSalesOrderSubQueryApi;
	@Resource(name = "tSalesOrderSubUpdateApi")
	private TSalesOrderSubUpdateApi  tSalesOrderSubUpdateApi;
	@Resource(name = "tSalesOrderSubStatusAddApi")
	private TSalesOrderSubStatusAddApi  tSalesOrderSubStatusAddApi;
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		ModelAndView mv = new ModelAndView("/order/order-list.jsp");
		if (page == null) { // 导出excel时设置了为空
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10000);
		} else {
			page.setLimit(10);
		}
		try {
			Map<String, Object> params = ServletUtil.readReqMap(request);
			mv.addObject("orderQueryMsg", StringUtils.trim((String) params.get("orderQueryMsg")));
			mv.addObject("sOrgNO", StringUtils.trim((String) params.get("sOrgNO")));
			mv.addObject("nOrderStatus", StringUtils.trim((String) params.get("nOrderStatus")));

			UserType userType = SecurityContextUtil.getUserType();

			if (!userType.oneOf(UserType.ADMIN, UserType.AGENT, UserType.OPERATOR)) {
				U.logger.error("订单管理:" + userType.getValue() + "非法访问此功能");
				return mv;
			}
			
			Map<String, Object> resultmap = Maps.newHashMap();
			if (UserType.AGENT.equals(userType)) {
				String agentId = SecurityContextUtil.getUserId();
				resultmap = tSalesOrderSubQueryApi.queryAgentSalesOrderSubs(agentId, params, page);
			} else {
				List<String> regionIds = SecurityContextUtil.getRegionIds();
				resultmap = tSalesOrderSubQueryApi.queryOrgSalesOrderSubs(regionIds, params, page);
			}
			mv.addObject("orderSubList", resultmap.get("DataList"));
			mv.addObject("page", resultmap.get("page"));

		} catch (EgolmException e) {
			EgolmLogger.OrderLogger.error(e.getMessage());
		} catch (Throwable e) {
			EgolmLogger.OrderLogger.error("", e);
		}
		return mv;
	}
	
	/**
	 * 订单状态更新
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/updateOrderStatus")
	public void updateOrderStatus(HttpServletRequest request,Writer writer){
		 try {
			 String subOrderid = StringUtils.trim(request.getParameter("subOrderid"));
			 String orderStatus = StringUtils.trim(request.getParameter("orderStatus"));
			 OrderStatus status = OrderStatus.getStatus(Integer.valueOf(orderStatus), OrderStatus.COMPLETE);
			 String userName = SecurityContextUtil.getUserName();
			 
			 if(U.isNotEmpty(subOrderid,orderStatus)){
				 Map<String,Object> dataMap = tSalesOrderSubUpdateApi.updateTSalesOrderSubById(userName, subOrderid, status);
				 boolean result = (boolean)dataMap.get("IsValid");
				 if(result){
					 Egox.egoxOk().setReturnValue("订单状态更新成功").write(writer);
				 }else{
					 Egox.egoxErr().setReturnValue("订单状态更新失败").write(writer);
				 }
			 }else{
				 Egox.egoxErr().setReturnValue("订单状态更新失败,参数缺失").write(writer);
			 }
		} catch (Exception e) {
			 U.logger.error("订单状态更新操作失败",e);
			 Egox.egoxErr().setReturnValue("订单状态更新操作失败").write(writer);
		}
	}
	
	/**
	 * 订单导出
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/exportExcel")
	public void exportExcel(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page,HttpServletResponse response){
		List<Map<String, Object>> dataList = new ArrayList<Map<String,Object>>();
		String subOrderid = StringUtils.trim(request.getParameter("subOrderid")); //复选框选中的订单号  优先级高于条件查询  
		if(U.isNotEmpty(subOrderid)){  
			 Map<String,Object> dataMap = tSalesOrderSubQueryApi.queryTSalesOrderSubByMoreId(subOrderid);
			 boolean result = (boolean)dataMap.get("IsValid");
			 if(result){
				 dataList = (List<Map<String, Object>>) dataMap.get("DataList");
			 }
		}else{
			ModelAndView mav = list(request, null);
			Map<String,Object> map = mav.getModel();
			dataList = (List<Map<String, Object>>)map.get("orderSubList");
		}
		
		if(dataList != null && dataList.size()>0){
			List<TSalesOrderSub> orderList = new ArrayList<TSalesOrderSub>();
			for(Map<String,Object> mapData :dataList){
				orderList.add(To.mapTo(mapData, TSalesOrderSub.class));
			}
			
			ExportExcelUtil<TSalesOrderSub> excelUtil=new ExportExcelUtil<TSalesOrderSub>();
		    OutputStream out=null;
		   try {
			  	out = response.getOutputStream();// 取得输出流   
		        response.reset();// 清空输出流  
		        response.setHeader("Content-disposition", "attachment; filename="+new String("订单列表".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		        response.setContentType("application/msexcel");// 定义输出类型
		   }  catch (IOException e) {
			  		e.printStackTrace();
		   }  
		   String[] headers ={"订单子单号","订单ID","仓库编码","区域编号","客户编号","订单类型","下单总数量","下单总金额","折扣总金额","收货人","收货人手机","收货人电话","收货人收货地址","收货人邮编","收货人电子邮箱","订单备注","订单日期","发货日期","发货总数量","发货总金额","收货日期","收货总数量","收货总金额","送货司机编号","送货司机名称","订单状态","日结日期"};
		   String[]columns={"sSubOrderID","sSalesOrderID","sWarehouseNO","sOrgNO","sCustNO","sSalesOrderType","nTotalSaleQty","nTotalSaleAmount","nTotalDisAmount","sContacts","sMobile","sTel","sAddress","sPostalcode","sEmail","sOrderMemo","dOrderDate","dSendDate","nTotalSendQty","nTotalSendAmount","dReceiveDate","nTotalReceiveQty","nTotalReceiveAmount","sDriverNO","sDriverName","nOrderStatusName","dUpdate"};
	 	   try  {
			  excelUtil.exportExcel("订单列表", headers, columns, orderList, out, "");
			  out.close();
		   } catch (Exception e1)  {
			  e1.printStackTrace();
		   }  
		}				
	}
}
