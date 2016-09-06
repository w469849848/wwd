package com.egolm.dealer.web;

import java.io.Writer;
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
import com.egolm.dealer.api.RegionQueryApi;
import com.egolm.security.utils.SecurityContextUtil;

@Controller
@RequestMapping("/city/manage")
public class CityController {

	@Resource(name = "jdbcTemplate")
	private JdbcTemplate jdbcTemplate;
	
	@Resource(name = "regionQueryApi")
	private RegionQueryApi regionQueryApi;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/priorityManageList")
	public String priorityManageList(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request) {
		try {
			String sqlWhere = "";
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
				page.setLimitKey("sRegionNO","sRegionTypeID");
			}
			
			String sRegionDesc  = request.getParameter("sRegionDesc"); 
			
			if(StringUtils.isNotBlank(sRegionDesc)){
				sqlWhere = " and r.sRegionDesc like '%"+sRegionDesc+"%'";
			}
			
			List<String> orgNOs =  SecurityContextUtil.getRegionIds();
			UserType userType = SecurityContextUtil.getUserType();

			String sql = "select "
					+ " r.sRegionNO,"
					+ " r.sRegionDesc,"
					+ " r.sRegionTypeID,"
					+ " r.sRegionType,"
					+ " (select r1.sRegionDesc from tRegion r1 where r1.sRegionNO = r.sUpRegionNO) sUpRegionDesc,"
					+ " (select count(1) from tWarehouseDistrict where sDistrictID = r.sRegionNO) whCount "
					+ " from tRegion r where r.sUpRegionNO in (select sRegionNO from tOrg where sOrgNO in("+U.join("','", "'","'", orgNOs)+")) and r.nTag = 0";
			
			List<Map<String,Object>> districtList = null;
			
			districtList = jdbcTemplate.limit(sql+sqlWhere,page);

			request.setAttribute("page", page);
			request.setAttribute("districtList",districtList);
			request.setAttribute("sRegionDesc",sRegionDesc);
			
		} catch (EgolmException e) {
			logger.error("", e);
		} catch (Throwable e) {
			logger.error("", e);
		}
		return "/dealer/warehouse/priorityManageList.jsp";
	}
	
	@RequestMapping("/priorityManageSetPage")
	public String priorityManageSetPage(HttpServletRequest request) {
		String districtIDs  = request.getParameter("districtIDs"); 
		
		/*String sql = "select sWarehouseNO from tWarehouseDistrict where sDistrictID = ? order by nDCPriority";
		List<String> warehouseNos = jdbcTemplate.queryForObjects(sql, String.class, districtIDs);
		String moduleItems = U.join(",","", warehouseNos);*/
		request.setAttribute("districtIDs", districtIDs);
		//request.setAttribute("moduleItems", moduleItems);
		
		return "/dealer/warehouse/priorityManageSetPage.jsp";
	}
	
	@RequestMapping(value="/priorityManageSet")
	public void priorityManageSet(HttpServletRequest request,Writer writer){
		try {
			String districtIDs = request.getParameter("districtIDs");
			List<String> orgNOs =  SecurityContextUtil.getRegionIds();
			String sql = "select wh.sWarehouseNO,wh.sWarehouseName,wh.sWarehouseType,wd.nDCPriority from tWarehouse wh ,tWarehouseDistrict wd where wh.sWarehouseNO= wd.sWarehouseNO and wd.sDistrictID = ? order by wd.nDCPriority";
			List<Map<String, Object>> datas = jdbcTemplate.queryForList(sql,districtIDs);
			Egox.egoxOk().setDataList(datas).write(writer);
		} catch (Exception e) {
			U.logger.error("查询区域仓库列表失败",e);
			Egox.egoxErr().setReturnValue("查询区域仓库列表失败").write(writer);
		}
		
	}
	
	@Transactional
	@RequestMapping("/priorityManageSetSave")
	public void warehouseSave(HttpServletRequest request,Writer writer) throws Exception {
		String moduleItems = request.getParameter("moduleItems");
		String districtIDs = request.getParameter("districtIDs");
		String[] warehouse = moduleItems.split(",");
		try{
			for(int i=0;i<warehouse.length;i++){
				String sWarehouseNO = warehouse[i];
				String sql = "update tWarehouseDistrict set nDCPriority = ? where sDistrictID = ? and sWarehouseNO = ? ";
				jdbcTemplate.update(sql,i,districtIDs,sWarehouseNO);
			}
			Egox.egoxOk().setReturnValue("保存成功").write(writer);
		}catch(Exception ex){
			ex.printStackTrace();
			Egox.egoxErr().setReturnValue("保存失败").write(writer);
			throw new Exception(ex.getMessage());
		}
	}
		
	 @InitBinder("page")
	 public void initBinder1(WebDataBinder binder) {
		  binder.setFieldDefaultPrefix("page.");
	 }
	
}
