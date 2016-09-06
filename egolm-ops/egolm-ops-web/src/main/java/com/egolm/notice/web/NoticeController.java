package com.egolm.notice.web;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.plugin.exception.SIOException;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.notice.api.NoticeApi;
import com.egolm.notice.domain.OpsNotice;
import com.egolm.notice.enums.NoticeState;
import com.egolm.notice.throwables.NoticeException;
import com.egolm.security.utils.SecurityContextUtil;

@Controller
@RequestMapping("/api/notice")
public class NoticeController {
	@Resource
	private NoticeApi noticeApi;
	@Resource
	private TOrgsQueryApi orgApi;
	
	@InitBinder  
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}
	
	/**
	 * 跳转到列表页面
	 */
	@RequestMapping(value = "/index")
	public ModelAndView index() {
		return query(null, 1L, 10);
	}

	/**
	 * 查找公告
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/query")
	public ModelAndView query(String sNoticeTitle, Long index, Integer limit) {
		PageSqlserver pager = new PageSqlserver();
		pager.setIndex(null == index ? 1 : index);
		pager.setLimit(null == limit ? 10 : limit);
		pager.setLimitKey("dCreatedDate desc");
		Map<String, Object> params = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView("/notice/list.jsp");
		sNoticeTitle = StringUtils.trim(sNoticeTitle);
		mv.addObject("sNoticeTitle", sNoticeTitle);
		mv.addObject("page", pager);
		try {
			if (StringUtils.isNotBlank(sNoticeTitle)) {
				params.put("sNoticeTitle", sNoticeTitle);
			}
			Map<String, Object> resultmap = noticeApi.query(params, pager);
			List<Map<String, Object>> result = (List<Map<String, Object>>) resultmap.get("result");
			pager = U.objTo(resultmap.get("page"), PageSqlserver.class);
			mv.addObject("page", pager);
			mv.addObject("noticeList", result);
		} catch (SIOException e) {
			U.logger.error("公告查询出错，参数读取出错", e);
		} catch (Exception e) {
			U.logger.error("公告查询请求出错,", e);
		}
		return mv;
	}
	
	/**
	 * 跳转到添加页面
	 */
	@RequestMapping(value = "/toAdd")
	public ModelAndView toAdd() {
		ModelAndView mv = new ModelAndView("/notice/add.jsp");
		return mv;
	}
	/**
	 * 添加公告
	 */
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	@ResponseBody
	public Rjx add(OpsNotice notice) {
		if (null == notice || !StringUtils.isNoneBlank(notice.getSNoticeTitle(), notice.getSNoticeContent())) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		String userId = SecurityContextUtil.getUserId();
		String userName = SecurityContextUtil.getUserName();
		try {
			wrapperOrgInfo(notice);
			notice.setSUserId(userId);
			notice.setSUserName(userName);
			notice.setNTag(NoticeState.CREATE.getCode());
			notice.setSNoticeContent(StringUtils.trim(notice.getSNoticeContent()));
			noticeApi.add(notice);
			return Rjx.jsonOk();
		} catch (SIOException e) {
			U.logger.error("新增公告出错，参数读取出错", e);
			return Rjx.jsonErr();
		} catch (Exception e) {
			U.logger.error("新增公告请求出错,", e);
			return Rjx.jsonErr();
		}
	}
	
	
	/**
	 * 跳转到修改页面
	 */
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public ModelAndView toUpdate(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		String id=request.getParameter("sNoticeId");
		Map<String, Object> dataMap = this.noticeApi.queryById(id);
		map.put("dataMap", dataMap);
		ModelAndView mv = new ModelAndView("/notice/modify.jsp",map);
		return mv;
	}
	
	@RequestMapping("/delete")
	@ResponseBody
	public Rjx delete(String[] noticeIds) {
		if (ArrayUtils.isEmpty(noticeIds)) {
			return Rjx.jsonErr();
		}
		try {
			noticeApi.changeState(Arrays.asList(noticeIds), NoticeState.DELETE);
			return Rjx.jsonOk();
		} catch (NoticeException e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	/**
	 * 封装地区信息进公告
	 */
	private void wrapperOrgInfo(OpsNotice notice) {
		if (StringUtils.isNotBlank(notice.getSOrgNO())) {
			Map<String, Object> orgMap = orgApi.queryTOrg(notice.getSOrgNO());
			if (MapUtils.isEmpty(orgMap)) {
				throw new NoticeException("地区不存在");
			}
			notice.setSOrgDesc(String.valueOf(orgMap.get("sOrgDesc")));
		}
	}
	
	/**
	 * 修改公告
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public Rjx update(OpsNotice notice) {
		if (null == notice || StringUtils.isBlank(notice.getSNoticeId())) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		try {
			wrapperOrgInfo(notice);
			String userId = SecurityContextUtil.getUserId();
			String userName = SecurityContextUtil.getUserName();
			notice.setSUserId(userId);
			notice.setSUserName(userName);
			noticeApi.update(notice);
			return Rjx.jsonOk();
		} catch (SIOException e) {
			U.logger.error("修改公告出错", e);
			return Rjx.jsonErr();
		} catch (NoticeException e) {
			U.logger.error("修改公告出错", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			U.logger.error("修改公告出错", e);
			return Rjx.jsonErr();
		}
	}

}
