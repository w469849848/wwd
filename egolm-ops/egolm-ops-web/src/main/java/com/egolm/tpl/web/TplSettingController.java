package com.egolm.tpl.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.domain.TYWTplLinkModule;
import com.egolm.domain.TYWTplManage;
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.service.CategoryService;
import com.egolm.tpl.service.impl.TplSettingServiceImpl;
import com.egolm.tpl.utils.HttpHandler;

@Controller
@RequestMapping("/template/setting")
public class TplSettingController {
	
	/*获取广告位下面的广告列表*/
	public static String HTTP_AD=HttpHandler.HTTP_HOST+"/egolm-open-web/advert/queryAdList";
	
	@Autowired
	private TplSettingServiceImpl tplSettingService;
	@Autowired
	private CategoryService categoryService;

	/**
	 * 跳转到导航模块设置界面
	 */
	@RequestMapping(value="/nav1")
	public ModelAndView toNav1Page(HttpServletRequest request){
		
		ModelAndView mv = new ModelAndView("tpl/tpl-setting-nav1.jsp");
		try {
			String sLinkNo = request.getParameter("sLinkNo");
			/**查询json数据结构*/
			Map<String, Object> map = tplSettingService.queryJson(sLinkNo);
			if(U.isNotEmpty(map) && map.containsKey("JsonData") && U.isNotEmpty(map.get("JsonData"))){
				mv.addObject("json", map.get("JsonData").toString());
			}
			/**查询模板的所有子模块*/
			List<Map<String, Object>> moduleList = tplSettingService.queryModules(sLinkNo);
			mv.addObject("moduleList", moduleList);
			
			mv.addObject("JsonApID", queryAdPosID(moduleList, sLinkNo));
			
			TYWTplManage tplManage = tplSettingService.queryTplBySlinkNo(sLinkNo);
			
			mv.addObject("sLinkNo", sLinkNo);
			mv.addObject("sTplNo", tplManage.getSTplNo());
			mv.addObject("sScopeType", tplManage.getSScopeType());
			mv.addObject("sBelongNo", tplManage.getSBelongNo());
			mv.addObject("sDisplayNo", tplManage.getSDisplayNo());
			mv.addObject("sScopeTypeID", tplManage.getSScopeTypeID());
			
			List<Category> categorylist= categoryService.queryCategoryForTpl(tplManage.getSBelongNo(), tplManage.getSScopeTypeID());
			mv.addObject("categorylist", categorylist);
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模块设置查询异常"+e.getMessage());
		}
		return mv;
		
	}
	
	@RequestMapping(value="/brand1")
	public ModelAndView toBrand1Page(HttpServletRequest request){
		
		ModelAndView mv = new ModelAndView("tpl/tpl-setting-brand1.jsp");
		try {
			String sLinkNo = request.getParameter("sLinkNo");
			/**查询json数据结构*/
			Map<String, Object> map = tplSettingService.queryJson(sLinkNo);
			if(U.isNotEmpty(map) && map.containsKey("JsonData") && U.isNotEmpty(map.get("JsonData"))){
				mv.addObject("json", map.get("JsonData").toString());
			}
			/**查询模板的所有子模块*/
			List<Map<String, Object>> moduleList = tplSettingService.queryModules(sLinkNo);
			mv.addObject("moduleList", moduleList);
			
			mv.addObject("JsonApID", queryAdPosID(moduleList, sLinkNo));
			
			TYWTplManage tplManage = tplSettingService.queryTplBySlinkNo(sLinkNo);
			
			mv.addObject("sLinkNo", sLinkNo);
			mv.addObject("sTplNo", tplManage.getSTplNo());
			mv.addObject("sBelongNo", tplManage.getSBelongNo());
			mv.addObject("sDisplayNo", tplManage.getSDisplayNo());
			mv.addObject("sScopeTypeID", tplManage.getSScopeTypeID());
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模块设置查询异常"+e.getMessage());
		}
		return mv;
		
	}
	
