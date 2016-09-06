/**
 * Copyright (c) Jul 13, 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.sales.web;

import java.util.Arrays;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.plugin.jdbc.PageResult;
import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmLogger;
import com.egolm.sales.api.line.SalesManDailyLineApi;
import com.egolm.sales.api.line.SalesManTemplateApi;
import com.egolm.sales.domain.vo.CreateLineVO;
import com.egolm.sales.domain.vo.LineDetailVO;
import com.egolm.security.utils.SecurityContextUtil;

import me.chanjar.weixin.common.util.StringUtils;

/**
 * @author coyzeng@gmail.com
 *
 */
@Controller
@RequestMapping("/salesman/line")
public class SalesManLineController {

	@Resource
	private SalesManDailyLineApi dailyLineApi;
	@Resource
	SalesManTemplateApi salesManTemplateApi;

	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("/sales/line.jsp");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/query", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView query(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("/sales/line_list.jsp");
		try {
			Map<String, Object> param = ServletUtil.readReqMap(request);
			PageResult<LineDetailVO> lines = dailyLineApi.queryAllDailyLines4WEB(param);
			mv.addObject("lines", lines);
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/create", method = { RequestMethod.GET })
	public ModelAndView create() {
		ModelAndView mv = new ModelAndView("/sales/line_add.jsp");
		try {
			Map<String, Object> tpls = salesManTemplateApi.findAllTemplates(null, null);
			mv.addObject("tpls", tpls);
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/create", method = { RequestMethod.POST })
	public Rjx create(String sLineName, String[] sShopNOs, String[] sTemplateIds, Integer[] nIndexs,
			String sRemark) {
		try {
			if (StringUtils.isBlank(sLineName) || ArrayUtils.isEmpty(sShopNOs) || ArrayUtils.isEmpty(sTemplateIds)) {
				return Rjx.jsonErr().setMessage("线路名、店铺不能为空");
			}
			CreateLineVO vo = new CreateLineVO();
			vo.setsLineName(sLineName);
			vo.setsShopNOs(Arrays.asList(sShopNOs));
			vo.setsTemplateIds(Arrays.asList(sTemplateIds));
			vo.setnIndexs(Arrays.asList(nIndexs));
			vo.setsRemark(sRemark);
			vo.setsOrgNO(SecurityContextUtil.getRegionIds().get(0));
			dailyLineApi.createDailyLines(SecurityContextUtil.getUserName(), vo);
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/audit", method = { RequestMethod.POST })
	public Rjx audit(Integer state, String[] lineIds) {
		try {
			dailyLineApi.auditDailyLines(SecurityContextUtil.getUserId(), Arrays.asList(lineIds));
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = { RequestMethod.POST })
	public Rjx modify(String salesId, String[] lineIds) {
		try {
			dailyLineApi.allocateDailyLines(SecurityContextUtil.getUserId(), salesId, Arrays.asList(lineIds));
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = { RequestMethod.POST })
	public Rjx delete(String[] lineIds) {
		try {
			dailyLineApi.deleteDailyLines(SecurityContextUtil.getUserId(), Arrays.asList(lineIds));
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}

}
