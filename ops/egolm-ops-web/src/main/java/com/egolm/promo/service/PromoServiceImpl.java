package com.egolm.promo.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.util.DateUtil;
import org.springframework.plugin.util.Json;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.egolm.domain.TPromo;
import com.egolm.domain.TPromoPlan;
import com.egolm.domain.TPromoRuleGoods;
import com.egolm.domain.TPromoSetting;
import com.egolm.domain.TPromoTerminal;
import com.egolm.domain.TYWPromoDtl;
import com.egolm.domain.TYWPromoExtends;
import com.egolm.domain.TYWPromoMain;
import com.egolm.domain.TYWPromoPicSet;
import com.egolm.security.utils.SecurityContextUtil;

@Service
@Transactional
public class PromoServiceImpl extends CommonServiceImpl {

	public String queryMaxPromoID() {
		return getNumber("sPromoPaperNO", "W00000000000000");
	}
	
	public List<Map<String, Object>> queryPromos(TYWPromoMain promo, List<String> orgs, String searchText, Page page) {
		List<Object> args = new ArrayList<Object>();
		List<String> strs = new ArrayList<String>();
		if(orgs == null || orgs.size() == 0) {
			return null;
		} else {
			strs.add("p.sOrgNO in (" + StringUtil.join("', '", "'", "'", orgs) + ")");
		}
		if(promo != null) {
			if(promo.getnTag() != null) {
				strs.add("p.nTag = ?");
				args.add(promo.getnTag());
			}
		}
		if(StringUtil.isNotBlank(searchText)) {
			strs.add("(p.sPromoTheme like '%" + searchText + "%' or p.sPromoName like '%" + searchText + "%' or p.sMemo like '%" + searchText + "%' or p.sPromoDesc like '%" + searchText + "%')");
		}
		strs.add("p.sPromoPaperNO like 'W%'");
		return jdbcTemplate.limit("select p.*, e.nSync from tYWPromoMain p left join tYWPromoExtends e on e.sPromoPaperNO = p.sPromoPaperNO" + StringUtil.join(" and ", " where ", strs), page, args.toArray());
	}

	public void updatePromo(TYWPromoMain promo) {
		String sql = "update tYWPromoMain set sPromoTheme = ?, sPromoActionTypeID = ?, sPromoActionType = ?, sPromoName = ?, dPromoBeginDate = ?, dPromoEndDate = ?, nUseCycle = ?, nTerminalTypeID = ?, sSettingModeID = ?, nPromoJoinType = ?, nProperty = ?, nLimitAmount = ?, sMemo = ?, sPromoDesc = ?, dLastUpdateTime = ?, sOrgNO = ?, sAgentContractNO = ?, sBWListTypeID = ? where sPromoPaperNO = ?";
		jdbcTemplate.executeUpdate(sql, promo.getsPromoTheme(), promo.getsPromoActionTypeID(), promo.getsPromoActionType(), promo.getsPromoName(), promo.getdPromoBeginDate(), promo.getdPromoEndDate(), promo.getnUseCycle(), promo.getnTerminalTypeID(), promo.getsSettingModeID(), promo.getnPromoJoinType(), promo.getnProperty(), promo.getnLimitAmount(), promo.getsMemo(), promo.getsPromoDesc(), promo.getdLastUpdateTime(), promo.getsOrgNO(), promo.getsAgentContractNO(), promo.getsBWListTypeID(), promo.getsPromoPaperNO());
		setSync(promo.getsPromoPaperNO(), 0);
	}

	public List<Map<String, Object>> queryGoodsByOrgNo(TYWPromoMain promo, String searchText,Page page) {
		List<String> strs = new ArrayList<String>();
		List<Object> args = new ArrayList<Object>();
		strs.add("acg.sOrgNO = ?");
		args.add(promo.getsOrgNO());
		strs.add("acg.sAgentContractNO = ?");
		args.add(promo.getsAgentContractNO());
		strs.add("acg.nTag&2 = 2");
		if(StringUtil.isNotBlank(searchText)) {
			strs.add("acg.sGoodsDesc like ?");
			args.add("%" + searchText + "%");
		}
		String sql = "select acg.nGoodsID, acg.sAgentContractNO, acg.sGoodsDesc, acg.sSpec, acg.sUnit, acg.sMainBarcode, acg.sBrand, a.sAgentName, c.sCategoryDesc from tAgentContractGoods acg left join tAgent a on a.nAgentID = acg.nAgentID left join tCategory c on c.sCategoryNO = acg.sCategoryNO" + StringUtil.join(" and ", " where ", "", strs);
		return jdbcTemplate.limit(sql, page, args.toArray());
	}
	

