/**
 * Copyright (c) Jul 13, 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.sales.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.ServletUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmLogger;
import com.egolm.sales.api.report.SalesManReportApi;

/**
 * @author coyzeng@gmail.com
 *
 */
@Controller
@RequestMapping("/salesman/report")
public class SalesManReportController {

	@Resource
	private SalesManReportApi salesManReportApi;

	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("/sales/report.jsp");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/aim", method = { RequestMethod.POST, RequestMethod.GET })
	public Rjx aim(HttpServletRequest request) {
		try {
			salesManReportApi.queryAimReports(ServletUtil.readReqMap(request));
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/dailyLine", method = { RequestMethod.POST, RequestMethod.GET })
	public Rjx dailyLine(HttpServletRequest request) {
		try {
			salesManReportApi.queryDailyLineReports(ServletUtil.readReqMap(request));
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}

}
