package com.egolm.tpl.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
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

import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.domain.TYWModuleManage;
import com.egolm.tpl.service.ModuleService;

@Controller
@RequestMapping("/template/module")
public class ModuleController {
	
	@Autowired
	private ModuleService moduleService;

	/**
	 * 进入模块管理列表页面
	 * @return
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page){
		ModelAndView mv = new ModelAndView("tpl/module-manage.jsp");
		try {
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("sModuleNo DESC");
			}
			String sModuleName=request.getParameter("sModuleName");
			String nModuleType=request.getParameter("nModuleType");
			mv.addObject("sModuleName", sModuleName);
			mv.addObject("nModuleType", nModuleType);
			mv.addObject("nModuleTypeText", nModuleType);
			if(U.isEmpty(nModuleType)){
				mv.addObject("nModuleTypeText", "模块类别");
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			if(U.isNotEmpty(sModuleName)){
				paramMap.put("sModuleName",sModuleName.trim());
			}
			if(U.isNotEmpty(nModuleType)&&!"模块类别".equals(nModuleType)){
				paramMap.put("nModuleType",nModuleType);
			}
			Map<String, Object> datas = moduleService.queryModules(paramMap, page);
			Page pageReturn = (Page) datas.get("page");
			mv.addObject("datas", datas);
			mv.addObject("page", pageReturn);
		} catch (Exception e) { 
			U.logger.error("查询模块出错", e);
		}
		
		return mv;
	}
	
	/**
	 * 进入模块管理列表页面
	 * @return
	 */
	@RequestMapping(value="/ajaxlist")
	public void ajaxlist(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page, Writer writer){
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey(" sModuleNo desc");
		try {
			String  nModuleType = request.getParameter("nModuleType");
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			params.put("nModuleType", nModuleType); 
			
			Map<String, Object>  dataMap = (Map<String, Object> )moduleService.queryModules(params,page);
			List<Map<String, Object>> dataList = (List<Map<String, Object>>)dataMap.get("result");
			page = U.objTo(dataMap.get("page"), PageSqlserver.class);
			Egox.egoxOk().setDataList(dataList).set("page", page).write(writer);
		} catch (Exception e) {
			U.logger.error("获取模块列表异常",e);
			Egox.egoxErr().setReturnValue("获取模块列表失败").write(writer);
		}
	}
	
	/**
	 * 进入模块管理新建页面
	 * @return
	 */
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public ModelAndView toAddModulePage(){
		ModelAndView mv = new ModelAndView("tpl/module-add.jsp");
		return mv;
	}
	
	/**
	 * 保存新建或修改模板
	 */
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public void saveModule(@RequestParam(value = "sMiniPic", required = false) MultipartFile file,HttpServletRequest request,Writer writer){
		try {
			TYWModuleManage module=new TYWModuleManage();
			module.setNIsFloor(request.getParameter("nIsFloor"));
			module.setNModuleType(request.getParameter("nModuleType"));
			module.setNStatus("启用");
			module.setSBgPath(request.getParameter("sBgPath"));
			module.setSPcPath(request.getParameter("sPcPath"));
			module.setSModuleNo(request.getParameter("sModuleNo"));
			module.setSModuleName(request.getParameter("sModuleName"));
			module.setSRemark(request.getParameter("sRemark"));
			module.setSWxPath(request.getParameter("sWxPath"));
			module.setSDisplayNo(request.getParameter("sDisplayNo"));
			module.setSDisplayArea(request.getParameter("sDisplayArea"));
			
			//文件上传
			 if(file != null){
				String fileName = file.getOriginalFilename();
				if(U.isNotEmpty(fileName)){
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.FLOOR_PATH+OSSUtils.getFileNewName(fileName);
					//上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					//获取图片路径
					//String filePath = OSSUtils.getImgURl(key, bucketName);
					//filePath = filePath.substring(0, filePath.indexOf("?"));
					OSSUtils.closeOssClient(); 
					module.setSMiniPic("/"+key);
				}
			} 
			
			 //如果没有新上传文件，尝试获取上次上传的文件路径
			 if(module.getSMiniPic()==null){
				 module.setSMiniPic(request.getParameter("oldMiniPic"));
			 }
			
			Map<String,Object> resultMap = moduleService.saveModule(module);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("新建模块出错失败", e);
			Egox.egoxErr().setReturnValue("新建模块出错失败").write(writer);
		}
	}
	
	/**
	 * 进入模块管理修改页面
	 * @return
	 */
	@RequestMapping(value="/edit",method=RequestMethod.GET)
	public ModelAndView toEditModulePage(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("tpl/module-add.jsp");
		String sModuleNo=request.getParameter("sModuleNo");
		try {
			TYWModuleManage module = moduleService.queryModuleById(sModuleNo);
			request.setAttribute("module", module);
		} catch (Exception e) { 
			U.logger.error("修改模块出错失败", e);
		}
		return mv;
	}
	
	/**
	 * 删除模块
	 * @return
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(HttpServletRequest request,Writer writer){
		String sModuleNo = request.getParameter("sModuleNo");
		try {
			Map<String,Object> resultMap = moduleService.deleteModule(sModuleNo);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("删除模块出错失败", e);
			Egox.egoxErr().setReturnValue("删除模块出错失败").write(writer);
		}
	}
	
	/**
	 * 修改模块状态
	 * @return
	 */
	@RequestMapping(value="/status",method=RequestMethod.POST)
	public void status(HttpServletRequest request,Writer writer){
		String sModuleNo = request.getParameter("sModuleNo");
		String nStatus=request.getParameter("nStatus");
		try {
			Map<String,Object> resultMap = moduleService.updateModuleStatus(sModuleNo,nStatus);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("更改模块状态失败", e);
			Egox.egoxErr().setReturnValue("更改模块状态失败").write(writer);
		}
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
}