	@RequestMapping(value="/ad1")
	public ModelAndView toAd1Page(HttpServletRequest request){
		
		ModelAndView mv = new ModelAndView("tpl/tpl-setting-ad1.jsp");
		try {
			String sLinkNo = request.getParameter("sLinkNo");
			/**查询json数据结构*/
			Map<String, Object> map = tplSettingService.queryJson(sLinkNo);
			if(U.isNotEmpty(map) && map.containsKey("JsonData") && U.isNotEmpty(map.get("JsonData"))){
				mv.addObject("json", map.get("JsonData").toString());
			}
			/**查询模板的所有子模块*/
			List<Map<String, Object>> moduleList = tplSettingService.queryModules(sLinkNo);
			mv.addObject("moduleList", moduleList);
			
			mv.addObject("JsonApID", queryAdPosID(moduleList, sLinkNo));
			
			TYWTplManage tplManage = tplSettingService.queryTplBySlinkNo(sLinkNo);
			
			mv.addObject("sLinkNo", sLinkNo);
			mv.addObject("sTplNo", tplManage.getSTplNo());
			mv.addObject("sBelongNo", tplManage.getSBelongNo());
			mv.addObject("sDisplayNo", tplManage.getSDisplayNo());
			mv.addObject("sScopeTypeID", tplManage.getSScopeTypeID());
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模块设置查询异常"+e.getMessage());
		}
		return mv;
		
	}
	
	@RequestMapping(value="/product1")
	public ModelAndView toProduct1Page(HttpServletRequest request){
		
		ModelAndView mv = new ModelAndView("tpl/tpl-setting-product1.jsp");
		try {
			String sLinkNo = request.getParameter("sLinkNo");
			/**查询json数据结构*/
			Map<String, Object> map = tplSettingService.queryJson(sLinkNo);
			if(U.isNotEmpty(map) && map.containsKey("JsonData") && U.isNotEmpty(map.get("JsonData"))){
				mv.addObject("json", map.get("JsonData").toString());
			}
			/**查询模板的所有子模块*/
			List<Map<String, Object>> moduleList = tplSettingService.queryModules(sLinkNo);
			mv.addObject("moduleList", moduleList);
			
			mv.addObject("JsonApID", queryAdPosID(moduleList, sLinkNo));
			
			TYWTplManage tplManage = tplSettingService.queryTplBySlinkNo(sLinkNo);
			
			mv.addObject("sLinkNo", sLinkNo);
			mv.addObject("sTplNo", tplManage.getSTplNo());
			mv.addObject("sBelongNo", tplManage.getSBelongNo());
			mv.addObject("sDisplayNo", tplManage.getSDisplayNo());
			mv.addObject("sScopeTypeID", tplManage.getSScopeTypeID());
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模块设置查询异常"+e.getMessage());
		}
		return mv;
		
	}
	
	@RequestMapping(value="/floor1")
	public ModelAndView toFloor1Page(HttpServletRequest request){
		
		ModelAndView mv = new ModelAndView("tpl/tpl-setting-floor1.jsp");
		try {
			String sLinkNo = request.getParameter("sLinkNo");
			/**查询json数据结构*/
			Map<String, Object> map = tplSettingService.queryJson(sLinkNo);
			if(U.isNotEmpty(map) && map.containsKey("JsonData") && U.isNotEmpty(map.get("JsonData"))){
				mv.addObject("json", map.get("JsonData").toString());
			}
			/**查询模板的所有子模块*/
			List<Map<String, Object>> moduleList = tplSettingService.queryModules(sLinkNo);
			mv.addObject("moduleList", moduleList);
			
			mv.addObject("JsonApID", queryAdPosID(moduleList, sLinkNo));
			
			TYWTplManage tplManage = tplSettingService.queryTplBySlinkNo(sLinkNo);
			
			mv.addObject("sLinkNo", sLinkNo);
			mv.addObject("sTplNo", tplManage.getSTplNo());
			mv.addObject("sBelongNo", tplManage.getSBelongNo());
			mv.addObject("sDisplayNo", tplManage.getSDisplayNo());
			mv.addObject("sScopeTypeID", tplManage.getSScopeTypeID());
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模块设置查询异常"+e.getMessage());
		}
		return mv;
		
	}
	
