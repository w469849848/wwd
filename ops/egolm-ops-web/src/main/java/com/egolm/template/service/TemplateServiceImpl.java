package com.egolm.template.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.egolm.common.EgolmException;
import com.egolm.tpl.utils.HttpHandler;
import com.egolm.tpl.web.TplSettingPopController;

@Service
public class TemplateServiceImpl {

	@Resource(name = "jdbcTemplate")
	JdbcTemplate jdbcTemplate;
	
	public void saveObject(Object... objs) {
		jdbcTemplate.save(objs);
	}
	
	public void updateObject(Object... objs) {
		jdbcTemplate.update(objs);
	}

	public List<Map<String, Object>> queryScopeTypes() {
		String sql = "select sComID sScopeTypeID, sComDesc sScopeType from tCommon where sCommonNO='ScopeType' and nTag = 0";
		return jdbcTemplate.queryForList(sql);
	}

	public List<Map<String, Object>> queryTplPageList(List<String> orgs, Integer nScopeTypeID, Integer nTerminalTypeID, String queryKey, PageSqlserver page) {
		List<String> args = new ArrayList<String>();
		List<Object> objs = new ArrayList<Object>();
		args.add("sOrgNO in (" + StringUtil.join("', '", "'", "'", orgs) + ")");
		if(nScopeTypeID != null) {
			args.add("nScopeTypeID = ?");
			objs.add(nScopeTypeID);
		}
		if(nTerminalTypeID != null) {
			args.add("nTerminalTypeID & " + nTerminalTypeID + " = " + nTerminalTypeID);
		}
		if(StringUtil.isNotBlank(queryKey)) {
			args.add("sPageName like ?");
			objs.add("%" + queryKey + "%");
		}
		return jdbcTemplate.limit("select * from tTplPage" + StringUtil.join(" and ", " where ", args), page, objs.toArray());
	}

	public Map<String, Object> queryTplPageByID(Integer nTplPageID) {
		return jdbcTemplate.queryForMap("select * from tTplPage where nTplPageID = ?", nTplPageID);
	}

	public List<Map<String, Object>> queryAdvertByPageID(Integer nTplPageID) {
		return jdbcTemplate.queryForList("select advert.* from tShopAdvert advert, tTplCell cell where advert.nApID = cell.nApID and cell.nTplPageID = ?", nTplPageID);
	}
	
	public void removeTplPageByID(Integer nTplPageID) {
		jdbcTemplate.executeUpdate("delete from tTplCell where nTplPageID = ?", nTplPageID);
		jdbcTemplate.executeUpdate("delete from tTplTab where nTplPageID = ?", nTplPageID);
		jdbcTemplate.executeUpdate("delete from tTplFloor where nTplPageID = ?", nTplPageID);
		jdbcTemplate.executeUpdate("delete from tTplPage where nTplPageID = ?", nTplPageID);
	}

	public List<Map<String, Object>> queryTplFloorsByPageID(Integer nTplPageID) {
		return jdbcTemplate.queryForList("select * from tTplFloor where nTplPageID = ? order by nFloorIndex, nTplFloorID", nTplPageID);
	}

	public void removeTplFloorByID(Integer nTplFloorID) {
		jdbcTemplate.executeUpdate("delete from tTplCell where nTplFloorID = ?", nTplFloorID);
		jdbcTemplate.executeUpdate("delete from tTplTab where nTplFloorID = ?", nTplFloorID);
		jdbcTemplate.executeUpdate("delete from tTplFloor where nTplFloorID = ?", nTplFloorID);
	}
	
	public Map<String, Object> queryTplFloorByID(Integer nTplFloorID) {
		return jdbcTemplate.queryForMap("select * from tTplFloor where nTplFloorID = ?", nTplFloorID);
	}
	
	public List<Map<String, Object>> queryTplTabsByPageID(Integer nTplPageID) {
		return jdbcTemplate.queryForList("select * from tTplTab where nTplPageID = ? order by nTplPageID, nTplFloorID, nTabIndex, nTplTabID", nTplPageID);
	}
	
	public void sortFloor(String[] args) {
		for(String arg : args) {
			if(StringUtil.isNotBlank(arg)) {
				String[] kv = arg.split("=");
				if(kv.length == 2) {
					jdbcTemplate.executeUpdate("update tTplFloor set nFloorIndex = ? where nTplFloorID = ?", Integer.valueOf(kv[1]), Integer.valueOf(kv[0]));
				}
			}
		}
	}

	public List<Map<String, Object>> queryTplCellsByPageID(Integer nTplPageID) {
		return jdbcTemplate.queryForList("select * from tTplCell where nTplPageID = ?", nTplPageID);
	}
	
	public Map<String, Object> queryTplTabByID(Integer nTplTabID) {
		return jdbcTemplate.queryForMap("select * from tTplTab where nTplTabID = ?", nTplTabID);
	}
	
