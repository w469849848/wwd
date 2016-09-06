/**
 *  Copyright (c) 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.member.web;

import java.util.Arrays;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.plugin.jdbc.PageResult;
import org.springframework.plugin.util.Rjx;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.egolm.common.enums.Platform;
import com.egolm.common.enums.UserType;
import com.egolm.member.api.role.RoleApi;
import com.egolm.member.api.user.UserApi;
import com.egolm.member.domain.throwables.MemberException;
import com.egolm.member.domain.user.User;
import com.egolm.member.domain.user.UserQuery;
import com.egolm.security.common.AuthResult;
import com.egolm.security.common.SecurityConst;
import com.egolm.security.context.SecurityBean;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @author coyzeng@gmail.com
 */
@Controller
@RequestMapping("/member/user")
public class UserController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	private UserApi userApi;
	@Resource
	private RoleApi roleApi;
	@Resource
	private SecurityBean securityBean;

	@RequestMapping(value = {"/signinPage","/signin"})
	public ModelAndView signinPage(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("member/user/login.jsp");
		String userNameKey = securityBean.getUsernameParameter();
		String passwordKey = securityBean.getPasswordParameter();
		AuthResult authResult = (AuthResult) request.getAttribute(SecurityConst.AUTH_RESULT_KEY);
		mv.addObject("authResult", authResult);
		mv.addObject(userNameKey, request.getAttribute(userNameKey));
		mv.addObject(passwordKey, request.getAttribute(passwordKey));
		return mv;
	}
	
	@RequestMapping("/index")
	public ModelAndView index(UserQuery userQuery) {
		logger.info(JSON.toJSONString(userQuery));
		ModelAndView mv = new ModelAndView("/member/user/list.jsp");
		mv.addObject("query", userQuery);
		mv.addObject("page", new PageResult<User>());
		try {
			PageResult<User> users = userApi.queryUsers(userQuery);
			mv.addObject("users", users.getDatas());
			mv.addObject("page", users);
			mv.addObject("userTypes", UserType.values());
			logger.info(users.getPageIndexs() +"    "+users.getPageTotal() +"  "+users.getTotal());
			return mv;
		} catch (MemberException e) {
			logger.error("", e);
			return mv;
		} catch (Throwable e) {
			logger.error("", e);
			return mv;
		}
	}

	@ResponseBody
	@RequestMapping(value = "/queryUsersUnderRole", method = { RequestMethod.POST })
	public Rjx queryUsersUnderRole(String roleId, Integer page, Integer pageSize) {
		try {
			PageResult<User> users = roleApi.queryUsersUnderRole(roleId, 1, 10);
			return Rjx.jsonOk().set("users", users);
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/denied")
	public ModelAndView denied(HttpServletRequest request, HttpServletResponse response) {
		SecurityContextUtil.popHistoryLatest(true);
		String refer = SecurityContextUtil.popHistoryLatest(false);
		ModelAndView mv = new ModelAndView("/denied.jsp");
		mv.addObject("refer", StringUtils.isBlank(refer) ? "/" : refer);
		mv.addObject("index", "/");
		mv.addObject("message", "权限认证失败!");
		return mv;
	}

	@ResponseBody
	@RequestMapping("/signout")
	public Rjx signOut(String loginName) {
		try {
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping(value = "/signup", method = { RequestMethod.GET })
	public ModelAndView signUpPage(User user) {
		ModelAndView mv = new ModelAndView("/member/user/add.jsp");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/signup", method = { RequestMethod.POST })
	public Rjx signUp(User user) {
		try {
			userApi.signUp(user);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@ResponseBody
	@RequestMapping("/resetPassword")
	public Rjx resetPassword(String originPassword, String newPassword) {
		String userId = SecurityContextUtil.getUserId();
		try {
			userApi.resetPassword(Platform.OPS, userId, originPassword, newPassword);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping("/setPassword")
	public Rjx setPassword(String[] userIds, String newPassword) {
		String userId = SecurityContextUtil.getUserId();
		if (ArrayUtils.isEmpty(userIds) || StringUtils.isBlank(newPassword)) {
			return Rjx.jsonErr().set("message", "必须选择用户");
		}
		try {
			userApi.setPassword(userId, UserType.OPERATOR, Arrays.asList(userIds), newPassword);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping("/bindRole")
	public Rjx bindRole(String userId, String[] roleIds) {
		// String userId = SecurityContextUtil.getUserId();
		try {
			userApi.bindRole(userId, Arrays.asList(roleIds));
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping("/batchImportAgent")
	public Rjx batchImportAgent(String password) {
		try {
			userApi.batchGenerateAgentPassword(password);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
}
