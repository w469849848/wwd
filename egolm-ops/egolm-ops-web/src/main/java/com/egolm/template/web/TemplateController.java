package com.egolm.template.web;

import java.io.Writer;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;
import org.springframework.plugin.web.As;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.EgolmLogger;
import com.egolm.common.enums.TerminalType;
import com.egolm.config.core.reader.ConfigReader;
import com.egolm.config.core.utils.ConfigPath;
import com.egolm.domain.TTplCell;
import com.egolm.domain.TTplFloor;
import com.egolm.domain.TTplPage;
import com.egolm.domain.TTplTab;
import com.egolm.open.tpl.api.TplApi;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.template.service.TemplateServiceImpl;
import com.google.common.collect.Lists;

@Controller
@RequestMapping("/tpl")
public class TemplateController {

	@Resource
	private TOrgsQueryApi  tOrgsQueryApi;
	@Resource(name="TplApi")
	private TplApi tplApi;
	@Resource(name="templateServiceImpl")
	private TemplateServiceImpl templateServiceImpl;
	private String imagePath = ConfigReader.getProperty(ConfigPath.cpath("G:system.properties"), "pic.img.url", "");
	
	@RequestMapping("/get")
	public String get(@As("page")PageSqlserver page, Integer nScopeTypeID, Integer nTerminalTypeID, String queryKey, HttpServletRequest request) {
		if(page == null) {
			page = new PageSqlserver(1L, 15);
		}
		page.setLimitKey("nTplPageID");
		List<String> orgs = SecurityContextUtil.getRegionIds();
		List<Map<String, Object>> scopes = templateServiceImpl.queryScopeTypes();
		List<Map<String, Object>> tplpages = templateServiceImpl.queryTplPageList(orgs, nScopeTypeID, nTerminalTypeID, queryKey, page);
		for(Map<String, Object> map : tplpages) {
			Integer nTerminalTypeID_tmp = (Integer)map.get("nTerminalTypeID");
			String sTerminalType = "";
			if((nTerminalTypeID_tmp&1) == 1) {
				sTerminalType += "微信,";
			}
			if((nTerminalTypeID_tmp&2) == 2) {
				sTerminalType += "WEB,";
			}
			if((nTerminalTypeID_tmp&4) == 4) {
				sTerminalType += "Android,";
			}
			if((nTerminalTypeID_tmp&8) == 8) {
				sTerminalType += "IOS,";
			}
			map.put("sTerminalType", sTerminalType.substring(0, sTerminalType.length() - 1));
		}
		request.setAttribute("nTerminalTypeID", nTerminalTypeID);
		request.setAttribute("nScopeTypeID", nScopeTypeID);
		request.setAttribute("tplpages", tplpages);
		request.setAttribute("scopes", scopes);
		request.setAttribute("queryKey", queryKey);
		request.setAttribute("page", page);
		return "/template/template-list.jsp";
	}
	
	@RequestMapping("/clear")
	public String clear(HttpServletRequest request) {
		List<Map<String, Object>> scopes = templateServiceImpl.queryScopeTypes();
		List<String> orgs = SecurityContextUtil.getRegionIds();
		request.setAttribute("orgs", orgs);
		request.setAttribute("scopes", scopes);
		return "/template/template-clear.jsp";
	}
	
	@RequestMapping("/clearTpl")
	public void clearTpl(Integer nScopeTypeID, TerminalType terminalType, String sOrgNO, Writer writer) {
		try {
			tplApi.clearTpl(sOrgNO, nScopeTypeID, terminalType);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("刷新模板缓存失败", e);
			Egox.egoxErr("刷新模板缓存失败").write(writer);
		}
	}
	
	@RequestMapping("/add")
	public String add(Integer nTplPageID, HttpServletRequest request) {
		if (nTplPageID != null) {
			Map<String, Object> tplpage = templateServiceImpl.queryTplPageByID(nTplPageID);
			request.setAttribute("tplpage", tplpage);
		}
		List<Map<String, Object>> scopes = templateServiceImpl.queryScopeTypes();
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		try {
			List<Map<String, Object>> orgs = tOrgsQueryApi.queryTOrgs(regionIds, 4);
			request.setAttribute("orgs", orgs);
		} catch (Throwable e) {
			EgolmLogger.OpsLogger.error("", e);
			request.setAttribute("orgs", Lists.newArrayList());
		}
		request.setAttribute("scopes", scopes);
		return "/template/template-add.jsp";
	}
	
