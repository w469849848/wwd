package com.egolm.customer.web;

import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.EgolmException;
import com.egolm.common.EgolmLogger;
import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.common.cust.CustContants;
import com.egolm.customer.api.ICustomerInfo;
import com.egolm.customer.api.IShopInfo;
import com.egolm.customer.api.IShopPic;
import com.egolm.customer.api.TShopLocationInfo;
import com.egolm.dealer.api.RegionQueryApi;
import com.egolm.domain.TCustCustomerInfo;
import com.egolm.domain.TShopInfo;
import com.egolm.domain.TShopLocationEntity;
import com.egolm.domain.TShopPic;
import com.egolm.sales.api.SalesManQueryApi;
import com.egolm.security.utils.SecurityContextUtil;
import com.google.common.collect.Maps;

import me.chanjar.weixin.common.util.StringUtils;
import net.sf.json.JSONObject;

/**
 * @Title: 门店店铺信息controller
 * @author TZH_PC
 *
 */
@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/shop")
public class ShopController extends BaseCustController {

	@Resource(name = "idShopApi")
	private IShopInfo shopApi;
	
	@Resource(name = "tShopLocationInfo")
	private TShopLocationInfo tShopLocationInfo;

	@Resource(name = "idShopPicApi")
	private IShopPic shopPicApi;

	@Resource(name = "regionQueryApi")
	private RegionQueryApi regionQueryApi;

	@Resource(name = "idCustomerApi")
	private ICustomerInfo customerApi;

	@Resource(name = "salesManQueryApi")
	private SalesManQueryApi salesManQueryApi;
	
