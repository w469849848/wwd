package com.egolm.goods.web;

import java.io.Writer;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Json;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.common.goods.GoodsContants;
import com.egolm.config.core.reader.ConfigReader;
import com.egolm.config.core.utils.ConfigPath;
import com.egolm.dealer.api.AgentContractQueryApi;
import com.egolm.dealer.api.TAlterACGoodsAddApi;
import com.egolm.dealer.api.TAlterACGoodsDtlAddApi;
import com.egolm.dealer.api.TAlterACGoodsUpdateApi;
import com.egolm.domain.TAgentContract;
import com.egolm.domain.TAlterACGoods;
import com.egolm.domain.TAlterACGoodsDtl;
import com.egolm.domain.TGoods;
import com.egolm.goods.api.TGoodsQueryApi;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * 
* Title:  商品导入
* Description:
* Company: 万店易购投资管理有限公司
* @author zhangyong
* @date 2016年5月5日
 */

@Controller
@RequestMapping("/goods/tGoodsDealer")
public class TGoodsDealerImportController {
	@Resource(name = "redisTemplate")
	private RedisTemplate<String,Object> redisTemplate;
	@Resource(name = "tAlterACGoodsAddApi")
	private TAlterACGoodsAddApi tAlterACGoodsAddApi;
	@Resource(name = "tAlterACGoodsDtlAddApi")
	private TAlterACGoodsDtlAddApi tAlterACGoodsDtlAddApi;
	@Resource(name = "tAlterACGoodsUpdateApi")
	private TAlterACGoodsUpdateApi tAlterACGoodsUpdateApi;
	@Resource(name = "agentContractQueryApi")
	private AgentContractQueryApi agentContractQueryApi;
	@Resource(name = "tGoodsQueryApi")
	private TGoodsQueryApi tGoodsQueryApi;
	
	private String cdnImgUrl = ConfigReader.getProperty(ConfigPath.cpath("G:system.properties"), "pic.img.url", "http://img.egolm.com");

	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	/**
	 * 跳转到商品导入第一步
	 * @return
	 *//*
	@RequestMapping(value="/importFirst")
	public String  importFirst(){
		return "/goods/goods-import-first.jsp";
	}*/
	