	@RequestMapping("/post")
	public void post(@As("tplpage")TTplPage tplpage, Writer writer) {
		try {
			if(tplpage.getnTag() == null) {
				tplpage.setnTag(0);
			} else if(tplpage.getnTag() == 1 && tplpage.getsPageTypeID().equals("M")) {
				templateServiceImpl.updateTplPageNTag0(tplpage.getsOrgNO(), tplpage.getnScopeTypeID(), tplpage.getnTerminalTypeID());
			}
			if(tplpage.getnTplPageID() == null) {
				templateServiceImpl.saveObject(tplpage);
			} else {
				templateServiceImpl.updateObject(tplpage);
			}
			templateServiceImpl.updateApStatusByPageID(tplpage.getnTplPageID(),tplpage.getnTag()+"");
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存页面模板失败", e);
			Egox.egoxErr("保存页面模板失败").write(writer);
		}
	}

	@RequestMapping("/edit")
	public String edit(Integer nTplPageID, HttpServletRequest request) {
		Map<String, Object> tplpage = templateServiceImpl.queryTplPageByID(nTplPageID);
		List<Map<String, Object>> floors = templateServiceImpl.queryTplFloorsByPageID(nTplPageID);
		List<Map<String, Object>> tabs = templateServiceImpl.queryTplTabsByPageID(nTplPageID);
		List<Map<String, Object>> cells = templateServiceImpl.queryTplCellsByPageID(nTplPageID);
		List<Map<String, Object>> adverts = templateServiceImpl.queryAdvertByPageID(nTplPageID);
		request.setAttribute("tplpage", tplpage);
		request.setAttribute("floors", floors);
		request.setAttribute("tabs", tabs);
		request.setAttribute("cells", cells);
		request.setAttribute("adverts", adverts);
		request.setAttribute("imagePath", imagePath);
		return "/template/template-edit.jsp";
	}
	
	@RequestMapping("/delete/{nTplPageID}")
	public void delete(@PathVariable("nTplPageID")Integer nTplPageID, Writer writer) {
		try {
			templateServiceImpl.removeTplPageByID(nTplPageID);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("删除页面模板失败", e);
			Egox.egoxErr("删除页面模板失败").write(writer);
		}
	}

	@RequestMapping("/floor/add")
	public String floorAdd(Integer nTplPageID, Integer nTplFloorID, HttpServletRequest request) {
		Map<String, Object> tplpage = templateServiceImpl.queryTplPageByID(nTplPageID);
		request.setAttribute("tplpage", tplpage);
		if(nTplFloorID != null) {
			Map<String, Object> floor = templateServiceImpl.queryTplFloorByID(nTplFloorID);
			request.setAttribute("floor", floor);
		}
		return "/template/template-floor-add.jsp";
	}
	
	@RequestMapping("/floor/post")
	public void floorPost(@As("floor")TTplFloor floor, Writer writer) {
		try {
			if(floor.getnTplFloorID() == null) {
				templateServiceImpl.saveObject(floor);
			} else {
				templateServiceImpl.updateObject(floor);
			}
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存楼层失败", e);
			Egox.egoxErr("保存楼层失败").write(writer);
		}
	}
	
	@RequestMapping("/floor/icon")
	public String floorIcon(Integer nTplFloorID, HttpServletRequest request) {
		Map<String, Object> floor = templateServiceImpl.queryTplFloorByID(nTplFloorID);
		request.setAttribute("floor", floor);
		List<Map<String, Object>> icons = templateServiceImpl.queryTplIconsByTypeID(1);
		request.setAttribute("icons", icons);
		return "/template/template-icon-add.jsp";
	}

	@RequestMapping("/floor/icon/post")
	public void floorIconPost(Integer nTplFloorID, String sTplIconUrl, Writer writer) {
		try {
			templateServiceImpl.updateFloorIcon(nTplFloorID, sTplIconUrl);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存图标失败", e);
			Egox.egoxErr("保存图标失败").write(writer);
		}
	}
	
	@RequestMapping("/floor/delete/{nTplFloorID}")
	public void floorDelete(@PathVariable("nTplFloorID")Integer nTplFloorID, Writer writer) {
		try {
			templateServiceImpl.removeTplFloorByID(nTplFloorID);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存删除失败", e);
			Egox.egoxErr("保存删除失败").write(writer);
		}
	}
	
	@RequestMapping("/tab/add")
	public String tabAdd(Integer nTplFloorID, Integer nTplTabID, HttpServletRequest request) {
		Map<String, Object> floor = templateServiceImpl.queryTplFloorByID(nTplFloorID);
		request.setAttribute("floor", floor);
		if(nTplTabID != null) {
			Map<String, Object> tab = templateServiceImpl.queryTplTabByID(nTplTabID);
			request.setAttribute("tab", tab);
		}
		return "/template/template-tab-add.jsp";
	}
	
