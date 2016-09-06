/**
 *  Copyright (c) 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.member.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.plugin.util.Rjx;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.member.api.group.GroupApi;
import com.egolm.member.api.perm.PermissionApi;
import com.egolm.member.domain.group.Group;
import com.egolm.member.domain.role.Role;
import com.egolm.member.domain.throwables.MemberException;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @author coyzeng@gmail.com
 */
@Controller
@RequestMapping("/member/group")
public class GroupController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	private GroupApi groupApi;
	@Resource
	private PermissionApi permApi;

	@RequestMapping("/index")
	public ModelAndView index(String groupId, Integer page, Integer pageSize) {
		ModelAndView mv = new ModelAndView("member/group/list.jsp");
		if (StringUtils.isBlank(groupId)) {
			groupId = "all";
		}
		try {
			List<Role> roles = groupApi.queryRolesUnderGroup(groupId, page, pageSize);
			mv.addObject("roles", roles);
		} catch (MemberException e) {
			logger.error("", e);
		} catch (Throwable e) {
			logger.error("", e);
		}
		mv.addObject("groupId", groupId);
		return mv;
	}

	@ResponseBody
	@RequestMapping("/queryAll")
	public Rjx queryAll() {
		try {
			List<Group> groups = groupApi.queryAllGroups();
			return Rjx.jsonOk().set("groups", groups);
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping(value = "/create", method = { RequestMethod.GET })
	public ModelAndView createPage(String groupId) {
		ModelAndView mv = new ModelAndView("member/group/create.jsp");
		mv.addObject("groupId", StringUtils.isNotBlank(groupId) ? groupId : "00");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/create", method = { RequestMethod.POST })
	public Rjx createAction(Group group) {
		try {
			String userId = SecurityContextUtil.getUserName();
			groupApi.createGroup(userId, group);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping(value = "/modify", method = { RequestMethod.GET })
	public String modifyPage() {
		return "member/group/modify.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = { RequestMethod.POST })
	public Rjx modifyAction(Group group) {
		try {
			groupApi.modifyGroup(group);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping(value = "/delete", method = { RequestMethod.GET })
	public String deletePage() {
		return "member/group/delete.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = { RequestMethod.POST })
	public Rjx deleteAction(String groupId) {
		try {
			groupApi.deleteGroup(groupId);
			return Rjx.jsonOk();
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping(value = "/info", method = { RequestMethod.GET })
	public String infoPage() {
		return "member/group/info.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/info", method = { RequestMethod.POST })
	public Rjx infoAction(String groupId) {
		try {
			groupApi.queryAllGroups();
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
	@RequestMapping(value = "/allocateRoles", method = { RequestMethod.POST })
	public Rjx allocateRoles(String groupId, String[] roleIds) {
		try {
			groupApi.allocateRoles(groupId, roleIds);
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
	@RequestMapping(value = "/removeRoles", method = { RequestMethod.POST })
	public Rjx removeRoles(String groupId, String[] roleIds) {
		try {
			groupApi.removeRoles(groupId, roleIds);
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
	@RequestMapping(value = "/modifyPerms", method = { RequestMethod.POST })
	public Rjx modifyPerms(String groupId, String[] permIds) {
		try {
			List<String> permissionIds = ArrayUtils.isEmpty(permIds) ? new ArrayList<String>() : Arrays.asList(permIds);
			permApi.groupAuthorization(Arrays.asList(groupId), permissionIds);
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
	@RequestMapping("/authorization")
	public Rjx groupAuthorization(String[] groupIds, String[] permissionIds) {
		try {
			List<String> permIds = ArrayUtils.isEmpty(permissionIds) ? new ArrayList<String>() : Arrays.asList(permissionIds);
			permApi.groupAuthorization(Arrays.asList(groupIds), permIds);
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
