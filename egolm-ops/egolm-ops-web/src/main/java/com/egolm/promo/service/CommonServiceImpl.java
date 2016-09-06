package com.egolm.promo.service;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.JdbcTemplate;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;

@Service
public class CommonServiceImpl {

	@Autowired
	protected JdbcTemplate jdbcTemplate;
	
	public int save(Object... objs) {
		return jdbcTemplate.save(objs);
	}

	public int update(Object... objs) {
		return jdbcTemplate.update(objs);
	}

	public int saveOrUpdate(Object obj) {
		return jdbcTemplate.saveOrUpdate(obj);
	}
	
	public int delete(Object... objs) {
		return jdbcTemplate.delete(objs);
	}
	
	public int delete(String tableName, Map<String, Object> objMap) {
		return jdbcTemplate.delete(tableName, objMap);
	}
	
	public Object queryByPk(Object obj) {
		return jdbcTemplate.queryForBeanByPk(obj);
	}

	public int merge(Object obj) {
		return jdbcTemplate.merge(obj);
	}
	
	public String getNumber(String sKey, String format) {
		Integer nStep = 1;
		Integer nDefaultIndex = 1;
		String sDate = DateUtil.format(new Date(), "yyMMdd");
		String sql = ""
				+ "DECLARE @sKey varchar(32) " + U.LINE_SEPARATOR
				+ "DECLARE @sDate varchar(32) " + U.LINE_SEPARATOR
				+ "DECLARE @nStep int " + U.LINE_SEPARATOR
				+ "DECLARE @nIndex int " + U.LINE_SEPARATOR
				+ "DECLARE @nCount int " + U.LINE_SEPARATOR
				+ "SET @sKey = '" + sKey + "' " + U.LINE_SEPARATOR
				+ "SET @sDate = '" + sDate + "' " + U.LINE_SEPARATOR
				+ "SET @nStep = " + nStep + " " + U.LINE_SEPARATOR
				+ "SET @nIndex = " + nDefaultIndex + " " + U.LINE_SEPARATOR
				+ "SELECT @nCount = COUNT(*) FROM tIndex WHERE sKey = @sKey AND sDate = @sDate " + U.LINE_SEPARATOR
				+ "IF(@nCount = 0) " + U.LINE_SEPARATOR 
				+ "BEGIN" + U.LINE_SEPARATOR 
				+ "INSERT INTO tIndex(sKey, sDate, nStep, nIndex) VALUES (@sKey, @sDate, @nStep, @nIndex)" + U.LINE_SEPARATOR 
				+ "END" + U.LINE_SEPARATOR 
				+ "UPDATE tIndex SET nIndex = nIndex+nStep WHERE sKey = @sKey AND sDate = @sDate " + U.LINE_SEPARATOR
				+ "SELECT * FROM tIndex WHERE sKey = @sKey AND sDate = @sDate";
		Map<String, Object> map = jdbcTemplate.executeMutil(sql).getDatas().get(0).get(0);
		String yyMMdd = (String)map.get("sDate");
		Integer nIndex = (Integer)map.get("nIndex");
		String No = StringUtil.formatLength(nIndex, "0000");
		return StringUtil.formatLength((yyMMdd+No), format);
	}
}
