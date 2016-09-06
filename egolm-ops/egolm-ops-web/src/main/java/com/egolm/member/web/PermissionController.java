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
import org.springframework.plugin.util.Json;
import org.springframework.plugin.util.Rjx;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.enums.Platform;
import com.egolm.member.api.perm.PermissionApi;
import com.egolm.member.domain.enums.MemberError;
import com.egolm.member.domain.enums.PermissionType;
import com.egolm.member.domain.perm.Permission;
import com.egolm.member.domain.perm.PermissionQuery;
import com.egolm.member.domain.throwables.MemberException;

/**
 * @author coyzeng@gmail.com
 */
@Controller
@RequestMapping("/member/permission")
public class PermissionController {

	/**
	 * @author coyzeng@gmail.com
	 */
	enum Unit {
		group, role, user,
	}

	private Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	private PermissionApi permApi;

	@RequestMapping("/index")
	public ModelAndView index(PermissionQuery permQuery) {
		return queryPerms(permQuery);
	}

	@RequestMapping(value = "/queryAll", method = { RequestMethod.GET })
	public ModelAndView queryAll() {
		ModelAndView mv = new ModelAndView("member/permission/list.jsp");
		try {
			List<Permission> perms = permApi.queryPlatformAllPerms(Platform.OPS, null);
			mv.addObject("permissions", perms);
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
	@RequestMapping(value = "/queryAll", method = { RequestMethod.POST })
	public Rjx queryAllAjax() {
		try {
			List<Permission> perms = permApi.queryAllPerms(null);
			return Rjx.jsonOk().set("permissions", perms);
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@RequestMapping("/queryPerms")
	public ModelAndView queryPerms(PermissionQuery permQuery) {
		ModelAndView mv = new ModelAndView("member/permission/list.jsp");
		mv.addObject("query", permQuery);
		mv.addObject("page", new PageResult<Permission>());
		try {
			List<Integer> versions = permApi.queryVersions(permQuery.getPlatform(), Integer.MAX_VALUE);
			PageResult<Permission> perms = permApi.queryPerms(permQuery);
			mv.addObject("permissions", perms.getDatas());
			mv.addObject("page", perms);
			mv.addObject("permTypes", PermissionType.values());
			mv.addObject("platforms", Platform.values());
			mv.addObject("versions", versions);
			return mv;
		} catch (MemberException e) {
			logger.error("", e);
			return mv;
		} catch (Throwable e) {
			logger.error("", e);
			return mv;
		}
	}

	@RequestMapping(value = "/queryPermsUnderGroup", method = { RequestMethod.POST })
	public ModelAndView queryPermissionUnderGroup(Platform platform, String groupId, String roleName, Integer page,
			Integer pageSize) {
		// if(null == platform) platform = Platform.OPS;
		ModelAndView mv = new ModelAndView("member/group/permission.jsp");
		try {
			List<Permission> perms = permApi.queryPermsByGroupId(platform, groupId);
			logger.info(Json.toJson(perms));
			mv.addObject("perms", perms);
			mv.addObject("roleName", roleName);
			mv.addObject("groupId", groupId);
			return mv;
		} catch (MemberException e) {
			logger.error("", e);
		} catch (Throwable e) {
			logger.error("", e);
		}
		return mv;
	}

	@RequestMapping(value = "/tree", method = { RequestMethod.GET })
	public ModelAndView permissionTreePage(Unit unit, String unitId) {
		ModelAndView mv = new ModelAndView("member/permission/tree.jsp");
		mv.addObject("unit", unit);
		mv.addObject("unitId", unitId);
		return mv;
	}
	
	@RequestMapping(value = "/create", method = { RequestMethod.GET })
	public ModelAndView createPage(Unit unit, String unitId) {
		ModelAndView mv = new ModelAndView("member/permission/tree.jsp");
		mv.addObject("unit", unit);
		mv.addObject("unitId", unitId);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/create", method = { RequestMethod.POST })
	public Rjx createAction(Permission perm) {
		if (null == perm || null == perm.getPlatform() || null == perm.getVersion()) {
			return Rjx.jsonErr().setMessage("参数错误");
		}
		try {
			permApi.createPerms(perm.getPlatform(), perm.getVersion(), Arrays.asList(perm));
			return Rjx.jsonOk().setMessage("增加权限成功");
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage(e.getMessage());
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage("系统异常");
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate", method = { RequestMethod.POST })
	public Rjx validate(Permission perm) {
		if (null == perm || null == perm.getPlatform() || null == perm.getVersion()) {
			return Rjx.jsonErr().setMessage("参数错误");
		}
		try {
			permApi.validate(perm.getPlatform(), perm.getId(), perm.getKeys(), perm.getVersion());
			return Rjx.jsonOk().setMessage("验证通过成功");
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage(e.getMessage());
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage("系统异常");
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/modify", method = { RequestMethod.POST })
	public Rjx modifyAction(Permission perm) {
		if (null == perm || StringUtils.isBlank(perm.getId())) {
			return Rjx.jsonErr().setMessage("参数错误");
		}
		try {
			permApi.modifyPerms(Arrays.asList(perm));
			return Rjx.jsonOk().setMessage("修改权限成功");
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage(e.getMessage());
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage("系统异常");
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = { RequestMethod.POST })
	public Rjx deleteAction(String[] permIds) {
		if (ArrayUtils.isEmpty(permIds)) {
			return Rjx.jsonErr().setMessage("参数错误");
		}
		try {
			permApi.deletePerms(Arrays.asList(permIds), true);
			return Rjx.jsonOk().setMessage("修改权限成功");
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage(e.getMessage());
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().setMessage("系统异常");
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/tree", method = { RequestMethod.POST })
	public Rjx permissionTreeAction(Platform platform, Unit unit, String unitId) {
		if (null == platform){
			platform = Platform.OPS;
		}
		try {
			List<Permission> perms = null;
			List<Permission> ownPerms = null;
			if (Unit.group.equals(unit)) {
				ownPerms = permApi.queryPermsByGroupId(platform, unitId);
				perms = permApi.queryMaxPermsOfGroup(platform, unitId);
			} else if (Unit.role.equals(unit)) {
				ownPerms = permApi.queryPermsByRoleId(platform, unitId);
				perms = permApi.queryMaxPermOfRole(platform, unitId);
			} else if (Unit.user.equals(unit)) {
				ownPerms = permApi.queryPermsByUserId(platform, unitId);
				perms = permApi.queryMaxPermOfRole(platform, unitId);
			} else {
				throw MemberException.instance(MemberError.PARAMETER_INVALID);
			}
			return Rjx.jsonOk().set("permissions", perms).set("ownPermissions", ownPerms);
		} catch (MemberException e) {
			logger.error("", e);
			return Rjx.jsonErr();
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr();
		}
	}
	
	@ResponseBody
	@RequestMapping("/active")
	public Rjx activePermission(String[] permIds) {
		try {
			permApi.activePerm(Arrays.asList(permIds));
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
	@RequestMapping("/freeze")
	public Rjx freezePermission(String[] permIds) {

		try {
			permApi.freezePerm(Arrays.asList(permIds));
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
