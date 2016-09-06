package com.egolm.promo;

import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.U;
import org.springframework.plugin.web.As;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONObject;
import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.domain.TPromoCustBWList;
import com.egolm.domain.TYWPromoDtl;
import com.egolm.domain.TYWPromoMain;
import com.egolm.promo.service.PromoServiceImpl;
import com.egolm.security.utils.SecurityContextUtil;
import com.google.gson.Gson;

@Controller
@RequestMapping("/promotion")
public class PromoController {

	@Autowired
	private TOrgsQueryApi  tOrgsQueryApi;
	@Autowired
	private PromoServiceImpl PromoServiceImpl;
	
	@RequestMapping("/list")
	public String list(@As("page")Page page, @As("promo")TYWPromoMain promo, String searchText, HttpServletRequest request) {
		if(page == null) {
			page = new Page();
		}
		page.setLimit(20);
		page.setLimitKey("sPromoPaperNO desc");
		List<String> orgs = SecurityContextUtil.getRegionIds();
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromos(promo, orgs, searchText, page);
		for(Map<String, Object> data : datas) {
			List<String> TerminalType = new ArrayList<String>();
			Integer nTerminalTypeID = U.objTo(data.get("nTerminalTypeID"), Integer.class, 0);
			if ((nTerminalTypeID & 1) == 1 || nTerminalTypeID == 0) {
				TerminalType.add("微信");
			}
			if ((nTerminalTypeID & 2) == 2 || nTerminalTypeID == 0) {
				TerminalType.add("网页");
			}
			if ((nTerminalTypeID & 4) == 4 || nTerminalTypeID == 0) {
				TerminalType.add("安卓");
			}
			if ((nTerminalTypeID & 8) == 8 || nTerminalTypeID == 0) {
				TerminalType.add("苹果");
			}
			data.put("sTerminalType", StringUtil.join(",", TerminalType));
		}
		request.setAttribute("page", page);
		request.setAttribute("datas", datas);
		request.setAttribute("searchText", searchText);
		return "/promo/promo-list.jsp";
	}
	
	@RequestMapping("/add")
	public String add(@As("promo")TYWPromoMain promo, HttpServletRequest request) {
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		if(promo != null) {
			Integer nTerminalTypeID = promo.getnTerminalTypeID();
			Integer nUseCycle = promo.getnUseCycle();
			List<Integer> terminals = new ArrayList<Integer>();
			List<Integer> cycles = new ArrayList<Integer>();
			Integer[] terminalTypeID = {1, 2, 4, 8};
			Integer[] useCycle = {1, 2, 4, 8, 16, 32, 64};
			for(int i = 0; i < terminalTypeID.length; i++) {
				if((nTerminalTypeID&terminalTypeID[i]) == terminalTypeID[i]) {
					terminals.add(terminalTypeID[i]);
				}
			}
			for(int i = 0; i < useCycle.length; i++) {
				if((nUseCycle&useCycle[i]) == useCycle[i]) {
					cycles.add(useCycle[i]);
				}
			}
			request.setAttribute("terminals", terminals);
			request.setAttribute("cycles", cycles);
		}
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		List<Map<String, Object>> orgs = tOrgsQueryApi.queryTOrgs(regionIds, 4);
		request.setAttribute("orgs", orgs);
		request.setAttribute("promo", promo);
		return "/promo/promo-add.jsp";
	}
	
