package com.egolm.advert.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.Writer;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.advert.api.TShopAdPosContractAddApi;
import com.egolm.advert.api.TShopAdvertAddApi;
import com.egolm.advert.api.TShopAdvertQueryApi;
import com.egolm.advert.api.TShopAdvertUpdateApi;
import com.egolm.advert.domain.AdReportDto;
import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.common.advert.AdvertContants;
import com.egolm.common.enums.UserType;
import com.egolm.common.goods.GoodsContants;
import com.egolm.config.core.reader.ConfigReader;
import com.egolm.config.core.utils.ConfigPath;
import com.egolm.domain.TSalesOrderSub;
import com.egolm.domain.TShopAdPosContract;
import com.egolm.domain.TShopAdvert;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.util.ExportExcelUtil;

/**
 * 广告控制器
 * 
 * @Title:
 * @Description:
 * @author zhangyong
 * @date 2016年4月9日 上午9:20:20
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/media/mediaContext")
public class TShopAdVertController extends BaseAdvertController {
	
	@Resource(name = "tShopAdvertAddApi")
	private TShopAdvertAddApi tShopAdvertAddApi;
	@Resource(name = "tShopAdvertQueryApi")
	private TShopAdvertQueryApi tShopAdvertQueryApi;
	@Resource(name = "tShopAdvertUpdateApi")
	private TShopAdvertUpdateApi tShopAdvertUpdateApi;

	@Resource(name = "tShopAdPosContractAddApi")
	private TShopAdPosContractAddApi tShopAdPosContractAddApi;
	
 
	
	private String imgUrl = ConfigReader.getProperty(ConfigPath.cpath("G:system.properties"), "pic.img.url", "http://img.egolm.com");
 
	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	@RequestMapping(value = "/listIndex")
	public String adVertListIndex() {
		return "/media/mediaContent-manage.jsp";
	}

	@RequestMapping(value = "/addIndex")
	public String adVertIndex() {
		return "/media/add-media-content.jsp";
	}
	@RequestMapping(value = "/adVertReport")
	public String adVertReport(){
		return "/media/mediaContent-report.jsp";
	}
	
	@RequestMapping(value = "/adEChartReport")
	public String adEChartReport(HttpServletRequest request){
		String nAdId = request.getParameter("nAdId");
		request.setAttribute("nAdId", nAdId);
		return "/media/mediaReport-select.jsp";
	}
	
	
	@RequestMapping(value = "/adPosSelect")
	public String adPosSelect(HttpServletRequest request){
		String sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
		String sApSaleTypeID = request.getParameter("sApSaleTypeID");
		String type = request.getParameter("type"); //select 为查询  ，add 为新增或编辑
		
		request.setAttribute("type", type);
		request.setAttribute("sAdZoneCodeID", sAdZoneCodeID);
		request.setAttribute("sApSaleTypeID", sApSaleTypeID);
		return "/media/mediaPos-select.jsp";
	}
	
	
	/**
	 * 新增 编辑时 的弹框 选择商品或品牌
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/adVertSelect")
	public String adVertSelect(HttpServletRequest request){
		String sAdJumpTypeId = request.getParameter("sAdJumpTypeId"); //链接类型 
		request.setAttribute("sAdJumpTypeId", sAdJumpTypeId);
		String nAgentID = request.getParameter("nAgentID");  //经销商ID
		String sOrgNO = request.getParameter("sOrgNO");  //区域ID
		request.setAttribute("nAgentID", nAgentID);
		request.setAttribute("sOrgNO", sOrgNO);  
		return "/media/media-select.jsp";
	}	
	
	/**
	 * 分页获取所有广告
	 * 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc");
		String sAdTitle = request.getParameter("sAdTitle");
		String nApID = request.getParameter("nApID");
		String sApTitle = request.getParameter("sApTitle");
		String sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
		String sApSaleTypeID = request.getParameter("sApSaleTypeID");
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP

			params = setMapByPar(request, params,"ad", "com.egolm.domain.TShopAdvert");
			params = setMapByPar(request, params,"ap", "com.egolm.domain.TShopAdPos");
			
 			
			boolean isCheck = false;
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf(UserType.ADMIN)) { //管理员
				isCheck = true;
				if(U.isNotEmpty(sAdZoneCodeID)){
					params.put("ad.sAdZoneCodeID",StringUtil.join("','","'","'",sAdZoneCodeID));
				}
			}else if(userType.oneOf(UserType.OPERATOR)){ //运营人员
				if(!U.isNotEmpty(sAdZoneCodeID)){
					params.put("ad.sAdZoneCodeID",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				}else{
					params.put("ad.sAdZoneCodeID",StringUtil.join("','","'","'",sAdZoneCodeID));
				}
				isCheck = true;
			}else if(userType.oneOf(UserType.AGENT)){  //经销商
				 String nAgentID = SecurityContextUtil.getUserId(); 
				 if(U.isNotEmpty(nAgentID)){
					 params.put("nAgentID", nAgentID);
				 }
				 if(U.isNotEmpty(sAdZoneCodeID)){
					params.put("ad.sAdZoneCodeID",StringUtil.join("','","'","'",sAdZoneCodeID));
				 }else{
					 params.put("ad.sAdZoneCodeID",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				 }
				 isCheck = true;
 			}else{
 				U.logger.error("广告管理:"+userType.getDescription()+"非法访问此功能");
 			}
			if(isCheck){
				
				Map<String, Object> resultMap = tShopAdvertQueryApi.query(params, page);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultMap.get("DataList");
					page = U.objTo(resultMap.get("page"), PageSqlserver.class);
					map.put("adVertList", dataList);
					map.put("page", page);
					map.put("imgUrl", imgUrl);
				}
			}else{
				U.logger.info("账号:"+SecurityContextUtil.getUserName()+"无查看广告管理的权限 ");
			} 

		} catch (Exception e) {
			U.logger.error("广告查询请求出错,", e);
		}
		map.put("nApID", nApID);
		map.put("sApTitle", sApTitle);
		map.put("sAdTitle", sAdTitle);
		map.put("sAdZoneCodeID", sAdZoneCodeID);
		map.put("sApSaleTypeID", sApSaleTypeID);
		ModelAndView mv = new ModelAndView("/media/mediaContent-manage.jsp", map);
		return mv;
	}

	/**
	 * 获取待审核广告
	 * 
	 * @param request
	 * @param page
	 * @return
	 */
	@RequestMapping(value = "/waitAuditlist")
	public ModelAndView waitAuditlist(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc");
		String sApTitle = request.getParameter("sApTitle"); 
 		String nApID = request.getParameter("nApID");
		String sAdTitle = request.getParameter("sAdTitle");
		String sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
		String sApSaleTypeID = request.getParameter("sApSaleTypeID");
		try {
 			
			boolean isCheck = false;
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			request.setAttribute("nTag", AdvertContants.NTAG_1 + "");
			params = setMapByAttr(request, params,"ad", "com.egolm.domain.TShopAdvert");
			params = setMapByPar(request, params,"ad", "com.egolm.domain.TShopAdvert");
			params = setMapByPar(request, params,"ap", "com.egolm.domain.TShopAdPos");
			
			if(params.containsKey("ad.sAdZoneCodeID")){
				params.put("ad.sAdZoneCodeID", StringUtil.join("','","'","'",params.get("ad.sAdZoneCodeID")+""));
			}
			 
			
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf(UserType.ADMIN)) { //管理员
				isCheck = true; 
			}else if(userType.oneOf(UserType.OPERATOR)){ //运营人员
				if(!U.isNotEmpty(sAdZoneCodeID)){
					params.put("sAdZoneCodeID",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()) );
				}
				isCheck = true;
			}else if(userType.oneOf(UserType.AGENT)){  //经销商
				 String nAgentID = SecurityContextUtil.getUserId(); 
				 if(U.isNotEmpty(nAgentID)){
					 params.put("nAgentID", nAgentID);
				 }
				 if(U.isNotEmpty(sAdZoneCodeID)){
					 params.put("sAdZoneCodeID",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				 }
				 isCheck = true;
 			}else{
 				U.logger.error("广告审核:"+userType.getDescription()+"非法访问此功能");
 			}
 			
			if(isCheck){
				
				Map<String, Object> resultMap = tShopAdvertQueryApi.query(params, page);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultMap.get("DataList");
					page = U.objTo(resultMap.get("page"), PageSqlserver.class);
					map.put("adVertList", dataList);
					map.put("page", page);
					map.put("imgUrl", imgUrl);
				}

			}else{
				U.logger.info("账号:"+SecurityContextUtil.getUserName()+"无查看广告审核的权限 ");
			}
			
		} catch (Exception e) {
			U.logger.error("广告查询请求出错,", e);
		}
		map.put("nApID", nApID);
		map.put("sApTitle", sApTitle);
		map.put("sAdTitle", sAdTitle);
		map.put("sAdZoneCodeID", sAdZoneCodeID);
		map.put("sApSaleTypeID", sApSaleTypeID);
		ModelAndView mv = new ModelAndView("/media/mediaContent-audit.jsp", map);
		return mv;
	}

	/**
	 * 新增广告 或编辑广告
	 * 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/add", method =RequestMethod.POST)
	public void add(@RequestParam(value = "filePath", required = false) MultipartFile file,HttpServletRequest request, Writer writer) {
		try {
			TShopAdvert tShopAdvert = new TShopAdvert();
			String nAdID = request.getParameter("nAdID");
			String dAdBeginTime = request.getParameter("dAdBeginTime");
			String dAdEndTime = request.getParameter("dAdEndTime");
			String nAdGold = request.getParameter("nAdGold");
			String nAdSlideSequence = request.getParameter("nAdSlideSequence");
			String sAdText = request.getParameter("sAdText");
			String sAdTitle = request.getParameter("sAdTitle");
			String sAdJumpUrl = request.getParameter("sAdJumpUrl");
			String nApID = request.getParameter("nApID");
			String sAdUserId = request.getParameter("sAdUserId");
			String sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
			String sAdZoneCode = request.getParameter("sAdZoneCode");
			String nContractID = request.getParameter("nContractID");
			String nBID = request.getParameter("nBID");
			String sAdJumpTypeId= request.getParameter("sAdJumpTypeId");
			String sAdJumpType = request.getParameter("sAdJumpType");
			String sAdJumpNo = request.getParameter("sAdJumpNo");
 			String sApSaleTypeID = request.getParameter("sApSaleTypeID");
			String nAdShowGoodsMsgID = request.getParameter("nAdShowGoodsMsgID");
			String sAdShowGoodsMsg = request.getParameter("sAdShowGoodsMsg");
 			String nAdHeight= request.getParameter("nAdHeight");
 			String nAdWidth = request.getParameter("nAdWidth");
 			if(U.isNotEmpty(sAdJumpTypeId)){
 				
 				if(U.isNotEmpty(sAdJumpNo)){
 					if(sAdJumpTypeId.equals("goods")){  //设置商品跳转链接
 	 					sAdJumpUrl = GoodsContants.GOODS_DETAIL_URL+""+sAdJumpNo;
 	 				}
 	 				if(sAdJumpTypeId.equals("brand")){  //设置品牌跳转链接
 	 					sAdJumpUrl = GoodsContants.BRAND_DETAIL_URL+""+sAdJumpNo;
 	 				}
 				} 
 				
 				if(sAdJumpTypeId.equals("activity")){  //设置活动跳转链接
 					sAdJumpUrl = GoodsContants.ACTIVITY_DETAIL_URL;
 				}
 			}
 			
			if(U.isNotEmpty(nAdID)){
				tShopAdvert.setNAdID(To.objTo(nAdID, Integer.class, null));
			}
			tShopAdvert.setDAdBeginTime(DateUtil.parse(dAdBeginTime,DateUtil.FMT_DATE));
			tShopAdvert.setDAdEndTime(DateUtil.parse(dAdEndTime,DateUtil.FMT_DATE));
			tShopAdvert.setNAdGold(To.objTo(nAdGold, BigDecimal.class, new BigDecimal(0)));
			tShopAdvert.setNAdSlideSequence(To.objTo(nAdSlideSequence, Integer.class, new Integer(1)));
			tShopAdvert.setSAdText(sAdText);
			tShopAdvert.setSAdTitle(sAdTitle);
			tShopAdvert.setSAdJumpUrl(sAdJumpUrl);
			tShopAdvert.setNApID(To.objTo(nApID, Integer.class));
			tShopAdvert.setSAdUserId(sAdUserId);
			tShopAdvert.setSAdZoneCodeID(sAdZoneCodeID);
			tShopAdvert.setSAdZoneCode(sAdZoneCode);
			tShopAdvert.setNContractID(To.objTo(nContractID, Integer.class));
			tShopAdvert.setNBID(To.objTo(nBID, Integer.class, null));
			tShopAdvert.setSAdJumpTypeId(sAdJumpTypeId);
			tShopAdvert.setSAdJumpType(sAdJumpType);
			tShopAdvert.setSAdJumpNo(sAdJumpNo);			
			tShopAdvert.setNAdShowGoodsMsgID(To.objTo(nAdShowGoodsMsgID, Integer.class));
			tShopAdvert.setSAdShowGoodsMsg(sAdShowGoodsMsg);
			tShopAdvert.setNAdWidth(To.objTo(nAdWidth, BigDecimal.class));
			tShopAdvert.setNAdHeight(To.objTo(nAdHeight, BigDecimal.class));
			
			TShopAdvert updateTShopAdvert = new TShopAdvert();
			if (U.isNotEmpty(tShopAdvert.getNAdID())) {
				Map<String, Object> idMap = this.tShopAdvertQueryApi.queryTShopAdvertById(tShopAdvert.getNAdID()+"");
				boolean idResult = (boolean) idMap.get("IsValid");
				if (idResult) {
					Map<String, Object> dataMap = (Map<String, Object>) idMap.get("DataList");
					updateTShopAdvert = To.mapTo(dataMap, TShopAdvert.class);
				} else {
					Egox.egoxErr().setReturnValue("广告编辑失败,广告位不存在").write(writer);
					return;
				}
			}
			
			boolean isUploadFile = false;
			if(file != null){
				String fileName = file.getOriginalFilename();
				if(StringUtil.isNotEmpty(fileName)){
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.AD_PATH+""+sApSaleTypeID+"/"+tShopAdvert.getSAdZoneCodeID()+"/2/"+OSSUtils.getFileNewName(fileName);
					//上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream()); 
					OSSUtils.closeOssClient(); 
					isUploadFile = true;
					tShopAdvert.setSAdPathUrl("/"+key); 
				}				
			} 
 

			if (StringUtil.isNotEmpty(tShopAdvert.getNAdID())) {
				updateTShopAdvert.setDAdBeginTime(tShopAdvert.getDAdBeginTime());
				updateTShopAdvert.setDAdEndTime(tShopAdvert.getDAdEndTime());
				updateTShopAdvert.setNAdGold(To.objTo(tShopAdvert.getNAdGold(), BigDecimal.class, new BigDecimal(0)));
				updateTShopAdvert.setNAdSlideSequence(To.objTo(tShopAdvert.getNAdSlideSequence(), Integer.class, new Integer(0)));
				updateTShopAdvert.setSAdText(tShopAdvert.getSAdText());
				updateTShopAdvert.setSAdTitle(tShopAdvert.getSAdTitle()); 
				updateTShopAdvert.setSAdUserId(tShopAdvert.getSAdUserId());
				updateTShopAdvert.setSAdZoneCodeID(tShopAdvert.getSAdZoneCodeID());
				updateTShopAdvert.setSAdZoneCode(tShopAdvert.getSAdZoneCode());
				updateTShopAdvert.setNContractID(tShopAdvert.getNContractID());
				updateTShopAdvert.setNBID(tShopAdvert.getNBID());
				updateTShopAdvert.setNApID(tShopAdvert.getNApID()); 
				updateTShopAdvert.setSAdJumpTypeId(sAdJumpTypeId);
				updateTShopAdvert.setSAdJumpType(sAdJumpType);
				updateTShopAdvert.setSAdJumpNo(sAdJumpNo);
				updateTShopAdvert.setSAdJumpUrl(sAdJumpUrl);
				updateTShopAdvert.setNAdShowGoodsMsgID(To.objTo(nAdShowGoodsMsgID, Integer.class));
				updateTShopAdvert.setSAdShowGoodsMsg(sAdShowGoodsMsg);
				updateTShopAdvert.setNAdWidth(To.objTo(nAdWidth, BigDecimal.class));
				updateTShopAdvert.setNAdHeight(To.objTo(nAdHeight, BigDecimal.class));
				
 				if(isUploadFile){
					updateTShopAdvert.setSAdPathUrl(tShopAdvert.getSAdPathUrl());
				}
				Map<String, Object> resultMap = this.tShopAdvertUpdateApi.updateTShopAdvert(updateTShopAdvert);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Egox.egoxOk().setReturnValue("广告编辑成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("广告编辑失败").write(writer);
				}

			} else {
				tShopAdvert.setNAdClickNum(0);

				tShopAdvert.setSCreateUser(SecurityContextUtil.getUserName());
				Map<String, Object> resultMap = this.tShopAdvertAddApi.createTShopAdvert(tShopAdvert);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					/*Integer saveAdID = (Integer) resultMap.get("nAdId");
					if (StringUtil.isNotEmpty(saveAdID)) {
						TShopAdPosContract tShopAdPosContract = new TShopAdPosContract();
						tShopAdPosContract.setNContractID(tShopAdvert.getNContractID());
						tShopAdPosContract.setNApID(Integer.valueOf(saveAdID));
						tShopAdPosContract.setSBID(111);
						tShopAdPosContract.setSCreateUser(SecurityContextUtil.getUserName());
						tShopAdPosContractAddApi.createTShopAdPosContract(tShopAdPosContract);
					}*/
					Egox.egoxOk().setReturnValue("广告添加成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("广告添加失败").write(writer);
				}

			}

		} catch (Exception e) {
			U.logger.error("广告新增出错,", e);
			Egox.egoxErr().setReturnValue("广告添加失败").write(writer);
		}
	}

	/**
	 * 删除广告
	 * 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/delete")
	public void delete(HttpServletRequest request, Writer writer) {
		try {
			String nAdID = request.getParameter("id");
			if (StringUtil.isNotEmpty(nAdID)) {
				Map<String, Object> resultMap = this.tShopAdvertUpdateApi
						.updateTShopAdvertNTagByApId(Integer.valueOf(nAdID), AdvertContants.NTAG_0);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Egox.egoxOk().setReturnValue("广告删除成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("广告删除失败").write(writer);
				}
			} else {
				Egox.egoxErr().setReturnValue("广告删除失败").write(writer);
			}
		} catch (Exception e) {
			U.logger.error("广告删除出错,", e);
			Egox.egoxErr().setReturnValue("广告删除失败").write(writer);
		}
	}

	/**
	 * 根据ID获取广告
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/loadMsgById")
	public ModelAndView loadMsgById(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String nAdID = request.getParameter("id");
			Map<String, Object> resultMap = this.tShopAdvertQueryApi.queryTShopAdvertAndPosAndContractByAdId(nAdID);
			boolean result = (boolean) resultMap.get("IsValid");
			if (result) {
				map.put("adVertData", resultMap.get("DataList"));
			}

		} catch (Exception e) {
			U.logger.error("获取广告信息出错,", e);
		}
		ModelAndView mv = new ModelAndView("/media/add-media-content.jsp", map);
		return mv;
	}

	/**
	 * 广告审核
	 * 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/auditTShopAdvert")
	public void auditTShopAdvert(HttpServletRequest request, Writer writer) {
		try {
			String nAdID = request.getParameter("id");
			String nTag = request.getParameter("nTag");
			String sMemo = request.getParameter("sMemo");
			
			String[] strArray = new String[4];
			strArray[0]=nTag;
			strArray[1]=sMemo;
			strArray[2]=SecurityContextUtil.getUserName();
			strArray[3]=nAdID;
			
			Map<String, Object> resultMap = this.tShopAdvertUpdateApi.updateTShopAdvertNTagByAdId(strArray);
			boolean result = (boolean) resultMap.get("IsValid");
			if (result) {
				Egox.egoxOk().setReturnValue("广告审核成功").write(writer);
			}else{
				Egox.egoxErr().setReturnValue("广告审核失败").write(writer);
			} 
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("系统异常:广告审核失败").write(writer);
			U.logger.error("广告审核出错,", e);
		}
	}
	
	/**
	 * 广告统计报表
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/adReport")
	public void  adReport(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page, Writer writer){
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey(" clickNum desc");
		try {
			String  sAdTitle = request.getParameter("sAdTitle");
			String  sApSaleTypeID = request.getParameter("sApSaleTypeID");
			String  sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
			String  sScopeTypeID = request.getParameter("sScopeTypeID");
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			if(U.isNotEmpty(sAdTitle)){
				params.put("sAdTitle", sAdTitle);
			}
			 
			
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf(UserType.ADMIN)) { //管理员
				if(U.isNotEmpty(sAdZoneCodeID)){
					params.put("sAdZoneCodeID", StringUtil.join("','","'","'",sAdZoneCodeID));
				}
 			}else if(userType.oneOf(UserType.OPERATOR)){ //运营人员
				if(!U.isNotEmpty(sAdZoneCodeID)){
					params.put("sAdZoneCodeID", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				}else{
					params.put("sAdZoneCodeID",StringUtil.join("','","'","'",sAdZoneCodeID));
				}
			}else if(userType.oneOf(UserType.AGENT)){  //经销商
				 String nAgentID = SecurityContextUtil.getUserId(); 
				 if(U.isNotEmpty(nAgentID)){
					 params.put("nAgentID", nAgentID);
				 }
				 if(U.isNotEmpty(sAdZoneCodeID)){
					params.put("sAdZoneCodeID",StringUtil.join("','","'","'",sAdZoneCodeID));
				 }else{
					 params.put("sAdZoneCodeID", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				 }
 			}else{
 				U.logger.error("广告统计:"+userType.getDescription()+"非法访问此功能");
 				Egox.egoxErr().setReturnValue("非法访问").write(writer);
 				return;
 			}
			if(U.isNotEmpty(sApSaleTypeID)){
				params.put("sApSaleTypeID", sApSaleTypeID);
			}
			if(U.isNotEmpty(sScopeTypeID)){
				params.put("sScopeTypeID", sScopeTypeID);
			}
			
			Map<String, Object>  dataMap = (Map<String, Object> )tShopAdvertQueryApi.queryAdReport(params,page);
			boolean result = (boolean) dataMap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>)dataMap.get("DataList");
				page = U.objTo(dataMap.get("page"), PageSqlserver.class);
				 
				Egox.egoxOk().setDataList(dataList).set("page", page).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("广告数据统计失败").write(writer);
			}
		} catch (Exception e) {
			U.logger.error("广告数据统计异常",e);
			Egox.egoxErr().setReturnValue("广告数据统计失败").write(writer);
		}
	}
	/**
	 * 广告统计导出
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/exportExcel")
	public void exportExcel(HttpServletRequest request,   HttpServletResponse response){
		PageSqlserver page = new PageSqlserver();
		page.setIndex(1L);
		page.setLimit(10000);
		page.setLimitKey(" clickNum desc");
		String  sAdTitle = request.getParameter("sAdTitle");
		String  sApSaleTypeID = request.getParameter("sApSaleTypeID");
		String  sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
		String  sScopeTypeID = request.getParameter("sScopeTypeID");
		Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
		if(U.isNotEmpty(sAdTitle)){
			params.put("sAdTitle", sAdTitle);	
		}
		UserType userType = SecurityContextUtil.getUserType();
		if (userType.oneOf(UserType.ADMIN)) { //管理员
			if(U.isNotEmpty(sAdZoneCodeID)){
				params.put("sAdZoneCodeID", StringUtil.join("','","'","'",sAdZoneCodeID));
			}
		}else if(userType.oneOf(UserType.OPERATOR)){ //运营人员
			if(!U.isNotEmpty(sAdZoneCodeID)){
				params.put("sAdZoneCodeID", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
			}else{
				params.put("sAdZoneCodeID", StringUtil.join("','","'","'",sAdZoneCodeID));
			}
		}else if(userType.oneOf(UserType.AGENT)){  //经销商
			 String nAgentID = SecurityContextUtil.getUserId(); 
			 if(U.isNotEmpty(nAgentID)){
				 params.put("nAgentID", nAgentID);
			 }
			 if(U.isNotEmpty(sAdZoneCodeID)){
				params.put("sAdZoneCodeID", StringUtil.join("','","'","'",sAdZoneCodeID));
			 }else{
				 params.put("sAdZoneCodeID",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
			 }
			}else{
				U.logger.error("广告统计:"+userType.getDescription()+"非法访问此功能");
		}
		if(U.isNotEmpty(sApSaleTypeID)){
			params.put("sApSaleTypeID", sApSaleTypeID);
		}
		if(U.isNotEmpty(sScopeTypeID)){
			params.put("sScopeTypeID", sScopeTypeID);
		}
		
		Map<String, Object>  dataMap = (Map<String, Object> )tShopAdvertQueryApi.queryAdReport(params,page);
		boolean result = (boolean) dataMap.get("IsValid");
		if(result){
			List<Map<String, Object>> dataList = (List<Map<String, Object>>)dataMap.get("DataList");
			if(dataList != null && dataList.size()>0){
				List<AdReportDto> adReportList = new ArrayList<AdReportDto>();
				for(Map<String,Object> mapData :dataList){
					adReportList.add(To.mapTo(mapData, AdReportDto.class));
				}
				
				ExportExcelUtil<AdReportDto> excelUtil=new ExportExcelUtil<AdReportDto>();
			    OutputStream out=null;
			   try {
				  	out = response.getOutputStream();// 取得输出流   
			        response.reset();// 清空输出流  
			        response.setHeader("Content-disposition", "attachment; filename="+new String("广告报表".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
			        response.setContentType("application/msexcel");// 定义输出类型
			   }  catch (IOException e) {
				  		e.printStackTrace();
			   }  
			   String[] headers ={"编号","广告名称","广告价格(元/天)","开始时间","结束时间","所属区域","访问量(PV)","访客量(UV)","点击数","独立点击IP数","点击率(CTR)","购物车转化率(CVR)","订单数量","订单金额(元)","订单转化率(CVR)","订单转化成本(CPA)","平均点击价格(CPC)","投资回报率(ROI)"};
			   String[]columns={"nadId","sadTitle","napPrice","dadBeginTime","dadEndTime","sadZoneCode","showNum","showIpNum","clickNum","clickIpNum","ctr","shop_cvr","orderCount","orderTotal","order_cvr","cpa","cpc","roi"};
		 	   try  {
				  excelUtil.exportExcel("广告统计", headers, columns, adReportList, out, "");
				  out.close();
			   } catch (Exception e1)  {
				  e1.printStackTrace();
			   }  
			}	
		}else{
			 
		} 
	}
	
	/**
	 * 广告的 7天的线性图
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/adLineReport")
	public void  adServenReport(HttpServletRequest request,  Writer writer){
		try {
			
			String nAdId = request.getParameter("nAdId");
			Map<String,Object> dataMap = tShopAdvertQueryApi.queryReportByAdId(nAdId); //统计的数据
			Egox egox = Egox.egox(dataMap);
			
			
			Map<String, Object> idMap = this.tShopAdvertQueryApi.queryTShopAdvertById(nAdId);
			boolean idResult = (boolean) idMap.get("IsValid");
			if (idResult) {
				Map<String, Object> adMap = (Map<String, Object>) idMap.get("DataList");
				String sAdTitle= adMap.get("sAdTitle")+"";
				egox.set("sAdTitle", sAdTitle);
				 
			} 
			egox.write(writer);
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("统计广告数据失败").write(writer);
		}
	}
}
