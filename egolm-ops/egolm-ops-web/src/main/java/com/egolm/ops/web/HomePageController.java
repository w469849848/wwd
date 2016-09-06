package com.egolm.ops.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.egolm.advert.api.TShopAdvertQueryApi;
import com.egolm.common.EgolmException;
import com.egolm.customer.api.PostSaleApi;
import com.egolm.dealer.api.AgentQueryApi;
import com.egolm.dealer.api.RegionQueryApi;
import com.egolm.dealer.api.TACTmpGoodsPromoQueryApi;
import com.egolm.dealer.api.TAlterACGoodsDtlQueryApi;
import com.egolm.notice.api.NoticeApi;
import com.egolm.order.api.TSalesOrderSubQueryApi;
import com.egolm.report.api.ReportEChartsQueryApi;
import com.egolm.sales.api.driver.DriverApi;
import com.egolm.security.utils.SecurityContextUtil;
import com.google.common.collect.Lists;

@Controller
@RequestMapping
public class HomePageController {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	@Resource(name = "tShopAdvertQueryApi")
	private TShopAdvertQueryApi tShopAdvertQueryApi;
	@Resource(name = "tAlterACGoodsDtlQueryApi")
	private TAlterACGoodsDtlQueryApi tAlterACGoodsDtlQueryApi;
	@Resource(name = "tACTmpGoodsPromoQueryApi")
	private TACTmpGoodsPromoQueryApi tACTmpGoodsPromoQueryApi;
	@Resource(name = "tSalesOrderSubQueryApi")
	private TSalesOrderSubQueryApi tSalesOrderSubQueryApi;
	@Resource(name = "noticeApi")
	private NoticeApi noticeApi;
	@Resource(name = "agentQueryApi")
	private AgentQueryApi agentQueryApi;
	@Resource
	private DriverApi driverApi;
	@Resource(name = "reportEChartsQueryApi")
	private ReportEChartsQueryApi reportEChartsQueryApi;
	@Resource(name = "regionQueryApi")
	private RegionQueryApi regionQueryApi;
	@Resource
	private PostSaleApi postSaleApi;

	private final List<String> paths;
	private final List<String> params;
	private final List<String> buttons;
	private final List<String> titles;
	{
		paths = Lists.newArrayList("/order/tSalesOrderSub/list","/order/tSalesOrderSub/list","/dealer/acGoods/list","/tmpPromo/list","/media/mediaContext/waitAuditlist","#","/salesman/toSalesManList","/logistics/driver/queryDrivers","/dealer/agentList","/postsale/advice/index");
		params = Lists.newArrayList("?sSalesOrderTypeID=0&nOrderStatus=2","?sSalesOrderTypeID=2","","","","","","","","");
		buttons = Lists.newArrayList("saleOrderWaitCount","refundOrderWaitCount","goodsDtlWaitCount","tmpPromoWaitCount","adWaitCount","msgWaitCount","bizWaitCount","driverWaitCount","agentWaitCount","adviceWaitCount");
		titles = Lists.newArrayList("待处理订单","待处理退单","待审核商品","待审核活动","待审核广告","待审核消息","待审核业务员","待审核司机","待审核经销商","待回复建议");
	}
	
	@RequestMapping("/index")
	public ModelAndView indexPage() {
		ModelAndView mv = new ModelAndView("index.jsp");
		U.logger.info(JSON.toJSONString(buttons));
		mv.addObject("paths", paths);
		mv.addObject("params", params);
		mv.addObject("buttons", buttons);
		mv.addObject("titles", titles);
		return mv;
	}