	@Resource
	private TOrgsQueryApi  tOrgsQueryApi;

	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	@RequestMapping(value = "/shopList")
	public ModelAndView shopList(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();

		String sShopName = request.getParameter("sShopName");
		String sDistrictID = request.getParameter("sDistrictID");
		String sDistrict = request.getParameter("sDistrict");
		String sAddress = request.getParameter("sAddress");
		List<Map<String,Object>> districtList = null;
		try {
			List<String> regionIds = SecurityContextUtil.getRegionIds();
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
			}
			Map<String, Object> params = searchSQL(request, page, "par", "com.egolm.domain.TShopInfo");
			Map<String, Object> resultmap = shopApi.queryTShopInfo(regionIds, params, page);
			districtList = shopApi.findDistrict(regionIds);

			boolean result = (boolean) resultmap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");

				page = U.objTo(resultmap.get("page"), PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}

		} catch (Exception e) {
			U.logger.error("店铺信息查询请求出错", e);
		}
		ModelAndView mv = new ModelAndView("/customer/shop-manage.jsp", map);
		mv.addObject("sShopName", sShopName);
		mv.addObject("sDistrictID",sDistrictID);
		mv.addObject("sDistrict",sDistrict);
		mv.addObject("sAddress",sAddress);
		mv.addObject("districtList",districtList);
		return mv;
	}
	
	@RequestMapping(value = "/list/dialog")
	public ModelAndView shopListDialog(String search, @ModelAttribute("page") PageSqlserver page) {
		ModelAndView mv = new ModelAndView("/customer/shop-list-dialog.jsp");
		mv.addObject("search", search);
		try {
			List<String> regionIds = SecurityContextUtil.getRegionIds();
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
			}
			page.setLimit(10);
			Map<String, Object> param = Maps.newHashMapWithExpectedSize(4);
			param.put("sShopName", search);
			param.put("sDistrictID", search);
			param.put("sDistrict", search);
			param.put("sAddress", search);
			Map<String, Object> resultmap = shopApi.queryTShopInfo(regionIds, param, page);
			List<Map<String, Object>> orgs = tOrgsQueryApi.queryTOrgs(regionIds, 4);
			mv.addObject("shops", resultmap.get("DataList"));
			mv.addObject("page", resultmap.get("page"));
			mv.addObject("orgs", orgs);
		} catch (Exception e) {
			U.logger.error("店铺信息查询请求出错", e);
		}
		return mv;
	}
	

	/**
	 * 进入新增店铺页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddShop")
	public ModelAndView toAddShop(HttpServletRequest request) {

		Map<String, Object> map = regionQueryApi.queryProvinces();

		return new ModelAndView("/customer/shop-info.jsp", map);
	}

	/**
	 * 进入编辑店铺页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddOrEditShop")
	public ModelAndView toAddOrEditShop(HttpServletRequest request) {
		int nShopID = Integer.valueOf(request.getParameter("nShopID"));
		Map<String, Object> map = regionQueryApi.queryProvinces();
		TShopInfo shopInfo = shopApi.findById(nShopID);
		TCustCustomerInfo custInfo = null;

		TShopPic shopPic = shopPicApi.findById(shopInfo.getSShopNO());
		if (shopInfo != null && shopInfo.getSCustNO() != null) {
			custInfo = customerApi.findById(shopInfo.getSCustNO());
			if(shopInfo.getSSalesmanNO1()!=null){
				request.setAttribute("sSalesNO1", salesManQueryApi.queryTSalesManById(shopInfo.getSSalesmanNO1()));
			}
			if(shopInfo.getSSalesmanNO2()!=null){
				request.setAttribute("sSalesNO2", salesManQueryApi.queryTSalesManById(shopInfo.getSSalesmanNO2()));
			}
		}
		request.setAttribute("shopInfo", shopInfo);
		request.setAttribute("shopPic", shopPic);
		request.setAttribute("custInfo", custInfo);
		return new ModelAndView("/customer/shop-info.jsp", map);
	}

	/**
	 * 保存店铺信息
	 * 
	 * @param file
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/saveFormShopInfo", method = RequestMethod.POST)
	public void saveFormShopInfo(@RequestParam(value = "sURL", required = false) MultipartFile file,
			HttpServletRequest request, Writer writer) {
		try {
			Integer nShopID = request.getParameter("nShopID") != null ? Integer.valueOf(request.getParameter("nShopID"))
					: null;
			Integer ntag = CustContants.TAG_0;
			Double nStoreArea = request.getParameter("nStoreArea") != null
					? Double.valueOf(request.getParameter("nStoreArea")) : null;
			String sAddress = request.getParameter("sAddress");
			String sCity = request.getParameter("sCity");
			String sCityID = request.getParameter("sCityID");
			String sContacts = request.getParameter("sContacts");
			String sCustNO = request.getParameter("sCustNO");
			String sDistrict = request.getParameter("sDistrict");
			String sDistrictID = request.getParameter("sDistrictID");
			String sEmail = request.getParameter("sEmail");
			String sFax = request.getParameter("sFax");
			String sLatitude = request.getParameter("sLatitude");
			String sLongitude = request.getParameter("sLongitude");
			String sMemo = request.getParameter("sMemo");
			String sOrgNO = request.getParameter("sOrgNO");
			String sPostalcode = request.getParameter("sPostalcode");
			String sProvince = request.getParameter("sProvince");
			String sProvinceID = request.getParameter("sProvinceID");
			String sScopeType = request.getParameter("sScopeType");
			String sScopeTypeID = request.getParameter("sScopeTypeID");
			String sShopName = request.getParameter("sShopName");
			String sShopNO = request.getParameter("sShopNO") != null ? request.getParameter("sShopNO") : getShopNo();
			String sShopType = request.getParameter("sShopType");
			String sShopTypeID = request.getParameter("sShopTypeID");
			String sTel = request.getParameter("sTel");
			Date dFirstSaleDate = request.getParameter("dFirstSaleDate") != null
					? DateUtil.parse(request.getParameter("dFirstSaleDate"), DateUtil.FMT_DATE) : null;
			String sSalesmanNO1 = request.getParameter("sSalesmanNO1");
			String sSalesmanNO2 = request.getParameter("sSalesmanNO2");

			TShopInfo shopInfo = null;
			if (nShopID == null) {
				shopInfo = new TShopInfo();
			} else {
				shopInfo = shopApi.findById(nShopID);
			}
			shopInfo.setNShopID(nShopID);
			shopInfo.setNTag(ntag);
			shopInfo.setNStoreArea(nStoreArea);
			shopInfo.setSAddress(sAddress);
			shopInfo.setSCity(sCity);
			shopInfo.setSCityID(sCityID);
			shopInfo.setSContacts(sContacts);
			shopInfo.setSDistrict(sDistrict);
			shopInfo.setSDistrictID(sDistrictID);
			shopInfo.setSEmail(sEmail);
			shopInfo.setSFax(sFax);
			shopInfo.setSCustNO(sCustNO);
			shopInfo.setSLatitude(sLatitude);
			shopInfo.setSLongitude(sLongitude);
			shopInfo.setSMemo(sMemo);
			shopInfo.setSOrgNO(sOrgNO);
			shopInfo.setSPostalcode(sPostalcode);
			shopInfo.setSProvince(sProvince);
			shopInfo.setSProvinceID(sProvinceID);
			shopInfo.setSScopeType(sScopeType);
			shopInfo.setSScopeTypeID(sScopeTypeID);
			shopInfo.setSShopName(sShopName);
			shopInfo.setSShopNO(sShopNO);
			shopInfo.setSShopType(sShopType);
			shopInfo.setSShopTypeID(sShopTypeID);
			shopInfo.setSTel(sTel);
			shopInfo.setDFirstSaleDate(dFirstSaleDate);
			shopInfo.setDConfirmDate(new Date());
			shopInfo.setDLastUpdateTime(new Date());
			shopInfo.setSConfirmUser(SecurityContextUtil.getUserId());
			shopInfo.setSSalesmanNO1(sSalesmanNO1);
			shopInfo.setSSalesmanNO2(sSalesmanNO2);

			// 文件上传
			if (file != null) {
				String fileName = file.getOriginalFilename();
				if (U.isNotEmpty(fileName)) {
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.SHOP_PIC_PATH + OSSUtils.getFileNewName(fileName);
					// 上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					// 获取图片路径
					String filePath = OSSUtils.getImgURl(key, bucketName);
					filePath = filePath.substring(0, filePath.indexOf("?"));
					OSSUtils.closeOssClient();
					TShopPic shopPic = null;
					if (sShopNO != null) {
						shopPic = shopPicApi.findById(sShopNO);
					}
					if (shopPic == null) {
						shopPic = new TShopPic();
					}
					shopPic.setSURL(filePath);
					shopPic.setNTag(0);
					shopPic.setDCreateDate(new Date());
					shopPic.setSPicDesc(request.getParameter("sPicDesc"));
					shopPic.setSConfirmUser(SecurityContextUtil.getUserId());
					shopPicApi.saveShopPic(shopPic, SecurityContextUtil.getUserId(), sShopNO);
				}
			}

			Map<String, Object> resultMap = shopApi.saveShopInfo(shopInfo, SecurityContextUtil.getUserId());
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) {
			U.logger.error("保存店铺出错失败", e);
			Egox.egoxErr().setReturnValue("保存店铺出错失败").write(writer);
		}
	}
	
	/**
	 * 修改店铺状态
	 * @return
	 */
	@RequestMapping(value="/updateTag",method=RequestMethod.POST)
	public void status(String[] sShopNOs, Integer nTag, Writer writer) {
		if (ArrayUtils.isEmpty(sShopNOs) || null == nTag) {
			Egox.egoxErr().setReturnValue("请选择需要操作的店铺").write(writer);
			return;
		}
		try {
			shopApi.updateShopTag(Arrays.asList(sShopNOs), nTag);
			Egox.egoxOk().setReturnValue("更新店铺状态成功").write(writer);
		} catch (EgolmException e) {
			U.logger.error(e.getMessage(), e);
			Egox.egoxErr().setReturnValue(e.getMessage()).write(writer);
		} catch (Exception e) {
			U.logger.error("修改店铺状态失败", e);
			Egox.egoxErr().setReturnValue("修改店铺状态失败").write(writer);
		}
	}
 

	@RequestMapping(value = "/changeDistrict")
	public void changeDistrict(String[] sShopNOs, String sDistrictID, Writer writer) {
		if (ArrayUtils.isEmpty(sShopNOs) || StringUtils.isBlank(sDistrictID)) {
			Egox.egoxErr().setReturnValue("请选择需要操作的店铺").write(writer);
			return;
		}
		try {
			shopApi.changeDistrict(Arrays.asList(sShopNOs), sDistrictID);
			Egox.egoxOk().setReturnValue("修改店铺市区成功").write(writer);
		} catch (EgolmException e) {
			EgolmLogger.ShopLogger.error(e.getMessage(), e);
			Egox.egoxErr().setReturnValue(e.getMessage()).write(writer);
		} catch (Throwable e) {
			EgolmLogger.ShopLogger.error("", e);
			Egox.egoxErr().setReturnValue("系统异常").write(writer);
		}
	}
	
	@RequestMapping("/getCityByProvinceId")
	public void getCityByProvinceId(String sProvinceID, Writer writer) {
		Map<String, Object> returnMsg = regionQueryApi.queryCityByProvinceId(sProvinceID);
		Egox.egox(returnMsg).write(writer);
	}

	@RequestMapping("/getAreaByCityId")
	public void getAreaByCityId(String sCityID, Writer writer) {
		Map<String, Object> returnMsg = regionQueryApi.queryAreaByCityId(sCityID);
		Egox.egox(returnMsg).write(writer);
	}

	private static long shopNum = 0l;
	private static String date;

	/**
	 * 生成店铺编号
	 * 
	 * @return
	 */
	public static synchronized String getShopNo() {
		String str = new SimpleDateFormat("yyMMddHHmm").format(new Date());
		if (date == null || !date.equals(str)) {
			date = str;
			shopNum = 0l;
		}
		shopNum++;
		long shopNum = Long.parseLong((date)) * 10000;
		shopNum += shopNum;
		return shopNum + "";
	}

	@RequestMapping(value = "/salectCustList")
	public ModelAndView salectCustList(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();

		String sCustName = request.getParameter("sCustName");
		try {
			List<String> regionIds = SecurityContextUtil.getRegionIds();
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
			}
			Map<String, Object> params = searchSQL(request, page, "par", "com.egolm.domain.TCustCustomerInfo");
			params.put("nTag", 0);
			Map<String, Object> resultmap = customerApi.queryTCustCustomerInfo(regionIds, params, page);

			boolean result = (boolean) resultmap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");

				page = U.objTo(resultmap.get("page"), PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}

		} catch (Exception e) {
			U.logger.error("会员信息查询请求出错", e);
		}
		ModelAndView mv = new ModelAndView("/customer/selected-cust.jsp", map);
		mv.addObject("sCustName", sCustName);
		return mv;
	}
	
	/**
	 * 查询店铺信息
	 * @param request
	 * @param nShopID
	 * @return
	 */
	@RequestMapping(value="/showMap")
	public ModelAndView showMap(HttpServletRequest request,@RequestParam String sShopNO,@RequestParam String lng,@RequestParam String lat,@RequestParam Integer nShopID){
		ModelAndView mv  = new ModelAndView("/customer/shop-map.jsp");
		U.logger.info("into showMap method...");
		U.logger.info("sShopNO="+sShopNO);
		TShopInfo shopInfo = shopApi.findById(nShopID);
		
		//查询有店铺的区域
		List<Map<String, Object>> zoneList = shopApi.findExistZone();
		
		List<Map<String, Object>> list = tShopLocationInfo.findShopInfoByID(sShopNO);
		
		//判断地址是否解析出来了
		if (list.size() == 0 || list == null) {
			//tShopLocation中没有则添加
			tShopLocationInfo.insertIntoShopLocation(shopInfo,lng,lat);
			mv.addObject("SCity", shopInfo.getSCity());
			mv.addObject("NShopID", shopInfo.getNShopID());
			mv.addObject("SProvince", shopInfo.getSProvince());
			mv.addObject("SDistrict", shopInfo.getSDistrict());
			mv.addObject("SAddress", shopInfo.getSAddress());
			mv.addObject("SShopName", shopInfo.getSShopName());
			mv.addObject("lng", lng);
			mv.addObject("lat", lat);
		} else {
			//tShopLocation中有则取出来
			Map<String, Object> map = list.get(0);
			@SuppressWarnings("static-access")
			TShopLocationEntity tShopLocationEntity = (TShopLocationEntity) JSONObject.toBean(new JSONObject().fromObject(map), TShopLocationEntity.class);
			
			if(StringUtils.isNotBlank(tShopLocationEntity.getsNewShopName())){
				mv.addObject("SAddress", tShopLocationEntity.getsNewAddress());
				mv.addObject("SShopName", tShopLocationEntity.getsNewShopName());
				mv.addObject("lng", tShopLocationEntity.getsNewLongitude());
				mv.addObject("lat", tShopLocationEntity.getsNewLatitude());
			}else{
				mv.addObject("SAddress", tShopLocationEntity.getsAddress());
				mv.addObject("SShopName", tShopLocationEntity.getsShopName());
				mv.addObject("lng", tShopLocationEntity.getsLongitude());
				mv.addObject("lat", tShopLocationEntity.getsLatitude());
			}
			mv.addObject("SCity", tShopLocationEntity.getsCity());
			mv.addObject("NShopID", tShopLocationEntity.getnShopID());
			mv.addObject("SProvince", tShopLocationEntity.getsProvince());
			mv.addObject("SDistrict", tShopLocationEntity.getsDistrict());
		}
		
		mv.addObject("zoneList", zoneList);
		return mv;
	}
	
	@RequestMapping(value= "/updateShopInfo")
	public void updateShopInfo(@RequestParam String nShopID,@RequestParam String lng,@RequestParam String lat,
			@RequestParam String sNewAddress,@RequestParam String sNewShopName,Writer writer){
		U.logger.info("into updateShopInfo method...");
		U.logger.info("nShopID="+nShopID);
		U.logger.info("lng="+lng);
		U.logger.info("lat="+lat);
		U.logger.info("sNewShopName="+sNewShopName);
		int result = tShopLocationInfo.updateShopInfoByID(nShopID,lng,lat,sNewAddress,sNewShopName);
		U.logger.info("result="+result);
		Egox.egoxOk().setReturnValue("修改店铺经纬度成功").write(writer);
	}
	
	/**
	 * 查询区域下面的店铺数量
	 * @param sOrgNO
	 * @param shopNum
	 * @param writer
	 */
	@RequestMapping(value= "/queryOrgZone")
	public void queryOrgZone(@RequestParam String sOrgNO,@RequestParam int shopNum,Writer writer){
		U.logger.info("into queryOrgZone method...");
		try{
			List<Map<String, Object>> addressList = shopApi.findLngAndLat(sOrgNO,shopNum);
			Map<String, Object> result = Egox.egoxOk().setDataList(addressList);
			Egox.egoxOk().setReturnValue(Egox.egox(result).toString()).write(writer);
		}catch(Exception e){
			Egox.egoxErr().setReturnValue("查询有店铺的区域失败").write(writer);
			U.logger.error("查询有店铺的区域失败",e);
		}
	}

	@RequestMapping(value = "/queryDistrictByOrgNO")
	public void queryDistrictByOrgNO(@RequestParam String sOrgNO,Writer writer){
		U.logger.info("into queryDistrictByOrgNO method...");
		U.logger.info("sOrgNO="+sOrgNO);
		try{
			List<Map<String, Object>> addressList = shopApi.queryDistrictByOrgNO(sOrgNO);
			Map<String, Object> result = Egox.egoxOk().setDataList(addressList);
			Egox.egoxOk().setReturnValue(Egox.egox(result).toString()).write(writer);
		}catch(Exception e){
			Egox.egoxErr().setReturnValue("查询区域下面的店铺信息失败").write(writer);
			U.logger.error("查询区域下面的店铺信息失败",e);
		}
	}
	
	/**
	 * 选择业务员窗口
	 * @param request
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/salesmanNOList")
	public ModelAndView salesmanNOList(HttpServletRequest request,String sSalChineseName,@ModelAttribute("page") PageSqlserver page){
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateTime DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sSalChineseName)){
			paramMap.put("sSalChineseName",sSalChineseName);
		}
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		Map<String, Object> datas = salesManQueryApi.querySalesMans(regionIds, paramMap, page);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sSalChineseName", sSalChineseName);
		mv.setViewName("/customer/salesmanNO.jsp");
		mv.addObject("saleNO",request.getParameter("saleNO"));
		return mv;
	}
}