	public List<Map<String, Object>> queryExGoods(TYWPromoMain promo, String searchText,Page page) {
		List<String> strs = new ArrayList<String>();
		List<Object> args = new ArrayList<Object>();
		strs.add("acg.sOrgNO = ?");
		args.add(promo.getsOrgNO());
		strs.add("acg.sAgentContractNO = ?");
		args.add(promo.getsAgentContractNO());
		strs.add("acg.nTag&2 = 2");
		if(StringUtil.isNotBlank(searchText)) {
			strs.add("acg.sGoodsDesc like ?");
			args.add("%" + searchText + "%");
		}
		if(promo.getsSettingModeID().endsWith("B")) {
			strs.add("acg.sBrandID in (select sBrandID from tYWPromoDtl where sPromoPaperNO = '" + promo.getsPromoPaperNO() + "')");
		}
		if(promo.getsSettingModeID().endsWith("C")) {
			strs.add("acg.sCategoryNO in (select sCategoryNO from tYWPromoDtl where sPromoPaperNO = '" + promo.getsPromoPaperNO() + "')");
		}
		String sql = "select acg.nGoodsID, acg.sAgentContractNO, acg.sGoodsDesc, acg.sSpec, acg.sUnit, acg.sMainBarcode, acg.sBrand, a.sAgentName, c.sCategoryDesc from tAgentContractGoods acg left join tAgent a on a.nAgentID = acg.nAgentID left join tCategory c on c.sCategoryNO = acg.sCategoryNO" + StringUtil.join(" and ", " where ", "", strs);
		return jdbcTemplate.limit(sql, page, args.toArray());
	}
	
	public List<Map<String, Object>> queryBrandsByOrgNo(TYWPromoMain promo, String searchText, Page page) {
		List<String> strs = new ArrayList<String>();
		List<Object> args = new ArrayList<Object>();
		if(StringUtil.isNotBlank(searchText)) {
			strs.add("b.sBrandName like ?");
			args.add("%" + searchText + "%");
		}
		String sql = "select b.* from (select distinct sBrandID from tAgentContractGoods where sAgentContractNO = '" + promo.getsAgentContractNO() + "' and sOrgNO = '" + promo.getsOrgNO() + "') acg left join tBrand b on b.sBrandID = acg.sBrandID " + StringUtil.join(" and ", " where ", "", strs);
		return jdbcTemplate.limit(sql, page, args.toArray());
	}

	public List<Map<String, Object>> queryCategorysByOrgNo(TYWPromoMain promo, String searchText,Page page) {
		List<String> strs = new ArrayList<String>();
		List<Object> args = new ArrayList<Object>();
		strs.add("sOrgNO = ?");
		args.add(promo.getsOrgNO());
		strs.add("nCategoryLevel = 3");
		if(StringUtil.isNotBlank(searchText)) {
			strs.add("sCategoryDesc like ?");
			args.add("%" + searchText + "%");
		}
		String sql = "select * from tOrgCategory" + StringUtil.join(" and ", " where ", "", strs);
		return jdbcTemplate.limit(sql, page, args.toArray());
	}

	public List<Map<String, Object>> queryPromoDtls(TYWPromoDtl promoDtl, Page page) {
		List<String> strs = new ArrayList<String>();
		List<Object> objs = new ArrayList<Object>();
		strs.add("dtl.sPromoPaperNO = ?");
		objs.add(promoDtl.getsPromoPaperNO());
		strs.add("dtl.nTag = ?");
		objs.add(promoDtl.getnTag());
		if(promoDtl.getnRuleID() != null) {
			strs.add("dtl.nRuleID = ?");
			objs.add(promoDtl.getnRuleID());
		}
		String sql = 
				"select "
						+ "dtl.*, "
						+ "promo.sPromoTheme, "
						+ "promo.sPromoName, "
						+ "promo.sPromoActionType, "
						+ "g.sGoodsDesc, "
						+ "b.sBrandName, "
						+ "c.sCategoryDesc "
				+ "from "
						+ "tYWPromoDtl dtl "
				+ "left join tYWPromoMain promo on promo.sPromoPaperNO = dtl.sPromoPaperNO "
				+ "left join tGoods g on g.nGoodsID = dtl.nGoodsID "
				+ "left join tBrand b on b.sBrandID = dtl.sBrandID "
				+ "left join tCategory c on c.sCategoryNO = dtl.sCategoryNO "
				+ StringUtil.join(" and ", " where ", "", strs);
		if(page == null){
			return jdbcTemplate.queryForList(sql, objs.toArray());
		}else{
			return jdbcTemplate.limit(sql, page, objs.toArray());	
		}
		
	}
	
