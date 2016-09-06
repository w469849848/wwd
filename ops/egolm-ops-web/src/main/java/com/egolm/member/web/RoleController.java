/**
 *  Copyright (c) 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.member.web;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.ArrayUtils;
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

import com.egolm.member.api.group.GroupApi;
import com.egolm.member.api.perm.PermissionApi;
import com.egolm.member.api.role.RoleApi;
import com.egolm.member.domain.role.Role;
import com.egolm.member.domain.role.RoleQuery;
import com.egolm.member.domain.throwables.MemberException;
import com.google.common.collect.Lists;

/**
 * @author coyzeng@gmail.com
 */
@Controller
@RequestMapping("/member/role")
public class RoleController {

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	private RoleApi roleApi;
	@Resource
	private GroupApi groupApi;
	@Resource
	private PermissionApi permApi;

	@RequestMapping("/index")
	public ModelAndView index(RoleQuery roleQuery) {
		ModelAndView mv = new ModelAndView("member/role/list.jsp");
		mv.addObject("query", roleQuery);
		mv.addObject("page", new PageResult<Role>());
		try {
			PageResult<Role> roles = roleApi.queryRoles(roleQuery);
			mv.addObject("roles", roles.getDatas());
			mv.addObject("page", roles);
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
	@RequestMapping(value = "/queryRoles", method = { RequestMethod.POST })
	public Rjx queryRoles(String userId, RoleQuery roleQuery) {
		try {
			List<Role> ownRoles = Lists.newArrayList();
			if (StringUtils.isNotBlank(userId)) {
				roleQuery.setIndex(1);
				roleQuery.setLimit(Integer.MAX_VALUE);
				List<Role> rs = roleApi.queryRolesBindOnUser(userId);
				ownRoles.addAll(rs);
			}
			PageResult<Role> roles = roleApi.queryRoles(roleQuery);
			return Rjx.jsonOk().set("roles", roles.getDatas()).set("ownRoles", ownRoles);
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr().set("code", e.getError().getCode());
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().set("code", 0);
		}
	}

	@RequestMapping(value = "/queryRolesUnderGroup", method = { RequestMethod.POST })
	public ModelAndView queryRolesUnderGroup(RoleQuery roleQuery) {
		ModelAndView mv = new ModelAndView("member/group/role.jsp");
		mv.addObject("query", roleQuery);
		try {
			if (null != roleQuery && !"0".equals(roleQuery.getGroupId())) {
				PageResult<Role> roles = roleApi.queryRoles(roleQuery);
				mv.addObject("roles", roles.getDatas());
				mv.addObject("page", roles);
			}else{
				mv.addObject("page", new PageResult<Role>());
			}
			return mv;
		} catch (MemberException e) {
			logger.error("", e);
		} catch (Throwable e) {
			logger.error("", e);
		}
		return mv;
	}


	@RequestMapping(value = "/create", method = { RequestMethod.GET })
	public String createPage(Role role) {
		return "member/role/create.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/create", method = { RequestMethod.POST })
	public Rjx createAction(Role role) {
		try {
			roleApi.createRole(role);
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
	@RequestMapping(value = "/delete", method = { RequestMethod.POST })
	public Rjx deleteAction(String[] roleIds) {
		try {
			roleApi.deleteRoles(Arrays.asList(roleIds));
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
	public String modifyPage(Role role) {
		return "member/role/modify.jsp";
	}

	@ResponseBody
	@RequestMapping(value = "/modify", method = { RequestMethod.POST })
	public Rjx modifyAction(Role role) {
		try {
			roleApi.modifyRole(role);
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
	@RequestMapping("/bindGroup")
	public Rjx authorization(String roleId, String resourcesId) {
		try {
			roleApi.bindOrganization(roleId, Arrays.asList(resourcesId));
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
	@RequestMapping("/allocateUsers")
	public Rjx allocateUsers(String roleId, String[] userIds) {
		try {
			roleApi.allocateUsers(roleId, userIds);
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
	@RequestMapping("/removeUsers")
	public Rjx removeUsers(String roleId, String... userIds) {
		try {
			roleApi.removeUsers(roleId, userIds);
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
	public Rjx roleAuthorization(String[] roleIds, String[] permissionIds) {
		try {
			if (ArrayUtils.isEmpty(roleIds)) {
				return Rjx.jsonErr();
			}
			if (ArrayUtils.isEmpty(permissionIds)) {
				permissionIds = new String[0];
			}
			permApi.roleAuthorization(Arrays.asList(roleIds), Arrays.asList(permissionIds));
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
