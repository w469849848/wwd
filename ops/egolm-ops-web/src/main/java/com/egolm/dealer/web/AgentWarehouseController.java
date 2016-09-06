package com.egolm.dealer.web;

import java.io.Writer;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.owasp.esapi.StringUtilities;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.common.EgolmException;
import com.egolm.common.enums.UserType;
import com.egolm.dealer.api.AgentContractGoodsUpdateApi;
import com.egolm.dealer.api.RegionQueryApi;
import com.egolm.domain.TAgentContractGoods;
import com.egolm.security.utils.SecurityContextUtil;

@Controller
@RequestMapping("/agent/warehouse")
public class AgentWarehouseController {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Resource(name = "regionQueryApi")
	private RegionQueryApi regionQueryApi;
	
	@Resource(name = "agentContractGoodsUpdateApi") 
	private AgentContractGoodsUpdateApi agentContractGoodsUpdateApi;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/warehouseList")
	public String warehouseList(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		try {
			String cWhere = "";
			String sqlWhere = "";
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("sCityID","dCreateDate","dLastUpdateTime");
			}
			
			String constractNO  = request.getParameter("constractNO"); 
			String sWarehouseName  = request.getParameter("sWarehouseName"); 
			
			if(StringUtils.isNotBlank(constractNO)){
				cWhere = " and ac.sAgentContractNO = '"+constractNO+"'";
			}
			
			if(StringUtils.isNotBlank(sWarehouseName)){
				sqlWhere = " and wh.sWarehouseName like '%"+sWarehouseName+"%'";
			}
			
			String agentId = SecurityContextUtil.getUserId(); 
			List<String> orgNOs =  SecurityContextUtil.getRegionIds();
			UserType userType = SecurityContextUtil.getUserType();

			String whSql = "select  "
					 + "	wh.sWarehouseNO, "
					 + "	wh.sWarehouseName, "
					 + "	wh.sWarehouseTypeID, "
					 + "	wh.sWarehouseType, "
					 + "	wh.nMinDCAmount, "
					 + "	wh.sProvinceID, "
					 + "	wh.sProvince, "
					 + "	wh.sCityID, "
					 + "	wh.sCity, "
					 + "	wh.sDistrictID, "
					 + "	wh.sDistrict, "
					 + "	wh.sAddress, "
					 + "	wh.sMemo, "
					 + "	wh.nTag, "
					 + "	wh.sCreateUser, "
					 + "	CONVERT(varchar(100), wh.dCreateDate, 20) dCreateDate, "
					 + "	wh.sConfirmUser, "
					 + "	CONVERT(varchar(100), wh.dConfirmDate, 20) dConfirmDate, "
					 + "	CONVERT(varchar(100), wh.dLastUpdateTime, 20) dLastUpdateTime, "
					 + "	wh.nAgentID "
					 + "	from tWarehouse wh where wh.sCityID IN (select sRegionNO from tOrg where sOrgNO in ("+U.join("','", "'","'", orgNOs)+")) "
					 + "	and wh.nTag <> 1";
			
			List<Map<String,Object>> warehouses = null;
			warehouses = jdbcTemplate.limit(whSql+sqlWhere,page);

			request.setAttribute("page", page);
			//request.setAttribute("agentContract",agentContract);
			request.setAttribute("warehouses",warehouses);
			request.setAttribute("constractNO",constractNO);
			request.setAttribute("sWarehouseName",sWarehouseName);
			
		} catch (EgolmException e) {
			logger.error("", e);
		} catch (Throwable e) {
			logger.error("", e);
		}
		return "/dealer/warehouse/warehouseList.jsp";
	}
	
	@RequestMapping("/warehouseEdit")
	public String warehouseEdit(HttpServletRequest request) {
		String type = request.getParameter("type");
		String sWarehouseNO = request.getParameter("sWarehouseNO");
		String deliverRegionID = "";
		String deliverRegionName = "";
		List<Map<String,Object>> whType = jdbcTemplate.queryForList("select sComID,sComDesc from tCommon where sCommonNO = 'WarehouseType'");
		
		Map<String, Object> data = null;
		
		if("edit".equals(type)){
			data = jdbcTemplate.queryForMap("select wh.sWarehouseNO, "
					+ "	wh.sWarehouseName, "
					+ "	wh.sWarehouseTypeID, "
					+ "	wh.sWarehouseType, "
					+ "	wh.nMinDCAmount, "
					+ "	wh.sProvinceID, "
					+ "	wh.sProvince, "
					+ "	wh.sCityID, "
					+ "	wh.sCity, "
					+ "	wh.sDistrictID, "
					+ "	wh.sDistrict, "
					+ "	wh.sAddress, "
					+ "	wh.sMemo, "
					+ "	wh.nTag, "
					+ "	wh.sCreateUser, "
					+ "	CONVERT(varchar(100), wh.dCreateDate, 20) dCreateDate, "
					+ "	wh.sConfirmUser, "
					+ "	CONVERT(varchar(100), wh.dConfirmDate, 20) dConfirmDate, "
					+ "	CONVERT(varchar(100), wh.dLastUpdateTime, 20) dLastUpdateTime, "
					+ "	(select a.sAgentName from tAgent a where a.nAgentID = wh.nAgentID) sAgentName,wh.nAgentID from tWarehouse wh where  wh.sWarehouseNO = ?", sWarehouseNO);
			
			List<Map<String,Object>> deliverRegion = jdbcTemplate.queryForList("select sDistrictID,sDistrict from tWarehouseDistrict whd where whd.sWarehouseNO = ? and sDistrictID in (select sRegionNO from tRegion where sUpRegionNO = (select sCityID from tWarehouse where sWarehouseNO = ? ))",sWarehouseNO,sWarehouseNO);
			if(deliverRegion != null && deliverRegion.size() > 0){
				for(int i=0;i<deliverRegion.size(); i++){
					Map<String,Object> region = deliverRegion.get(i);
					deliverRegionID += region.get("sDistrictID")+",";
					deliverRegionName += region.get("sDistrict")+",";
				}
			}
			
		}

		Map<String, Object> provinceDatas = regionQueryApi.queryProvinces();
		
		request.setAttribute("data",data);
		request.setAttribute("whType", whType);
		request.setAttribute("deliverRegionID", deliverRegionID);
		request.setAttribute("deliverRegionName", deliverRegionName);
		request.setAttribute("type", type);
		request.setAttribute("provinceDatas", provinceDatas.get("DataList"));
		
		return "/dealer/warehouse/warehouseEdit.jsp";
	}
	
	@Transactional
	@RequestMapping("/warehouseSave")
	public void warehouseSave(HttpServletRequest request,Writer writer) throws Exception{
		String agentName = SecurityContextUtil.getUserName(); 
		String type = request.getParameter("type");
		String sWarehouseNO = request.getParameter("sWarehouseNO");
		String nAgentID = request.getParameter("nAgentID");
		String sWarehouseName = request.getParameter("sWarehouseName");
		String sWarehouseTypeID = request.getParameter("sWarehouseTypeID");
		String sWarehouseType = request.getParameter("sWarehouseType");
		String nMinDCAmount = request.getParameter("nMinDCAmount");
		String sProvinceID = request.getParameter("sProvinceID");
		String sProvince = request.getParameter("sProvince");
		String sCityID = request.getParameter("sCityID");
		String sCity = request.getParameter("sCity");
		String sDistrictID = request.getParameter("sDistrictID");
		String sDistrict = request.getParameter("sDistrict");
		String sMemo = request.getParameter("sMemo");
		String sAddress = request.getParameter("sAddress");
		
		String deliverRegion = request.getParameter("deliverRegion");
		String deliverRegionDesc = request.getParameter("deliverRegionDesc");
		String sql = "";
		String message = "";
		try{
			if("add".equals(type)){
				message = "基础资料保存";
				int count = jdbcTemplate.queryForInt("select count(1) from tWarehouse where sWarehouseNO = ? ", sWarehouseNO);
				
				if(count > 0){
					Egox.egoxErr().setReturnValue(message+"失败,仓库编号已经存在").write(writer);
				}else{
					sql = "insert into tWarehouse "
							+ "(sWarehouseNO,sWarehouseName,sWarehouseTypeID,sWarehouseType,nMinDCAmount,sProvinceID,sProvince,sCityID,sCity,sDistrictID,sDistrict,sMemo,sAddress,nTag,sCreateUser,dCreateDate,sConfirmUser,dConfirmDate,dLastUpdateTime,nAgentID) "
							+ "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,getDate(),?,getDate(),getDate(),?)";
					int i = jdbcTemplate.update(sql,sWarehouseNO,sWarehouseName,sWarehouseTypeID,sWarehouseType,nMinDCAmount,sProvinceID,sProvince,sCityID,sCity,sDistrictID,sDistrict,sMemo,sAddress,0,agentName,agentName,nAgentID);
					
					if(i <= 0){
						Egox.egoxErr().setReturnValue(message+"失败").write(writer);
					}else{
						/**
						 * 修改配送区域
						 */
						sql = "update tWarehouseDistrict set nTag = '1' where sWarehouseNO = ?";
						int j = jdbcTemplate.update(sql,sWarehouseNO);
						
						String[] dIdArr = deliverRegion.split(",");
						String[] distrDesc = deliverRegionDesc.split(",");
						for(int m=0;m<dIdArr.length;m++){
							String dId = dIdArr[m];
							String dDesc = distrDesc[m];
							jdbcTemplate.batchUpdate("merge into tWarehouseDistrict whd using (select 1 as a ) ustemp on (whd.sWarehouseNO = '"+sWarehouseNO+"' and whd.sDistrictID = '"+dId+"')"
							 +" when matched then "
							 +" update set whd.nTag = 0, whd.dLastUpdateTime = GETDATE() , sConfirmUser='"+agentName+"'"
							 +" when not matched then "
							 +" insert (sWarehouseNO,sDistrictID,sDistrict,nDCPriority,nTag,sConfirmUser,dConfirmDate,dLastUpdateTime) values ('"+sWarehouseNO+"','"+dId+"','"+dDesc+"','0','0','"+agentName+"',GETDATE(),GETDATE());");
						}
						
						Egox.egoxOk().setReturnValue(message+"成功").write(writer);
					}
				}
			}else if("edit".equals(type)){
				message = "基础资料保存";
				sql = "update tWarehouse set sWarehouseName=?,sWarehouseTypeID=?,sWarehouseType=?,nMinDCAmount=?,sProvinceID=?,sProvince=?,sCityID=?,sCity=?,sDistrictID=?,sDistrict=?,sMemo=?,sAddress=?,dLastUpdateTime=getDate(),nAgentID=? where sWarehouseNO = ?";
				int i = jdbcTemplate.update(sql,sWarehouseName,sWarehouseTypeID,sWarehouseType,nMinDCAmount,sProvinceID,sProvince,sCityID,sCity,sDistrictID,sDistrict,sMemo,sAddress,nAgentID,sWarehouseNO);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					/**
					 * 修改配送区域
					 */
					sql = "update tWarehouseDistrict set nTag = '1' where sWarehouseNO = ?";
					int j = jdbcTemplate.update(sql,sWarehouseNO);
					
					String[] dIdArr = deliverRegion.split(",");
					String[] distrDesc = deliverRegionDesc.split(",");
					for(int m=0;m<dIdArr.length;m++){
						String dId = dIdArr[m];
						String dDesc = distrDesc[m];
						jdbcTemplate.batchUpdate("merge into tWarehouseDistrict whd using (select 1 as a ) ustemp on (whd.sWarehouseNO = '"+sWarehouseNO+"' and whd.sDistrictID = '"+dId+"')"
						 +" when matched then "
						 +" update set whd.nTag = 0, whd.dLastUpdateTime = GETDATE() , sConfirmUser='"+agentName+"'"
						 +" when not matched then "
						 +" insert (sWarehouseNO,sDistrictID,sDistrict,nDCPriority,nTag,sConfirmUser,dConfirmDate,dLastUpdateTime) values ('"+sWarehouseNO+"','"+dId+"','"+dDesc+"','0','0','"+agentName+"',GETDATE(),GETDATE());");
					}
					
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}else if("del".equals(type)){
				message = "基础资料删除";
				sql = "update tWarehouse set dLastUpdateTime=getDate(),nTag=1 where sWarehouseNO = ?";
				int i = jdbcTemplate.update(sql, sWarehouseNO);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					sql = "update tWarehouseDistrict set dLastUpdateTime=getDate(),nTag=1 where sWarehouseNO = ?";
					jdbcTemplate.update(sql, sWarehouseNO);
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}
		}catch(Exception ex){
			U.logger.info(">>>>>> baseLevelSave >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue(message+"失败").write(writer);
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
	}
	
	@RequestMapping("/warehouseGoodsList")
	public String warehouseGoodsList(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("sWarehouseNO","nGoodsID");
		}
		String where = "";
		String agentId = "";
		String agentName = "";
		String sWarehouseNO = request.getParameter("sWarehouseNO");
		String categoryID = request.getParameter("categoryID");
		String brandID = request.getParameter("brandID");
		String goodsDesc = request.getParameter("goodsDesc");
		
		UserType userType = SecurityContextUtil.getUserType();
		String agentSql = "";
		List<Map<String,Object>> agent = null;
		if(userType.oneOf(UserType.AGENT)){  //经销商
			agentId = SecurityContextUtil.getUserId(); 
			agentName = SecurityContextUtil.getUserName(); 
			agentSql = "select nAgentID,sAgentName from tAgent where nAgentID = ? ";
			agent = jdbcTemplate.queryForList(agentSql,agentId);
		}else if(userType.oneOf(UserType.OPERATOR)){
			agentId = request.getParameter("nAgentID");
			agentName = request.getParameter("sAgentName");
			List<String> orgNOs =  SecurityContextUtil.getRegionIds();
			agentSql = "select nAgentID,sAgentName from tAgent where sCityID in (select sRegionNO from tOrg where sOrgNO in ("+U.join("','", "'","'", orgNOs)+")) ";
			agent = jdbcTemplate.queryForList(agentSql);
		}
		
		
		if(U.isNotBlank(categoryID)){
			where += " and acg.sCategoryNO = '"+categoryID+"'";
		}
		
		if(U.isNotBlank(brandID)){
			where += " and acg.sBrandID = '"+brandID+"'";
		}
		
		if(StringUtils.isNotBlank(goodsDesc)){
			where += " and (acg.sGoodsDesc like '%"+goodsDesc+"%' or acg.sMainBarcode = '"+goodsDesc+"') ";
		}
		
		List<Map<String,Object>> datas = null;
		String sql = "select  "
				 + "	acg.nGoodsID,acg.sGoodsDesc,wh.sWarehouseNO,wh.sWarehouseName,aso.nStockQty,gmp.nPrice,gmp.sUnit,acg.sCategoryNO,acg.sBrandID,acg.nTag,acg.sAgentContractNO,acg.nAgentID,tagName = (ISNULL(case when acg.nTag&17=16 then 'up' else 'down' end,'')),acg.sMainBarcode  "
				 + "from  "
				 + "	tAgentContractGoods acg , "
				 + "	tAgentStockOnline aso, "
				 + "	tWarehouse wh , "
				 + "	tOrg o, "
				 + "	tGoodsMarketPrice gmp "
				 + "where  "
				 + "	acg.nGoodsID = aso.nGoodsID  "
				 + "	and acg.sAgentContractNO = aso.sAgentContractNO  "
				 + "	and aso.sWarehouseNO = wh.sWarehouseNO  "
				 + "	and aso.sWarehouseNO=? "
				 + "	and o.sRegionNO = wh.sCityID "
				 + "	and gmp.sOrgNO = o.sOrgNO "
				 + "	and gmp.nGoodsID = acg.nGoodsID  ";
		
		if(U.isNotBlank(sWarehouseNO)){
			datas = jdbcTemplate.limit(sql+where,page,sWarehouseNO);
		}
				
		request.setAttribute("page", page);
		request.setAttribute("datas", datas);
		request.setAttribute("agent", agent);
		request.setAttribute("nAgentID", agentId);
		request.setAttribute("sAgentName", agentName);
		request.setAttribute("sWarehouseNO", sWarehouseNO);
		request.setAttribute("categoryID", categoryID);
		request.setAttribute("brandID", brandID);
		request.setAttribute("goodsDesc", goodsDesc);
		
		return "/dealer/warehouse/warehouseGoodsList.jsp";
	}
	
	@Transactional
	@RequestMapping("/warehouseGoodsListSave")
	public void warehouseGoodsListSave(HttpServletRequest request,Writer writer) throws Exception{
		try{
			String jsonStr = ServletUtil.readReqJson(request);
			JSONObject jsonObject = JSONObject.parseObject(jsonStr);
			JSONArray goodsList =jsonObject.getJSONArray("goodsList");
			
			String agentId = SecurityContextUtil.getUserId(); 
			
			if(goodsList!=null && goodsList.size() > 0){
				for(int i=0;i<goodsList.size();i++){
					JSONObject goods = goodsList.getJSONObject(i);
					
					String acNO =  goods.getString("acNO");
					String gid =  goods.getString("gid");
					String whNO =  goods.getString("whNO");
					String nStockQty =  goods.getString("nStockQty");
					String nPrice =  goods.getString("nPrice");
					String sUnit =  goods.getString("sUnit");

					/*
					 * 修改库存
					 */
					String sql ="update tAgentStockOnline set nStockQty = ?,dLastUpdateTime = GETDATE() where sAgentContractNO = ? and nGoodsID = ? and sWarehouseNO = ? "; 
					jdbcTemplate.update(sql,nStockQty,acNO,gid,whNO);
					
					/*
					 * 修改零售价
					 */
					String pSql = "update tGoodsMarketPrice set nPrice = ?,sUnit = ?,dLastUpdateTime = GETDATE() where sOrgNO = (select o.sOrgNO from tOrg o ,tWarehouse wh where wh.sWarehouseNO = ? and o.sRegionNO = wh.sCityID) and nGoodsID = ? ";
					jdbcTemplate.update(pSql,nPrice,sUnit,whNO,gid);
					
				}
			}
			Egox.egoxOk().setReturnValue("保存成功").write(writer);
		}catch(Exception ex){
			U.logger.info(">>>>>> tAgentShopLevel >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue("保存失败").write(writer);
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
	}
	
	@RequestMapping("/districtSelectPage")
	public String districtSelectPage(HttpServletRequest request) {
		String cityID  = request.getParameter("cityID"); 
		String districtIDs  = request.getParameter("districtIDs"); 
		request.setAttribute("sCityID", cityID);
		request.setAttribute("districtIDs", districtIDs);
		return "/dealer/warehouse/district-select.jsp";
	}
	
	@RequestMapping("/agentSelectPage")
	public String agentSelectPage(HttpServletRequest request) {
		return "/dealer/warehouse/agent-select.jsp";
	}
	
	@RequestMapping(value="/districtSelectList")
	public void districtSelectList(HttpServletRequest request,Writer writer){
		try {
			String cityID = request.getParameter("cityID");
			String sRegionDesc = request.getParameter("sRegionDesc");
			String where = "";
			if(StringUtils.isNotBlank(sRegionDesc)){
				where = " and sRegionDesc like '%"+sRegionDesc+"%'";
			}
			String sql = "select sRegionNO,sRegionDesc,sRegionType,nTag from tRegion where sUpRegionNO = ?";

			List<Map<String, Object>> datas = jdbcTemplate.queryForList(sql+where,cityID);
			
			Egox.egoxOk().setDataList(datas).write(writer);
		} catch (Exception e) {
			U.logger.error("根据合同查询店铺列表失败",e);
			Egox.egoxErr().setReturnValue("根据合同查询店铺列表失败").write(writer);
		}
		
	}
	
	@RequestMapping(value="/agentSelectList")
	public void agentSelectList(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(20);
			}else{
				page.setLimit(10);
			}
			page.setLimitKey("sAgentNO");
			String sAgentName = request.getParameter("sAgentName");
			List<String> orgNOs =  SecurityContextUtil.getRegionIds();
			String where = "";
			if(StringUtils.isNotBlank(sAgentName)){
				where = " and sAgentName like '%"+sAgentName+"%'";
			}
			String sql = "select nAgentID,sAgentNO,sAgentName,sAgentTitle,nTag from tAgent where sCityID IN (select sRegionNO from tOrg where sOrgNO in ("+U.join("','", "'","'", orgNOs)+"))";

			List<Map<String, Object>> datas = jdbcTemplate.limit(sql+where, page);
			
			Egox.egoxOk().setDataList(datas).set("page",page).write(writer);
		} catch (Exception e) {
			U.logger.error("根据合同查询店铺列表失败",e);
			Egox.egoxErr().setReturnValue("根据合同查询店铺列表失败").write(writer);
		}
		
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

	 @InitBinder("page")
	 public void initBinder1(WebDataBinder binder) {
		  binder.setFieldDefaultPrefix("page.");
	 }
	
	 @RequestMapping("/warehouseByAgent")
	 public void warehouseByAgent(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		 String nAgentID = request.getParameter("nAgentID");
		 try{
			 String whSql = "select acw.sWarehouseNO,wh.sWarehouseName from tAgentContractWarehouse acw,tAgentContract ac,tWarehouse wh where acw.sAgentContractNO = ac.sAgentContractNO and wh.sWarehouseNO = acw.sWarehouseNO and ac.nAgentID = ?";
			List<Map<String,Object>> warehouse = jdbcTemplate.queryForList(whSql,nAgentID);
			Egox.egoxOk().setDataList(warehouse).write(writer);
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询经销商仓库失败。").write(writer);
			U.logger.info("查询经销商仓库失败:"+ex.getMessage());
		}
	}	 
	
	@RequestMapping("/categoryByWarehouse")
	public void categoryByWarehouse(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		String sWarehouseNO = request.getParameter("sWarehouseNO");
		
		String agentId = SecurityContextUtil.getUserId(); 
		String sOrgNO =  SecurityContextUtil.getRegionId();
		try{
			String sql = "SELECT "
					+ "	categoryID = c.sCategoryNO, "
					+ "	categoryName = c.sCategoryDesc "
					+ "FROM "
					+ "	tCategory c "
					+ "JOIN ( "
					+ "	SELECT DISTINCT "
					+ "			ag.sCategoryNO "
					+ "	FROM "
					+ "		tAgentContractGoods ag "
					+ "	LEFT JOIN tGoodsCategory gc ON ag.nGoodsID = gc.nGoodsID "
					+ " left join tAgentStockOnline aso on ag.nGoodsID = aso.nGoodsID "
					+ "	WHERE "
					+ "	 aso.sWarehouseNO = ?"
					+ "	AND ag.sOrgNO = ? "
					+ ") AS t ON t.sCategoryNO = c.sCategoryNO ";
			List<Map<String,Object>> category = jdbcTemplate.queryForList(sql,sWarehouseNO,sOrgNO);
			Egox.egoxOk().setDataList(category).write(writer);
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询仓库下的商品分类失败。").write(writer);
			U.logger.info("查询仓库下的商品分类失败:"+ex.getMessage());
		}
			
	}
		
	@RequestMapping("/brandByCategory")
	public void brandByCategory(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		String sWarehouseNO = request.getParameter("sWarehouseNO");
		String sCategoryNO = request.getParameter("sCategoryNO");
		String where = "";
		if(U.isNotBlank(sCategoryNO)){
			where = "	and ag.sCategoryNO = '"+sCategoryNO+"'";
		}
		try{
			String sql = "select brandID=b.sBrandID  , "
					 + "	brandName=b.sBrandName  "
					 + "	FROM tBrand b   "
					 + "	join  "
					 + "	(select  "
					 + "		distinct bid=ag.sBrandID  "
					 + "	from tAgentContractGoods ag  "
					 + "	left join tAgentStockOnline aso on ag.nGoodsID = aso.nGoodsID  "
					 + "	where aso.sWarehouseNO = ?"
					 + 	where
					 + "	) as t  "
					 + "	on t.bid=b.sBrandID ";
			List<Map<String,Object>> brand = jdbcTemplate.queryForList(sql,sWarehouseNO);
			Egox.egoxOk().setDataList(brand).write(writer);
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询仓库下的商品品牌失败。").write(writer);
			U.logger.info("查询仓库下的商品品牌失败:"+ex.getMessage());
		}
		
	}
	
	/**
	 * 
	* @Title: updateNTag 
	* @Description: TODO(商品上下架操作) 
	* @param @param request
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/updateNTag")
	public void updateNTag(HttpServletRequest request,Writer writer){
		try {
			String jsonStr = ServletUtil.readReqJson(request);
			JSONObject jsonObject = JSONObject.parseObject(jsonStr); 
			String type = (String)jsonObject.get("type");
			List acGoodList = (List)jsonObject.get("acGoodList");
			
			List<TAgentContractGoods> list = new ArrayList<TAgentContractGoods>();
			if(acGoodList != null && acGoodList.size()>0){
				 for(int i=0;i<acGoodList.size();i++){
					 JSONObject acJson = (JSONObject)acGoodList.get(i); 
					 int nTag = acJson.getIntValue("nTag");
					 int nGoodId = acJson.getIntValue("nGoodId");
					 String nAgentID = acJson.getString("nAgentID");
					 String sAgentContractNO = acJson.getString("sAgentContractNO");
					 
					 TAgentContractGoods tacGoods= new TAgentContractGoods();
					 if(type.equals("up")){
						 tacGoods.setnTag(nTag+16);
					 }else{
						 tacGoods.setnTag(nTag-16);
					 }
					 tacGoods.setnAgentID(Integer.valueOf(nAgentID));
					 tacGoods.setnGoodsID(nGoodId);
					 tacGoods.setsAgentContractNO(sAgentContractNO);
					 tacGoods.setsConfirmUser(SecurityContextUtil.getUserName()); 
					 list.add(tacGoods);
				 }
				 
				 if(list.size()>0){
					 Map<String, Object> dataMap =  agentContractGoodsUpdateApi.updateTAgentContractGoods(list);
					 boolean result = (boolean)dataMap.get("IsValid");
					 if(result){
						String returnMsg = "";
						if(type.equals("up")){
							returnMsg="商品上架成功";
						}else{
							returnMsg="商品下架成功";
						}
						Egox.egoxOk().setReturnValue(returnMsg).write(writer);
					}else{
						String returnMsg = "";
						if(type.equals("up")){
							returnMsg="商品上架失败";
						}else{
							returnMsg="商品下架失败";
						}
						Egox.egoxErr().setReturnValue(returnMsg).write(writer);
					}
				 }else{
					    String returnMsg = "";
						if(type.equals("up")){
							returnMsg="商品上架失败,未获取到要操作的商品";
						}else{
							returnMsg="商品下架失败,未获取到要操作的商品";
						}
						Egox.egoxErr().setReturnValue(returnMsg).write(writer);
				 }
			}else{
				String returnMsg = "";
				if(type.equals("up")){
					returnMsg="商品上架失败,未获取到要操作的商品";
				}else{
					returnMsg="商品下架失败,未获取到要操作的商品";
				}
				Egox.egoxErr().setReturnValue(returnMsg).write(writer);
			}
		} catch (Exception e) {
			U.logger.error("商品上下架操作失败",e);
			Egox.egoxErr().setReturnValue("操作失败").write(writer);
		}
	}
}
