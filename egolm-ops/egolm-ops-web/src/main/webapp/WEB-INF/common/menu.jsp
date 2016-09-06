<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%-- 菜单数据在 WEB项目/resources/data/下定义 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>

<div class="sidebar" id="sidebar">
	<ul class="nav nav-list">
		<c:forEach var="topMenu" items="${e:topMenus()}">
			<e:authorize key="${topMenu.keys}" path="${topMenu.url}">
				<li class="${topMenu.name eq currentTopMenu ? 'open' : ''}">
					<a href="/${serverName}${topMenu.url}" class="dropdown-toggle">
						<i class="icon ${topMenu.icon}" aria-hidden="true"></i>
						<span class="menu-text">${topMenu.name}</span>
						<b class="arrow"></b>
					</a>
					<ul class="submenu" style="${topMenu.name eq currentTopMenu ? 'display: block;' : ''}">
						<c:forEach var="subMenu" items="${e:subMenus(topMenu.id)}">
							<e:authorize key="${subMenu.keys}" path="${subMenu.url}">
								<li><a href="/${serverName}${subMenu.url}">${subMenu.name}</a></li>
							</e:authorize>
						</c:forEach>
					</ul>
				</li>
			</e:authorize>
		</c:forEach>
	</ul>
	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="fa icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
	</div>
</div>
