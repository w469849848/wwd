/**
 * Copyright (c) Aug 8, 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.postsale.web;

import java.io.Writer;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.plugin.jdbc.PageResult;
import org.springframework.plugin.util.Egox;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmException;
import com.egolm.common.EgolmLogger;
import com.egolm.customer.api.PostSaleApi;
import com.egolm.customer.domain.vo.AdviceInfo;
import com.egolm.customer.domain.vo.AdviceQuery;
import com.egolm.domain.TAdvise;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @author coyzeng@gmail.com
 *
 */
@Controller
@RequestMapping("/postsale/advice")
public class AdviceController {

	@Resource
	private PostSaleApi postSaleApi;
	
	@RequestMapping("/index")
	public ModelAndView index(AdviceQuery query) {
		ModelAndView mv = new ModelAndView("postsale/advice-list.jsp");
		try {
			PageResult<AdviceInfo> result = postSaleApi.queryAdvices(query);
			mv.addObject("page", result);
			mv.addObject("advices", result.getDatas());
			mv.addObject("query", query);
		} catch (EgolmException e) {
			EgolmLogger.CustomerLogger.error(e.getMessage());
		} catch (Throwable e) {
			EgolmLogger.CustomerLogger.error("", e);
		}
		return mv;
	}
	
	@RequestMapping(value = "/reply", method = {RequestMethod.GET})
	public ModelAndView replyView(Integer adviceId) {
		ModelAndView mv = new ModelAndView("postsale/advice-reply.jsp");
		if (null == adviceId) {
			return mv;
		}
		try {
			List<AdviceInfo> advices = postSaleApi.queryAdviceChain(adviceId);
			mv.addObject("advices", advices);
		} catch (EgolmException e) {
			EgolmLogger.CustomerLogger.error(e.getMessage());
		} catch (Throwable e) {
			EgolmLogger.CustomerLogger.error("", e);
		}
		return mv;
	}
	
	@RequestMapping(value = "/reply", method = {RequestMethod.POST})
	public void replyAction(TAdvise advice, Writer writer) {
		try {
			String userName = SecurityContextUtil.getUserName();
			postSaleApi.replyAdvice(userName, advice);
			Egox.egoxOk().setReturnValue("回复成功").write(writer);
		} catch (EgolmException e) {
			EgolmLogger.CustomerLogger.error(e.getMessage());
			Egox.egoxErr().setReturnValue(e.getMessage()).write(writer);
		} catch (Throwable e) {
			EgolmLogger.CustomerLogger.error("", e);
			Egox.egoxErr().setReturnValue("系统异常").write(writer);
		}
	}
	
	@ResponseBody
	@RequestMapping("/chain")
	public void chain(Integer adviceId, Writer writer) {
		try {
			List<AdviceInfo> advices = postSaleApi.queryAdviceChain(adviceId);
			Egox.egoxOk().setReturnValue("回复成功").setDataList(advices).write(writer);
		} catch (EgolmException e) {
			EgolmLogger.CustomerLogger.error(e.getMessage());
			Egox.egoxErr().setReturnValue(e.getMessage()).write(writer);
		} catch (Throwable e) {
			EgolmLogger.CustomerLogger.error("", e);
			Egox.egoxErr().setReturnValue("系统异常").write(writer);
		}
	}
}