	@RequestMapping("/save")
	public void save(@As("promo")TYWPromoMain promo, Integer[] nTerminalTypeID, Integer[] nUseCycle, Writer writer) {
		Date now = new Date();
		Integer TerminalTypeID = 0;
		Integer UseCycle = 0;
		if (nTerminalTypeID != null) {
			for(Integer n : nTerminalTypeID) {
				TerminalTypeID = TerminalTypeID|n;
			}
		}
		if (nUseCycle != null) {
			for(Integer n : nUseCycle) {
				UseCycle = UseCycle|n;
			}
		}
		String sUser = SecurityContextUtil.getUserName();
		promo.setdConfirmDate(now);
		promo.setdCreateDate(now);
		promo.setsConfirmUser(sUser);
		promo.setsCreateUser(sUser);
		promo.setnTag(0);
		promo.setnTerminalTypeID(TerminalTypeID);
		promo.setnUseCycle(UseCycle);
		promo.setdLastUpdateTime(now);
		if("1".equals(promo.getsPromoActionTypeID()) || "2".equals(promo.getsPromoActionTypeID())) {
			promo.setsSettingModeID("G");
		}
		if(StringUtil.isNotBlank(promo.getsPromoPaperNO())) {
			PromoServiceImpl.updatePromo(promo);
		} else {
			String sPromoPaperNO = PromoServiceImpl.queryMaxPromoID();
			promo.setsPromoPaperNO(PromoServiceImpl.queryMaxPromoID());
			PromoServiceImpl.save(promo);
			PromoServiceImpl.setSync(sPromoPaperNO, 0);
		}
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/del")
	public void del(@As("promo")TYWPromoMain promo, Writer writer) {
		promo.setnTag(3);
		PromoServiceImpl.merge(promo);
		PromoServiceImpl.flush(promo.getsPromoPaperNO());
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/view")
	public String view(@As("promoDtl")TYWPromoDtl promoDtl, @As("page")Page page, HttpServletRequest request) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("sGroupNO", "nRuleID", "nGoodsID", "sBrandID", "sCategoryNO");
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromoDtls(promoDtl, page);
		request.setAttribute("promo", promo);
		request.setAttribute("promoDtl", promoDtl);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		return "/promo/promo-dtl-list.jsp";
	}
	
	@RequestMapping("/selectDtl")
	public String selectDtl(@As("page")Page page, @As("promo")TYWPromoMain promo, String searchText, Integer nRuleID, HttpServletRequest request) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = null;
		if(promo.getsSettingModeID().equals("G")) {
			page.setLimitKey("nGoodsID");
			datas = PromoServiceImpl.queryGoodsByOrgNo(promo, searchText, page);
		} else if(promo.getsSettingModeID().equals("B")) {
			page.setLimitKey("sBrandID");
			datas = PromoServiceImpl.queryBrandsByOrgNo(promo, searchText, page);
		} else if(promo.getsSettingModeID().equals("C")) {
			page.setLimitKey("sCategoryNO");
			datas = PromoServiceImpl.queryCategorysByOrgNo(promo, searchText, page);
		}
		request.setAttribute("promo", promo);
		request.setAttribute("nRuleID", nRuleID);
		request.setAttribute("page", page);
		request.setAttribute("datas", datas);
		request.setAttribute("searchText", searchText);
		return "/promo/promo-dtl-select.jsp";
	}
	
	@RequestMapping("/addDtl")
	public String addDtl(@As("promoDtl")TYWPromoDtl promoDtl, HttpServletRequest request) {
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		request.setAttribute("promoDtl", promoDtl);
		request.setAttribute("promo", promo);
		return "/promo/promo-dtl-add.jsp";
	}
	