	@RequestMapping("/tab/post")
	public void tabPost(@As("tab")TTplTab tab, Writer writer) {
		try {
			if(tab.getnTplTabID() == null) {
				templateServiceImpl.saveObject(tab);
			} else {
				templateServiceImpl.updateObject(tab);
			}
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存选项卡失败", e);
			Egox.egoxErr("保存选项卡失败").write(writer);
		}
	}
	
	@RequestMapping("/tab/delete")
	public void tabPost(Integer nTplTabID, Writer writer) {
		try {
			templateServiceImpl.removeTplTabByID(nTplTabID);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存选项卡失败", e);
			Egox.egoxErr("保存选项卡失败").write(writer);
		}
	}
	
	@RequestMapping("/floor/sort")
	public void sort(String data, Writer writer) {
		try {
			if(StringUtil.isNotBlank(data)) {
				if(data.endsWith(",")) {
					data = data.substring(0, data.length() - 1);
				}
				if(StringUtil.isNotBlank(data)) {
					String[] args = data.split(",");
					templateServiceImpl.sortFloor(args);
				}
			}
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("楼层排序错误", e);
			Egox.egoxErr("楼层排序错误").write(writer);
		}
	}
	
	@RequestMapping("/cell/add/{nTplTabID}")
	public String tabCell(@PathVariable("nTplTabID")Integer nTplTabID, HttpServletRequest request) {
		Map<String, Object> tab = templateServiceImpl.queryTplTabByID(nTplTabID);
		request.setAttribute("tab", tab);
		return "/template/template-cell-add.jsp";
	}
	
	@RequestMapping("/cell/post")
	public void cellPost(@As("cell")TTplCell cell, Writer writer) {
		try {
			templateServiceImpl.saveObject(cell);
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("保存单元格失败", e);
			Egox.egoxErr("保存单元格失败").write(writer);
		}
	}
	
	@RequestMapping("/adpos/add")
	public String dtlAdd(Integer nTplTabID, Integer nRowStart, Integer nColStart, HttpServletRequest request) {
		List<Map<String, Object>> scopes = templateServiceImpl.queryScopeTypes();
		Map<String, Object> cell = templateServiceImpl.queryTplCellByStartCell(nTplTabID, nRowStart, nColStart);
		Map<String, Object> tab = templateServiceImpl.queryTplTabByID(nTplTabID);
		if(cell != null) {
			Integer nApID = To.objTo(cell.get("nApID"), Integer.class, null);
			if(nApID != null) {
				Map<String, Object> adpos = templateServiceImpl.queryAdPosByID(nApID);
				List<Map<String, Object>> adverts = templateServiceImpl.queryAdvertsByApID(nApID);
				request.setAttribute("adpos", adpos);
				request.setAttribute("adverts", adverts);
			}
		}
		request.setAttribute("scopes", scopes);
		request.setAttribute("cell", cell);
		request.setAttribute("tab", tab);
		request.setAttribute("nRowStart", nRowStart);
		request.setAttribute("nColStart", nColStart);
		request.setAttribute("imagePath", imagePath);
		return "/template/template-dtl-add.jsp";
	}
	
	@RequestMapping("/adpos/search")
	public void queryAdpos(@As("page")PageSqlserver page, String searchText, Integer nTplPageID, String sApTypeID, Writer writer) {
		if(page == null) {
			page = new PageSqlserver(1L, 1000);
		}
		page.setLimitKey("nApID");
		String sOrgNO = templateServiceImpl.queryOrgNoByPageID(nTplPageID);
		List<Map<String, Object>> datas = templateServiceImpl.searchAdpos(page, sOrgNO, nTplPageID, sApTypeID, searchText);
		Egox.egoxOk(datas).set("page", page).write(writer);
	}
	
	@RequestMapping("/adpos/get")
	public void adposGet(Integer nApID, Writer writer) {
		List<Map<String, Object> > datas = templateServiceImpl.queryAdvertsByApID(nApID);
		Egox.egoxOk(datas).write(writer);
	}
	
	@RequestMapping("/adpos/post")
	public void adposPost(@As("cell")TTplCell cell, Writer writer) {
		try {
			if(cell.getnTplCellID() != null) {
				templateServiceImpl.updateObject(cell);
			} else {
				templateServiceImpl.saveObject(cell);
			}
			Egox.egoxOk().write(writer);
		} catch (Exception e) {
			EgolmLogger.OpsLogger.error("关联广告位失败", e);
			Egox.egoxErr("关联广告位失败").write(writer);
		}
	}

	public TemplateServiceImpl getTemplateServiceImpl() {
		return templateServiceImpl;
	}

	public void setTemplateServiceImpl(TemplateServiceImpl templateServiceImpl) {
		this.templateServiceImpl = templateServiceImpl;
	}

}