	@RequestMapping(value="/floor2")
	public ModelAndView toFloor2Page(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("tpl/tpl-setting-floor2.jsp");
		try {
			String sLinkNo = request.getParameter("sLinkNo");
			/**查询json数据结构*/
			Map<String, Object> map = tplSettingService.queryJson(sLinkNo);
			if(U.isNotEmpty(map) && map.containsKey("JsonData") && U.isNotEmpty(map.get("JsonData"))){
				mv.addObject("json", map.get("JsonData").toString());
			}
			/**查询模板的所有子模块*/
			List<Map<String, Object>> moduleList = tplSettingService.queryModules(sLinkNo);
			mv.addObject("moduleList", moduleList);
			
			mv.addObject("JsonApID", queryAdPosID(moduleList, sLinkNo));
			
			TYWTplManage tplManage = tplSettingService.queryTplBySlinkNo(sLinkNo);
			
			mv.addObject("sLinkNo", sLinkNo);
			mv.addObject("sTplNo", tplManage.getSTplNo());
			mv.addObject("sBelongNo", tplManage.getSBelongNo());
			mv.addObject("sDisplayNo", tplManage.getSDisplayNo());
			mv.addObject("sScopeTypeID", tplManage.getSScopeTypeID());
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("模块设置查询异常"+e.getMessage());
		}
    	return mv;
		
	}
	
	/**
	 * @description 保存模板设置的json数据结构
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/saveJson",method=RequestMethod.POST)
	public void saveJson(HttpServletRequest request,Writer writer,TYWTplLinkModule tplLinkModule, String sTplNo){
		try {
			Map<String,Object> resultMap = tplSettingService.saveJson(tplLinkModule, sTplNo);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("保存Json数据结构失败", e);
			Egox.egoxErr().setReturnValue("保存Json数据结构失败").write(writer);
		}
	}
	
	/**
	 * @description 根据广告位ID查询其包含的所有广告信息
	 * @param request
	 * @param writer
	 * @param adPosID
	 */
	@RequestMapping(value="/queryAds",method=RequestMethod.POST)
	public void queryAds(HttpServletRequest request,Writer writer, String apId, String orgNo){
		try {
			Map<String, String> map=new HashMap<String,String>();
			map.put("apID", apId);//广告位编号
			map.put("orgNO", orgNo);//区域编码
			JSONObject json = HttpHandler.post(HTTP_AD,map);
			if(json.getBooleanValue("IsValid")){
				Egox.egoxOk().set("datas", json.get("DataList")).write(writer);
			}else{
				U.logger.error(json.getString("ReturnValue"));
				Egox.egoxErr().setReturnValue(json.getString("ReturnValue")).write(writer);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Egox.egoxErr().setReturnValue("根据广告位ID查询其包含的所有广告信息失败").write(writer);
		}
		
	}
	
	/**
	 * @description 获取模板其他模块的广告位ID
	 * @param list
	 * @param sLinkNo
	 * @return
	 */
	private String queryAdPosID(List<Map<String, Object>> list, String sLinkNo){
		StringBuffer sb = new StringBuffer();
		for(Map<String, Object> map : list){
			if(!sLinkNo.equals(map.get("sLinkNo")) && map.get("sLayoutContent") != null){
				if(map.get("sLayoutContent").toString().indexOf("nApID") > 0){
					String[] data = map.get("sLayoutContent").toString().split("\"nApID\":");
					for(int i=1,length=data.length; i<length; i++){
						sb.append("["+data[i].substring(0, data[i].indexOf(",")) + "],");
					}
				}
			}
		}
		return sb.toString();
	}
	
}