	@RequestMapping("/saveDtl")
	public void saveDtl(@As("promoDtl")TYWPromoDtl promoDtl, Writer writer) {
		Date now = new Date();
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		String sUser = SecurityContextUtil.getUserName();
		
		promoDtl.setsAgentContractNO(promo.getsAgentContractNO());
		promoDtl.setsCreateUser(sUser);
		promoDtl.setsConfirmUser(sUser);
		promoDtl.setdConfirmDate(now);;
		promoDtl.setdCreateDate(now);
		promoDtl.setdLastUpdateTime(now);
		promoDtl.setnTag(0);
		
		if(promo.getsPromoActionTypeID().equals("2")) {
			promoDtl.setnAmount(promoDtl.getnMeetQty().multiply(promoDtl.getnPrice()));
		}
		PromoServiceImpl.save(promoDtl);
		PromoServiceImpl.setSync(promoDtl.getsPromoPaperNO(), 0);
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/delDtl")
	public void delDtl(@As("promoDtl")TYWPromoDtl promoDtl, Writer writer) {
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		Map<String, Object> objMap = new HashMap<String, Object>();
		if(StringUtil.isNotBlank(promoDtl.getsPromoPaperNO())) {
			objMap.put("sPromoPaperNO", promoDtl.getsPromoPaperNO());
			objMap.put("sAgentContractNO", promoDtl.getsAgentContractNO());
			objMap.put("nTag", promoDtl.getnTag());
			if(StringUtil.isNotBlank(promoDtl.getsGroupNO())) {
				objMap.put("sGroupNO", promoDtl.getsGroupNO());
			} else if(promoDtl.getnRuleID() != null) {
				objMap.put("nRuleID", promoDtl.getnRuleID());
			}
			if(promoDtl.getnGoodsID() != null) {
				objMap.put("nGoodsID", promoDtl.getnGoodsID());
			} else if(StringUtil.isNotBlank(promoDtl.getsCategoryNO())) {
				objMap.put("sCategoryNO", promoDtl.getsCategoryNO());
			} else if(StringUtil.isNotBlank(promoDtl.getsBrandID())) {
				objMap.put("sBrandID", promoDtl.getsBrandID());
			}
			PromoServiceImpl.delete("tYWPromoDtl", objMap);
			PromoServiceImpl.setSync(promoDtl.getsPromoPaperNO(), 0);
		}
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/queryAmountByRuleID")
	public void queryAmountByRuleID(@As("promoDtl")TYWPromoDtl promoDtl, Writer writer) {
		Map<String, Object> data = PromoServiceImpl.queryAmountPyRuleID(promoDtl);
		Egox.egoxOk(data).write(writer);
	}
	
	@RequestMapping("/queryContractsByOrgNO")
	public void queryContractsByOrgNo(String sOrgNO, Writer writer) {
		List<Map<String, Object>> contracts = PromoServiceImpl.queryContractsByOrgNO(sOrgNO);
		Egox.egoxOk(contracts).write(writer);
	}
	
	@RequestMapping("/validateRuleID")
	public void validateRuleID(@As("promoDtl")TYWPromoDtl promoDtl, Writer writer) {
		if(PromoServiceImpl.validateRuleID(promoDtl))  {
			Egox.egoxOk().write(writer);
		} else {
			Egox.egoxErr().write(writer);
		}
	}
	
	@RequestMapping("/bwList")
	public String bwList(@As("page")Page page, @As("promo")TYWPromoMain promo, HttpServletRequest request) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("sShopNO");
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryBWlist(promo, page);
		request.setAttribute("promo", promo);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		return "/promo/promo-bw-list.jsp";
	}
	
	@RequestMapping("/bwSelect")
	public String promoBwSelect(@As("page")Page page, @As("promo")TYWPromoMain promo, HttpServletRequest request) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("sShopNO");
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryShopByOrgNO(promo.getsOrgNO(), page);
		request.setAttribute("promo", promo);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		return "/promo/promo-bw-select.jsp";
	}
	
