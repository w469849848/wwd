package com.egolm.dealer.web;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmException;
import com.egolm.common.enums.UserType;
import com.egolm.dealer.api.AgentAddApi;
import com.egolm.dealer.api.AgentCleanApi;
import com.egolm.dealer.api.AgentQueryApi;
import com.egolm.dealer.api.AgentUpdateApi;
import com.egolm.dealer.api.RegionQueryApi;
import com.egolm.domain.TAgent;
import com.egolm.member.api.user.UserApi;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.util.ExportExcelUtil;
import com.google.common.collect.Lists;

/**
 * 
 * @Title:
 * @Description:经销商资料相关控制器
 * @author qlh
 * @date 2016年4月15日 下午1:10:09
 * @version V1.0
 * 
 */

@Controller
@RequestMapping("/dealer")
public class TAgentController {

	@Resource(name = "agentQueryApi")
	private AgentQueryApi agentQueryApi;

	@Resource(name = "agentAddApi")
	private AgentAddApi agentAddApi;
	
	@Resource(name = "agentUpdateApi")
	private AgentUpdateApi agentUpdateApi;
	
	@Resource(name = "agentCleanApi")
	private AgentCleanApi agentCleanApi;
	
	@Resource(name = "regionQueryApi")
	private RegionQueryApi regionQueryApi;
	

	@Resource(name = "userApi")
	private UserApi userApi;
	
	
	@RequestMapping("/listToJson")
	public void listToJson(String sAgentName,HttpServletRequest request,Writer writer){
		/*ModelAndView mav = agentList(page, sAgentName, request);
		Map<String,Object> resultMap = mav.getModel();
		Map<String,Object> dataMap = (Map<String,Object> )resultMap.get("datas");*/
		
		PageSqlserver page = new PageSqlserver();
		page.setLimit(1000);
		page.setLimitKey("sAgentNO DESC"); 
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		List<String> regionIds = SecurityContextUtil.getRegionIds(); //用户类型
		
		Map<String, Object> datas = agentQueryApi.queryAgents(regionIds, paramMap, page);
		Egox.egox(datas).write(writer); 
	}