	public List<Map<String, Object>> queryPromoDtls(TYWPromoDtl promoDtl) {
		List<String> strs = new ArrayList<String>();
		List<Object> objs = new ArrayList<Object>();
		strs.add("dtl.sPromoPaperNO = ?");
		objs.add(promoDtl.getsPromoPaperNO());
		strs.add("dtl.nTag = ?");
		objs.add(promoDtl.getnTag());
		String ruleSql = "select sPromoPaperNO,nRuleID,nMeetAmount,nDisRate,nDisAmount  from tYWPromoDtl dtl where dtl.sPromoPaperNO = ? and dtl.nTag = ? group by sPromoPaperNO,nRuleID,nMeetAmount,nDisRate,nDisAmount";
		List<Map<String,Object>> ruleList = jdbcTemplate.queryForList(ruleSql, objs.toArray());
		for(int i=0;i<ruleList.size();i++){
			Map<String,Object> rule = ruleList.get(i);
			strs = new ArrayList<String>();
			objs = new ArrayList<Object>();
			strs.add("dtl.sPromoPaperNO = ?");
			objs.add(promoDtl.getsPromoPaperNO());
			strs.add("dtl.nTag = ?");
			objs.add(promoDtl.getnTag());
			strs.add("dtl.nRuleID = ?");
			objs.add(rule.get("nRuleID"));
			String sql = 
					"select "
							+ "dtl.*, "
							+ "promo.sPromoTheme, "
							+ "promo.sPromoName, "
							+ "promo.sPromoActionType, "
							+ "g.sGoodsDesc, "
							+ "b.sBrandName, "
							+ "c.sCategoryDesc "
					+ "from "
							+ "tYWPromoDtl dtl "
					+ "left join tYWPromoMain promo on promo.sPromoPaperNO = dtl.sPromoPaperNO "
					+ "left join tGoods g on g.nGoodsID = dtl.nGoodsID "
					+ "left join tBrand b on b.sBrandID = dtl.sBrandID "
					+ "left join tCategory c on c.sCategoryNO = dtl.sCategoryNO "
					+ StringUtil.join(" and ", " where ", "", strs);
			
			List<Map<String,Object>> promoList = jdbcTemplate.queryForList(sql, objs.toArray());
			rule.put("promoList", promoList);
		}
		return ruleList;
	}
	
	public Map<String, Object> queryAmountPyRuleID(TYWPromoDtl promoDtl) {
		String sql = "select nDisAmount, nMeetAmount, nDisRate from tYWPromoDtl where sPromoPaperNO = ? and nRuleID = ?";
		List<Map<String, Object>> list = jdbcTemplate.queryForList(sql, promoDtl.getsPromoPaperNO(), promoDtl.getnRuleID());
		if(list != null && list.size() > 0) {
			return list.get(0);
		} else {
			return null;
		}
	}

	public List<Map<String, Object>> queryContractsByOrgNO(String sOrgNO) {
		String sql = "select distinct sAgentContractNO from tAgentContract where sOrgNO = '" + sOrgNO + "'";
		return jdbcTemplate.queryForList(sql);
	}

