<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
</style>
<form action="post" method="post" id="TplCreateForm">
	<input type="hidden" name="tplpage.nTplPageID" value="${tplpage.nTplPageID}">
	<dl>
		<dt><label>模板名称：</label></dt>
		<dd><input type="text" id="tplpage_sPageName" name="tplpage.sPageName" value="${tplpage.sPageName}"/></dd>
	</dl>
	<dl>
		<dt><label>模板宽度：</label></dt>
		<dd><input type="text" name="tplpage.nWidth" ${not empty tplpage ? 'readonly':''} value="${not empty tplpage ? tplpage.nWidth : '1000'}"/></dd>
	</dl>
	<dl>
		<dt><label>模板状态：</label></dt>
		<dd>
			<select name="tplpage.nTag">
				<option value="0">未使用</option>
				<option <c:if test="${not empty tplpage && tplpage.nTag eq 1}">selected</c:if> value="1">使用</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>模板类型：</label></dt>
		<dd>
			<select name="tplpage.sPageTypeID">
				<option value="A">专区页面</option>
				<option <c:if test="${not empty tplpage && tplpage.sPageTypeID eq 'M'}">selected</c:if> value="M">区域主页</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>店铺类型：</label></dt>
		<dd>
			<select name="tplpage.nScopeTypeID">
				<c:forEach items="${scopes}" var="scope">
					<option <c:if test="${not empty tplpage && tplpage.nScopeTypeID eq scope.sScopeTypeID}">selected</c:if> value="${scope.sScopeTypeID}">${scope.sScopeType}</option>
				</c:forEach>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>终端类型：</label></dt>
		<dd>
			<select name="tplpage.nTerminalTypeID">
				<option value="1">微信</option>
				<option <c:if test="${not empty tplpage && tplpage.nTerminalTypeID  eq 2}">selected</c:if> value="2">WEB</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>作用区域：</label></dt>
		<dd>
			<select name="tplpage.sOrgNO">
				<c:forEach var="org" items="${orgs}" varStatus="status" >
					<option <c:if test="${status.index == 0}">selected</c:if> value="${org.sOrgNO}">${org.sOrgDesc}</option>
				</c:forEach>
			</select>
		</dd>
	</dl>
</form>