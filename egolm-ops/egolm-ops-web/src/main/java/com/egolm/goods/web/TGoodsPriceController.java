package com.egolm.goods.web;


import java.io.Writer;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.Parse;
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
import com.egolm.common.enums.UserType;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * 
 * @Title: 商品价格控制器
 * @Description:
 * @author 韩晓宁
 * @date 2016年6月27日16:41:25
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/goods/price")
public class TGoodsPriceController {
	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@RequestMapping("/baseLevelList")
	public String baseLevelList(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		String where = "";
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("nLevel","dCreateDate","dUpdateDate");
		}
		
		String constractNO  = request.getParameter("constractNO"); 
		
		if(StringUtils.isNotBlank(constractNO)){
			where = " and sAgentContractNO = '"+constractNO+"'";
		}
		
		List<Map<String, Object>> datas = null;
		List<Map<String,Object>> agentContract =  null;
		UserType userType = SecurityContextUtil.getUserType();
		if(userType.oneOf(UserType.AGENT)){  //经销商
			String agentId = SecurityContextUtil.getUserId(); 
			String sOrgNO =  SecurityContextUtil.getRegionId();
			datas = jdbcTemplate.limit("select nLevel,sLevelName,sAgentContractNO,nDisRate,sCreateUser,CONVERT(varchar(100), dCreateDate, 20) dCreateDate,sUpdateUser,CONVERT(varchar(100), dUpdateDate, 20) dUpdateDate,nTag from tAgentLevel where 1=1 and sAgentContractNO in (select sAgentContractNO from tAgentContract where nAgentID = '"+agentId+"') and (nTag <> 1 or nTag is null) " + where , page);
			agentContract = jdbcTemplate.queryForList("select sAgentContractNO from tAgentContract where nAgentID = ? and sOrgNO = ? ",agentId,sOrgNO);
		}
		
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		request.setAttribute("constract",agentContract);
		request.setAttribute("constractNO", constractNO);
		return "/goods/price/baseLevelList.jsp";
	}
	
	
	@RequestMapping("/baseLevelEdit")
	public String baseLevelEdit(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		String agentId = SecurityContextUtil.getUserId(); 
		String sOrgNO =  SecurityContextUtil.getRegionId();
		String type = request.getParameter("type");
		String nLevel = request.getParameter("nLevel");
		String curtitle = "";
		List<Map<String,Object>> agentContract =  null;
		UserType userType = SecurityContextUtil.getUserType();
		if(userType.oneOf(UserType.AGENT)){  //经销商
			agentContract = jdbcTemplate.queryForList("select sAgentContractNO from tAgentContract where nAgentID = ? and sOrgNO = ? ",agentId,sOrgNO);
		}
		if("add".equals(type)){
			curtitle = "新增基础等级";
		}else{
			curtitle = "编辑基础等级";
			Map<String, Object> datas = jdbcTemplate.queryForMap("select * from tAgentLevel where nTag <> 1 and nLevel = ? ", nLevel);
			request.setAttribute("sLevelName", datas.get("sLevelName"));
			request.setAttribute("nDisRate", datas.get("nDisRate"));
			request.setAttribute("constractNO", datas.get("sAgentContractNO"));
			request.setAttribute("nLevel", nLevel);
		}
		request.setAttribute("curtitle", curtitle);
		request.setAttribute("agent",agentContract);
		request.setAttribute("type", type);
		
		return "/goods/price/baseLevelEdit.jsp";
	}
	
	@Transactional
	@RequestMapping("/baseLevelSave")
	public void baseLevelSave(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) throws Exception{
		String agentId = SecurityContextUtil.getUserId(); 
		String type = request.getParameter("type");
		String nLevel = request.getParameter("nLevel");
		String sLevelName = request.getParameter("sLevelName");
		String nDisRate = request.getParameter("nDisRate");
		String sAgentContractNO = request.getParameter("constractNO");
		String resetPrice = request.getParameter("resetPrice");
		String sql = "";
		String message = "";
		try{
			if("add".equals(type)){
				message = "基础等级保存";
				sql = "insert into tAgentLevel (sLevelName,sAgentContractNO,nDisRate,sCreateUser,dCreateDate) values (?,?,?,?,getDate())";
				int i = jdbcTemplate.update(sql, sLevelName,sAgentContractNO,nDisRate,agentId);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}else if("edit".equals(type)){
				message = "基础等级保存";
				sql = "update tAgentLevel set sLevelName=?,sAgentContractNO=?,nDisRate=?,sUpdateUser=?,dUpdateDate=getDate() where nLevel = ?";
				int i = jdbcTemplate.update(sql, sLevelName,sAgentContractNO,nDisRate,agentId,nLevel);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					if("y".equals(resetPrice)){
						sql = "select nGoodsID from tAgentLevelPrice where nLevelID = ? and sAgentContractNO = ? ";
						List<String> goodsIdList = jdbcTemplate.queryForList(sql, String.class,nLevel,sAgentContractNO);
						for(int m=0;m<goodsIdList.size();m++){
							String goodsId = goodsIdList.get(m);
							String nRealSalePrice = jdbcTemplate.queryForString("select nRealSalePrice from tAgentContractGoods where nGoodsID = ? and sAgentContractNO = ? ", goodsId , sAgentContractNO);
							BigDecimal bRealSalePrice = new BigDecimal(nRealSalePrice);
							BigDecimal bDisRate = new BigDecimal(nDisRate);
							BigDecimal divider = new BigDecimal("100");
							Double salePrice = bRealSalePrice.multiply(bDisRate.divide(divider)).doubleValue();
							
							jdbcTemplate.update("update tAgentLevelPrice set nRealSalePrice = ?,nSalePrice=? where  nLevelID = ? AND sAgentContractNO = ? and nGoodsID = ? ",salePrice,salePrice,nLevel,sAgentContractNO,goodsId);
							
						}
					}
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}else if("del".equals(type)){
				message = "基础等级删除";
				sql = "update tAgentLevel set sUpdateUser=?,dUpdateDate=getDate(),nTag=1 where nLevel = ?";
				int i = jdbcTemplate.update(sql, agentId,nLevel);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}
		}catch(Exception ex){
			U.logger.info(">>>>>> baseLevelSave >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue(message+"失败").write(writer);
			ex.printStackTrace();
			throw new Exception(message+"失败");
		}
	}
	
	@RequestMapping("/shopLevelList")
	public String shopLevelList(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		String where = "";
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("sShopNO","dCreateDate","dUpdateDate");
		}
		
		String constractNO  = request.getParameter("constractNO"); 
		
		if(StringUtils.isNotBlank(constractNO)){
			where += " and l.sAgentContractNO = '"+constractNO+"'";
		}
		
		String shopLevel = request.getParameter("shopLevel");
		if(StringUtils.isNotBlank(shopLevel)){
			where += " and l.nLevelID = '"+shopLevel+"'";
		}
		
		String shopName = request.getParameter("sShopName");
		if(StringUtils.isNotBlank(shopName)){
			where += " and s.sShopName like '%"+shopName+"%'";
		}

		List<Map<String, Object>> datas = null;
		List<Map<String,Object>> agentContract =  null;

		String agentId = SecurityContextUtil.getUserId(); 
		String sOrgNO =  SecurityContextUtil.getRegionId();
		
		String sql = " select   "
				 + " l.sAgentContractNO sAgentContractNO,l.nLevelID nLevelID,al.sLevelName sLevelName, "
				 + " l.sShopNO sShopNO,s.sShopName sShopName,l.nTag,CONVERT(varchar(100), l.dCreateDate, 20) dCreateDate , "
				 + " CONVERT(varchar(100), l.dUpdateDate, 20) dUpdateDate,l.sCreateUser sCreateUser,l.sUpdateUser sUpdateUser  "
				 + " from tAgentShopLevel l left join tShop s on l.sShopNO = s.sShopNO  "
				 + " left join tWarehouseDistrict whd on  s.sDistrictID = whd.sDistrictID  "
				 + " left join tAgentContractWarehouse acw on acw.sWarehouseNO = whd.sWarehouseNO "
				 + " left join tAgentContract ac on ac.sAgentContractNO = acw.sAgentContractNO "
				 + " left join tAgentLevel al on l.nLevelID = al.nLevel  "
				 + " where (l.nTag <> 1 OR l.nTag is null) and ac.nAgentID = '"+agentId+"' ";

		UserType userType = SecurityContextUtil.getUserType();
		if(userType.oneOf(UserType.AGENT)){  //经销商
			agentContract = jdbcTemplate.queryForList("select sAgentContractNO from tAgentContract where nAgentID = ? and sOrgNO = ? ",agentId,sOrgNO);
			datas = jdbcTemplate.limit(sql + where , page);
		}
		
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		request.setAttribute("constract",agentContract);
		request.setAttribute("constractNO", constractNO);
		request.setAttribute("shopLevel", shopLevel);
		request.setAttribute("shopName", shopName);
		return "/goods/price/shopLevelList.jsp";
	}
	
	
	@RequestMapping("/shopLevelEdit")
	public String shopLevelEdit(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		String agentId = SecurityContextUtil.getUserId(); 
		String sOrgNO =  SecurityContextUtil.getRegionId();
		String type = request.getParameter("type");
		String nLevel = request.getParameter("nLevel");
		String sShopNO = request.getParameter("sShopNO");
		String shopName = request.getParameter("shopName");
		String sAgentContractNO = request.getParameter("constractNO");
		String curtitle = "";
		List<Map<String,Object>> agentContract = null;
	
		UserType userType = SecurityContextUtil.getUserType();
		if(userType.oneOf(UserType.AGENT)){  //经销商
			agentContract = jdbcTemplate.queryForList("select sAgentContractNO from tAgentContract where nAgentID = ? and sOrgNO = ? ",agentId,sOrgNO);
		}
		
		if("add".equals(type)){
			curtitle = "新增商铺等级";
		}else{
			curtitle = "编辑商铺等级";
			request.setAttribute("constractNO", sAgentContractNO);
			request.setAttribute("shopNO", sShopNO);
			request.setAttribute("shopName", shopName);
			request.setAttribute("nLevel", nLevel);
		}
		request.setAttribute("curtitle", curtitle);
		request.setAttribute("agent",agentContract);
		request.setAttribute("type", type);
		
		return "/goods/price/shopLevelEdit.jsp";
	}
	
	@Transactional
	@RequestMapping("/shopLevelSave")
	public void shopLevelSave(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) throws Exception {
		String agentId = SecurityContextUtil.getUserId(); 
		String type = request.getParameter("type");
		String nLevel = request.getParameter("nLevel");
		String sShopNO = request.getParameter("sShopNO");
		String sAgentContractNO = request.getParameter("constractNO");
		
		String oldLevel = request.getParameter("oldLevel");
		String oldShopNO = request.getParameter("oldShopNO");
		String oldAgentContractNO = request.getParameter("oldConstractNO");
		String sql = "";
		String message = "";
		try{
			int count =0;
			if("add".equals(type)){
				sql = "select count(1) from tAgentShopLevel where sAgentContractNO=? and sShopNO=? and (nTag = 0 or nTag is null)";
				count = jdbcTemplate.queryForInt(sql,sAgentContractNO,sShopNO);
				message = "店铺等级设置保存";
				if(count > 0){
					Egox.egoxErr().setReturnValue(message+"失败,已经存在的设置").write(writer);
				}else{
					int hasCount = jdbcTemplate.queryForInt("select count(1) from tAgentShopLevel where sAgentContractNO=? and sShopNO=? and nTag = 1",sAgentContractNO,sShopNO);
					if(hasCount > 0){
						sql = "update tAgentShopLevel set nLevelID = ?,sUpdateUsser = ? , dUpdateDate = GETDATE() ,nTag=0 where sAgentContractNO=? and sShopNO= ? and nTag = 1 ";
						int i = jdbcTemplate.update(sql,nLevel,agentId,sAgentContractNO,sShopNO);
						if(i <= 0){
							Egox.egoxErr().setReturnValue(message+"失败").write(writer);
						}else{
							Egox.egoxOk().setReturnValue(message+"成功").write(writer);
						}
					}else{
						sql = "insert into tAgentShopLevel (sAgentContractNO,nLevelID,sShopNO,sCreateUser,dCreateDate,nTag) values (?,?,?,?,GETDATE(),'0')";
						int i = jdbcTemplate.update(sql, sAgentContractNO,nLevel,sShopNO,agentId);
						if(i <= 0){
							Egox.egoxErr().setReturnValue(message+"失败").write(writer);
						}else{
							Egox.egoxOk().setReturnValue(message+"成功").write(writer);
						}
						
					}
				}
			}else if("edit".equals(type)){
				if(!sAgentContractNO.equals(oldAgentContractNO) || !sShopNO.equals(oldShopNO)){
					sql = "select count(1) from tAgentShopLevel where sAgentContractNO=? and sShopNO=? and (nTag = 0 or nTag is null)";
					count = jdbcTemplate.queryForInt(sql,sAgentContractNO,sShopNO);
				}
				message = "店铺等级设置保存";
				if(count > 0){
					Egox.egoxErr().setReturnValue(message+"失败,已经存在的设置").write(writer);
				}else{
					int hasCount = jdbcTemplate.queryForInt("select count(1) from tAgentShopLevel where sAgentContractNO=? and sShopNO=? and nTag = 1",sAgentContractNO,sShopNO);
					if(hasCount > 0){
						sql = "update tAgentShopLevel set nLevelID=?,sUpdateUser=?,dUpdateDate=getDate() where sAgentContractNO=? and sShopNO=?";
						int i = jdbcTemplate.update(sql,nLevel,agentId,sAgentContractNO,sShopNO);
						if(i <= 0){
							Egox.egoxErr().setReturnValue(message+"失败").write(writer);
						}else{
							Egox.egoxOk().setReturnValue(message+"成功").write(writer);
						}
					}else{
						sql = "update tAgentShopLevel set sAgentContractNO=?,nLevelID=?,sShopNO=?,sUpdateUser=?,dUpdateDate=getDate() where sAgentContractNO=? and nLevelID=? and sShopNO=?";
						int i = jdbcTemplate.update(sql, sAgentContractNO,nLevel,sShopNO,agentId,oldAgentContractNO,oldLevel,oldShopNO);
						if(i <= 0){
							Egox.egoxErr().setReturnValue(message+"失败").write(writer);
						}else{
							Egox.egoxOk().setReturnValue(message+"成功").write(writer);
						}
					}
				}
			}else if("del".equals(type)){
				message = "店铺等级设置删除";
				sql = "update tAgentShopLevel set sUpdateUser=?,dUpdateDate=getDate(),nTag =1 where sAgentContractNO=? and nLevelID=? and sShopNO=?";
				int i = jdbcTemplate.update(sql, agentId,sAgentContractNO,nLevel,sShopNO);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}
		}catch(Exception ex){
			U.logger.info(">>>>>> tAgentShopLevel >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue(message+"失败").write(writer);
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
	}
	
	@RequestMapping("/goodsPriceLevelList")
	public String goodsPriceLevelList(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		String where = "";
		
		String otherWhere = "";
		
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("sAgentContractNO","nGoodsID","dCreateDate","dUpdateDate","ord");
		}
		
		String constractNO  = request.getParameter("constractNO"); 
		
		if(StringUtils.isNotBlank(constractNO)){
			where += " and acg.sAgentContractNO = '"+constractNO+"'";
		}else{
			where += " and 1=2";
		}
		
		String category = request.getParameter("categoryID");
		if(StringUtils.isNotBlank(category)){
			where += " and acg.sCategoryNO = '"+category+"'";
		}
		
		String brand = request.getParameter("brandID");
		if(StringUtils.isNotBlank(brand)){
			where += " and acg.sBrandID  = '"+brand+"'";
		}
		
		String goodsDesc = request.getParameter("goodsDesc");
		if(StringUtils.isNotBlank(goodsDesc)){
			where += " and (acg.sGoodsDesc like '%"+goodsDesc+"%' or acg.sMainBarcode = '"+goodsDesc+"') ";
		}

		String goodsId = request.getParameter("goodsId");
		if(StringUtils.isNotBlank(goodsId)){
			where += " and acg.nGoodsID  = '"+goodsId+"' ";
		}
		
		otherWhere += where;
		
		String shopLevel = request.getParameter("shopLevel");
		if(StringUtils.isNotBlank(shopLevel)){
			where += " and (alp.nLevelID = '"+shopLevel+"') ";
		}else{
			where += " and 1=2";
		}
		
		List<Map<String,Object>> agentContract = null;
		List<Map<String, Object>> datas = null;
		String agentId = SecurityContextUtil.getUserId(); 
		String sOrgNO =  SecurityContextUtil.getRegionId();
		
		UserType userType = SecurityContextUtil.getUserType();
		if(userType.oneOf(UserType.AGENT)){  //经销商
			agentContract = jdbcTemplate.queryForList("select sAgentContractNO from tAgentContract where nAgentID = ? and sOrgNO = ? ",agentId,sOrgNO);
			String sql = "select  	acg.sAgentContractNO sAgentContractNO, "
					 + "		 	acg.nGoodsID nGoodsID, "
					 + "			acg.sGoodsDesc sGoodsDesc, 	 "
					 + "			acg.nSalePrice nRealSalePrice, 	 "
					 + "			alp.nSalePrice nSalePrice, 	 "
					 + "			alp.nLevelID nLevelID,	"	
					 + "			(select al.sLevelName from tAgentLevel al where al.nLevel = alp.nLevelID) sLevelName, "
					 + "			CONVERT(varchar(100), alp.dCreateDate, 20) dCreateDate , 	 "
					 + "			alp.sCreateUser sCreateUser, 	 "
					 + "			CONVERT(varchar(100), alp.dUpdateDate, 20) dUpdateDate, 	 "
					 + "			alp.sUpdateUser sUpdateUser  ,"
					 + "			0 ord "
					 + "		from tAgentContractGoods acg  	 "
					 + "		left join tAgentLevelPrice alp  	 "
					 + "		on alp.nGoodsID = acg.nGoodsID 	and alp.sAgentContractNO = acg.sAgentContractNO and (alp.nTag <> 1 OR alp.nTag is null) and alp.nLevelID = '"+shopLevel+"'"
					 + "	where (alp.nTag <> 1 OR alp.nTag is null) and acg.nAgentID = '"+agentId+"' "
					 + where
					 + " union "
					 + "select  	acg.sAgentContractNO sAgentContractNO, "
					 + "		 	acg.nGoodsID nGoodsID, "
					 + "			acg.sGoodsDesc sGoodsDesc, 	 "
					 + "			acg.nSalePrice nRealSalePrice, 	 "
					 + "			alp.nSalePrice nSalePrice, 	 "
					 + "			alp.nLevelID nLevelID,	"	
					 + "			(select al.sLevelName from tAgentLevel al where al.nLevel = alp.nLevelID) sLevelName, "
					 + "			CONVERT(varchar(100), alp.dCreateDate, 20) dCreateDate , 	 "
					 + "			alp.sCreateUser sCreateUser, 	 "
					 + "			CONVERT(varchar(100), alp.dUpdateDate, 20) dUpdateDate, 	 "
					 + "			alp.sUpdateUser sUpdateUser   ,"
					 + "			1 ord "
					 + "		from tAgentContractGoods acg  	 "
					 + "		left join tAgentLevelPrice alp  	 "
					 + "		on alp.nGoodsID = acg.nGoodsID 	and alp.sAgentContractNO = acg.sAgentContractNO and (alp.nTag <> 1 OR alp.nTag is null) and alp.nLevelID = '"+shopLevel+"' "
					 + "	where alp.nLevelID is null "
					 + otherWhere;
			
			datas = jdbcTemplate.limit(sql, page);
		}
		if(U.isNotEmpty(datas)){
			for(Map<String, Object> map:datas){
				String cno = (String) map.get("sAgentContractNO");
				Integer nLevelID = (Integer) map.get("nLevelID");
				List<Map<String, Object>> lvList = jdbcTemplate.queryForList("select nLevel,sLevelName,nDisRate from tAgentLevel where sAgentContractNO = '"+ cno +"'");
				if(lvList != null && lvList.size() > 0 && nLevelID == null){
					map.put("lvList", lvList);
				}
			}
		}
		
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		request.setAttribute("constract",agentContract);
		request.setAttribute("constractNO", constractNO);
		request.setAttribute("categoryID", category);
		request.setAttribute("brandID", brand);
		request.setAttribute("goodsDesc", goodsDesc);
		request.setAttribute("goodsID", goodsId);
		request.setAttribute("shopLevel", shopLevel);
		return "/goods/price/goodsPriceLevelList.jsp";
	}
	
	@RequestMapping("/goodsPriceLevelBatch")
	public String goodsPriceLevelBatch(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		String agentId = SecurityContextUtil.getUserId(); 
		String sOrgNO =  SecurityContextUtil.getRegionId();
		String nLevel = request.getParameter("nLevel");
		String sAgentContractNO = request.getParameter("constractNO");
		String nLevelDesc = "";
		if(StringUtils.isNotBlank(sAgentContractNO) && StringUtils.isNotBlank(nLevel)){
			
			int count = jdbcTemplate.queryForInt("select count(1) from tAgentContractGoods tAgentContractGoods where sAgentContractNO = ?",sAgentContractNO);
			
			int setCount = jdbcTemplate.queryForInt("select count(1) from tAgentContractGoods where nGoodsID in (select alp.nGoodsID from tAgentLevelPrice alp where (alp.nTag <> 1 OR alp.nTag is null) and alp.nLevelID = ? and sAgentContractNO = ?) and sAgentContractNO = ?", nLevel,sAgentContractNO,sAgentContractNO);
			
			int noSetCount = jdbcTemplate.queryForInt("select count(1) from tAgentContractGoods where nGoodsID not in (select alp.nGoodsID from tAgentLevelPrice alp where (alp.nTag <> 1 OR alp.nTag is null) and alp.nLevelID = ? and sAgentContractNO = ?) and sAgentContractNO = ?", nLevel,sAgentContractNO,sAgentContractNO);
			
			Map<String,Object> lv = jdbcTemplate.queryForMap("select cast(nDisRate as varchar) nDisRate,sLevelName from tAgentLevel where nLevel = ? ", nLevel);
			String disRate = (String) lv.get("nDisRate");
			nLevelDesc = (String) lv.get("sLevelName");


			request.setAttribute("count",count);
			request.setAttribute("setCount",setCount);
			request.setAttribute("noSetCount",noSetCount);
			request.setAttribute("disRate",disRate);
			request.setAttribute("nLevelDesc",nLevelDesc);
			request.setAttribute("constractNO",sAgentContractNO);
			request.setAttribute("showDetail", "true");
			
		}
		List<Map<String,Object>> agentContract = null;
		UserType userType = SecurityContextUtil.getUserType();
		if(userType.oneOf(UserType.AGENT)){  //经销商
			agentContract = jdbcTemplate.queryForList("select sAgentContractNO from tAgentContract where nAgentID = ? and sOrgNO = ? ",agentId,sOrgNO);
		}

		request.setAttribute("agent",agentContract);
		request.setAttribute("constractNO", sAgentContractNO);
		request.setAttribute("nLevel",nLevel);
		return "/goods/price/goodsPriceLevelBatch.jsp";
	}
	
	@Transactional
	@RequestMapping("/goodsPriceLevelSave2")
	public void goodsPriceLevelSave2(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) throws Exception {
		String agentId = SecurityContextUtil.getUserId(); 
		String type = request.getParameter("type");
		String nLevel = request.getParameter("nLevel");
		String sShopNO = request.getParameter("sShopNO");
		String sAgentContractNO = request.getParameter("constractNO");
		
		String oldLevel = request.getParameter("oldLevel");
		String oldShopNO = request.getParameter("oldShopNO");
		String oldAgentContractNO = request.getParameter("oldConstractNO");
		String sql = "";
		String message = "";
		try{
			sql = "select count(1) from tAgentShopLevel where sAgentContractNO=? and nLevelID=? and sShopNO=?";
			int count = jdbcTemplate.queryForInt(sql,sAgentContractNO,nLevel,sShopNO);
			if("add".equals(type)){
				message = "店铺等级设置保存";
				if(count > 0){
					Egox.egoxErr().setReturnValue(message+"失败,已经存在的设置").write(writer);
				}else{
					sql = "insert into tAgentShopLevel (sAgentContractNO,nLevelID,sShopNO,sCreateUser,dCreateDate,nTag) values (?,?,?,?,GETDATE(),'0')";
					int i = jdbcTemplate.update(sql, sAgentContractNO,nLevel,sShopNO,agentId);
					if(i <= 0){
						Egox.egoxErr().setReturnValue(message+"失败").write(writer);
					}else{
						Egox.egoxOk().setReturnValue(message+"成功").write(writer);
					}
				}
			}else if("edit".equals(type)){
				message = "店铺等级设置保存";
				if(count > 0){
					Egox.egoxErr().setReturnValue(message+"失败,已经存在的设置").write(writer);
				}else{
					sql = "update tAgentShopLevel set sAgentContractNO=?,nLevelID=?,sShopNO=?,sUpdateUser=?,dUpdateDate=getDate() where sAgentContractNO=? and nLevelID=? and sShopNO=?";
					int i = jdbcTemplate.update(sql, sAgentContractNO,nLevel,sShopNO,agentId,oldAgentContractNO,oldLevel,oldShopNO);
					if(i <= 0){
						Egox.egoxErr().setReturnValue(message+"失败").write(writer);
					}else{
						Egox.egoxOk().setReturnValue(message+"成功").write(writer);
					}
				}
			}else if("del".equals(type)){
				message = "店铺等级设置删除";
				sql = "update tAgentShopLevel set sUpdateUser=?,dUpdateDate=getDate(),nTag =1 where sAgentContractNO=? and nLevelID=? and sShopNO=?";
				int i = jdbcTemplate.update(sql, agentId,sAgentContractNO,nLevel,sShopNO);
				if(i <= 0){
					Egox.egoxErr().setReturnValue(message+"失败").write(writer);
				}else{
					Egox.egoxOk().setReturnValue(message+"成功").write(writer);
				}
			}
		}catch(Exception ex){
			U.logger.info(">>>>>> tAgentShopLevel >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue(message+"失败").write(writer);
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
	}
	
	@Transactional
	@RequestMapping("/goodsPriceLevelSave")
	public void goodsPriceLevelSave(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) throws Exception {
		try{
			String jsonStr = ServletUtil.readReqJson(request);
			JSONObject jsonObject = JSONObject.parseObject(jsonStr);
			JSONArray goodsPriceList =jsonObject.getJSONArray("goodsPriceList");
			
			String agentId = SecurityContextUtil.getUserId(); 
			
			if(goodsPriceList!=null && goodsPriceList.size() > 0){
				for(int i=0;i<goodsPriceList.size();i++){
					JSONObject goodsPrice = goodsPriceList.getJSONObject(i);
					
					String acNO = goodsPrice.getString("acNO");
					String gid = goodsPrice.getString("gid");
					String lv = goodsPrice.getString("level");
					String oldLevel = goodsPrice.getString("oldLevel");
					String salePrice = goodsPrice.getString("salePrice");
					String realSalePrice = goodsPrice.getString("realSalePrice");

					String sql =""; 
					if(StringUtils.isNotBlank(oldLevel)){
						sql = "update tAgentLevelPrice set nSalePrice = ?,nRealSalePrice = ?  where  sAgentContractNO=? and nLevelID=? and nGoodsID=?";
						int tag = jdbcTemplate.update(sql,salePrice,salePrice,acNO,oldLevel,gid);
//						if(tag<= 0){
//							Egox.egoxErr().setReturnValue("保存失败").write(writer);
//						}else{
//							Egox.egoxOk().setReturnValue("保存成功").write(writer);
//						}
					}else{
						if(StringUtils.isNotBlank(salePrice) && StringUtils.isNotBlank(lv)){
							jdbcTemplate.batchUpdate("merge into tAgentLevelPrice alp using (select 1 as a ) ustemp on (alp.nLevelID= '"+lv+"' and alp.sAgentContractNO = '"+acNO+"' and nGoodsID = '"+gid+"')"
									+" when matched then"
									+" update set alp.nSalePrice = '"+salePrice+"',alp.nRealSalePrice = '"+salePrice+"',alp.nTag=0 "
									+" when not matched then"
									+" insert values ('"+acNO+"','"+lv+"','"+gid+"','"+salePrice+"','"+salePrice+"','"+agentId+"',GETDATE(),'"+agentId+"',GETDATE(),0);");
//							if(tag<= 0){
//								Egox.egoxErr().setReturnValue("保存失败").write(writer);
//							}else{
//								Egox.egoxOk().setReturnValue("保存成功").write(writer);
//							}
						}
					}
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
	
	@RequestMapping("/goodsPriceLevelReset")
	public void goodsPriceLevelReset(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		try{
			String acNO = request.getParameter("acNO");
			String gid = request.getParameter("gid");
			String lv = request.getParameter("lv");
			if(jdbcTemplate.queryForInt("select count(1) from tAgentLevelPrice where sAgentContractNO =? and nLevelID=? and nGoodsID=?",acNO,lv,gid) <= 0){
				Egox.egoxErr().setReturnValue("未设置等级价格，无需重置").write(writer);
			}else{
				String sql = "update tAgentLevelPrice set nTag = 1 where  sAgentContractNO=? and nLevelID=? and nGoodsID=?";
				int tag = jdbcTemplate.update(sql,acNO,lv,gid);
				if(tag<= 0){
					Egox.egoxErr().setReturnValue("重置失败").write(writer);
				}else{
					Egox.egoxOk().setReturnValue("重置成功").write(writer);
				}
			}
		}catch(Exception ex){
			U.logger.info(">>>>>> tAgentShopLevel >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue("重置失败").write(writer);
			ex.printStackTrace();
		}
	}
	
	@Transactional
	@RequestMapping("/goodsPriceLevelBatchSave")
	public void goodsPriceLevelBatchSave(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) throws Exception{
		try{
			String nLevel = request.getParameter("applyLevel");
			String sAgentContractNO = request.getParameter("applyConstractNO");
			String scope = request.getParameter("scope");
			String disRate = request.getParameter("disRate");
			String agentId = SecurityContextUtil.getUserId(); 
			if("0".equals(scope)){
				List<Map<String,Object>> list = jdbcTemplate.queryForList("select cast(nGoodsID as varchar) nGoodsID,cast(nRealSalePrice as varchar) nRealSalePrice from tAgentContractGoods where sAgentContractNO=?",sAgentContractNO);
				for(Map<String,Object> g:list){
					String goodsId = (String) g.get("nGoodsID");
					String nRealSalePrice = (String) g.get("nRealSalePrice");
					BigDecimal bRealSalePrice = new BigDecimal(nRealSalePrice);
					BigDecimal bDisRate = new BigDecimal(disRate);
					BigDecimal divider = new BigDecimal("100");
					Double salePrice = bRealSalePrice.multiply(bDisRate.divide(divider)).doubleValue();
					
					/*try{
						jdbcTemplate.update("update tAgentLevelPrice alp set alp.nSalePrice = ?",salePrice);
					}catch(Exception e){
						Egox.egoxErr().setReturnValue("保存失败").write(writer);
						e.printStackTrace();
					}
					
					try{
						jdbcTemplate.update("insert into tAgentLevelPrice values (?,?,?,?,?,?,GETDATE(),?,GETDATE(),0);",sAgentContractNO,nLevel,goodsId,nRealSalePrice,salePrice,agentId,agentId);
					}catch(Exception e){
						if(e instanceof SQLException){
							e.printStackTrace();
						}else{
							Egox.egoxErr().setReturnValue("保存失败").write(writer);
							e.printStackTrace();
						}
					}*/
					
					jdbcTemplate.batchUpdate("merge into tAgentLevelPrice alp using (select 1 as a ) ustemp on (alp.nLevelID= '"+nLevel+"' and alp.sAgentContractNO = '"+sAgentContractNO+"' and nGoodsID = '"+goodsId+"')"
								+" when matched then"
								+" update set alp.nSalePrice = '"+salePrice+"', alp.nRealSalePrice='"+salePrice+"',alp.nTag=0 "
								+" when not matched then"
								+" insert values ('"+sAgentContractNO+"','"+nLevel+"','"+goodsId+"','"+nRealSalePrice+"','"+salePrice+"','"+agentId+"',GETDATE(),'"+agentId+"',GETDATE(),0);");
				}
			}else if("1".equals(scope)){
				List<Map<String,Object>> list = jdbcTemplate.queryForList("select cast(nGoodsID as varchar) nGoodsID,cast(nRealSalePrice as varchar) nRealSalePrice from tAgentContractGoods where nGoodsID not in (select alp.nGoodsID from tAgentLevelPrice alp where (alp.nTag <> 1 OR alp.nTag is null) and alp.nLevelID = ? and sAgentContractNO = ?) and sAgentContractNO = ?", nLevel,sAgentContractNO,sAgentContractNO);
				for(Map<String,Object> g:list){
					String goodsId = (String) g.get("nGoodsID");
					String nRealSalePrice = (String) g.get("nRealSalePrice");
					BigDecimal bRealSalePrice = new BigDecimal(nRealSalePrice);
					BigDecimal bDisRate = new BigDecimal(disRate);
					BigDecimal divider = new BigDecimal("100");
					Double salePrice = bRealSalePrice.multiply(bDisRate.divide(divider)).doubleValue();
					
					jdbcTemplate.update("insert into tAgentLevelPrice values (?,?,?,?,?,?,GETDATE(),?,GETDATE(),0)",sAgentContractNO,nLevel,goodsId,salePrice,salePrice,agentId,agentId);
				}
			}else if("2".equals(scope)){
				List<Map<String,Object>> list = jdbcTemplate.queryForList("select cast(nGoodsID as varchar) nGoodsID,cast(nRealSalePrice as varchar) nRealSalePrice from tAgentContractGoods where nGoodsID in (select alp.nGoodsID from tAgentLevelPrice alp where (alp.nTag <> 1 OR alp.nTag is null) and alp.nLevelID = ? and sAgentContractNO = ?) and sAgentContractNO = ?", nLevel,sAgentContractNO,sAgentContractNO);
				for(Map<String,Object> g:list){
					String goodsId = (String) g.get("nGoodsID");
					String nRealSalePrice = (String) g.get("nRealSalePrice");
					BigDecimal bRealSalePrice = new BigDecimal(nRealSalePrice);
					BigDecimal bDisRate = new BigDecimal(disRate);
					BigDecimal divider = new BigDecimal("100");
					Double salePrice = bRealSalePrice.multiply(bDisRate.divide(divider)).doubleValue();
					
					jdbcTemplate.update("update tAgentLevelPrice set nSalePrice = ?,nRealSalePrice=?,sUpdateUser=?,dUpdateDate=GETDATE() where sAgentContractNO=? and  nLevelID=? and nGoodsID=?",salePrice,salePrice,agentId,sAgentContractNO,nLevel,goodsId);
					
				}
			}
			Egox.egoxOk().setReturnValue("批量设置成功").write(writer);
		}catch(Exception ex){
			U.logger.info(">>>>>> goodsPriceLevelBatchSave >> Exception :"+ex.getMessage());
			Egox.egoxErr().setReturnValue("批量设置失败").write(writer);
			ex.printStackTrace();
			throw new Exception(ex.getMessage());
		}
	}
	
	@RequestMapping("/baseLevelJsonByConstract")
	public void baseLevelJsonByConstract(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		String constractNO = request.getParameter("constractNO");
		try{
			if(StringUtils.isBlank(constractNO)){
				List<Map<String,Object>> baseLevel = jdbcTemplate.queryForList("select nLevel,sLevelName,nDisRate from tAgentLevel");
				Egox.egoxOk().setDataList(baseLevel).write(writer);
			}else{
				List<Map<String,Object>> baseLevel = jdbcTemplate.queryForList("select nLevel,sLevelName,nDisRate from tAgentLevel where sAgentContractNO = ? ",constractNO);
				Egox.egoxOk().setDataList(baseLevel).write(writer);
			}
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询基础等级失败。").write(writer);
			U.logger.info("查询基础等级失败:"+ex.getMessage());
		}
		
	}
	
	@RequestMapping("/shopJsonByAgent")
	public void shopJsonByAgent(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		try{
			String constractNO = request.getParameter("constractNO");
			String sql = " select sShopNO,sShopName from "
					 + " tShop where sDistrictID in  "
					 + " (select whd.sDistrictID  "
					 + "	from tWarehouseDistrict whd  "
					 + "	left join tAgentContractWarehouse  acw on acw.sWarehouseNO = whd.sWarehouseNO  "
					 + "	left join tAgentContract ac on ac.sAgentContractNO = acw.sAgentContractNO  "
					 + "	where ac.sAgentContractNO = ? ) ";
			List<Map<String,Object>> baseLevel = jdbcTemplate.queryForList(sql,constractNO);
			Egox.egoxOk().setDataList(baseLevel).write(writer);
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询经销商相关店铺失败。").write(writer);
			U.logger.info("查询经销商相关店失败:"+ex.getMessage());
		}
		
	}
	
	@RequestMapping("/categoryByConstract")
	public void categoryByConstract(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		String constractNO = request.getParameter("constractNO");

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
					 + "		cno = ISNULL( "
					 + "			gc.sCategoryNO, "
					 + "			ag.sCategoryNO "
					 + "		) "
					 + "	FROM "
					 + "		tAgentContractGoods ag "
					 + "	LEFT JOIN tGoodsCategory gc ON ag.nGoodsID = gc.nGoodsID "
					 + "	WHERE "
					 + "		ag.sAgentContractNO = ? "
					 + "	AND ag.sOrgNO = ? "
					 + ") AS t ON t.cno = c.sCategoryNO " ;
			List<Map<String,Object>> category = jdbcTemplate.queryForList(sql,constractNO,sOrgNO);
			Egox.egoxOk().setDataList(category).write(writer);
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询合同下的商品分类失败。").write(writer);
			U.logger.info("查询合同下的商品分类失败:"+ex.getMessage());
		}
		
	}
	
	@RequestMapping("/brandByConstract")
	public void brandByConstract(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request,Writer writer) {
		String constractNO = request.getParameter("constractNO");
		try{
			String sql = "select brandID=b.sBrandID  , "
					 + "	brandName=b.sBrandName  "
					 + "	FROM tBrand b   "
					 + "	join  "
					 + "	(select  "
					 + "		distinct bid=ag.sBrandID  "
					 + "	from tAgentContractGoods ag  "
					 + "	where ag.sAgentContractNO = ?) as t  "
					 + "	on t.bid=b.sBrandID ";
			List<Map<String,Object>> brand = jdbcTemplate.queryForList(sql,constractNO);
			Egox.egoxOk().setDataList(brand).write(writer);
		}catch(Exception ex){
			Egox.egoxErr().setReturnValue("查询合同下的商品品牌失败。").write(writer);
			U.logger.info("查询合同下的商品品牌失败:"+ex.getMessage());
		}
		
	}
	
	
	@RequestMapping("/shopSelectPage")
	public String shopSelectPage(HttpServletRequest request) {
		String constractNO  = request.getParameter("constractNO"); 
		request.setAttribute("constractNO", constractNO);
		return "/goods/price/shop-select.jsp";
	}
	
	 @InitBinder("page")
	  public void initBinder1(WebDataBinder binder) {
		  binder.setFieldDefaultPrefix("page.");
	  }
	/**
	 * 
	* @Title: listGoodsByIdAndOrgId 
	* @Description: TODO(根据经销商ID和组织机构查询商品) 
	* @param @param request
	* @param @param page
	* @param @param writer    设定文件 
	* @return void    返回类型 
	* @throws
	 */
	@RequestMapping(value="/shopSelectList")
	public void shopSelectList(HttpServletRequest request,@ModelAttribute("page")PageSqlserver page,Writer writer){
		try {
			if (page == null) {
				page = new PageSqlserver();
				page.setIndex(1L);
				page.setLimit(20);
			}else{
				page.setLimit(10);
			}
			page.setLimitKey("dLastUpdateTime");
			String constractNO = request.getParameter("constractNO");
			String shopName = request.getParameter("shopName");
			String where = "";
			if(StringUtils.isNotBlank(shopName)){
				where = " and sShopName like '%"+shopName+"%'";
			}
			String sql = " select nShopID,sShopNO,sShopName,sContacts,nTag,dLastUpdateTime from "
					 + " tShop where sDistrictID in  "
					 + " (select whd.sDistrictID  "
					 + "	from tWarehouseDistrict whd  "
					 + "	left join tAgentContractWarehouse  acw on acw.sWarehouseNO = whd.sWarehouseNO  "
					 + "	left join tAgentContract ac on ac.sAgentContractNO = acw.sAgentContractNO  "
					 + "	where ac.sAgentContractNO = ? ) ";

			List<Map<String, Object>> datas = jdbcTemplate.limit(sql+where,page,constractNO);
			Egox.egoxOk().setDataList(datas).set("page",page).write(writer);
		} catch (Exception e) {
			U.logger.error("根据合同查询店铺列表失败",e);
			Egox.egoxErr().setReturnValue("根据合同查询店铺列表失败").write(writer);
		}
		
	}
}
