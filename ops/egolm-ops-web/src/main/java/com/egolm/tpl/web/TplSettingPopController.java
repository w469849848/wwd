package com.egolm.tpl.web;

import java.io.PrintWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.egolm.common.OSSConstants;
import com.egolm.common.OSSUtils;
import com.egolm.tpl.service.TplService;
import com.egolm.tpl.utils.HttpHandler;

@Controller
@RequestMapping("/template/setting/pop")
public class TplSettingPopController {
	
	/*获取商品列表接口*/
	public static String HTTP_PRODUCT;
	/*商品分类接口 */
	public static String HTTP_CATEGORY;
	/*品牌列表接口*/
	public static String HTTP_BRAND;
	/*获取区域列表*/
	public static String HTTP_ZONE;
	/*获取广告位列表*/
	public static String HTTP_AP;
	/*获取广告位列表*/
	public static String HTTP_APID;
	/*获取广告位下面的广告列表*/
	public static String HTTP_AD;
	/*查询广告位状态*/
	public static String HTTP_QUERY_AP_STATUS;
	/*更新广告位状态*/
	public static String HTTP_UPDATE_AP_STATUS;
	
	
	@Value("${pic.img.url}")
	private String imgUrl;
	
	@Autowired
	private TplService tplService;

	/**
	 * @Description: 跳转广告位选择弹出框
	 * @param page 分页参数
	 * @param aAptile 广告位title
	 * @return
	 */
	@RequestMapping(value="/ad")
	public ModelAndView toNav1Page(@ModelAttribute("page") PageSqlserver page,String width,String height,String aAptile,String sign,String orgNO,String sScopeTypeID){
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null)  page.setLimit(10);
		if(org.apache.commons.lang.StringUtils.isNotBlank(orgNO)) orgNO = org.apache.commons.lang.StringUtils.split(orgNO,",")[0];
		if(org.apache.commons.lang.StringUtils.isNotBlank(orgNO)) sScopeTypeID = org.apache.commons.lang.StringUtils.split(sScopeTypeID,",")[0];
		
		Map<String, String> map=new HashMap<String,String>();
		map.put("adType", "web");
		map.put("pageIndex",  (StringUtils.isEmpty(aAptile)?page.getIndex().toString():"1"));
		map.put("pageCount", page.getLimit().toString());
		map.put("orgNO", orgNO);//SUZU
		map.put("scopeTypeID", sScopeTypeID);//店铺类型过滤
		map.put("title", org.apache.commons.lang.StringUtils.trim(aAptile));
		map.put("width", width);
		map.put("height", height);
		map.put("apID", "1");
		JSONObject json = HttpHandler.post(HTTP_AP,map);
		Page pageReturn = new Page();
		JSONObject pageJ = (JSONObject) json.get("page");
		pageReturn.setIndex(pageJ.getLong("index"));
		pageReturn.setLimit(pageJ.getInteger("limit"));
		pageReturn.setTotal(pageJ.getLong("total"));
		
