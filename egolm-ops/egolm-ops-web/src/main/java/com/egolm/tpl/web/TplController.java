package com.egolm.tpl.web;

import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.common.enums.UserType;
import com.egolm.domain.TYWTplLinkModule;
import com.egolm.domain.TYWTplManage;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.tpl.generator.TemplateHtmlGenerator;
import com.egolm.tpl.service.TplService;
import com.egolm.tpl.utils.HttpHandler;

/**
 * @description 模板管理Controller
 * @package com.egolm.tpl.web
 * @author H.P.Yang
 * @date 2016-5-18 上午9:16:58
 */
@Controller
@RequestMapping("/template")
public class TplController {
	
	@Autowired
	private TplService tplService;
	@Autowired
	private TemplateHtmlGenerator templateHtmlGenerator;
	
	
	@RequestMapping(value="/preview",method=RequestMethod.GET)
	public String preview(HttpServletRequest request){
		String sTplNo=request.getParameter("sTplNo");
		String htmlCode;
		try {
			htmlCode = templateHtmlGenerator.preview(sTplNo);
			request.setAttribute("htmlCode", htmlCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "tpl/preview.jsp";
	}
	
	/**
	 * @description 进入模板信息列表页面
	 * @param page
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request){
		ModelAndView mv = new ModelAndView("tpl/tpl-manage.jsp");
		try {
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("sTplNo DESC");
			}
			
			String sTplName = request.getParameter("sTplName");
			String sBelongArea = request.getParameter("sBelongArea");
			List<String> sBelongNoList = new ArrayList<String>();
			String sBelongNo=request.getParameter("sBelongNo");
			if(U.isNotBlank(sBelongNo)){
				sBelongNoList.add(sBelongNo);
			}
			
			
			List<Map<String,Object>> zonelist = queryRegion();
			mv.addObject("zonelist", zonelist);
			
			List<Map<String,Object>> newZonelist = new ArrayList<Map<String,Object>>();
			//如果用户不是管理员，则只显示当前人所属区域模板,查询条件下拉里面也仅显示一个区域
			if (!SecurityContextUtil.getUserType().oneOf(UserType.ADMIN)) { // 
				sBelongNoList = SecurityContextUtil.getRegionIds();
				for (Map<String, Object> map : zonelist) {
					String tempBelongNo=map.get("sBelongNo").toString();
					if(sBelongNoList.contains(tempBelongNo)){
						//mv.addObject("sBelongArea",map.get("sBelongArea"));
						Map<String,Object> tempmap=new HashMap<String,Object>();
						tempmap.put("sBelongNo", tempBelongNo);
						tempmap.put("sBelongArea", map.get("sBelongArea"));
						newZonelist.add(tempmap);
					}
				}
				mv.addObject("zonelist", newZonelist);
			}
			
			mv.addObject("sTplName", sTplName);
			mv.addObject("sBelongArea", sBelongArea);
			mv.addObject("sBelongNo", sBelongNo);
			if(U.isEmpty(sBelongArea)){
				mv.addObject("sBelongArea", "区域");
				mv.addObject("sBelongNo", "");
			}
			
			
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			if(U.isNotEmpty(sTplName)){
				paramMap.put("sTplName", sTplName.trim());
			}
			if(U.isNotEmpty(sBelongArea)){
				paramMap.put("sBelongArea", sBelongArea.trim());
			}
			if(sBelongNoList.size()>0){
				paramMap.put("sBelongNoList", sBelongNoList);
			}
			
			Map<String, Object> datas = tplService.queryTemplates(paramMap, page);
			Page pageReturn = (Page) datas.get("page");
			mv.addObject("datas", datas);
			mv.addObject("page", pageReturn);
			
			
			
			if(U.isNotBlank(sBelongNo)){
				for (Map<String, Object> map : zonelist) {
					if(map.get("sBelongNo").toString().equals(sBelongNo)){
						mv.addObject("sBelongArea",map.get("sBelongArea"));
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("查询模板信息出错", e);
		}
		
		return mv;
	}
	
	/**
	 * @description 进入新建或更新模板页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/addorupdate",method=RequestMethod.GET)
	public ModelAndView toTplAddOrUpdate(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("tpl/tpl-add.jsp");
		try {
			String sTplNo = request.getParameter("sTplNo");
			if(U.isNotEmpty(sTplNo)){
				TYWTplManage tpl = tplService.queryTemplateById(sTplNo);
				request.setAttribute("tpl", tpl);
				List<TYWTplLinkModule>  modulelist = tplService.queryModulesBySTplNo(sTplNo);
				request.setAttribute("modulelist", modulelist);
			}
			Map<String, Object> datas = tplService.queryModules();
			request.setAttribute("datas", datas);
			
			Map<String, Object> scopedatas = tplService.queryScopeType("ScopeType");
			request.setAttribute("scopedatas", scopedatas);
			
			List<String> sBelongNoList = new ArrayList<String>();
			List<Map<String,Object>> zonelist = queryRegion();
			mv.addObject("zonelist", zonelist);
			List<Map<String,Object>> newZonelist = new ArrayList<Map<String,Object>>();
			//如果用户不是管理员，则只显示当前人所属区域模板,查询条件下拉里面也仅显示一个区域
			if (!SecurityContextUtil.getUserType().oneOf(UserType.ADMIN)) { // 
				sBelongNoList = SecurityContextUtil.getRegionIds();
				for (Map<String, Object> map : zonelist) {
					String tempBelongNo=map.get("sBelongNo").toString();
					if(sBelongNoList.contains(tempBelongNo)){
						Map<String,Object> tempmap=new HashMap<String,Object>();
						tempmap.put("sBelongNo", tempBelongNo);
						tempmap.put("sBelongArea", map.get("sBelongArea"));
						newZonelist.add(tempmap);
					}
				}
				mv.addObject("zonelist", newZonelist);
			}else{
				mv.addObject("zonelist", zonelist);
			}
			
			
			
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("进入新建或更新模板页面失败");
		}
		return mv;
	}
	
	/**
	 * @description 保存新建或更新模板
	 * @param request
	 * @param writer
	 * @param tplManage
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	public void saveTemplate(HttpServletRequest request, Writer writer, TYWTplManage tplManage){
		try {
			String moduleItems = request.getParameter("moduleItems");
			Map<String,Object> resultMap = tplService.saveTemplate(tplManage, moduleItems);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("保存模块失败", e);
			Egox.egoxErr().setReturnValue("保存模块失败").write(writer);
		}
	}
	
	/**
	 * @description 删除模板
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(HttpServletRequest request,Writer writer){
		String sTplNo = request.getParameter("sTplNo");
		try {
			if(U.isNotEmpty(sTplNo)){
				Map<String,Object> resultMap = tplService.deleteTemplate(sTplNo);
				Egox.egox(resultMap).write(writer);
			}else{
				U.logger.error("删除模板出错失败");
				Egox.egoxErr().setReturnValue("删除模板出错失败").write(writer);
			}
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("删除模板出错失败", e);
			Egox.egoxErr().setReturnValue("删除模板出错失败").write(writer);
		}
	}
	
	/**
	 * @description 更改模板发布状态
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/status",method=RequestMethod.POST)
	public void status(HttpServletRequest request,Writer writer){
		try {
			String sTplNo = request.getParameter("sTplNo");
			Integer nTag = Integer.parseInt(request.getParameter("nTag"));
			Map<String,Object> resultMap = tplService.updateTemplateStatus(sTplNo, nTag);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("更新模板失败", e);
			Egox.egoxErr().setReturnValue("更新模板失败").write(writer);
		}
	}
	
	/**
	 * @description 进入模板设置页面
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/setting",method=RequestMethod.GET)
	public ModelAndView toTplSetting(HttpServletRequest request){
		ModelAndView mv = new ModelAndView();
		try {
			String sTplNo = request.getParameter("sTplNo");
			Map<String, Object> map = tplService.queryModuleUrl(sTplNo);
			if(U.isNotEmpty(map)){
				mv.setViewName("redirect:/" + map.get("sBgPath").toString());
				mv.addObject("sLinkNo", map.get("sLinkNo").toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("根据模板查询模块管理地址异常，"+e);
		}
		return mv;
	}
	
	/**
	 * @description 查询区域
	 *
	 */
	private List<Map<String,Object>> queryRegion(){
		List<Map<String,Object>> zoneList = new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		JSONObject json = HttpHandler.post(HttpHandler.HTTP_HOST+"/egolm-open-web/user/queryShopDistrict",null );
		if(json != null && json.getBooleanValue("isValid")){
			JSONArray jsonArray = json.getJSONObject("data").getJSONArray("areaList");
			for(int i=0,length=jsonArray.size(); i<length; i++){
				JSONArray jsonArr = jsonArray.getJSONObject(i).getJSONArray("provinceList");
				for(int j=0,len=jsonArr.size(); j<len; j++){
					JSONArray jsonTemp = jsonArr.getJSONObject(j).getJSONArray("cityList");
					for(int k=0,lenTemp=jsonTemp.size(); k<lenTemp; k++){
						JSONObject jsonObj = jsonTemp.getJSONObject(k);
						map = new HashMap<String,Object>();
						map.put("sBelongNo", jsonObj.getString("regionNo"));
						map.put("sBelongArea", jsonObj.getString("cityName"));
						zoneList.add(map);
					}
				}
				
			}
		}
		return zoneList;
	}
	
	/**
	 * @description 根据条件查询获取模块数据
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/queryModules",method=RequestMethod.POST)
	public void queryModules(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request, Writer writer){
		
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
}
