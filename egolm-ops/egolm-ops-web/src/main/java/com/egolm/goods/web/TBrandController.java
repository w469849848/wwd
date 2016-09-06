package com.egolm.goods.web;

import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.common.goods.GoodsContants;
import com.egolm.domain.TBrand;
import com.egolm.goods.api.TBrandAddApi;
import com.egolm.goods.api.TBrandQueryApi;
import com.egolm.goods.api.TBrandUpdateApi;
import com.egolm.goods.domain.TBrandTree;  
 /**
 * 
 * @Title:  品牌控制器
 * @Description:
 * @author zhangyong
 * @date  2016年4月15日 下午5:40:05
 * @version V1.0
 *
 */

@Controller
@RequestMapping("/goods/brand")
public class TBrandController  {
	@Resource(name = "tBrandAddApi")
	private TBrandAddApi tBrandAddApi;
	@Resource(name = "tBrandQueryApi")
	private TBrandQueryApi tBrandQueryApi;
	@Resource(name = "tBrandUpdateApi")
	private TBrandUpdateApi tBrandUpdateApi;
	@RequestMapping(value="/index")
	public String index(){
		return "/goods/brand/brand_add.jsp";
	}
	@RequestMapping(value="/tolist")
	public String tolist(){
		return "/goods/brand/brand_list.jsp";
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	/**
	 * 品牌树
	 * @param request
	 * @param page
	 * @param writer
	 */
	@RequestMapping(value="/brandZtree")
	public void brandZtree(HttpServletRequest request,PageSqlserver page,Writer writer){
		 page.setLimit(10000);
		 String jsonp = request.getParameter("jsonp");  //跨域
		 Map<String,Object> resultMap = queryBrandSQL(request,page);
		 if(resultMap != null){
			 boolean result = (boolean)resultMap.get("IsValid");
			 if(result){
				 List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultMap.get("DataList");
				 List<TBrandTree> tBrandList = new ArrayList<TBrandTree>();
				 if(dataList != null && dataList.size()>0){
					 for(Map<String,Object> map:dataList){
						 TBrandTree tBrandTree = new TBrandTree();
						  String id = map.get("sBrandID").toString();
						  String pId = map.get("sParentBrandID").toString();
						  String name = map.get("sBrandName").toString();
						  
						  tBrandTree.setId(id);
						  tBrandTree.setpId(pId);
						  tBrandTree.setName(name);
						  tBrandList.add(tBrandTree);
					 }
				 }
				 Egox.egoxOk().setCallback(jsonp).setDataList(tBrandList).write(writer);
			 }else{
				 Egox.egoxErr().setCallback(jsonp).setReturnValue("品牌树结构生成失败").write(writer);
			 }
		 }else{
			 Egox.egoxErr().setCallback(jsonp).setReturnValue("品牌资料查询异常").write(writer);
		 }
	}
	
	
	
	
	@RequestMapping(value="/list")
	public void list(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		 
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(20);
		}else{
			page.setLimit(10);
		}
		page.setLimitKey("dLastUpdateTime");
		try {
			String sBrandSelect = request.getParameter("sBrandSelect");  //包含  编号 和名称
		    Map<String, Object> params = new HashMap<String,Object>();
		    if(U.isNotEmpty(sBrandSelect)){
		    	params.put("sBrandSelect",sBrandSelect);	
		    }
		    
			Map<String, Object> resultmap = tBrandQueryApi.queryTBrand(params, page); 
 			if(resultmap != null){
				boolean result = (boolean)resultmap.get("IsValid");
				if(result){
					List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList"); 
					page =U.objTo(resultmap.get("page"),PageSqlserver.class); 
					Egox.egoxOk().setDataList(dataList).set("page",page).write(writer);
				}else{
				  Egox.egoxErr().setReturnValue("品牌资料查询失败").write(writer);
				}
			}else{
				Egox.egoxErr().setReturnValue("品牌资料查询异常").write(writer);
			}
			
			
		} catch (Exception e) { 
			U.logger.error("产品基础资料查询失败,", e);
			Egox.egoxErr().setReturnValue("品牌资料查询失败").write(writer);
		}
	}