	public boolean validateRuleID(TYWPromoDtl promoDtl) {
		Integer countRuleID = jdbcTemplate.queryForInt("select count(*) from tYWPromoDtl where sPromoPaperNO = ? and sAgentContractNO = ? and nRuleID = ?", promoDtl.getsPromoPaperNO(), promoDtl.getsAgentContractNO(), promoDtl.getnRuleID());
		if(countRuleID > 0) {
			String sql = "select count(*) from (select * from tYWPromoDtl where sPromoPaperNO = ? and sAgentContractNO = ? and nRuleID = ? and nMeetAmount = ? and (nDisAmount = ? or nDisRate = ? or (nPrice = ? and nPoint = ?))) as_count";
			Integer count = jdbcTemplate.queryForInt(sql, promoDtl.getsPromoPaperNO(), promoDtl.getsAgentContractNO(), promoDtl.getnRuleID(), promoDtl.getnMeetAmount(), promoDtl.getnDisAmount(), promoDtl.getnDisRate(), promoDtl.getnPrice(), promoDtl.getnPoint());
			return count > 0;
		} else {
			return true;
		}
	}

	public List<Map<String, Object>> queryBWlist(TYWPromoMain promo, Page page) {
		String sql = "select bw.nTag bw_nTag, bw.sShopNO, s.sShopName, pm.* from tPromoCustBWList bw left join tShop s on s.sShopNO = bw.sShopNO left join tYWPromoMain pm on pm.sPromoPaperNO = bw.sPromoPaperNO where bw.sPromoPaperNO = ?";
		return jdbcTemplate.limit(sql, page, promo.getsPromoPaperNO());
	}

	public List<Map<String, Object>> queryShopByOrgNO(String sOrgNO, Page page) {
		String sql = "select s.*, c.sCustName from tShop s left join tCustomer c on c.sCustNO = s.sCustNO where s.sOrgNO = '" + sOrgNO + "'";
		return jdbcTemplate.limit(sql, page);
	}

	public List<Map<String, Object>> queryGifts(TYWPromoMain promo, Page page) {
		String sql =  
				"select "
						+ "dtl.*, "
						+ "promo.sPromoTheme, "
						+ "promo.sPromoName, "
						+ "promo.sPromoActionType, "
						+ "g.sGoodsDesc "
				+ "from "
						+ "tYWPromoDtl dtl "
				+ "left join "
						+ "tYWPromoMain promo on promo.sPromoPaperNO = dtl.sPromoPaperNO "
				+ "left join "
						+ "tGoods g on g.nGoodsID = dtl.nGoodsID "
				+ "where "
						+ "dtl.nTag = 1 and dtl.sPromoPaperNO = ?";
		return jdbcTemplate.limit(sql, page, promo.getsPromoPaperNO());
	}

	public boolean validateGiftRuleID(String sPromoPaperNO, Integer nRuleID) {
		Integer count = jdbcTemplate.queryForInt("select count(*) from tYWPromoDtl where sPromoPaperNO = ? and nTag = 1 and nRuleID = ?", sPromoPaperNO, nRuleID);
		return count == 0;
	}
	
	private static final Map<String, String> BW_TYPE = new HashMap<String, String>();
	private static final Map<String, String> LIMIT_TYPE = new HashMap<String, String>();
	private static final Map<String, String> SETTING_MODE = new HashMap<String, String>();
	private static final String[] sTerminalTypesID = new String[]{"WX", "WEB", "AndroidApp", "IOSApp"};
	private static final String[] sTerminalTypes = new String[]{"微信端", "网页端", "Android端App", "IOS苹果端App"};
	private static final Integer[] terminalTypes = new Integer[]{1, 2, 4, 8};
	static {
		BW_TYPE.put("A", "不限制");
		BW_TYPE.put("B", "黑名单");
		BW_TYPE.put("W", "白名单");
		LIMIT_TYPE.put("0", "不限制");
		LIMIT_TYPE.put("1", "每个用户在活动期限内只能参与一次");
		LIMIT_TYPE.put("2", "每个用户在活动期限内每天只能参与一次");
		SETTING_MODE.put("A", "全部商品");
		SETTING_MODE.put("G", "商品");
		SETTING_MODE.put("B", "品牌");
		SETTING_MODE.put("C", "分类");
	}