	@RequestMapping("/pageLimitExample")
	public String pageLimitExample(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("nGoodsID");
		}
		List<Map<String, Object>> datas = jdbcTemplate.limit("select * from tYWCart", page);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		return "/pageLimitExample.jsp";
	}

	@RequestMapping("/indexECharts")
	public void indexECharts(HttpServletRequest request, Writer writer) {
		String userid = SecurityContextUtil.getUserId();
		String userType = SecurityContextUtil.getUserType().getValue();
		String sOrgNo = SecurityContextUtil.getRegionId();
		Map<String, Object> params = new HashMap<String, Object>();
		Map<String, Object> dataMap = null;
		if (userType.equals("AGENT")) { // 经销商
			params.put("nAgentID", userid);
			params.put("sOrgNO", sOrgNo);
			dataMap = this.reportEChartsQueryApi.queryEChartsMsg(params, "agentOrderReport");

		}
		if (userType.equals("OPERATOR") || userType.equals("ADMIN")) { // 运营人员
			dataMap = this.reportEChartsQueryApi.queryEChartsMsg(params, "operatorOrderReport");
		}
		
		if(dataMap != null){
			boolean result = (boolean) dataMap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList");
				Egox.egoxOk().setDataList(dataList).set("userType", userType).write(writer);
			} else {
				Egox.egoxErr().setReturnValue("销售数据获取失败").set("userType", userType).write(writer);
			}
		}else{
			Egox.egoxErr().setReturnValue("销售数据获取失败").set("userType", userType).write(writer);
		} 
	}
	
	/**
	 * 根据省份查询该省份下的订单金额及数量
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/indexEchartsProvince")
	public void indexEchartsProvince(HttpServletRequest request, Writer writer){
		String sUpOrgNO = request.getParameter("upOrgNo");  //省份编号
		String orgName = request.getParameter("orgName"); //省份名称，对应的是报表上的名称，非数据库中组织机构名称，用于计算拼音，加载对应的省份json
		String sRegionNO= request.getParameter("sRegionNO"); //
		if(!U.isNotEmpty(sUpOrgNO)){
			Egox.egoxErr().setReturnValue("省份参数缺失").write(writer);
			return;
		}
		Egox egox = Egox.egoxOk();
		Map<String, Object>  regionDataMap = regionQueryApi.queryCityByProvinceId(sRegionNO);
		if(regionDataMap != null){
			boolean result = (boolean) regionDataMap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) regionDataMap.get("DataList");
				egox.set("regionList", dataList);
			}
		}
		
		String orgNamePinying = StringUtil.fullPinyin(orgName);
		if(orgName.equals("陕西")){
			orgNamePinying = orgNamePinying+"1";   //陕西与山西同音，  JSON后面 陕西多加一个1 区别
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("sUpOrgNO", sUpOrgNO); //key 不能变，与后端匹配了
		Map<String, Object> dataMap = this.reportEChartsQueryApi.queryEChartsMsg(params, "provinceReport");
		if(dataMap != null){
			boolean result = (boolean) dataMap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList");
				egox.setDataList(dataList).set("orgNamePinying",orgNamePinying).write(writer);
			} else {
				Egox.egoxErr().setReturnValue("省份销售数据获取失败").set("orgNamePinying",orgNamePinying).write(writer);
			}
		}else{
			Egox.egoxErr().setReturnValue("省份销售数据获取失败").set("orgNamePinying",orgNamePinying).write(writer);
		} 
	}
	 
	/**
	 * 首页的统计数据
	 * 
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/indexCount")
	public void indexCount(HttpServletRequest request, Writer writer) {
		Egox egox = Egox.egoxOk();
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		Map<String,Object> params = new HashMap<String,Object>();
		params.put("sOrgNO",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
		
		try {
			// 统计待审核广告数据
			Map<String, Object> adWaitCountMap = this.tShopAdvertQueryApi.queryWaitAuditTShopAdvertCount(params);
			boolean result = (boolean) adWaitCountMap.get("IsValid");
			if (result) {
				int adWaitCount = (int) adWaitCountMap.get("adWaitCount");
				egox.set("adWaitCount", adWaitCount);
			} else {
				egox.set("adWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待审核广告数据失败", e);
			egox.set("adWaitCount", -1); // 表示统计失败
		}

		try {
			// 统计待审核商品数据
			Map<String, Object> goodsDtlWaitCountMap = this.tAlterACGoodsDtlQueryApi.queryWaitAuditGoodsDtlCount(regionIds, params);
			boolean result = (boolean) goodsDtlWaitCountMap.get("IsValid");
			if (result) {
				int goodsDtlWaitCount = (int) goodsDtlWaitCountMap.get("goodsDtlWaitCount");
				egox.set("goodsDtlWaitCount", goodsDtlWaitCount);
			} else {
				egox.set("goodsDtlWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待审核商品数据失败", e);
			egox.set("goodsDtlWaitCount", -1); // 表示统计失败
		}

		try {
			// 统计待审核活动数据
			Map<String, Object> tmpPromoWaitCountMap = this.tACTmpGoodsPromoQueryApi.queryWaitAuditTmpPromoCount(params);
			boolean result = (boolean) tmpPromoWaitCountMap.get("IsValid");
			if (result) {
				int tmpPromoWaitCount = (int) tmpPromoWaitCountMap.get("tmpPromoWaitCount");
				egox.set("tmpPromoWaitCount", tmpPromoWaitCount);
			} else {
				egox.set("tmpPromoWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待审核活动数据失败", e);
			egox.set("tmpPromoWaitCount", -1); // 表示统计失败
		}

		try {
			// 统计待处理销售订单
			Map<String, Object> saleOrderWaitCountMap = this.tSalesOrderSubQueryApi.queryTSaleOrderSubCount(params,"0");
			boolean result = (boolean) saleOrderWaitCountMap.get("IsValid");
			if (result) {
				int saleOrderWaitCount = (int) saleOrderWaitCountMap.get("ordeWaitCount");
				egox.set("saleOrderWaitCount", saleOrderWaitCount);
			} else {
				egox.set("saleOrderWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待处理的销售订单数据失败", e);
			egox.set("saleOrderWaitCount", -1); // 表示统计失败
		}

		try {
			// 统计待处理退货订单
			Map<String, Object> saleOrderWaitCountMap = this.tSalesOrderSubQueryApi.queryTSaleOrderSubCount(params,"2");
			boolean result = (boolean) saleOrderWaitCountMap.get("IsValid");
			if (result) {
				int refundOrderWaitCount = (int) saleOrderWaitCountMap.get("ordeWaitCount");
				egox.set("refundOrderWaitCount", refundOrderWaitCount);
			} else {
				egox.set("refundOrderWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待处理退货订单数据失败", e);
			egox.set("refundOrderWaitCount", -1); // 表示统计失败
		}

		try {
			// 统计待处理公告数据
			Map<String, Object> noticeWaitCountMap = this.noticeApi.queryWaitAuditCount(params);
			boolean result = (boolean) noticeWaitCountMap.get("IsValid");
			if (result) {
				int noticeWaitCount = (int) noticeWaitCountMap.get("noticeWaitCount");
				egox.set("noticeWaitCount", noticeWaitCount);
			} else {
				egox.set("noticeWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待处理公告数据失败", e);
			egox.set("noticeWaitCount", -1); // 表示统计失败
		}
		try {
			// 统计待处理公告数据
			Map<String, Object> agentWaitCountMap = this.agentQueryApi.queryWaitAuditAgentCount(regionIds, params);
			boolean result = (boolean) agentWaitCountMap.get("IsValid");
			if (result) {
				int agentWaitCount = (int) agentWaitCountMap.get("agentWaitCount");
				egox.set("agentWaitCount", agentWaitCount);
			} else {
				egox.set("agentWaitCount", -1); // 表示统计失败
			}
		} catch (Exception e) {
			U.logger.error("统计待处理经销商数据失败", e);
			egox.set("agentWaitCount", -1); // 表示统计失败
		}

		try {
			int count = driverApi.countPreAuditDrivers();
			egox.set("driverWaitCount", count);
		} catch (EgolmException e) {
			U.logger.error("", e);
			egox.set("driverWaitCount", 0);
		} catch (Throwable e) {
			U.logger.error("", e);
			egox.set("driverWaitCount", 0);
		}
		
		try {
			int count = postSaleApi.countPreReplyAdvices();
			egox.set("adviceWaitCount", count);
		} catch (EgolmException e) {
			U.logger.error("", e);
			egox.set("adviceWaitCount", 0);
		} catch (Throwable e) {
			U.logger.error("", e);
			egox.set("adviceWaitCount", 0);
		}
		
		egox.write(writer);
	}

	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