	@RequestMapping(value = "/agentList", produces = { "application/json;charset=UTF-8" })
	public ModelAndView agentList(@ModelAttribute("page") PageSqlserver page,String sAgentName,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateDate DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sAgentName)){
			paramMap.put("sAgentName",sAgentName);
		}
		if(SecurityContextUtil.getRegionIds().size()>0){
			paramMap.put("sOrgNO",listToString(SecurityContextUtil.getRegionIds()));
		}
		List<String> regionIds = SecurityContextUtil.getRegionIds(); 
		Map<String, Object> datas = agentQueryApi.queryAgents(regionIds, paramMap, page);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sAgentName", sAgentName);
		mv.setViewName("/dealer/dealer_list.jsp");
		return mv;
	}
	@RequestMapping("/agentAdd")
	public String agentAdd(HttpServletRequest request) {
		Map<String, Object> nationDatas = regionQueryApi.queryNation();
		request.setAttribute("nationDatas", nationDatas.get("DataList"));
		Map<String, Object> provinceDatas = regionQueryApi.queryProvinces();
		request.setAttribute("provinceDatas", provinceDatas.get("DataList"));
		return "/dealer/dealer_add.jsp";
	}
	
	@RequestMapping("/getCityByProvinceId")
	public void getCityByProvinceId(String sProvinceID,Writer writer) {
		Map<String, Object> returnMsg = regionQueryApi.queryCityByProvinceId(sProvinceID);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping("/getAreaByCityId")
	public void getAreaByCityId(String sCityID,Writer writer) {
		Map<String, Object> returnMsg = regionQueryApi.queryAreaByCityId(sCityID);
		Egox.egox(returnMsg).write(writer);
	}
	
	
	@RequestMapping(value = "/agentSubmit", produces = { "application/json;charset=UTF-8" })
	public void agentSubmit(TAgent tAgent,HttpServletRequest request,Writer writer) {
		
		Map<String,Object> maxId = agentQueryApi.queryMaxIdAgent();
		tAgent.setNAgentID(Integer.valueOf(maxId.get("maxId").toString())+1);
		tAgent.setSAgentNO(String.valueOf(U.random(4)));
		Date date = new Date();
		tAgent.setNTag(0);
		tAgent.setDCreateDate(date);
		tAgent.setSCreateUser(SecurityContextUtil.getUserName());
		tAgent.setDLastUpdateTime(date);
		Map<String, Object> returnMsg = agentAddApi.createTAgent(tAgent);
		//新增经销商用户同时插入基础用户表
		//userApi.signUp(UserType.AGENT, returnMsg.get("id").toString(), tAgent.getSAgentNO(), "123456");
		Egox.egox(returnMsg).write(writer);
	}
	@RequestMapping("/agentEdit")
	public ModelAndView agentEdit(Integer nAgentID,String type,HttpServletRequest request) {
		ModelAndView mv  = new ModelAndView();
		TAgent tAgent = agentQueryApi.queryTAgentById(nAgentID);
		Map<String, Object> nationDatas = regionQueryApi.queryNation();
		mv.addObject("nationDatas", nationDatas.get("DataList"));
		Map<String, Object> provinceDatas = regionQueryApi.queryProvinces();
		mv.addObject("provinceDatas", provinceDatas.get("DataList"));
		mv.addObject("tAgent", tAgent);
		mv.addObject("type", type);
		mv.addObject("provinceDatas",  provinceDatas.get("DataList"));
		mv.setViewName("/dealer/dealer_edit.jsp");
		return mv;
	}
	
	@RequestMapping("/agentUpdate")
	public void agentUpdate(TAgent tAgent,HttpServletRequest request,Writer writer) {
		TAgent tAgentBean = agentQueryApi.queryTAgentById(tAgent.getNAgentID());
		tAgentBean.setSAgentName(tAgent.getSAgentName());
		tAgentBean.setSAgentTitle(tAgent.getSAgentTitle());
		tAgentBean.setSAgentType(tAgent.getSAgentType());
		tAgentBean.setSAgentTypeID(tAgent.getSAgentTypeID());
		tAgentBean.setSContact(tAgent.getSContact());
		tAgentBean.setSTel(tAgent.getSTel());
		tAgentBean.setSFax(tAgent.getSFax());
		tAgentBean.setSMobile(tAgent.getSMobile());
		tAgentBean.setSAddress(tAgent.getSAddress());
		tAgentBean.setSNationID(tAgent.getSNationID());
		tAgentBean.setSNation(tAgent.getSNation());
		tAgentBean.setSProvinceID(tAgent.getSProvinceID());
		tAgentBean.setSProvince(tAgent.getSProvince());
		tAgentBean.setSCityID(tAgent.getSCityID());
		tAgentBean.setSCity(tAgent.getSCity());
		tAgentBean.setSDistrict(tAgent.getSDistrict());
		tAgentBean.setSDistrictID(tAgent.getSDistrictID());
		tAgentBean.setSPostalcode(tAgent.getSPostalcode());
		tAgentBean.setSEmail(tAgent.getSEmail());
		Date date = new Date();
		tAgentBean.setDConfirmDate(date);
		tAgentBean.setSConfirmUser(SecurityContextUtil.getUserName());
		tAgentBean.setDLastUpdateTime(new Date());
		Map<String, Object> returnMsg = agentUpdateApi.updateTAgent(tAgentBean);
		Egox.egox(returnMsg).write(writer);
	}
	@RequestMapping("/agentClean")
	public void agentDelete(Integer nAgentID,HttpServletRequest request,Writer writer) {
		Map<String, Object> returnMsg = agentCleanApi.cleanTAgent(nAgentID);
		Egox.egox(returnMsg).write(writer);
	}
	
	@RequestMapping(value="/exprotExcel")
    @ResponseBody 
    public String exprotExcel(HttpServletResponse response,@ModelAttribute("page") PageSqlserver pageParam,String sAgentName,String agentIds,HttpServletRequest request) {
		if (pageParam == null || pageParam.getLimitKey() == null) {
			pageParam.setLimit(10);
			pageParam.setLimitKey("sAgentNO DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sAgentName)){
			paramMap.put("sAgentName",sAgentName);
		}
		List<String> idsArray = Lists.newArrayList();
		if (StringUtils.isNotBlank(agentIds)) {
			idsArray.addAll(Arrays.asList(agentIds.split(",")));
		}
		ExportExcelUtil<TAgent> excelUtil=new ExportExcelUtil<TAgent>();
		  OutputStream out=null;
		  try {
			  		 out = response.getOutputStream();// 取得输出流   
		             response.reset();// 清空输出流  
		             response.setHeader("Content-disposition", "attachment; filename="+new String("经销商列表".getBytes("GB2312"),"8859_1")+".xls");// 设定输出文件头   
		             response.setContentType("application/msexcel");// 定义输出类型
		  }  catch (IOException e) {
			  		e.printStackTrace();
		  }  
		  String[] headers ={"经销商编号","经销商姓名","经销商抬头","联系人"};
		  String[]columns={ "sAgentNO", "sAgentName", "sAgentTitle", "sContact"};
		  List<TAgent> dataset = agentQueryApi.queryAgentOfExcel(paramMap,idsArray,pageParam);
		  try  {
			  excelUtil.exportExcel("经销商列表", headers, columns, dataset, out, "");
			  out.close();
		  } catch (Exception e1)  {
			  e1.printStackTrace();
		  }
		  return null;
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}

	@RequestMapping("queryAgentByOrgNo")
	@ResponseBody
	public Rjx queryAgentByOrgNo(String sOrgNo) {
		if (StringUtils.isBlank(sOrgNo)) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		try {
			Map<String, Object> data = agentQueryApi.queryTAgentByOrgNo(sOrgNo);
			if(null != data) {
				return Rjx.jsonOk().set("agents", data.get("DataList"));
			}
			return Rjx.jsonOk().set("agents", new ArrayList<Object>());
		} catch (EgolmException e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	public static String listToString(List<String> stringList){
        if (stringList==null) {
            return null;
        }
        String temp="";
        for (String string : stringList) {
        	temp+="'"+string+"',";
        }
        return temp.substring(0, temp.length() -1).toString();
    }
	
	
	
	
}
