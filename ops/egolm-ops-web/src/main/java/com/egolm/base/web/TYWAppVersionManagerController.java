package com.egolm.base.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.Writer;
import java.math.BigDecimal;
import java.net.URLEncoder;
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
import org.springframework.plugin.util.Ftp;
import org.springframework.plugin.util.Sftp;
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

import com.egolm.base.api.TYWAppVersionManagerAddApi;
import com.egolm.base.api.TYWAppVersionManagerQueryApi;
import com.egolm.base.api.TYWAppVersionManagerUpdateApi;
import com.egolm.common.EgolmContants;
import com.egolm.config.core.reader.ConfigReader;
import com.egolm.config.core.utils.ConfigPath;
import com.egolm.domain.TYWAppVersionManager;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * 
 * @author admin
 *
 */
@Controller
@RequestMapping("/system/appVersion")
public class TYWAppVersionManagerController {
	@Resource(name = "tYWAppVersionManagerAddApi")
	private TYWAppVersionManagerAddApi  tYWAppVersionManagerAddApi;
	
	@Resource(name = "tYWAppVersionManagerQueryApi")
	private TYWAppVersionManagerQueryApi  tYWAppVersionManagerQueryApi;
	
	@Resource(name = "tYWAppVersionManagerUpdateApi")
	private TYWAppVersionManagerUpdateApi  tYWAppVersionManagerUpdateApi;
	
	
	//上传环境
	private String sftpEnv = ConfigReader.getProperty(ConfigPath.cpath("G:system.properties"), "path.sftp.env", "test");

	
	@RequestMapping(value = "/addIndex")
	public String addIndex(){
		return "/base/appVersion_add.jsp";
	}
	
	
	
	@RequestMapping(value = "/list")
	public ModelAndView list(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(10);
			}else{
				page.setLimit(10);
			}
			
			page.setLimitKey("dUpdateDate desc");
			
			String sAppTypeID  = request.getParameter("sAppTypeID");
			String sAppQuery  = request.getParameter("sAppQuery");
			String sAppType = request.getParameter("sAppType");
			map.put("sAppTypeID", sAppTypeID);
			map.put("sAppType",sAppType);
			map.put("sAppQuery", sAppQuery);
			
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			if(U.isNotEmpty(sAppTypeID)){
				params.put("sAppTypeID",sAppTypeID);
			}
			if(U.isNotEmpty(sAppQuery)){
				params.put("sAppQuery", sAppQuery);
			}
			