	/**
	 * 添加或修改
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value="/add")
	public void add(HttpServletRequest request,Writer writer){
		String jsonp = request.getParameter("jsonp");  //跨域
		  try {
			  String sBrandID = request.getParameter("sBrandID"); //品牌ID
			  String sBrandName  = request.getParameter("sBrandName");      
			  String nSortPriority = request.getParameter("nSortPriority");
			  String sParentBrandID = request.getParameter("sParentBrandID");
			  String sCradle = request.getParameter("sCradle");
			  String sBrandTypeID   = request.getParameter("sBrandTypeID");  
 			  String sBrandType   = request.getParameter("sBrandType");    
			  String sMemo       = request.getParameter("sMemo");  
			  String sCreateUser  = request.getParameter("sCreateUser");    
			  String sLogoUrl = request.getParameter("sLogoUrl");
  			  
 			  if(!U.isNotBlank(sBrandName,sBrandTypeID,sBrandType)){
 				  Egox.egoxErr().setCallback(jsonp).setReturnValue("参数为空").write(writer);
 				  return ;
 			  }else{
 				  boolean insertBoolean = false; //是否为insert 				  
 				  TBrand tbb = new TBrand(); 				  
 				  if(StringUtils.isEmpty(sBrandID)){
 					  insertBoolean = true;
 					  sBrandID = "B"+System.nanoTime();  //根据系统纳秒时间生成
 					 tbb.setSBrandID(sBrandID);
 				  }else{
 					 tbb=  this.tBrandQueryApi.queryTBrandById(sBrandID);
 					 tbb.setDLastUpdateTime(new Date());
 				  }
 				     
 				  tbb.setSLogoUrl(sLogoUrl);
 				  tbb.setNSortPriority(Integer.valueOf(nSortPriority));
 				  tbb.setSParentBrandID(sParentBrandID);
 				  tbb.setSCradle(sCradle);
 				  tbb.setSBrandType(sBrandType);
 				  tbb.setSBrandName(sBrandName);
 				  tbb.setSBrandTypeID(sBrandTypeID); 			  
 				  tbb.setSMemo(sMemo);
 				  tbb.setNTag(GoodsContants.TAG_0);
 				  tbb.setSCreateUser(sCreateUser); 
 				  tbb.setSConfirmUser(sCreateUser);
 				 
 				  
				  Map<String,Object> resultMap =new  HashMap<String,Object>();
				  if(insertBoolean){
					 resultMap = this.tBrandAddApi.createTBrand(tbb);
				  }else{
					 resultMap = this.tBrandUpdateApi.updateTBrand(tbb);
				  }
			      
				 boolean result = (boolean)resultMap.get("IsValid");
				 if(result){
					 Egox.egoxOk().setCallback(jsonp).setReturnValue(resultMap.get("ReturnValue").toString()).write(writer);    
				 }else{
					 Egox.egoxErr().setCallback(jsonp).setReturnValue(resultMap.get("ReturnValue").toString()).write(writer);
				 } 
 			  } 
		}  catch (Exception e) {
			U.logger.error("品牌操作失败",e);
			 Egox.egoxErr().setCallback(jsonp).setReturnValue("品牌数据操作失败").write(writer);

		}
	}
	
	@RequestMapping(value="/delete")
	public  void delete(HttpServletRequest request,Writer writer){
		String nBrandID = request.getParameter("nBrandID");
		String jsonp = request.getParameter("jsonp");  //跨域
		if(U.isEmpty(nBrandID)){
			Egox.egoxErr().setCallback(jsonp).setReturnValue("品牌ID参数为空").write(writer);
			return ;
		}
		/*if(StringUtil.isInt(nBrandID.trim())){
			Egox.egoxErr().setReturnValue("品牌ID参数错误").write(writer);
		}*/
		 
		TBrand tBrand = this.tBrandQueryApi.queryTBrandById(nBrandID);
		if(tBrand != null){ 
			Map<String,Object> resultMap = this.tBrandUpdateApi.updateTBrand(tBrand);
			boolean result = (boolean)resultMap.get("IsValid");
			if(result){
				Egox.egoxOk().setCallback(jsonp).setReturnValue(resultMap.get("ReturnValue").toString()).write(writer);
			}else{
				Egox.egoxErr().setCallback(jsonp).setReturnValue(resultMap.get("ReturnValue").toString()).write(writer);
			}
		}else{
			Egox.egoxErr().setCallback(jsonp).setReturnValue("未找到ID对应的品牌数据").write(writer);
		}
		
	}
	 
	/**
	 * 统一拼装查询条件 并查询
	 * @param request
	 * @param page
	 * @return
	 */
	public Map<String,Object> queryBrandSQL(HttpServletRequest request,PageSqlserver page){
		try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(20);
			}
			page.setLimitKey("dLastUpdateTime");
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			String id = request.getParameter("id");
			if(U.isNotEmpty(id)){
			    params.put("id",id);
			}
			
			Map<String, Object> resultmap = tBrandQueryApi.queryTBrand(params, page);
			return resultmap;
		} catch (Exception e) {
			U.logger.error("拼装品牌查询条件出错",e);
		}
		return null;
	}
	 
}