	@RequestMapping("/bwSave")
	public void bwSave(@As("bw")TPromoCustBWList bw, Writer writer) {
		Date now = new Date();
		String sUser = SecurityContextUtil.getUserName();
		bw.setNTag(2);
		bw.setSConfirmUser(sUser);
		bw.setSCreateUser(sUser);
		bw.setDConfirmDate(now);
		bw.setDCreateDate(now);
		bw.setDLastUpdateTime(now);
		PromoServiceImpl.save(bw);
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/bwDel")
	public void bwDel(@As("bw")TPromoCustBWList bw, Writer writer) {
		Map<String, Object> objMap = new HashMap<String, Object>();
		objMap.put("sPromoPaperNO", bw.getSPromoPaperNO());
		objMap.put("sShopNO", bw.getSShopNO());
		PromoServiceImpl.delete("tPromoCustBWList", objMap);
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/exList")
	public String exList(@As("page")Page page, @As("promoDtl")TYWPromoDtl promoDtl, HttpServletRequest request) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("sGroupNO", "nRuleID", "nGoodsID", "sBrandID", "sCategoryNO");
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromoDtls(promoDtl, page);
		request.setAttribute("promo", promo);
		request.setAttribute("promoDtl", promoDtl);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		return "/promo/promo-ex-list.jsp";
	}
	
	@RequestMapping("/exSelect")
	public String exSelect(@As("page")Page page, @As("promo")TYWPromoMain promo, String searchText, HttpServletRequest request) {
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("nGoodsID");
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryExGoods(promo, searchText, page);
		request.setAttribute("promo", promo);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		request.setAttribute("searchText", searchText);
		return "/promo/promo-ex-select.jsp";
	}
	
	@RequestMapping("/exSearch")
	public void exSearch(@As("page")Page page, @As("promo")TYWPromoMain promo, String searchText, HttpServletRequest request, Writer writer) {
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("nGoodsID");
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryExGoods(promo, searchText, page);
		Egox.egoxOk().set("promo", promo).set("datas", datas).set("page", page).set("indexs", page.getPageIndexs()).write(writer);
	}
	
	@RequestMapping("/exSave")
	public void exSave(@As("ex")TYWPromoDtl ex, String ids, Writer writer) {
		List<?> list = new Gson().fromJson(ids, List.class);
		List<Integer> ilist = new ArrayList<Integer>();
		for(Object obj : list) {
			ilist.add(U.objTo(obj, Integer.class));
		}
		Date now = new Date();
		String sUser = SecurityContextUtil.getUserName();
		ex.setnTag(2);
		ex.setsConfirmUser(sUser);
		ex.setsCreateUser(sUser);
		ex.setdConfirmDate(now);
		ex.setdCreateDate(now);
		ex.setdLastUpdateTime(now);
		PromoServiceImpl.saveEx(ex, ilist.toArray(new Integer[ilist.size()]));
		PromoServiceImpl.setSync(ex.getsPromoPaperNO(), 0);
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/giftList")
	public String giftList(@As("page")Page page, @As("promo")TYWPromoMain promo, HttpServletRequest request) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("nGoodsID");
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryGifts(promo, page);
		request.setAttribute("promo", promo);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		return "/promo/promo-gift-list.jsp";
	}
	
	@RequestMapping("/giftSelect")
	public String giftSelect(@As("page")Page page, @As("promo")TYWPromoMain promo, String searchText, HttpServletRequest request) {
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		page = page == null ? new Page() : page;
		page.setLimit(20);
		page.setLimitKey("nGoodsID");
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = PromoServiceImpl.queryGoodsByOrgNo(promo, searchText, page);
		request.setAttribute("promo", promo);
		request.setAttribute("datas", datas);
		request.setAttribute("page", page);
		request.setAttribute("searchText", searchText);
		return "/promo/promo-gift-select.jsp";
	}
	
	@RequestMapping("/giftAdd")
	public String giftAdd(@As("promoDtl")TYWPromoDtl promoDtl, HttpServletRequest request) {
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		request.setAttribute("promo", promo);
		request.setAttribute("promoDtl", promoDtl);
		return "/promo/promo-gift-add.jsp";
	}
	
	@RequestMapping("/saveGift")
	public void saveGift(@As("promoDtl")TYWPromoDtl promoDtl, Writer writer) {
		Date now = new Date();
		String sUser = SecurityContextUtil.getUserName();
		promoDtl.setsConfirmUser(sUser);
		promoDtl.setsCreateUser(sUser);
		promoDtl.setdConfirmDate(now);
		promoDtl.setdCreateDate(now);
		promoDtl.setdLastUpdateTime(now);
		TYWPromoMain promo = new TYWPromoMain();
		promo.setsPromoPaperNO(promoDtl.getsPromoPaperNO());
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		promoDtl.setnTag(1);
		PromoServiceImpl.save(promoDtl);
		if(promo.getsSettingModeID().equals("A")) {
			promoDtl.setnGoodsID(null);
			promoDtl.setsBrandID(null);
			promoDtl.setsCategoryNO(null);
			promoDtl.setnTag(0);
			promoDtl.setnMeetAmount(null);
			promoDtl.setnMeetQty(null);
			promoDtl.setnPoint(null);
			promoDtl.setnPrice(null);
			promoDtl.setnLimitQty(null);
			promoDtl.setnMaxLimitQty(null);
			promoDtl.setnAmount(null);
			promoDtl.setnDisAmount(null);
			promoDtl.setnDisRate(null);
			PromoServiceImpl.save(promoDtl);
		}
		PromoServiceImpl.setSync(promoDtl.getsPromoPaperNO(), 0);
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/delGift")
	public void delGift(@As("promoDtl")TYWPromoDtl promoDtl, Writer writer) {
		Map<String, Object> objMap = new HashMap<String, Object>();
		objMap.put("nTag", 1);
		objMap.put("sPromoPaperNO", promoDtl.getsPromoPaperNO());
		objMap.put("sAgentContractNO", promoDtl.getsAgentContractNO());
		objMap.put("nGoodsID", promoDtl.getnGoodsID());
		objMap.put("nRuleID", promoDtl.getnRuleID());
		objMap.put("nMeetAmount", promoDtl.getnMeetAmount());
		objMap.put("nPrice", promoDtl.getnPrice());
		objMap.put("nPoint", promoDtl.getnPoint());
		objMap.put("nLimitQty", promoDtl.getnLimitQty());
		objMap.put("nMaxLimitQty", promoDtl.getnMaxLimitQty());
		PromoServiceImpl.delete("tYWPromoDtl", objMap);
		Integer count = PromoServiceImpl.queryRuleGiftCount(promoDtl.getsPromoPaperNO(), promoDtl.getnRuleID());
		if(count == 0) {
			objMap.clear();
			objMap.put("sPromoPaperNO", promoDtl.getsPromoPaperNO());
			PromoServiceImpl.delete("tYWPromoDtl", objMap);
		}
		PromoServiceImpl.setSync(promoDtl.getsPromoPaperNO(), 0);
		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/flush")
	public void flush(String sPromoPaperNO, Writer writer) {
		try {
			PromoServiceImpl.flush(sPromoPaperNO);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			U.logger.error(e, e);
			Egox.egoxErr().write(writer);
		}
	}
	
	@RequestMapping("/setting")
	public String setting(@As("promo")TYWPromoMain promo, HttpServletRequest request) {
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		request.setAttribute("promo", promo);
		request.setAttribute("sTerminalType", getsTerminalType(promo.getnTerminalTypeID()));
		if(promo.getsPromoActionTypeID().equals("1") || promo.getsPromoActionTypeID().equals("2")) {
			batch(request);
		} else if(promo.getsPromoActionTypeID().equals("4") || promo.getsPromoActionTypeID().equals("5")) {
			fullcut(request);
		} else if(promo.getsPromoActionTypeID().equals("6")) {
			gift(promo, request);
		} else if(promo.getsPromoActionTypeID().equals("3")) {
			group(request);
		}
		return "/promo/setting.jsp";
	}
	
	private void batch(HttpServletRequest request) {
		TYWPromoMain tYWPromoMain = (TYWPromoMain)request.getAttribute("promo");
		
		TYWPromoDtl tYWPromoDtl = new TYWPromoDtl();
		tYWPromoDtl.setsPromoPaperNO(tYWPromoMain.getsPromoPaperNO());
		tYWPromoDtl.setnTag(0);
		
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromoDtls(tYWPromoDtl, null);
		request.setAttribute("promoDtlList", datas); 
	}
	
	private void fullcut(HttpServletRequest request) {
		TYWPromoDtl promoDtl = new TYWPromoDtl(); 
		promoDtl.setsPromoPaperNO(request.getParameter("promo.sPromoPaperNO"));
		promoDtl.setnTag(0);
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromoDtls(promoDtl);
		request.setAttribute("resultDatas", datas);
	}
	
	public void gift(TYWPromoMain promo, HttpServletRequest request) {
		TYWPromoDtl promoDtl = new TYWPromoDtl();
		promoDtl.setsPromoPaperNO(promo.getsPromoPaperNO());
		promoDtl.setnTag(0);
		List<Map<String, Object>> datas = PromoServiceImpl.queryPromoDtls(promoDtl, null);
		promoDtl.setnTag(1);
		List<Map<String, Object>> gifts = PromoServiceImpl.queryPromoDtls(promoDtl, null);
		request.setAttribute("datas", datas);
		request.setAttribute("gifts", gifts);
	}
	
	public void group(HttpServletRequest request) {
		
	}
	
	@RequestMapping("/select")
	public String select(@As("promo")TYWPromoMain promo, Boolean isGift, HttpServletRequest request) {
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		request.setAttribute("promo", promo);
		request.setAttribute("isGift", isGift);
		return "/promo/select.jsp";
	}
	
	@RequestMapping("/search")
	public void search(@As("page")Page page, @As("promo")TYWPromoMain promo, Boolean isGift, String searchText, Writer writer) {
		page = page == null ? new Page() : page;
		page.setLimit(20);
		promo = (TYWPromoMain)PromoServiceImpl.queryByPk(promo);
		List<Map<String, Object>> datas = null;
		if(promo.getsSettingModeID().equals("G") || (isGift != null && isGift.booleanValue() == true)) {
			page.setLimitKey("nGoodsID");
			datas = PromoServiceImpl.queryGoodsByOrgNo(promo, searchText, page);
		} else if(promo.getsSettingModeID().equals("B")) {
			page.setLimitKey("sBrandID");
			datas = PromoServiceImpl.queryBrandsByOrgNo(promo, searchText, page);
		} else if(promo.getsSettingModeID().equals("C")) {
			page.setLimitKey("sCategoryNO");
			datas = PromoServiceImpl.queryCategorysByOrgNo(promo, searchText, page);
		}
		Egox.egoxOk().set("promo", promo).set("datas", datas).set("page", page).set("indexs", page.getPageIndexs()).write(writer);
	}
	
	private String getsTerminalType(Integer nTerminalTypeID) {
		List<String> TerminalType = new ArrayList<String>();
		if ((nTerminalTypeID & 1) == 1 || nTerminalTypeID == 0) {
			TerminalType.add("微信");
		}
		if ((nTerminalTypeID & 2) == 2 || nTerminalTypeID == 0) {
			TerminalType.add("网页");
		}
		if ((nTerminalTypeID & 4) == 4 || nTerminalTypeID == 0) {
			TerminalType.add("安卓");
		}
		if ((nTerminalTypeID & 8) == 8 || nTerminalTypeID == 0) {
			TerminalType.add("苹果");
		}
		return StringUtil.join(",", TerminalType);
	}
	
	/**
	 * 批量添加促销活动详细信息
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/saveBatchDtl")
	public void saveBatchDtl(HttpServletRequest request, Writer writer){
		String jsonStr = ServletUtil.readReqJson(request);
		JSONObject jsonObject = JSONObject.parseObject(jsonStr); 
		String sPromoPaperNO = (String)jsonObject.get("sPromoPaperNO");
		String sAgentContractNO = (String)jsonObject.get("sAgentContractNO");
		
		List<TYWPromoDtl> tYWPromoDtlList = new ArrayList<TYWPromoDtl>();
		List promoDtlList = (List)jsonObject.get("PromoDtlList");
		if(promoDtlList != null && promoDtlList.size()>0){
			for(int i = 0;i<promoDtlList.size();i++){
				 JSONObject promoDtlJson = (JSONObject)promoDtlList.get(i);
				 Map<String, Object> map = U.toMap(promoDtlJson);
				 TYWPromoDtl tYWPromoDtl = U.mapTo(map,TYWPromoDtl.class);
				 tYWPromoDtl.setsPromoPaperNO(sPromoPaperNO);
				 tYWPromoDtl.setsAgentContractNO(sAgentContractNO);
				 tYWPromoDtl.setsCreateUser(SecurityContextUtil.getUserName());
				 tYWPromoDtl.setdCreateDate(new Date());
				 tYWPromoDtl.setdConfirmDate(new Date());
				 tYWPromoDtl.setsConfirmUser(SecurityContextUtil.getUserName());
				 tYWPromoDtl.setdLastUpdateTime(new Date());
				 tYWPromoDtlList.add(tYWPromoDtl);
			}
		}
		PromoServiceImpl.savePromoDtl(sPromoPaperNO, sAgentContractNO, tYWPromoDtlList);

		Egox.egoxOk().write(writer);
	}
	
	@RequestMapping("/saveGifts")
	public void saveGifts(HttpServletRequest request, Writer writer){
		String jsonStr = ServletUtil.readReqJson(request);
		PromoServiceImpl.saveGiftPromoDtl(jsonStr);
		Egox.egoxOk().write(writer);
	}
}