		mv.addObject("datas", json.get("DataList"));
		mv.addObject("page", pageReturn);
		mv.addObject("orgNO", orgNO);
		mv.addObject("sign", sign);
		mv.addObject("aAptile", aAptile);
		mv.addObject("sScopeTypeID", sScopeTypeID);
		mv.setViewName("tpl/tpl-setting-pop-ad.jsp");
		return mv;
		
	}
	
	/**
	 * @Description: 跳转导航专区选择弹出框
	 * @param page 分页参数
	 * @return
	 */
	@RequestMapping(value="/section")
	public ModelAndView toSectionNavigationPage(@ModelAttribute("page") PageSqlserver page,String sTplNo,String sBelongNo,String nTag){
		ModelAndView mv  = new ModelAndView();
		try {
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("sTplNo DESC");
			}
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			
			if(U.isNotEmpty(sBelongNo)){
				paramMap.put("sBelongNo", sBelongNo);
			}
			
			if(U.isNotEmpty(sTplNo)){
				paramMap.put("sTplNo", sTplNo);
			}
			
			if(U.isNotEmpty(nTag)){
				paramMap.put("nTag", nTag);
			}
			
			Map<String, Object> datas = tplService.queryTemplates(paramMap, page);
			Page pageReturn = (Page) datas.get("page");
			mv.addObject("datas", datas);
			mv.addObject("page", pageReturn);
			
			mv.setViewName("tpl/tpl-setting-pop-navigation.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			U.logger.error("查询专区信息出错", e);
		}
		
		return mv;
		
	}
	
	/**
	 * @Description: 跳转广告位下面的广告显示
	 * @param page 分页参数
	 * @param aAptile 广告位title
	 * @author yjie
	 * @return
	 */
	@RequestMapping(value="/adDetail")
	public ModelAndView toAddDetailPage(String apId,String orgNO){
		ModelAndView mv  = new ModelAndView();
		Map<String, String> map=new HashMap<String,String>();
		map.put("orgNO", orgNO);//区域编号
		map.put("apID", apId);//广告位编号
		JSONObject json = HttpHandler.post(HTTP_AD,map);
		
		mv.addObject("datas", json.get("DataList"));
		mv.setViewName("tpl/tpl-setting-pop-ad-detail.jsp");
		return mv;
		
	}

	/**
	 * @Description: 导航模块商品分类
	 * @return
	 */
	@RequestMapping(value="/navProductCategory")
	public ModelAndView toNavProductCategoryPage(String orgNO){
		ModelAndView mv  = new ModelAndView();
		Map<String, String> map=new HashMap<String,String>();
		map.put("orgNO", orgNO);//区域编号
		JSONObject json = HttpHandler.post(HTTP_CATEGORY,map);
		mv.addObject("datas", json.get("data"));
		mv.setViewName("tpl/tpl-setting-pop-navcategory.jsp");
		return mv;
	}
	
	/**
	 * 跳转品牌选择弹出框
	 */
	@RequestMapping(value="/brand")
	public ModelAndView toBrandPage(@ModelAttribute("page") PageSqlserver page,String orgNO,String num,String brandsName,Writer writer){
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null)  page.setLimit(10);
//		if(org.apache.commons.lang.StringUtils.isNotBlank(orgNO)) orgNO = org.apache.commons.lang.StringUtils.split(orgNO,",")[0];
		
		// 获取品牌列表接口样例
		Map<String, String> map = new HashMap<String, String>();
		map.put("pageIndex", page.getIndex().toString());
		map.put("pageCount", page.getLimit().toString());
		map.put("orgNO", orgNO);//SUZU
		map.put("brandsName",org.apache.commons.lang.StringUtils.trim(brandsName));
		String paramString = JSON.toJSONString(map, true);
		JSONObject json = HttpHandler.postWithJSON(HTTP_BRAND, paramString);
		mv.addObject("categoryDatas", json.get("data"));

		mv.addObject("brandCount",num);
		mv.addObject("orgNO", orgNO);
		mv.setViewName("tpl/tpl-setting-pop-brand.jsp");

		return mv;
		
	}
	
	
	/**
	 * 品牌数据
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/queryBrand")
	public void  ajaxBrands(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page, Writer writer){
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		try {
			
			Map<String, Object> map = new HashMap<String, Object>();// 参数MAP
			map.put("orgNO", request.getParameter("orgNO"));//SUZU
			String brandsName = request.getParameter("brandsName");
			if(brandsName!=null){
				brandsName = brandsName.trim();
			}
			
			map.put("brandsName", brandsName);
			map.put("pageIndex", page.getIndex().toString());
			map.put("pageCount", page.getLimit().toString());
			String paramString = JSON.toJSONString(map, true);
			
			//获取品牌数据
			JSONObject brandJson = HttpHandler.postWithJSON(HTTP_BRAND,paramString);
			JSONObject dataJson = (JSONObject) brandJson.get("data");
			Long index = Long.valueOf(brandJson.get("currentPage").toString());
			Long total = Long.valueOf(brandJson.get("totalCount").toString());
			boolean result = (boolean) brandJson.get("isValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>)dataJson.get("brandList");
				PageSqlserver pg = new PageSqlserver(index, Integer.valueOf(page.getLimit().toString()),"");
				pg.setTotal(total);
				page = U.objTo(pg, PageSqlserver.class);
				Egox.egoxOk().setDataList(dataList).set("page", page).set("imgUrl",imgUrl ).write(writer);//"http://img.egolm.com"
			}else{
				Egox.egoxErr().setReturnValue("品牌数据失败").write(writer);
			}
		} catch (Exception e) {
			U.logger.error("品牌数据异常",e);
			Egox.egoxErr().setReturnValue("品牌数据失败").write(writer);
		}
	}
	
	
	/**选择商品弹出框*/
	@RequestMapping(value="/product")
	public ModelAndView toProductPage(@ModelAttribute("page") PageSqlserver page,String categoryNO,String orgNO,String num){
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null)  page.setLimit(10);
		// 获取商品列表接口样例
		Map<String, String> map = new HashMap<String, String>();
		//if(org.apache.commons.lang.StringUtils.isNotBlank(orgNO)) orgNO = org.apache.commons.lang.StringUtils.split(orgNO,",")[0];
		map.put("pageIndex", page.getIndex().toString());
		map.put("pageCount", page.getLimit().toString());
		map.put("orgNO", orgNO);//SUZU
		map.put("categoryNO","");
		
		//获取商品分类数据
		JSONObject categoryJson = HttpHandler.post(HTTP_CATEGORY,map);
		mv.addObject("categoryDatas", categoryJson.get("data"));
		
		mv.addObject("goodsCount", num);
		mv.addObject("orgNO", orgNO);
		mv.addObject("imgUrl", imgUrl);
		mv.setViewName("tpl/tpl-setting-pop-product.jsp");
		return mv;
	}
	
	/**
	 * 商品数据
	 * @param request
	 * @param writer
	 */
	@RequestMapping(value = "/ajaxGoods")
	public void  ajaxGoods(HttpServletRequest request, @ModelAttribute("page")PageSqlserver page, Writer writer){
		if (page == null) {
			page = new PageSqlserver();
			page.setIndex(1L);
			page.setLimit(10);
		}else{
			page.setLimit(10);
		}
		//page.setLimitKey(" clickNum desc");
		try {
			String  goodName = request.getParameter("goodName");
			if(goodName!=null){
				goodName = goodName.trim();
			}
			String  categoryNO = request.getParameter("categoryNO");
			String  orgNO = request.getParameter("orgNO");
			Map<String, Object> params = new HashMap<String, Object>();// 参数MAP
			params.put("name", goodName);
			params.put("pageIndex", page.getIndex().toString());
			params.put("pageCount", page.getLimit().toString());
			params.put("orgNO", orgNO);//SUZU
			params.put("categoryNO",categoryNO);
			String paramString = JSON.toJSONString(params, true);
			
			//获取商品数据
			JSONObject productJson = HttpHandler.postWithJSON(HTTP_PRODUCT,paramString);
			JSONObject dataJson = (JSONObject) productJson.get("data");
			Long index = Long.valueOf(productJson.get("currentPage").toString());
			Long total = Long.valueOf(productJson.get("totalCount").toString());
			boolean result = (boolean) productJson.get("isValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>)dataJson.get("goodsList");
				PageSqlserver pg = new PageSqlserver(index, Integer.valueOf(page.getLimit().toString()),"");
				pg.setTotal(total);
				page = U.objTo(pg, PageSqlserver.class);
				Egox.egoxOk().setDataList(dataList).set("page", page).set("imgUrl", imgUrl).write(writer);
			}else{
				Egox.egoxErr().setReturnValue("商品数据失败").write(writer);
			}
		} catch (Exception e) {
			U.logger.error("商品数据异常",e);
			Egox.egoxErr().setReturnValue("商品数据失败").write(writer);
		}
	}
	
	@RequestMapping(value="/uploadBrandImg")
	public void uploadBrandImg(
			HttpServletRequest request,
			@RequestParam(value = "brandImg", required = false) MultipartFile file,HttpServletResponse response){
		JSONObject obj = new JSONObject();
		PrintWriter out = null;
		try {
			out = response.getWriter();
			if(file != null){
				String fileName = file.getOriginalFilename();
				if(U.isNotEmpty(fileName)){
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.FLOOR_PATH+OSSUtils.getFileNewName(fileName);
					//上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					//获取图片路径
					String filePath = OSSUtils.getImgURl(key, bucketName);
					filePath = filePath.substring(0, filePath.indexOf("?"));
					if(!StringUtils.isEmpty(filePath)){
						obj.put("msg", "success");
						obj.put("url", filePath);
					}else{
						obj.put("msg", "failed");
					}
					OSSUtils.closeOssClient(); 
				}				
			} 
			out.print(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			out.close();
		}
	}
	
	@RequestMapping(value="/uploadGoodImg")
	public void uploadGoodImg(
			HttpServletRequest request,
			@RequestParam(value = "goodImg", required = false) MultipartFile file,HttpServletResponse response){
		JSONObject obj = new JSONObject();
		PrintWriter out = null;
		try {
			out = response.getWriter();
			if(file != null){
				String fileName = file.getOriginalFilename();
				if(U.isNotEmpty(fileName)){
					String bucketName = OSSConstants.bucketName;
					String key = OSSConstants.FLOOR_PATH+OSSUtils.getFileNewName(fileName);
					//上传图片
					OSSUtils.uploadFile(bucketName, key, "image/jpeg", file.getInputStream());
					//获取图片路径
					String filePath = OSSUtils.getImgURl(key, bucketName);
					filePath = filePath.substring(0, filePath.indexOf("?"));
					if(!StringUtils.isEmpty(filePath)){
						obj.put("msg", "success");
						obj.put("url", filePath);
					}else{
						obj.put("msg", "failed");
					}
					OSSUtils.closeOssClient(); 
				}				
			} 
			out.print(obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally{
			out.close();
		}
	}

	/**
	 * @Description: 楼层商品分类弹出框
	 * @author yjie
	 * @return
	 */
	@RequestMapping(value="/floorCategory")
	public ModelAndView toFloorCategoryPage(String orgNO){
			ModelAndView mv  = new ModelAndView();
			
			Map<String, String> map=new HashMap<String,String>();
			map.put("orgNO", orgNO);//区域编号
			JSONObject json = HttpHandler.post(HTTP_CATEGORY,map);
			mv.addObject("datas", json.get("data"));
			mv.setViewName("tpl/tpl-setting-pop-floor-category.jsp");
			return mv;
	}
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
}