	public void flush(String sPromoPaperNO) {
		String sUser = SecurityContextUtil.getUserName();
		Date now = new Date();
		TYWPromoMain promoMain = new TYWPromoMain();
		promoMain.setsPromoPaperNO(sPromoPaperNO);
		promoMain = (TYWPromoMain)jdbcTemplate.queryForBeanByPk(promoMain);
		String sPromoActionNO = null;
		try {
			sPromoActionNO = jdbcTemplate.queryForString("select sPromoActionNO from tPromo where sPromoPaperNO = ?", promoMain.getsPromoPaperNO());
		} catch (Exception e) {
			U.logger.error(e, e);
			sPromoActionNO = promoMain.getsOrgNO() + DateUtil.format(now, "yyyyMMdd");
			TPromoPlan tPromoPlan = new TPromoPlan();
			tPromoPlan.setSPromoActionNO(sPromoActionNO);
			tPromoPlan.setSPaperNO(getNumber("sPaperNO", "W00000000000000"));
			tPromoPlan.setSPromoTheme(sPromoActionNO + "WEB端促销数据");
			tPromoPlan.setSMemo(sPromoActionNO + "WEB端促销数据");
			tPromoPlan.setNTag(2);
			tPromoPlan.setDPromoBeginDate(DateUtil.parse(DateUtil.format(promoMain.getdPromoBeginDate(), "yyyy-MM-dd"), "yyyy-MM-dd"));
			tPromoPlan.setDPromoBeginTime(DateUtil.parse(DateUtil.format(promoMain.getdPromoBeginDate(), "HH:mm:ss"), "HH:mm:ss"));
			tPromoPlan.setDPromoEndDate(DateUtil.parse(DateUtil.format(promoMain.getdPromoEndDate(), "yyyy-MM-dd"), "yyyy-MM-dd"));
			tPromoPlan.setDPromoEndTime(DateUtil.parse(DateUtil.format(promoMain.getdPromoEndDate(), "HH:mm:ss"), "HH:mm:ss"));
			tPromoPlan.setSCreateUser(sUser);
			tPromoPlan.setSConfirmUser(sUser);
			tPromoPlan.setDConfirmDate(now);
			tPromoPlan.setDCreateDate(now);
			tPromoPlan.setDLastUpdateTime(now);
			try {
				jdbcTemplate.save(tPromoPlan);
			} catch (Exception e1) {
				U.logger.error(e1, e1);
			}
		}
		clearErpData(sPromoPaperNO);
		List<TYWPromoDtl> promoDtls = jdbcTemplate.queryForBeans("select * from tYWPromoDtl where sPromoPaperNO = ?", TYWPromoDtl.class, sPromoPaperNO);
		TPromo promo = To.mapTo(To.toMap(promoMain), TPromo.class);
		String sPromoActionType = (String)promoMain.getsPromoActionType();
		String sPromoActionTypeID = (String)promoMain.getsPromoActionTypeID();
		Integer nTerminalTypeID = (Integer)promoMain.getnTerminalTypeID();
		String sLimitTypeID = To.objTo(promoMain.getnPromoJoinType(), String.class, null);
		String sAgentContractNO = promoMain.getsAgentContractNO();
		promo.setSLimitTypeID(sLimitTypeID);
		promo.setNAgentID(queryAgentID(sAgentContractNO));
		promo.setSPromoActionNO(sPromoActionNO);
		promo.setSLimitType(LIMIT_TYPE.get(sLimitTypeID));
		promo.setSBWListType(BW_TYPE.get(promoMain.getsBWListTypeID()));
		promo.setSSettingMode(SETTING_MODE.get(promoMain.getsSettingModeID()));
		jdbcTemplate.save(promo);
		for(int i = 0; i < terminalTypes.length; i++) {
			Integer terminalType = terminalTypes[i];
			if((nTerminalTypeID&terminalType) == terminalType) {
				TPromoTerminal promoTerminal = new TPromoTerminal();
				promoTerminal.setSPromoPaperNO(sPromoPaperNO);
				promoTerminal.setSTerminalType(sTerminalTypes[i]);
				promoTerminal.setSTerminalTypeID(sTerminalTypesID[i]);
				promoTerminal.setSCreateUser(sUser);
				promoTerminal.setSConfirmUser(sUser);
				promoTerminal.setNTag(2);
				promoTerminal.setDConfirmDate(now);
				promoTerminal.setDCreateDate(now);
				promoTerminal.setDLastUpdateTime(now);
				jdbcTemplate.save(promoTerminal);
			}
		}
		for(TYWPromoDtl promoDtl : promoDtls) {
			TPromoSetting promoSetting = new TPromoSetting();
			promoSetting.setSPromoPaperNO(sPromoPaperNO);
			promoSetting.setNItem(queryItemID(sPromoPaperNO));
			promoSetting.setSAgentContractNO(promoDtl.getsAgentContractNO());
			promoSetting.setSCategoryNO(promoDtl.getsCategoryNO());
			promoSetting.setSBrandID(promoDtl.getsBrandID());
			promoSetting.setNGoodsID(promoDtl.getnGoodsID());
			promoSetting.setSMemo("WEB");
			promoSetting.setSCreateUser(sUser);
			promoSetting.setSConfirmUser(sUser);
			promoSetting.setDConfirmDate(now);
			promoSetting.setDCreateDate(now);
			promoSetting.setDLastUpdateTime(now);
			promoSetting.setNTag(2);
			jdbcTemplate.save(promoSetting);
			TPromoRuleGoods ruleGoods = To.mapTo(To.toMap(promoDtl), TPromoRuleGoods.class);
			ruleGoods.setSPromoActionType(sPromoActionType);
			ruleGoods.setSPromoActionTypeID(sPromoActionTypeID);
			ruleGoods.setSRuleDesc(promoMain.getsPromoActionType());
			ruleGoods.setSMemo(promoMain.getsPromoActionType());
			ruleGoods.setSCreateUser(sUser);
			ruleGoods.setSConfirmUser(sUser);
			ruleGoods.setDConfirmDate(now);
			ruleGoods.setDCreateDate(now);
			ruleGoods.setDLastUpdateTime(now);
			ruleGoods.setNTag(2);
			jdbcTemplate.save(ruleGoods);
		}
		jdbcTemplate.executeUpdate("update tYWPromoMain set nTag = 2 where sPromoPaperNO = ? and nTag = 0", sPromoPaperNO);
		setSync(sPromoPaperNO, 1);
	}

