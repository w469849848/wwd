
package com.egolm.dealer.web;

import java.io.Writer;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Ftp;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmContants;
import com.egolm.common.enums.UserType;
import com.egolm.dealer.api.TACTmpGoodsPromoAddApi;
import com.egolm.dealer.api.TACTmpGoodsPromoQueryApi;
import com.egolm.dealer.api.TACTmpGoodsPromoUpdateApi;
import com.egolm.domain.TACTmpGoodsPromo;
import com.egolm.security.utils.SecurityContextUtil;

/**   
* @Title: TACTmpGoodsPromoController.java 
* @Package com.egolm.dealer.web 
* @Description: TODO(活动申请控制器) 
* @author zhangyong  
* @date 2016年5月16日 上午11:11:36 
* @version V1.0   
*/
@Controller
@RequestMapping("/tmpPromo")
public class TACTmpGoodsPromoController {
	@Resource(name = "tACTmpGoodsPromoAddApi")
	private TACTmpGoodsPromoAddApi tACTmpGoodsPromoAddApi;
	@Resource(name = "tACTmpGoodsPromoQueryApi")
	private TACTmpGoodsPromoQueryApi tACTmpGoodsPromoQueryApi;
	@Resource(name = "tACTmpGoodsPromoUpdateApi")
	private TACTmpGoodsPromoUpdateApi tACTmpGoodsPromoUpdateApi;
	
	@RequestMapping(value="/addIndex")
	public String addIndex(){
		return "/dealer/add-activity.jsp";
	}
	@RequestMapping(value="/listIndex")
	public String listIndex(){
		return "/dealer/activity-manage.jsp";
	}
	