	/**
	 * 
	* @Title: importFirst 
	* @Description: TODO(商品导入第一步，加载经销商合同) 
	* @param @param page
	* @param @param request
	* @param @return    设定文件 
	* @return ModelAndView    返回类型 
	* @throws
	 */
	@RequestMapping("/importFirst")
	public ModelAndView importFirst(@ModelAttribute("page")PageSqlserver page,HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		 
		try {
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("sAgentContractNO DESC");
			}
			String nAgentID =  SecurityContextUtil.getUserId(); 
			String sOrgNO =  SecurityContextUtil.getRegionId();
		 
			TAgentContract tAgentContract = new TAgentContract();
			tAgentContract.setSOrgNO(sOrgNO);
			tAgentContract.setNAgentID(Integer.valueOf(nAgentID));
			map.put("nAgentID", nAgentID);
			map.put("sOrgNO", sOrgNO);
			Map<String, Object> dataMap = agentContractQueryApi.queryAllTAgentContractByAgIdAndOrgNo(tAgentContract, page); 
			boolean result = (boolean)dataMap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) dataMap.get("DataList"); 
				page =U.objTo(dataMap.get("page"),PageSqlserver.class);
				map.put("agentList", dataList);
				map.put("page", page);
			}
		} catch (Exception e) {
			U.logger.error("获取经销商的合同失败",e);
		}
		ModelAndView mv = new ModelAndView("/goods/goods-import-first.jsp",map);
		return mv;
	}
	/**
	 * 
	* @Title: importSecond 
	* @Description: TODO(商品导入第二步) 
	* @param @return    设定文件 
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping(value="/importSecond")
	public String importSecond(HttpServletRequest request){
		String  sAgentContractNO =   request.getParameter("sAgentContractNO"); //经销商合同编号
		
		//搜索的条件
 		String  sGoodsDescOrBarcode = request.getParameter("sGoodsDescOrBarcode");  //商品名称/条码
		String  sCategoryNO = request.getParameter("sCategoryNO");  //商中分类
		String  sBrand = request.getParameter("sBrand");  //品牌 
		
		request.setAttribute("sGoodsDescOrBarcode", sGoodsDescOrBarcode);
		request.setAttribute("sCategoryNO", sCategoryNO);
		request.setAttribute("sBrand", sBrand);

		request.setAttribute("sAgentContractNO", sAgentContractNO); 
		return "/goods/goods-import-second.jsp";
	}
	/**
	 * 
	* @Title: importThird 
	* @Description: TODO(商品导入第三步) 
	* @param @param request
	* @param @return    设定文件 
	* @return String    返回类型 
	* @throws
	 */
	@RequestMapping(value="/importThird")
	public String importThird(HttpServletRequest request){
		String sGoodIds = request.getParameter("sGoodIds");
		String sAgentContractNO = request.getParameter("sAgentContractNO");
 		request.setAttribute("sGoodIds", sGoodIds);
		request.setAttribute("sAgentContractNO", sAgentContractNO);
		return "/goods/goods-import-third.jsp";
	}
	
	
	/**
	 * 
	* @Title: loadRedisMsg 
	* @Description: TODO(加载已选择数据) 
	* @param @param request
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/loadRedisMsg")
	public void loadRedisMsg(HttpServletRequest request,Writer writer){
		try {
			String sAgentContractNO =   request.getParameter("sAgentContractNO"); //经销商合同编号
			String nAgentID =SecurityContextUtil.getUserId(); // 经销商ID
			List<Object> redisDataList = redisTemplate.opsForHash().values(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO);
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			
			if(redisDataList != null && redisDataList.size()>0){
				for(Object obj:redisDataList){ 
					JSONArray jsonArray = JSONArray.parseArray(Json.toJson(obj)); 
					//System.out.println(jsonArray.get(0).toString());
					Map<String,Object> resultMap = Json.toMap(jsonArray.get(0).toString());
					dataList.add(resultMap);
				}
			}
			Egox.egoxOk().setDataList(dataList).set("cdnImgUrl", cdnImgUrl).write(writer);
		} catch (Exception e) {
			U.logger.error("加载已选择商品数据出错",e);
			Egox.egoxErr().setReturnValue("加载已选择商品数据出错").write(writer);
		}
	}
	 
	
	/**
	 * 第二步
	 * @param request
	 * @param page
	 * @param writer
	 * @return
	 */
	@RequestMapping(value="/loadSecondMsg")
	public void loadSecondMsg(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		try {
			String sAgentContractNO =   request.getParameter("sAgentContractNO"); //经销商合同编号
			String nAgentID = SecurityContextUtil.getUserId(); // request.getParameter("nAgentID"); //经销商ID
			
			String  sGoodsDescOrBarcode = request.getParameter("sGoodsDescOrBarcode");  //商品名称/条码
			String  sCategoryNO = request.getParameter("sCategoryNO");  //商中分类
			String  sBrand = request.getParameter("sBrand");  //品牌 
			String sOrgNO = request.getParameter("sOrgNO");
			
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sAgentContractNO", sAgentContractNO); 
			
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			List<Object> redisDataList = redisTemplate.opsForHash().values(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO);
			if(redisDataList != null && redisDataList.size()>0){
				for(Object obj:redisDataList){ 
					JSONArray jsonArray = JSONArray.parseArray(Json.toJson(obj)); 
					//System.out.println(jsonArray.get(0).toString());
					Map<String,Object> resultMap = Json.toMap(jsonArray.get(0).toString());
					if(resultMap != null){
						
						if(!StringUtil.isNotEmpty(sGoodsDescOrBarcode) && !StringUtil.isNotEmpty(sCategoryNO)  && !StringUtil.isNotEmpty(sBrand) ){
							dataList.add(resultMap);
						}else{
							int i = 0; //条件个数
							int k = 0; //匹配的个数
 							if(StringUtil.isNotEmpty(sCategoryNO.trim())){  //根据分类进行匹配
								String sCategoryNO_map = (String)resultMap.get("sCategoryNO");
								i++;
								if( sCategoryNO_map.equals(sCategoryNO.trim())){
 									k++;
 								}
							}
							
 							if(StringUtil.isNotEmpty(sBrand.trim())){  //根据品牌进行匹配
								i++;
								String sBrandID_map = (String)resultMap.get("sBrandID");
								if(sBrandID_map.equals(sBrand.trim())){
									k++;
  								} 
							}
 							if(StringUtil.isNotEmpty(sGoodsDescOrBarcode.trim())){
								i++;
								String sGoodsName =  (String)resultMap.get("sGoodsName"); // //商品名称
								String sMainBarcode = (String)resultMap.get("sMainBarcode"); //条码 
								boolean  goodsDescOrBarCodeResult = false;
								if(sGoodsName.contains(sGoodsDescOrBarcode.trim())){ //商品名称满足
									goodsDescOrBarCodeResult= true;
 								}
								if(sMainBarcode.contains(sGoodsDescOrBarcode.trim())){ //条码满足
									goodsDescOrBarCodeResult= true;
 								}
								if(goodsDescOrBarCodeResult){
									k++;
								}
							}
							if(i == k){
								dataList.add(resultMap);
							} 
						} 
					} 
				}
			}
			map.put("tGoodsList", dataList);
			map.put("sGoodsDescOrBarcode",sGoodsDescOrBarcode.trim());
			map.put("sCategoryNO",sCategoryNO);
			map.put("sBrand",sBrand);
			map.put("nAgentID", nAgentID);
			map.put("sOrgNO", sOrgNO);
			map.put("sAgentContractNO", sAgentContractNO);
			map.put("cdnImgUrl", cdnImgUrl);
			Egox.egoxOk().setDataList(map).write(writer);
		} catch (Exception e) {
			 U.logger.error("加载商品导入第二步失败",e);
			 Egox.egoxErr().setReturnValue("数据加载异常").write(writer);
		}					 
	}
	/**
	 * 第三步
	 * @param request
	 * @param page
	 * @param writer
	 * @return
	 */
	@RequestMapping(value="/loadThirdMsg")
	public void loadThirdMsg(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		
		try {
			String sAgentContractNO =   request.getParameter("sAgentContractNO"); //经销商合同编号
			String nAgentID = SecurityContextUtil.getUserId();   //经销商ID
			String sGoodIds = request.getParameter("sGoodIds"); //所选择的商品ID
			String[] sGoodIdArray =null;
			if(U.isNotEmpty(sGoodIds)){
				  sGoodIdArray = sGoodIds.split(","); 
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("sAgentContractNO", sAgentContractNO); 
			List<Map<String, Object>> dataList = new ArrayList<Map<String, Object>>();
			List<Object> redisDataList = redisTemplate.opsForHash().values(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO);
			if(redisDataList != null && redisDataList.size()>0){
				for(Object obj:redisDataList){ 
					JSONArray jsonArray = JSONArray.parseArray(Json.toJson(obj)); 
					Map<String, Object> goodsMap = Json.toMap(jsonArray.get(0).toString());
					Double nGoodsID = (Double)goodsMap.get("nGoodsID");
					if (StringUtil.contains(sGoodIdArray, nGoodsID.intValue() + "")) {
						if (null == goodsMap.get("nNormalSalePrice")) {
							goodsMap.put("nRealSalePrice", BigDecimal.ZERO.setScale(2));
						}
						else {
							goodsMap.put("nRealSalePrice", new BigDecimal(((Double) goodsMap.get("nNormalSalePrice"))).multiply(new BigDecimal(1.5)).setScale(2, RoundingMode.HALF_UP));
						}
						dataList.add(goodsMap);
					}
					
				}
			}
			map.put("tGoodsList", dataList);
			Egox.egoxOk().setDataList(map).write(writer);
		} catch (Exception e) {
			 U.logger.error("加载商品导入第三步失败",e);
			 Egox.egoxErr().setReturnValue("数据加载异常").write(writer);
		}
	}
	
	/**
	 * 提交 经销商商品
	 * @param request
	 */
	@RequestMapping(value="/submitAgentContractGoods")
	public void submitAgentContractGoods(HttpServletRequest request,Writer writer){
 		 
		 try {
			String jsonStr = ServletUtil.readReqJson(request);
			 JSONObject jsonObject = JSONObject.parseObject(jsonStr);
			 String sAgentContractNO = (String)jsonObject.get("sAgentContractNO"); //经销商合同编码
			 String nAgentID = SecurityContextUtil.getUserId();  //(String)jsonObject.get("nAgentID");
			 
   
			 //新增变更单
			   TAlterACGoods tAlterACGoods = new TAlterACGoods();
			   tAlterACGoods.setSPaperNO("E"+System.nanoTime()+"");
			   tAlterACGoods.setSAgentContractNO(sAgentContractNO);
			   tAlterACGoods.setNAgentID(Integer.valueOf(nAgentID));
			   tAlterACGoods.setSUpdateTypeID("I");
			   tAlterACGoods.setSAlterTypeID("G");
			   tAlterACGoods.setSAlterType("商品资料变更");
			   tAlterACGoods.setSAlterUser(SecurityContextUtil.getUserName());
			   tAlterACGoods.setSCreateUser(SecurityContextUtil.getUserName());
			   tAlterACGoods.setDAlterDate(DateUtil.parse(DateUtil.format(new Date()), DateUtil.FMT_DATE_SECOND)); 
			   
			   Map<String,Object> acResultMap = tAlterACGoodsAddApi.createTAlterACGoods(tAlterACGoods);
			   boolean adResult = (boolean)acResultMap.get("IsValid");
			   if(adResult){
				   String sPaperNO = (String)acResultMap.get("sPaperNO");         	   
				     List goodsDtlList = (List)jsonObject.get("goodsDtls");
			  		 if(goodsDtlList != null && goodsDtlList.size()>0){
			  			 
			  			 List<TAlterACGoodsDtl> acGoodsList = new ArrayList<TAlterACGoodsDtl>();  //批量新增的
			  			 for(int i = 0;i<goodsDtlList.size();i++){
			  				JSONObject dtlJson = (JSONObject)goodsDtlList.get(i); 
			  				
			  				TAlterACGoodsDtl tAlterACGoodsDtl = new TAlterACGoodsDtl(); 
			  				tAlterACGoodsDtl.setSPaperNO(sPaperNO);
			  				tAlterACGoodsDtl.setSAgentContractNO(sAgentContractNO);
			  				tAlterACGoodsDtl.setNGoodsID(Integer.valueOf(To.objTo(dtlJson.get("tGoodsId"), Integer.class,0)));
			      			tAlterACGoodsDtl.setSOrgNO(SecurityContextUtil.getRegionId()); //组织机构编码
			      			tAlterACGoodsDtl.setSGoodsNO((String)dtlJson.get("sGoodsNO"));
			      			tAlterACGoodsDtl.setSCategoryNO((String)dtlJson.get("sCategoryNO"));
			      			tAlterACGoodsDtl.setSBrandID((String)dtlJson.get("sBrandID"));
			      			tAlterACGoodsDtl.setSBrand((String)dtlJson.get("sBrand"));
			  				tAlterACGoodsDtl.setSMainBarcode(To.objTo(dtlJson.get("sMainBarcode"),String.class,""));
			  				tAlterACGoodsDtl.setSGoodsDesc((String)dtlJson.get("sGoodsDesc"));
			  				tAlterACGoodsDtl.setSSpec(To.objTo(dtlJson.get("sSpec"),String.class,""));
			  				tAlterACGoodsDtl.setSUnit(To.objTo(dtlJson.get("sUnit"),String.class,""));
			  				tAlterACGoodsDtl.setNMinSaleQty(To.objTo(dtlJson.get("nMinSaleQty"), BigDecimal.class, new BigDecimal(0)));
			  				tAlterACGoodsDtl.setNSaleUnits(To.objTo(dtlJson.get("nSaleUints"), BigDecimal.class, new BigDecimal(0)));
			  				tAlterACGoodsDtl.setSHome((String)dtlJson.get("sHome"));
			  				tAlterACGoodsDtl.setNSalePrice(To.objTo(dtlJson.get("nSalePrice"), BigDecimal.class, new BigDecimal(0)));
			  				tAlterACGoodsDtl.setNRealSalePrice(To.objTo(dtlJson.get("nRealSalePrice"), BigDecimal.class, new BigDecimal(0)));
			  				tAlterACGoodsDtl.setNLifeCycle(To.objTo(dtlJson.get("nLifeCycle"), BigDecimal.class, new BigDecimal(0)).intValue());
			  				tAlterACGoodsDtl.setSMemo((String)dtlJson.get("sMemo"));
			  				tAlterACGoodsDtl.setSCreateUser(SecurityContextUtil.getUserName());
			  				
			  				//4=可订货(供应商)
			  				//8=可退货(供应商)
			  				String sell_piece_by_piece = dtlJson.getString("sell_piece_by_piece");  //32=拆零(物流)
			  				String seasonal_goods = dtlJson.getString("seasonal_goods");  //64=季节性商品
			  				String can_return = dtlJson.getString("can_return");   //128=是否可退换货
			  				
			  				int nGoodsTag =4+8+ To.objTo(sell_piece_by_piece,Integer.class,0)+ To.objTo(seasonal_goods,Integer.class,0)+ To.objTo(can_return,Integer.class,0);
			  				tAlterACGoodsDtl.setNGoodsTag(nGoodsTag);
			  				tAlterACGoodsDtl.setNTag(GoodsContants.TAG_0);
			  				tAlterACGoodsDtl.setDCreateDate(DateUtil.parse(DateUtil.format(new Date()), DateUtil.FMT_DATE_SECOND));
			  				tAlterACGoodsDtl.setDLastUpdateTime(DateUtil.parse(DateUtil.format(new Date()), DateUtil.FMT_DATE_SECOND));
			  				acGoodsList.add(tAlterACGoodsDtl); 
			  			 }
			  			 if(acGoodsList.size()>0){
			  				 Map<String,Object> dataMap = (Map<String,Object>)tAlterACGoodsDtlAddApi.createTAlterACGoodsDtl(acGoodsList);
			  				boolean acDtalResult = (boolean)dataMap.get("IsValid");
			  				if(acDtalResult){
			  					redisTemplate.delete(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO);
			      			    Egox.egoxOk().setReturnValue("商品申请成功").write(writer);
			  				}else{
			  					 tAlterACGoodsUpdateApi.updateTAlterACGoodsNTagById(sPaperNO, 1); //删除表头
			  					 Egox.egoxOk().setReturnValue("商品申请失败").write(writer);
			  				}
			  			 }else{
			  				tAlterACGoodsUpdateApi.updateTAlterACGoodsNTagById(sPaperNO, 1); //删除表头
			  				Egox.egoxOk().setReturnValue("商品申请失败,未获取到要申请的商品明细").write(writer);
			  			 }
			  		 }
			   }else{
				   Egox.egoxErr().setReturnValue("商品申请失败").write(writer);
			   }
		} catch (Exception e) {
			U.logger.error("商品申请失败",e);
			Egox.egoxErr().setReturnValue("商品申请失败").write(writer);
		}
          
	}
	
	/**
	 * 商品导入使用
	 * @param request
	 * @param page
	 * @param writer
	 * @return
	 */
	@RequestMapping(value="/listGoods")
	public void listGoods(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(20);
			}else{
				page.setLimit(15);
			}
			page.setLimitKey("dLastUpdateTime");
			String goodsNameOrBarCode = request.getParameter("goodsNameOrBarCode"); //商品名称或条码
			String sCategoryNO = request.getParameter("sCategoryNO"); //分类
			String sAgentContractNO = request.getParameter("sAgentContractNO"); //合同编码
			String nAgentID =SecurityContextUtil.getUserId(); // 经销商ID
			
			String select_goods_right = request.getParameter("select_goods"); //客户右边已选择的商品
			String del_goods = request.getParameter("del_goods"); //客户删除的商品
			
			String[] delGoodsArray = null;
			if(U.isNotEmpty(del_goods)){
				delGoodsArray = del_goods.split(",");
			}
			 
			
			StringBuffer sbBuffer = new StringBuffer();
			sbBuffer.append(select_goods_right);
			if(U.isNotEmpty(select_goods_right)){
				sbBuffer.append(",");
			}
			//客户历史选择的商品
			List<Object> redisDataList = redisTemplate.opsForHash().values(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO);
			if(redisDataList != null && redisDataList.size()>0){
				for(Object obj:redisDataList){ 
					JSONArray jsonArray = JSONArray.parseArray(Json.toJson(obj)); 
					Map<String, Object> goodsMap = Json.toMap(jsonArray.get(0).toString());
					String sGoodsNO = (String)goodsMap.get("sGoodsNO");
					if(delGoodsArray != null){
						if(!StringUtil.contains(delGoodsArray, sGoodsNO)){
							sbBuffer.append(sGoodsNO).append(",");
						}
					}else{
						sbBuffer.append(sGoodsNO).append(",");
					}
					
				}
			}
			String select_goods = sbBuffer.toString();
			if(!select_goods.isEmpty()){
				if(select_goods.endsWith(",")){
					select_goods = select_goods.substring(0,select_goods.length()-1); 
				}
			} 
			TGoods tGoods = new TGoods();
			tGoods.setSGoodsDesc(goodsNameOrBarCode);
			tGoods.setSCategoryNO(sCategoryNO);
			tGoods.setSGoodsNO(select_goods);
			
			Map<String, Object> resultmap = tGoodsQueryApi.queryTGoods(tGoods,sAgentContractNO, page);

			boolean result = (boolean)resultmap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList"); 
				page =U.objTo(resultmap.get("page"),PageSqlserver.class); 
				Egox.egoxOk().setDataList(dataList).set("page",page).set("pageTotal", page.getPageTotal()).set("pageIndex", page.getPageIndexs().length).set("cdnImgUrl", cdnImgUrl).write(writer); 
			}else{
				  Egox.egoxErr().setReturnValue("产品基础资料查询失败").write(writer); 
			}
		} catch (Exception e) {
			 U.logger.error("产品基础资料查询失败",e);
			 Egox.egoxErr().setReturnValue("产品基础资料查询失败").write(writer); 
		} 
	}
	 
	
	/**
	 * 经销商选择的商品 
	 * @param request
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/selectGoods")
	public void  selectGoods(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){ 
		Map<String, Object> map = new HashMap<String, Object>();
		String sAgentContractNO =  request.getParameter("sAgentContractNO"); //经销商合同编号
		String nAgentID = SecurityContextUtil.getUserId();  //request.getParameter("nAgentID"); //经销商ID
		String tGoods_ids = request.getParameter("tGoods_ids");// 经销商选择的商品
		String trLength = request.getParameter("trLength"); //已选商品中的tr 个数。如果为0，则表示全被删除，清空缓存
		if(StringUtil.isNotEmpty(tGoods_ids)){
			String[] ids_strArray = tGoods_ids.split(",");
			int[] ids_intArray = new int[ids_strArray.length];
			for(int i = 0;i<ids_strArray.length;i++){
				String idstr = ids_strArray[i];
				if(StringUtil.isNotEmpty(idstr.trim()) && StringUtil.isInt(idstr.trim())){
					ids_intArray[i]=Integer.valueOf(idstr.trim());
				}else{
					ids_intArray[i]=0; //防止出现为空，查询出现异常
				}
			}
			Map<String, Object> resultMap =  tGoodsQueryApi.queryTGoodsByIDs(ids_intArray);
			boolean result = (boolean)resultMap.get("IsValid");
			if(result){
				 redisTemplate.delete(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO); //删除缓存
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultMap.get("DataList"); 
				map.put("tGoodsList", dataList);
				//此处建义将选择的商品加入redis 中
				Map<String, List<Map<String, Object>>> mapDatas = To.listToML(dataList, "nGoodsID"); 
				redisTemplate.opsForHash().putAll(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO, mapDatas);
			}
			
		}else{
			if(trLength.equals("0")){
				 redisTemplate.delete(GoodsContants.AGENT_SELECT_GOODS_KEY+"-"+nAgentID+"-"+sAgentContractNO); //删除缓存
			}
		}
		Egox.egoxOk().setReturnValue("商品选择成功").write(writer);
		 
	}
}
