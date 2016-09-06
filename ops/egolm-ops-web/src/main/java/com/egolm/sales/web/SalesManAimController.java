/**
 * Copyright (c) Jul 13, 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.sales.web;

import java.util.Arrays;

import javax.annotation.Resource;

import org.springframework.plugin.util.Rjx;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmLogger;
import com.egolm.domain.TSalesManAim;
import com.egolm.sales.api.metadata.SalesManMetadataApi;

/**
 * @author coyzeng@gmail.com
 *
 */
@Controller
@RequestMapping("/salesman/aim")
public class SalesManAimController {

	@Resource
	private SalesManMetadataApi metadataApi;

	@RequestMapping("/index")
	public ModelAndView index() {
		ModelAndView mv = new ModelAndView("/sales/aim.jsp");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/create", method = { RequestMethod.POST })
	public Rjx create(TSalesManAim aim, String[] salesIds) {
		try {
			metadataApi.createTask(Arrays.asList(salesIds), aim);
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
			metadataApi.createTask(null, null);
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = { RequestMethod.POST })
	public Rjx delete(String[] aimIds) {
		try {
			metadataApi.deleteTask(Arrays.asList(aimIds));
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/modify", method = { RequestMethod.POST })
	public Rjx modify(TSalesManAim aim) {
		try {
			metadataApi.modifyTask(aim);
			return Rjx.jsonOk();
		} catch (Throwable e) {
			EgolmLogger.SalesLogger.error("", e);
			return Rjx.jsonErr();
		}
	}
}