	@RequestMapping(value="/auditList")
	public ModelAndView auditList(HttpServletRequest request,PageSqlserver page){
		ModelAndView mv = list(request, page);
		return mv;
	}
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page){
		Map<String, Object> map = new HashMap<String, Object>();
		 try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(10);
			}else{
				page.setLimit(10);
			}
			page.setLimitKey("dLastUpdateTime"); 
			String sTmpPromoTitle = request.getParameter("sTmpPromoTitle");
			String zoneCode = request.getParameter("zoneCode");
			
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP 
			if(U.isNotEmpty(sTmpPromoTitle)){
				params.put("sTmpPromoTitle", sTmpPromoTitle);
			}
			if(U.isNotEmpty(zoneCode)){
				params.put("zoneCode", zoneCode);
			}
			
			
			boolean isSelect = false;
			UserType userType = SecurityContextUtil.getUserType();
			if (userType.oneOf( UserType.ADMIN)) { //管理员
				if(U.isNotEmpty(zoneCode)){
					params.put("sOrgNO",  StringUtil.join("','","'","'",zoneCode));
					isSelect= true;
				}
			}else if(userType.oneOf(UserType.OPERATOR)){  //运营人员
				if(U.isNotEmpty(zoneCode)){
					params.put("sOrgNO", StringUtil.join("','","'","'",zoneCode));
				}else{
					params.put("sOrgNO", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				}
				isSelect= true;
			}else if(userType.oneOf(UserType.AGENT)){  //经销商
				if(U.isNotEmpty(zoneCode)){
					params.put("sOrgNO", StringUtil.join("','","'","'",zoneCode));
				}else{
					params.put("sOrgNO", StringUtil.join("','","'","'",SecurityContextUtil.getRegionIds()));
				} 
				 isSelect= true;
			}else{
				 U.logger.error("订单管理:"+userType.getValue()+"非法访问此功能");
			}  
			
			
			if(isSelect){
				Map<String, Object> dataMap = tACTmpGoodsPromoQueryApi.queryTACTmpGoodsPromo(params, page);
				boolean result = (boolean)dataMap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList");
					
					page =U.objTo(dataMap.get("page"),PageSqlserver.class);
					map.put("activityList", dataList);
					map.put("page", page);
				}
			}
			
			
		} catch (Exception e) {
			U.logger.error("获取经销商申请活动数据失败",e); 
		} 
		ModelAndView mv = new ModelAndView("/dealer/activity-manage.jsp",map);
		return mv;
	}
	
	@RequestMapping(value = "/add", method =RequestMethod.POST) 
	public void add(@RequestParam(value = "filePath", required = false) MultipartFile file,HttpServletRequest request,Writer writer){
		 try {
			String  nTmpPromoID=  request.getParameter("nTmpPromoID");
			 String  sTmpPromoSchedule   = request.getParameter("sTmpPromoSchedule"); 
			 String  sTmpPromoTitle   = request.getParameter("sTmpPromoTitle"); 
			 String  sZoneCode   = request.getParameter("sZoneCode"); 
			 String  sZoneName   = request.getParameter("sZoneName"); 
			 String  sTmpPromoMemo   = request.getParameter("sTmpPromoMemo"); 
			 String  sTmpPromoSmsMemo   = request.getParameter("sTmpPromoSmsMemo"); 
			 String  sTmpPromoAttr   = request.getParameter("sTmpPromoAttr"); 
			 String  sTmpPromoActionTypeID   = request.getParameter("sTmpPromoActionTypeID"); 
			 String  sTmpPromoActionType   = request.getParameter("sTmpPromoActionType"); 
			 String  dTmpPromoBeginDate   = request.getParameter("dTmpPromoBeginDate"); 
			 String  dTmpPromoEndDate   = request.getParameter("dTmpPromoEndDate"); 
			 String  dTmpPromoSmsBeginTime   = request.getParameter("dTmpPromoSmsBeginTime"); 
			 String  dTmpPromoSmsEndTime   = request.getParameter("dTmpPromoSmsEndTime"); 
			 String  dTmpPromoNoticeBeginTime   = request.getParameter("dTmpPromoNoticeBeginTime"); 
			 String  dTmpPromoNoticeEndTime   = request.getParameter("dTmpPromoNoticeEndTime"); 
			 
			 
			 TACTmpGoodsPromo  tACTmpGoodsPromo = new TACTmpGoodsPromo();
			 if(U.isNotEmpty(nTmpPromoID)){
				 if(StringUtil.isInt(nTmpPromoID.trim())){
				   Map<String,Object>	updatePromoMap =  this.tACTmpGoodsPromoQueryApi.queryTACTmpGoodsPromoById(Integer.valueOf(nTmpPromoID.trim()));	 
					boolean idResult = (boolean) updatePromoMap.get("IsValid");
					if(idResult){
						Map<String, Object> dataMap = (Map<String, Object>) updatePromoMap.get("DataList");
						tACTmpGoodsPromo =To.mapTo(dataMap, TACTmpGoodsPromo.class);	
					}else{
						Egox.egoxErr().setReturnValue("根据ID加载活动申请数据失败").write(writer);
						return;
					}
				   
				 }else{
					 Egox.egoxErr().setReturnValue("活动申请ID不正确").write(writer);
					 return;
				 } 
			 }
			 if(file != null){
				 String fileName = file.getOriginalFilename();
				 if(StringUtil.isNotEmpty(fileName)){
					
					String remotePath  = "/"+sZoneCode+"/"+fileName;
					Ftp ftp = Ftp.newInstance(EgolmContants.FTP_IP, EgolmContants.FTP_PORT, EgolmContants.FTP_USERNAME, EgolmContants.FTP_PASSWORD);
					ftp.uploadFile(file.getInputStream(),remotePath);
					tACTmpGoodsPromo.setSTmpPromoAttr(remotePath);
				 }
			 }
			 
			 
			 tACTmpGoodsPromo.setSTmpPromoSchedule(sTmpPromoSchedule);
			 tACTmpGoodsPromo.setSTmpPromoTitle(sTmpPromoTitle);
			 tACTmpGoodsPromo.setSZoneCode(sZoneCode);
			 tACTmpGoodsPromo.setSZoneName(sZoneName);
			 tACTmpGoodsPromo.setSTmpPromoMemo(sTmpPromoMemo);
			 tACTmpGoodsPromo.setSTmpPromoSmsMemo(sTmpPromoSmsMemo); 
			 tACTmpGoodsPromo.setSTmpPromoActionTypeID(sTmpPromoActionTypeID);
			 tACTmpGoodsPromo.setSTmpPromoActionType(sTmpPromoActionType);
			 tACTmpGoodsPromo.setDTmpPromoBeginDate(DateUtil.parse(dTmpPromoBeginDate,DateUtil.FMT_DATE_MINUTE));
			 tACTmpGoodsPromo.setDTmpPromoEndDate(DateUtil.parse(dTmpPromoEndDate,DateUtil.FMT_DATE_MINUTE));  
			 tACTmpGoodsPromo.setDTmpPromoSmsBeginTime(DateUtil.parse(dTmpPromoSmsBeginTime,DateUtil.FMT_DATE_MINUTE));
			 tACTmpGoodsPromo.setDTmpPromoSmsEndTime(DateUtil.parse(dTmpPromoSmsEndTime,DateUtil.FMT_DATE_MINUTE));
			 tACTmpGoodsPromo.setDTmpPromoNoticeBeginTime(DateUtil.parse(dTmpPromoNoticeBeginTime,DateUtil.FMT_DATE_MINUTE));
			 tACTmpGoodsPromo.setDTmpPromoNoticeEndTime(DateUtil.parse(dTmpPromoNoticeEndTime,DateUtil.FMT_DATE_MINUTE)); 
			 
			 if(U.isNotEmpty(nTmpPromoID.trim())){ //编辑
				 Map<String, Object> resultMap =  this.tACTmpGoodsPromoUpdateApi.updateTACTmpGoodsPromo(tACTmpGoodsPromo);
				 boolean result = (boolean) resultMap.get("IsValid");
					if (result) {
						Egox.egoxOk().setReturnValue("活动更新成功").write(writer);
					} else {
						Egox.egoxErr().setReturnValue("活动更新失败").write(writer);
					}
			 }else{
				 tACTmpGoodsPromo.setSCreateUser(SecurityContextUtil.getUserName());
				 Map<String, Object> resultMap =  this.tACTmpGoodsPromoAddApi.createTACTmpGoodsPromo(tACTmpGoodsPromo);
				 boolean result = (boolean) resultMap.get("IsValid");
					if (result) {
						Egox.egoxOk().setReturnValue("活动申请成功").write(writer);
					} else {
						Egox.egoxErr().setReturnValue("活动申请失败").write(writer);
					}
			 }
		} catch (Exception e) {
			U.logger.error("活动申请操作失败",e);
			Egox.egoxErr().setReturnValue("活动申请操作失败").write(writer);
		}
	}
	
	
	@RequestMapping(value="/loadMsgById")
	public ModelAndView loadMsgById(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		 try {
			 String id = request.getParameter("id");
			 Map<String,Object> resultMap = tACTmpGoodsPromoQueryApi.queryTACTmpGoodsPromoById(Integer.valueOf(id));
			 boolean result = (boolean) resultMap.get("IsValid");
			 if (result) {
				map.put("activityData", resultMap.get("DataList"));
			 }

		} catch (Exception e) {
			U.logger.error("根据ID获取经销商申请活动数据失败",e); 
		} 
		ModelAndView mv = new ModelAndView("/dealer/add-activity.jsp",map);
		return mv;
	}
	@RequestMapping(value="/delete")
	public void delete(HttpServletRequest request,Writer writer){
		try {
			String id = request.getParameter("id");
			if(StringUtil.isNotEmpty(id)){
				List<TACTmpGoodsPromo> tmpList = new ArrayList<TACTmpGoodsPromo>();
				TACTmpGoodsPromo tmp = new TACTmpGoodsPromo();
				tmp.setNTmpPromoID(Integer.valueOf(id));
				tmp.setNTag(1);
				tmp.setSConfirmUser(SecurityContextUtil.getUserName());
				tmpList.add(tmp);
				Map<String,Object> deleteMap = this.tACTmpGoodsPromoUpdateApi.updateTACTmpGoodsPromoNTagById(tmpList);	
				boolean result = (boolean)deleteMap.get("IsValid");
				 if(result){
					 Egox.egoxOk().setReturnValue("活动申请数据删除成功").write(writer);
				 }else{
					 Egox.egoxErr().setReturnValue("活动申请数据删除失败").write(writer);
				 } 
			}else{
				Egox.egoxErr().setReturnValue("活动申请数据删除失败,ID不能为空").write(writer);
			}
		} catch ( Exception e) {
			U.logger.error("活动申请数据删除失败",e);
			Egox.egoxErr().setReturnValue("活动申请数据删除失败").write(writer);
		} 
	}
	
	@RequestMapping(value="/loadDetailMsgById")
	public ModelAndView loadDetailMsgById(HttpServletRequest request){
		Map<String, Object> returnMap = new HashMap<String, Object>();
		try {
			ModelAndView mv = loadMsgById(request);
			Map<String,Object> map = mv.getModel();
			Map<String, Object> dataMap =  (Map<String, Object>) map.get("activityData");
			returnMap.put("activityData", dataMap);
		} catch (Exception e) {
			U.logger.error("获取活动申请信息出错,", e);
		}
		ModelAndView returnMv = new ModelAndView("/dealer/activity-detail.jsp",returnMap);
		return returnMv;
	}
	@RequestMapping(value="/downloadFile")
	public void downloadFile(HttpServletRequest request,Writer writer, HttpServletResponse response){
		try {
			String id = request.getParameter("id");
			 Map<String,Object> resultMap = tACTmpGoodsPromoQueryApi.queryTACTmpGoodsPromoById(Integer.valueOf(id));
			 boolean result = (boolean) resultMap.get("IsValid");
			 if (result) {
				 Map<String, Object>  data =  (Map<String, Object> )resultMap.get("DataList");
				 if(data != null){
					 String filePath = (String)data.get("sTmpPromoAttr");
					 if(StringUtil.isNotEmpty(filePath)){
						 Ftp ftp = Ftp.newInstance(EgolmContants.FTP_IP, EgolmContants.FTP_PORT, EgolmContants.FTP_USERNAME, EgolmContants.FTP_PASSWORD);
						 String fileName = filePath.substring(filePath.lastIndexOf("/")+1, filePath.length()); 
						 response.setContentType("text/html;charset=UTF-8");
						 response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
						 ftp.downFile(filePath, response.getOutputStream());
					 }
					 
				 }
			 }
		}  catch (Exception e) { 
		}
	}
	
	/**
	 * 
	* @Title: auditPromo 
	* @Description: TODO(审核活动) 
	* @param @param request
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/auditPromo")
	public void auditPromo(HttpServletRequest request,Writer writer){
		try {
			String id = request.getParameter("id");
			String nTag = request.getParameter("nTag");
			String[] ids = id.split(",");
			if(ids != null && ids.length>0){
				List<TACTmpGoodsPromo> tmpList = new ArrayList<TACTmpGoodsPromo>();
				for(String tmpId:ids){
					if(U.isNotEmpty(tmpId) && U.isInt(tmpId.trim())){
						TACTmpGoodsPromo tmp = new TACTmpGoodsPromo();
						tmp.setNTmpPromoID(Integer.valueOf(tmpId));
						tmp.setNTag(Integer.valueOf(nTag));
						tmp.setSConfirmUser(SecurityContextUtil.getUserName());
						tmpList.add(tmp);
					}
				}
				if(tmpList.size()>0){
					Map<String,Object> auditMap = this.tACTmpGoodsPromoUpdateApi.updateTACTmpGoodsPromoNTagById(tmpList);
					boolean result = (boolean)auditMap.get("IsValid");
					if(result){
						if(nTag.equals("2")){
							Egox.egoxOk().setReturnValue("批量通过操作成功").write(writer);
						}
						if(nTag.equals("4")){
							Egox.egoxOk().setReturnValue("批量不通过操作成功").write(writer);
						}
					}else{
						if(nTag.equals("2")){
							Egox.egoxOk().setReturnValue("批量通过操作失败 ").write(writer);
						}
						if(nTag.equals("4")){
							Egox.egoxOk().setReturnValue("批量不通过操作失败 ").write(writer);
						}
					}
				}
			}else{
				Egox.egoxErr().setReturnValue("批量操作失败,未获取到操作数据").write(writer);
			}
		} catch (Exception e) {
			U.logger.error("批量操作活动审请数据异常",e);
			Egox.egoxErr().setReturnValue("批量操作异常").write(writer);
		} 
	}
}