	private void clearErpData(String sPromoPaperNO) {
		Map<String, Object> objMap = new HashMap<String, Object>();
		objMap.put("sPromoPaperNO", sPromoPaperNO);
		jdbcTemplate.delete("tPromoCustBWList", objMap);
		jdbcTemplate.delete("tPromoTerminal", objMap);
		jdbcTemplate.delete("tPromoGoods", objMap);
		jdbcTemplate.delete("tPromoSetting", objMap);
		jdbcTemplate.delete("tPromoRuleGoods", objMap);
		jdbcTemplate.delete("tPromo", objMap);
	}
	
	private Integer queryAgentID(String sAgentContractNO) {
		return jdbcTemplate.queryForInt("select nAgentID from tAgentContract where sAgentContractNO = ?", sAgentContractNO);
	}

	public Integer queryRuleGiftCount(String sPromoPaperNO, Integer nRuleID) {
		return jdbcTemplate.queryForInt("select count(*) from tYWPromoDtl where sPromoPaperNO = ? and nRuleID = ? and nTag = 1", sPromoPaperNO, nRuleID);
	}
	
	private Integer queryItemID(String sPromoPaperNO) {
		return jdbcTemplate.queryForInt("select isnull(max(nItem), 0) + 1 from tPromoSetting where sPromoPaperNO = ?", sPromoPaperNO);
	}

