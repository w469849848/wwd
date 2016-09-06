package com.egolm.advert.web;
 
import java.io.Writer;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
 
import javax.servlet.http.HttpServletResponse;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Json;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U; 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

 import com.egolm.advert.api.TShopAdPosAddApi;
import com.egolm.advert.api.TShopAdPosQueryApi;
import com.egolm.advert.api.TShopAdPosUpdateApi;
import com.egolm.advert.api.TShopAdvertUpdateApi;
import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.common.advert.AdvertContants;
import com.egolm.common.enums.UserType;
import com.egolm.domain.TShopAdPos;
import com.egolm.security.utils.SecurityContextUtil;  
 
/**
 * 
 * @Title: 
 * @Description:  广告位控制器
 * @author zhangyong
 * @date  2016年4月8日 上午9:45:58
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/media/mediaPos")
public class TShopAdPosController extends BaseAdvertController{
	@Resource(name = "tShopAdPosAddApi")
	private TShopAdPosAddApi tShopAdPosAddApi; 
	@Resource(name = "tShopAdPosQueryApi")
	private TShopAdPosQueryApi tShopAdPosQueryApi;
	@Resource(name = "tShopAdPosUpdateApi")
	private TShopAdPosUpdateApi tShopAdPosUpdateApi;
	@Resource(name = "tShopAdvertUpdateApi")
	private TShopAdvertUpdateApi tShopAdvertUpdateApi;

	@RequestMapping(value = "/addIndex")
	public String adPosIndex() {
		return "/media/add-media-position.jsp";
	}
	@RequestMapping(value = "/listIndex")
	public String adPosListIndex(){
		return "/media/mediaPosition-manage.jsp";
	}
	@RequestMapping(value="/listToJson")
	public void listToJson(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page,Writer writer){
		String nApID = request.getParameter("nApID");
		Map<String,Object> dataMap = tShopAdPosQueryApi.queryTShopAdPosById(nApID);
	    boolean result = (boolean)dataMap.get("IsValid");
		if(result){
			Map<String,Object> dataList = (Map<String,Object>) dataMap.get("DataList");
			Egox.egoxOk().setDataList(dataList).write(writer);
		}else{
			Egox.egoxErr().setReturnValue("获取合同编号失败").write(writer);
		}
		
	}
	
	/**
	 * 返回JSON格式的广告位数据
	 * @param request
	 * @param page
	 */
	@RequestMapping(value="/listPos")
	public void listPos(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page,Writer writer){
		try {
			ModelAndView mav = list(request, page);
			Map<String,Object> map = mav.getModel();
			
			List<Map<String, Object>> dataList =  (List<Map<String, Object>>)map.get("adPosList");
			page = U.objTo(map.get("page"),PageSqlserver.class);
			Egox.egoxOk().setDataList(dataList).set("page", page).write(writer);
		} catch (Exception e) {
			 U.logger.error("返回JSON格式的广告位数据失败",e);
			 Egox.egoxErr().setReturnValue("广告位数据获取失败").write(writer);
		}
	}
	
	
	
	/**
	 * 分页获取所有广告位 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page){
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		} else {
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc");
		String sApTitle= request.getParameter("sApTitle");
		String sZoneCodeID = request.getParameter("sZoneCodeID");
		String sApSaleTypeID = request.getParameter("sApSaleTypeID");
		try {

 			
			boolean isCheck = false;
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			params = setMapByPar(request, params,null, "com.egolm.domain.TShopAdPos");

			
			
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf(UserType.ADMIN)) { //管理员
				isCheck = true; 
				if(U.isNotEmpty(sZoneCodeID)){
					 params.put("sZoneCodeID",  StringUtil.join("','","'","'",sZoneCodeID));
				 }
			}else if(userType.oneOf(UserType.OPERATOR,UserType.AGENT)){//运营人员,经销商
				 if(U.isNotEmpty(sZoneCodeID)){
					 params.put("sZoneCodeID", StringUtil.join("','","'","'",sZoneCodeID));
				 }else{
					 params.put("sZoneCodeID",StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				 }
				 isCheck = true;
			}else {
				 U.logger.error("广告位管理:"+userType.getDescription()+"非法访问此功能");
 			}
			
			if(isCheck){
				Map<String, Object> resultmap = tShopAdPosQueryApi.query(params, page);
				boolean result = (boolean)resultmap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList"); 
					page =U.objTo(resultmap.get("page"),PageSqlserver.class);
					map.put("adPosList", dataList);
					map.put("page", page);
				}
			}else{
				U.logger.info("账号:"+SecurityContextUtil.getUserName()+"无查看广告位管理的权限 ");
			} 
			
		} catch (Exception e) { 
			U.logger.error("广告位查询请求出错,", e);
		}
		map.put("sZoneCodeID", sZoneCodeID);
		map.put("sApSaleTypeID", sApSaleTypeID);
		map.put("sApTitle", sApTitle);
		ModelAndView mv = new ModelAndView("/media/mediaPosition-manage.jsp", map);
		return mv;
	}
	
	@RequestMapping(value="/add", method =RequestMethod.POST)
	public void add(TShopAdPos tShopAdPos,@RequestParam(value = "filePath", required = false) MultipartFile file,HttpServletRequest request,Writer writer) { 
 		try {  
			//添加广告位
 			TShopAdPos updateAdPos = new TShopAdPos();
			if(U.isNotEmpty(tShopAdPos.getNApID())){
				Map<String,Object> idMap = this.tShopAdPosQueryApi.queryTShopAdPosById(tShopAdPos.getNApID()+"");
				 boolean idResult = (boolean)idMap.get("IsValid");
				 if(idResult){
					 Map<String,Object> dataMap = (Map<String,Object>)idMap.get("DataList");
					 updateAdPos = To.mapTo(dataMap, TShopAdPos.class);
				 }else{
					 Egox.egoxErr().setReturnValue("广告位编辑失败,广告位不存在").write(writer);
	                 return ;
				 } 
			}
			boolean isUploadFile = false;
			 if(file != null){
				String fileName = file.getOriginalFilename();
				if(StringUtil.isNotEmpty(fileName)){
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.AD_PATH+""+tShopAdPos.getSApSaleTypeID()+"/"+tShopAdPos.getSZoneCodeID()+"/1/"+OSSUtils.getFileNewName(fileName);
					//上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					 
					OSSUtils.closeOssClient(); 
					isUploadFile = true;
					tShopAdPos.setSApPathUrl("/"+key); 
				}				
			} 
			
			if(StringUtil.isNotEmpty(tShopAdPos.getNApID())){
 				updateAdPos.setSApTitle(tShopAdPos.getSApTitle()); 
				updateAdPos.setSApContent(tShopAdPos.getSApContent());
				updateAdPos.setNApHeight(tShopAdPos.getNApHeight());
				updateAdPos.setNApWidth(tShopAdPos.getNApWidth());
				updateAdPos.setNApPrice(tShopAdPos.getNApPrice().multiply(new BigDecimal(100)));
				updateAdPos.setSApSaleTypeID(tShopAdPos.getSApSaleTypeID());
				updateAdPos.setSApSaleType(tShopAdPos.getSApSaleType());
				updateAdPos.setSApType(tShopAdPos.getSApType());
				updateAdPos.setSApTypeID(tShopAdPos.getSApTypeID());
				updateAdPos.setSApSysType(tShopAdPos.getSApSysType());
				updateAdPos.setSApSysTypeID(tShopAdPos.getSApSysTypeID());
				updateAdPos.setSApText(tShopAdPos.getSApText());
				updateAdPos.setSZoneCodeID(tShopAdPos.getSZoneCodeID());
				updateAdPos.setSZoneCode(tShopAdPos.getSZoneCode());
				updateAdPos.setSApStatusID(tShopAdPos.getSApStatusID());
				updateAdPos.setSApStatus(tShopAdPos.getSApStatus());
				updateAdPos.setSApJumpUrl(tShopAdPos.getSApJumpUrl());
				updateAdPos.setSScopeTypeID(tShopAdPos.getSScopeTypeID());
				updateAdPos.setSScopeType(tShopAdPos.getSScopeType());
				if(isUploadFile){
					updateAdPos.setSApPathUrl(tShopAdPos.getSApPathUrl());
				}
                 Map<String,Object> resultMap = this.tShopAdPosUpdateApi.updateTShopAdPos(updateAdPos); 
                boolean result = (boolean)resultMap.get("IsValid");
                if(result){
                	Egox.egoxOk().setReturnValue("广告位编辑成功").write(writer);
                }else{
                	Egox.egoxErr().setReturnValue("广告位编辑失败").write(writer);
                }
				
			}else{
				 tShopAdPos.setNApPrice(tShopAdPos.getNApPrice().multiply(new BigDecimal(100)));
				 tShopAdPos.setSApSysType("是");
				 tShopAdPos.setSApSysTypeID("0");
				 if(tShopAdPos.getSZoneCodeID().equals(AdvertContants.ADVER_CHINA)){ //全国的广告默认为启用
					 tShopAdPos.setSApStatusID("1");
					 tShopAdPos.setSApStatus("启用");
				 }else{
					 tShopAdPos.setSApStatusID("0");
					 tShopAdPos.setSApStatus("未启用");
				 }
				 
				 tShopAdPos.setSCreateUser( SecurityContextUtil.getUserName());
 				 Map<String,Object> resultMap = this.tShopAdPosAddApi.createTShopAdPos(tShopAdPos);
				 boolean result = (boolean)resultMap.get("IsValid");
				 if(result){
					 Egox.egoxOk().setReturnValue("广告位新增成功").write(writer);
				 }else{
					 Egox.egoxErr().setReturnValue("广告位新增失败").write(writer);
				 } 
			}
			
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("广告位业务操作失败").write(writer);
			U.logger.error("广告位业务操作出错,", e);
		} 
	}
	/**
	 * 删除广告位
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/delete", method =RequestMethod.POST)
	public void delete(HttpServletRequest request,Writer writer){
		try {
			 String id = request.getParameter("id");
			 if(U.isNotEmpty(id)){
				 Map<String,Object> resultMap =  this.tShopAdPosUpdateApi.deleteTShopAdPosById(id);
				 boolean result = (boolean)resultMap.get("IsValid");
				 if(result){
					 Egox.egoxOk().setReturnValue("广告位删除成功").write(writer);
				 }else{
					 Egox.egoxErr().setReturnValue("广告位删除失败").write(writer);
				 } 
			 }else{
				 Egox.egoxErr().setReturnValue("广告位删除失败,参数为空").write(writer);
			 }
		} catch (Exception e) {
			Egox.egoxErr().setReturnValue("广告位删除失败").write(writer);
			U.logger.error("广告位删除出错,", e);
		}
	}
	
	/**
	 * 根据ID获取广告位
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/loadMsgByID")
	public ModelAndView loadMsgByID(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String nApID = request.getParameter("id");
			Map<String, Object> dataMap = tShopAdPosQueryApi.queryTShopAdPosById(nApID);
			boolean result = (boolean)dataMap.get("IsValid");
			if(result){
				map.put("adPosData", dataMap.get("DataList"));
			}else{	
				
			}
		} catch (Exception e) { 
			U.logger.error("根据ID获取广告位信息出错,", e);
		}
		ModelAndView mv = new ModelAndView("/media/add-media-position.jsp", map);
		return mv;
	}
	/**
	 * 根据广告位 类型 获取数据
	 * @param request
	 */
	@RequestMapping(value="/loadMsgByApSaleType")
	public void loadMsgByApSaleType(HttpServletRequest request,HttpServletResponse response,Writer writer){ 
		try {
			 
			PageSqlserver	page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(1000); 
			page.setLimitKey("dLastUpdateTime desc");
			String sApSaleTypeID = request.getParameter("sApSaleTypeID");
			String sAdZoneCodeID = request.getParameter("sAdZoneCodeID");
			 Map<String, Object> resultMap = tShopAdPosQueryApi.queryTShopAdPosByAdSaleTypeAndZoneCodeId(sApSaleTypeID,sAdZoneCodeID,page);
			boolean result = (boolean)resultMap.get("IsValid");
			if(result){
				List<Map<String,Object>>dataList  = (List<Map<String,Object>>)resultMap.get("DataList");
				Egox.egoxOk().setDataList(dataList).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("获取广告位数据失败").write(writer);
			}
			 
		} catch (Exception e) { 
			U.logger.error("根据广告位类型获取广告位信息出错,", e);
			Egox.egoxErr().setReturnValue("获取广告位数据失败").write(writer);
		}
		
		 
	}
	@RequestMapping(value="/exprotExcel")
    @ResponseBody 
    public String exprotExcel(HttpServletResponse response,@ModelAttribute("page") PageSqlserver pageParam,String sAgentName,HttpServletRequest request) {
		return null;
	}
	 
}
