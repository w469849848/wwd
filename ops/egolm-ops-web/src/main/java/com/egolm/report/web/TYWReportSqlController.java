package com.egolm.report.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.enums.UserType;
import com.egolm.domain.TYWReportSql;
import com.egolm.report.api.TYWReportSQLAddApi;
import com.egolm.report.api.TYWReportSQLQueryApi;
import com.egolm.report.api.TYWReportSQLUpdateApi;
import com.egolm.security.utils.SecurityContextUtil;

@Controller 
@RequestMapping("/system/ywReport/")
public class TYWReportSqlController {

	@Resource(name = "tYWReportSQLAddApi")
	private TYWReportSQLAddApi tYWReportSQLAddApi;
	
	@Resource(name = "tYWReportSQLQueryApi")
	private TYWReportSQLQueryApi tYWReportSQLQueryApi;
	@Resource(name = "tYWReportSQLUpdateApi")
	private TYWReportSQLUpdateApi tYWReportSQLUpdateApi;
	
	@RequestMapping("/index")
	public String index(){
		return "/system/report-manager.jsp";
	}
	@RequestMapping("/addIndex")
	public String addIndex(){
		return "/system/report-add.jsp";
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	@RequestMapping(value="/list")
	public void list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime desc");
 		
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			
			String queryAttr = request.getParameter("queryAttr");
			
			if(U.isNotEmpty(queryAttr)){
				params.put("queryAttr", queryAttr);
			}
			
			boolean isSelect = false;
			UserType userType = SecurityContextUtil.getUserType(); //用户类型
			if (userType.oneOf(UserType.ADMIN)) {  //管理员
				isSelect = true;
			} else{
				U.logger.error("非法访问"); 
				Egox.egoxErr().setReturnValue("非法访问").write(writer);
				return;
			}
			if(isSelect){ 
 				Map<String, Object> resultmap = tYWReportSQLQueryApi.queryTYWReportSQL(params, page);
				boolean result = (boolean)resultmap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");
					page =U.objTo(resultmap.get("page"),PageSqlserver.class);
					Egox.egoxOk().setDataList(dataList).set("page",page).write(writer);
				}else{
					Egox.egoxErr().setReturnValue("数据请求异常").write(writer);
				}		
			} 
		} catch (Exception e) { 
			U.logger.error("报表基础数据请求异常出错,", e);
		} 
	}
	
	@RequestMapping(value="/add", method =RequestMethod.POST)
	public void add(HttpServletRequest request,Writer writer){
		try {
		 	String sMenuID = request.getParameter("sMenuID");
			String sMenuName = request.getParameter("sMenuName");
			String sReportTitle = request.getParameter("sReportTitle");
			String sReportSql = request.getParameter("sReportSql");
			String sReportTypeID = request.getParameter("sReportTypeID");
			String sReportType = request.getParameter("sReportType"); 
			String sReportSortField = request.getParameter("sReportSortField");
			
			sReportSql = sReportSql.replace("drop"," ").replace("create", " ").replace("update", " ")
					.replace("delete", " ").replace("<", " ").replace(">", " ").replace("&", " ");
			
			String type = "";
			
			TYWReportSql tYWReportSql = new TYWReportSql();
			if(U.isNotEmpty(sMenuID)){
				Map<String, Object> resultMap = this.tYWReportSQLQueryApi.queryTYWReportSQLById(sMenuID);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Map<String,Object> dataMap = (Map<String,Object>) resultMap.get("DataList"); 
					tYWReportSql = U.mapTo(dataMap, TYWReportSql.class);
					type = "update";
				}
			}else{
				tYWReportSql.setSMenuID(U.uuid());
				tYWReportSql.setSCreateUser(SecurityContextUtil.getUserName()); 
				type = "add";
			} 
			tYWReportSql.setSReportTypeID(sReportTypeID);

			tYWReportSql.setSMenuName(sMenuName);
			tYWReportSql.setSReportSql(sReportSql);
			tYWReportSql.setSReportTitle(sReportTitle);
			tYWReportSql.setSReportType(sReportType); 
			tYWReportSql.setSReportSortField(sReportSortField);
			tYWReportSql.setSConfirmUser(SecurityContextUtil.getUserName());
			
			if(type.equals("update")){
				Map<String, Object> resultMap = this.tYWReportSQLUpdateApi.updateTYWReportSQL(tYWReportSql);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Egox.egoxOk().setReturnValue("报表基础数据更新成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("报表基础数据更新失败").write(writer);
				}
			}else{
				Map<String, Object> resultMap = this.tYWReportSQLAddApi.createTYWReportSQL(tYWReportSql);
				boolean result = (boolean) resultMap.get("IsValid");
				if (result) {
					Egox.egoxOk().setReturnValue("报表基础数据新增成功").write(writer);
				} else {
					Egox.egoxErr().setReturnValue("报表基础数据新增失败").write(writer);
				}
			}
			
			
		} catch (Exception e) {
			U.logger.error("报表基础数据操作失败",e);
			Egox.egoxErr().setReturnValue("报表基础数据操作异常").write(writer);
		}
	}
	
	@RequestMapping(value = "/loadMsgById")
	public ModelAndView loadReportSqlMsg(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String menuId = request.getParameter("menuId");
			Map<String, Object> resultMap = this.tYWReportSQLQueryApi.queryTYWReportSQLById(menuId);
			boolean result = (boolean) resultMap.get("IsValid");
			if (result) {
				map.put("reportSqlData", resultMap.get("DataList"));
			}

		} catch (Exception e) {
			U.logger.error("根据ID获取报表统计信息出错,", e);
		}
		ModelAndView mv = new ModelAndView("/system/report-add.jsp", map);
		return mv;
	}
}