	public Map<String, Object> queryTplCellByStartCell(Integer nTplTabID, Integer nRowStart, Integer nColStart) {
		try {
			return jdbcTemplate.queryForMap("select * from tTplCell where nTplTabID = ? and nRowStart = ? and nColStart = ?", nTplTabID, nRowStart, nColStart);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

	public Map<String, Object> queryAdPosByID(Integer nApID) {
		return jdbcTemplate.queryForMap("select * from tShopAdPos where nApID = ?", nApID);
	}
	
	public List<Map<String, Object>> queryAdvertsByApID(Integer nApID) {
		return jdbcTemplate.queryForList("select * from tShopAdvert where nTag = 2 and dAdEndTime > getdate() and nApID = ?", nApID);
	}
	
	public List<Map<String, Object>> searchAdpos(PageSqlserver page, String sOrgNO, Integer nTplPageID, String sApTypeID, String searchText) {
		Map<String, Object> map = jdbcTemplate.queryForMap("select * from tTplPage where nTplPageID = ?", nTplPageID);
		String sql = "select * from tShopAdPos s where ( not exists (select 1 from tTplCell t where t.nApID = s.nApID and t.nTplPageID = '"+nTplPageID+"') or exists (select 1 from tTplCell t1 where t1.nApID = s.nApID and t1.nTplPageID = '"+nTplPageID+"')) ";
		List<String> args = new ArrayList<String>();
		List<Object> objs = new ArrayList<Object>();
		args.add("s.sZoneCodeID = ?");
		objs.add(sOrgNO);
		args.add("s.sScopeTypeID = ?");
		objs.add(U.objTo(map.get("nScopeTypeID"), String.class));
		Integer nTerminalTypeID = U.objTo(map.get("nTerminalTypeID"), Integer.class);
		args.add("s.sApSaleTypeID = ?");
		if((nTerminalTypeID&1) == 1) {
			objs.add("wx");
		} else if((nTerminalTypeID&2) == 2) {
			objs.add("web");
		} else if((nTerminalTypeID&4) == 4) {
			objs.add("android");
		} else if((nTerminalTypeID&8) == 8) {
			objs.add("ios");
		} else {
			objs.add("undefind");
		}
		if(StringUtil.isNotBlank(sApTypeID)) {
			args.add("s.sApTypeID = ?");
			objs.add(sApTypeID);
		}
		if(StringUtil.isNotBlank(searchText)) {
			args.add("s.sApTitle like ?");
			objs.add("%" + searchText + "%");
		}
		return jdbcTemplate.limit(sql + StringUtil.join(" and ", " and ", args), page, objs.toArray());
	}
	
	public String queryOrgNoByPageID(Integer nTplPageID) {
		return jdbcTemplate.queryForString("select sOrgNO from tTplPage where nTplPageID = ?", nTplPageID);
	}
	
	public List<Map<String, Object>> queryTplIconsByTypeID(Integer nTplIconTypeID) {
		return jdbcTemplate.queryForList("select * from tTplIcon where nTag = 1 and nTplIconTypeID = ?", nTplIconTypeID);
	}

	public void updateFloorIcon(Integer nTplFloorID, String sTplIconUrl) {
		jdbcTemplate.executeUpdate("update tTplFloor set sFloorIcon = ? where nTplFloorID = ?", sTplIconUrl, nTplFloorID);
	}

	public void removeTplTabByID(Integer nTplTabID) {
		jdbcTemplate.executeUpdate("delete from tTplCell where nTplTabID = ?", nTplTabID);
		jdbcTemplate.executeUpdate("delete from tTplTab where nTplTabID = ?", nTplTabID);
	}
	public void updateTplPageNTag0(String sOrgNO, Integer nScopeTypeID, Integer nTerminalTypeID) {
		jdbcTemplate.executeUpdate("update tTplPage set nTag = ? where sOrgNO = ? and nScopeTypeID = ? and nTerminalTypeID = ? and sPageTypeID = ?", 0, sOrgNO, nScopeTypeID, nTerminalTypeID, "M");
	}
	
	public void updateApStatusByPageID(Integer nTplPageID,String nTag) {
		List<String> nApIDList = jdbcTemplate.queryForList("select nApID from tTplCell where nTplPageID = ?",String.class, nTplPageID);
		//批量更新模板中所有广告的状态，如果是启用，刚将所有广告位状态更新为“启用：1”，如果是取消启用，则将所有广告位状态更新为“未启用：0”。
		Map<String, String> searchMap=new HashMap<String, String>();
		if(nApIDList.size()>0){
			searchMap.put("apID", StringUtils.join(nApIDList, ","));
			searchMap.put("statusID", nTag);
			JSONObject json = HttpHandler.post(TplSettingPopController.HTTP_UPDATE_AP_STATUS,searchMap);
			if(!json.getBoolean("IsValid")){
				throw new EgolmException("更新广告位状态出错。"+json.getString("ReturnValue"));
			}
		}
	}
	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