	public void saveGiftPromoDtl(String jsonStr) {
		Date now = new Date();
		Map<String, Object> obj = Json.toMap(jsonStr);
		String sPromoPaperNO = (String)obj.get("sPromoPaperNO");
		Map<String, Object> objMap = new HashMap<String, Object>();
		objMap.put("sPromoPaperNO", sPromoPaperNO);
		jdbcTemplate.delete("tYWPromoDtl", objMap);
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(sPromoPaperNO);
		promo = (TYWPromoMain)queryByPk(promo);
		List<?> objArray = (List<?>)obj.get("objArray");
		Integer nRuleID = 0;
		for(Object o : objArray) {
			nRuleID++;
			Map<String, Object> omap = (Map)o;
			TYWPromoDtl promoDtl = U.mapTo(omap, TYWPromoDtl.class);
			promoDtl.setnRuleID(nRuleID);
			promoDtl.setnTag(1);
			promoDtl.setsPromoPaperNO(promo.getsPromoPaperNO());
			promoDtl.setsAgentContractNO(promo.getsAgentContractNO());
			String sUser = SecurityContextUtil.getUserName();
			promoDtl.setsConfirmUser(sUser);
			promoDtl.setsCreateUser(sUser);
			promoDtl.setdConfirmDate(now);
			promoDtl.setdCreateDate(now);
			promoDtl.setdLastUpdateTime(now);
			save(promoDtl);
			if(promo.getsSettingModeID().equals("A")) {
				Map<String, Object> dtlMap = U.toMap(promoDtl);
				TYWPromoDtl dtl = U.mapTo(dtlMap, TYWPromoDtl.class);
				dtl.setnTag(0);
				dtl.setnLimitQty(null);
				dtl.setnMaxLimitQty(null);
				dtl.setnMeetAmount(null);
				dtl.setnPrice(null);
				dtl.setnPoint(null);
				dtl.setnGoodsID(null);
				save(dtl);
			} else {
				List<?> ids = (List<?>)omap.get("ids");
				for(Object oid : ids) {
					String sid = (String)oid;
					Map<String, Object> dtlMap = U.toMap(promoDtl);
					TYWPromoDtl dtl = U.mapTo(dtlMap, TYWPromoDtl.class);
					dtl.setnTag(0);
					dtl.setnLimitQty(null);
					dtl.setnMaxLimitQty(null);
					dtl.setnMeetAmount(null);
					dtl.setnPrice(null);
					dtl.setnPoint(null);
					dtl.setnGoodsID(null);
					if(promo.getsSettingModeID().equals("G")) {
						dtl.setnGoodsID(U.objTo(sid, Integer.class));
					} else if(promo.getsSettingModeID().equals("B")) {
						dtl.setsBrandID(sid);
					} else if(promo.getsSettingModeID().equals("C")) {
						dtl.setsCategoryNO(sid);
					}
					save(dtl);
				}
			}
		}
		setSync(sPromoPaperNO, 0);
	}
	
	public void  savePromoDtl(String sPromoPaperNO,String sAgentContractNO ,List<TYWPromoDtl> tYWPromoDtlList){
		Map<String,Object> delMap = new HashMap<String,Object>();
		delMap.put("sPromoPaperNO", sPromoPaperNO);
		delMap.put("sAgentContractNO", sAgentContractNO);
		int i = jdbcTemplate.delete("tYWPromoDtl", delMap);
		
		if(tYWPromoDtlList != null && tYWPromoDtlList.size()>0){
			jdbcTemplate.batchSave(tYWPromoDtlList);
		} 
		setSync(sPromoPaperNO, 0);
	}

	public void setSync(String sPromoPaperNO, int nSync) {
		TYWPromoExtends ex = new TYWPromoExtends();
		ex.setsPromoPaperNO(sPromoPaperNO);
		ex.setnSync(nSync);
		jdbcTemplate.merge(ex);
	}

	public void saveEx(TYWPromoDtl ex, Integer[] ids) {
		for(Integer id : ids) {
			ex.setnGoodsID(id);
			jdbcTemplate.save(ex);
		}
	}
	
	
	
	
	public List<Map<String, Object>> queryPromosPicSet(TYWPromoPicSet promoPicSet, List<String> orgs, Page page) {
		List<Object> args = new ArrayList<Object>();
		List<String> strs = new ArrayList<String>();
		if(U.isNotEmpty(promoPicSet.getsOrgNO())){
			strs.add(" ps.sOrgNO = '"+promoPicSet.getsOrgNO()+"' ");
		}else{
			if(orgs == null || orgs.size() == 0) {
				return null;
			} else {
				strs.add(" ps.sOrgNO in (" + StringUtil.join("', '", "'", "'", orgs) + ")");
			} 
		}
		
		if(U.isNotEmpty(promoPicSet.getsDisplayNO())){
			strs.add(" ps.sDisplayNO = '"+promoPicSet.getsDisplayNO()+"' ");
		} 
		
		strs.add(" ps.nTag = 0 ");
 
		return jdbcTemplate.limit("SELECT * FROM tYWPromoPicSet ps " + StringUtil.join(" and ", " where ", strs), page, args.toArray());
	}

	public List<Map<String, Object>> queryPromosPicSetByOrgAndDisplayNo(TYWPromoPicSet promoPicSet){
		String sql = "select * from tYWPromoPicSet where  sOrgNO = '"+promoPicSet.getsOrgNO()+"' AND sDisplayNO = '"+promoPicSet.getsDisplayNO()+"'  AND nTag != 1 ";
		return jdbcTemplate.queryForList(sql);
	}
}
