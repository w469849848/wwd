package com.egolm.advert.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.advert.api.TShopAdBatchAddApi;
import com.egolm.advert.api.TShopAdBatchQueryApi;
import com.egolm.advert.api.TShopAdBatchUpdateApi;
import com.egolm.domain.TShopAdBatch;
import com.egolm.security.utils.SecurityContextUtil; 

/**
 * 
* Title:   广告批次表
* Description:
* Company: 万店易购投资管理有限公司
* @author zhangyong
* @date 2016年5月4日
 */

@Controller
@RequestMapping("/media/mediaBatch")
public class TShopAdBatchController extends BaseAdvertController{
	@Resource(name = "tShopAdBatchAddApi")
	private TShopAdBatchAddApi tShopAdBatchAddApi;
	@Resource(name = "tShopAdBatchQueryApi")
	private TShopAdBatchQueryApi tShopAdBatchQueryApi;
	@Resource(name = "tShopAdBatchUpdateApi")
	private TShopAdBatchUpdateApi  tShopAdBatchUpdateApi;
	
	@RequestMapping(value = "/index")
	public String adVertIndex(){
		return "/ad/adBatch/adBatch_add.jsp";
	}
	
	@RequestMapping(value="/listToJson")
	public void listToJson(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		ModelAndView mv = list(request, page);
		Map<String,Object> map= mv.getModel();
		List<Map<String, Object>> dataList =  (List<Map<String, Object>>) map.get("adBatchList");
		Egox.egoxOk().setDataList(dataList).write(writer);
	}
	
	@RequestMapping(value="/list")
	public ModelAndView list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page){
		Map<String, Object> map = new HashMap<String, Object>();
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(20);
		}
		page.setLimitKey("dLastUpdateTime");
		try {
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			params = setMapByPar(request, params,null, "com.egolm.domain.TShopAdBatch");
 			Map<String, Object> resultmap = tShopAdBatchQueryApi.query(params, page);
			boolean result = (boolean)resultmap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");
				page =U.objTo(resultmap.get("page"),PageSqlserver.class);
				map.put("adBatchList", dataList);
				map.put("page", page);
			}
			
		} catch (Exception e) { 
			U.logger.error("广告批次表查询请求出错,", e);
		}
		ModelAndView mv = new ModelAndView("/ad/adBatch/adBatch_list.jsp", map);
		return mv;
	}
	
	@RequestMapping(value="/add", method =RequestMethod.POST)
	public void add(HttpServletRequest request,Writer writer) {
		try {
			String sBatchName= request.getParameter("sBatchName");
			String sCreateUser = SecurityContextUtil.getUserName();
			TShopAdBatch tShopAdBatch = new TShopAdBatch();
			tShopAdBatch.setSBatchName(sBatchName);
			tShopAdBatch.setSCreateUser(sCreateUser);
			
			Map<String,Object> resultMap = this.tShopAdBatchAddApi.createTShopAdBatch(tShopAdBatch);
			 Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("广告批次新增出错,", e);
			Egox.egoxErr().setReturnValue("广告批次新增失败").write(writer);
		}
	}
	
	/**
	 * 根据ID获取合同
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/loadMsgById")
	public ModelAndView loadMsgById(HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String nBID = request.getParameter("id");
			Map<String, Object> resultMap = this.tShopAdBatchQueryApi.queryTShopAdBatchById(nBID);
			 boolean result = (boolean)resultMap.get("IsValid");
			 if(result){
				 map.put("advContractData", resultMap.get("DataList"));
			 }
			
		} catch (Exception e) { 
			U.logger.error("获取广告批次信息出错,", e);
		}
		ModelAndView mv = new ModelAndView("/ad/adBatch/adBatch_add.jsp", map);
		return mv;
	}
	
}
