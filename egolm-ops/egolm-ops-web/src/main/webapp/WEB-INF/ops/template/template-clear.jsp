<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
</style>
<form action="clearTpl" method="post" id="TplFlushForm">
	<dl>
		<dt><label>所属区域：</label></dt>
		<dd>
			<select name="sOrgNO">
				<c:forEach items="${orgs}" var="org">
					<option value="${org}">${org}</option>
				</c:forEach>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>店铺类型：</label></dt>
		<dd>
			<select name="nScopeTypeID">
				<c:forEach items="${scopes}" var="scope">
					<option value="${scope.sScopeTypeID}">${scope.sScopeType}</option>
				</c:forEach>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>终端类型：</label></dt>
		<dd>
			<select name="terminalType">
				<option value="WX">微信</option>
				<option value="WEB">WEB</option>
			</select>
		</dd>
	</dl>
</form>