			Map<String, Object> resultMap = tYWAppVersionManagerQueryApi.query(params, page);
			boolean result = (boolean) resultMap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultMap.get("DataList");
				page = U.objTo(resultMap.get("page"), PageSqlserver.class);
				map.put("appVersionList", dataList); 
				map.put("page", page);
			}
		} catch (Exception e) {
		  U.logger.error("获取版本管理数据失败",e);
		}
		
		ModelAndView mv = new ModelAndView("/base/appVersion_list.jsp", map);
		return mv;
	}
	
	
	@RequestMapping(value = "/add", method =RequestMethod.POST)
	public void add(@RequestParam(value = "filePath", required = false) MultipartFile file,HttpServletRequest request, Writer writer) {
		try {
			TYWAppVersionManager tYWAppVersionManager = new TYWAppVersionManager();
			String sAppName = request.getParameter("sAppName");
			String nID = request.getParameter("nID");
			String sAppVersion = request.getParameter("sAppVersion");
 			String sAppTypeID = request.getParameter("sAppTypeID");
			String sAppType = request.getParameter("sAppType"); 
 			  
			
 			if (U.isNotEmpty(nID)) {
				tYWAppVersionManager = this.tYWAppVersionManagerQueryApi.queryById(nID);
				tYWAppVersionManager.setsUpdateUser(SecurityContextUtil.getUserName());
				
				if(tYWAppVersionManager == null){
					Egox.egoxErr().setReturnValue("版本不存在,更新失败").write(writer);
					return ;
				}
			}else{
				tYWAppVersionManager.setsCreateUser(SecurityContextUtil.getUserName());
				tYWAppVersionManager.setsUpdateUser(SecurityContextUtil.getUserName());
			}
			
			tYWAppVersionManager.setsAppName(sAppName);
			tYWAppVersionManager.setsAppVersion(sAppVersion);
 			tYWAppVersionManager.setsAppTypeID(sAppTypeID);
			tYWAppVersionManager.setsAppType(sAppType);
			tYWAppVersionManager.setnTag(1);
			
			
 			if(file != null){
				String fileName = file.getOriginalFilename();
				if(StringUtil.isNotEmpty(fileName)){
					String extName = null;
					 
					if(fileName.contains(".")) {
						extName = fileName.substring(fileName.lastIndexOf(".") + 1);
					}
					
					String remotePath  = "app/"+sftpEnv+"/"+sAppTypeID+"/"+StringUtil.fullPinyin(sAppType)+"_"+sAppVersion+"."+extName;
					//FTP 上传包会损坏
					/*Ftp ftp = Ftp.newInstance(EgolmContants.FTP_IP, EgolmContants.FTP_PORT, EgolmContants.FTP_USERNAME, EgolmContants.FTP_PASSWORD);
					ftp.uploadFile(file.getInputStream(),remotePath);*/
					
					Sftp sftp = Sftp.newInstance(EgolmContants.FTP_IP, EgolmContants.SFTP_PORT, EgolmContants.SFTP_USERNAME, EgolmContants.SFTP_PASSWORD).open();
					 
					sftp.uploadFile(file.getInputStream(), EgolmContants.SFTP_PATH+""+remotePath); 
					sftp.close();
					tYWAppVersionManager.setsAppUrl(remotePath);
					tYWAppVersionManager.setnSize(new BigDecimal(file.getSize()));
				}			
			}
			
			if(U.isNotEmpty(nID)){
				Map<String,Object> resultMap = this.tYWAppVersionManagerUpdateApi.update(tYWAppVersionManager);
				 boolean result = (boolean) resultMap.get("IsValid");
				 if (result) {
					Egox.egoxOk().setReturnValue("版本信息更新成功").write(writer);
				 } else {
					Egox.egoxErr().setReturnValue("版本信息更新失败").write(writer);
				 }
			}else{
				Map<String,Object> resultMap = this.tYWAppVersionManagerAddApi.createTywVersionManager(tYWAppVersionManager);
				 boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Egox.egoxOk().setReturnValue("版本信息添加成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("版本信息添加失败").write(writer);
				}
			}
		} catch (Exception e) {
			U.logger.error("版本信息操作出错,", e);
			Egox.egoxErr().setReturnValue("版本信息操作失败").write(writer);
		}
	}
	
	@RequestMapping(value = "/loadMsgById")
	public ModelAndView loadMsgById(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String nId = request.getParameter("nId");
			TYWAppVersionManager tYWAppVersionManager = tYWAppVersionManagerQueryApi.queryById(nId);
			if(tYWAppVersionManager == null){
				tYWAppVersionManager = new TYWAppVersionManager();
			}
			map.put("appVersion", tYWAppVersionManager);

		} catch (Exception e) {
			U.logger.error("获取版本信息出错,", e);
		}
		ModelAndView mv = new ModelAndView("/base/appVersion_add.jsp", map);
		return mv;
	}
	
	
	/**
	 * 删除版本数据
	 * 
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/delete")
	public void delete(HttpServletRequest request, Writer writer) {
		try {
			String nId = request.getParameter("nId");
			TYWAppVersionManager tYWAppVersionManager = tYWAppVersionManagerQueryApi.queryById(nId);
			if(tYWAppVersionManager != null){
				tYWAppVersionManager.setnTag(0);
				tYWAppVersionManager.setsUpdateUser(SecurityContextUtil.getUserName());
				tYWAppVersionManager.setdUpdateDate(DateUtil.parse(DateUtil.format(new Date()), DateUtil.FMT_DATE_SECOND));
				
				Map<String, Object> resultMap = tYWAppVersionManagerUpdateApi.update(tYWAppVersionManager);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Egox.egoxOk().setReturnValue("版本数据删除成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("版本数据删除失败").write(writer);
				}
			}else{
				Egox.egoxErr().setReturnValue("版本数据删除失败,未找到对应的版本数据").write(writer);
			}
			
			 
		} catch (Exception e) {
			U.logger.error("版本数据删除出错,", e);
			Egox.egoxErr().setReturnValue("版本数据删除失败").write(writer);
		}
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	
	@RequestMapping(value="/downloadFile")
	public void downloadFile(HttpServletRequest request,Writer writer, HttpServletResponse response){
		try {
			
			String nId = request.getParameter("nId");
			TYWAppVersionManager tYWAppVersionManager = tYWAppVersionManagerQueryApi.queryById(nId);
			if(tYWAppVersionManager != null){
				String sAppUrl = tYWAppVersionManager.getsAppUrl();
				if(U.isNotEmpty(sAppUrl)){
					 Ftp ftp = Ftp.newInstance(EgolmContants.FTP_IP, EgolmContants.FTP_PORT, EgolmContants.FTP_USERNAME, EgolmContants.FTP_PASSWORD);
					 response.reset();
					 String fileName = sAppUrl.substring(sAppUrl.lastIndexOf("/")+1, sAppUrl.length()); 
					 response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8")); 
					 response.setContentType("application/octet-stream");
					 ftp.downFile(sAppUrl, response.getOutputStream());
				}
			} 
		}  catch (Exception e) { 
		}
	}
}
