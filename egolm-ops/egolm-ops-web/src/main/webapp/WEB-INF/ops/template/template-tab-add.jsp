<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
</style>
<form action="tab/post" method="post" id="TplTabCreateForm">
	<input type="hidden" name="tab.nTplFloorID" value="${floor.nTplFloorID}"/>
	<input type="hidden" name="tab.nTplPageID" value="${floor.nTplPageID}"/>
	<input type="hidden" name="tab.nTplTabID" value="${tab.nTplTabID}"/>
	<dl>
		<dt><label>选项卡名称：</label></dt>
		<dd><input id="tab_sTabName" type="text" name="tab.sTabName" value="${tab.sTabName}"/></dd>
	</dl>
	<dl>
		<dt><label>选项卡位置：</label></dt>
		<dd><input type="text" name="tab.nTabIndex" value="${empty tab.nTabIndex ? '1' : tab.nTabIndex}"/></dd>
	</dl>
	<dl>
		<dt><label>相对宽度：</label></dt>
		<dd><input type="text" name="tab.nColCount" ${not empty tab ? 'readonly' : ''} value="${empty tab.nColCount ? '1' : tab.nColCount}"/></dd>
	</dl>
	<dl>
		<dt><label>相对高度：</label></dt>
		<dd><input type="text" name="tab.nRowCount" ${not empty tab ? 'readonly' : ''} value="${empty tab.nRowCount ? '1' : tab.nRowCount}"/></dd>
	</dl>
	<dl>
		<dt><label>单元格内边距：</label></dt>
		<dd><input type="text" name="tab.nCellPadding" value="${empty tab.nCellPadding ? '0' : tab.nCellPadding}"/></dd>
	</dl>
	<dl>
		<dt><label>单元格外边距：</label></dt>
		<dd><input type="text" name="tab.nCellMargin" value="${empty tab.nCellMargin ? '0' : tab.nCellMargin}"/></dd>
	</dl>
	<dl>
		<dt><label>单元格显示边框：</label></dt>
		<dd>
			<select name="tab.nCellShowBorder">
				<option value="0">不显示单元格边框</option>
				<option <c:if test="${not empty tab && tab.nCellShowBorder == 1}">selectd</c:if> value="1">显示单元格边框</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>单元格边框颜色：</label></dt>
		<dd><input type="text" name="tab.sCellBorderColor" value="${empty tab.sCellBorderColor ? '#EEEEEE' : tab.sCellBorderColor}" /></dd>
	</dl>
	<dl>
		<dt><label>是否默认显示：</label></dt>
		<dd>
			<select name="tab.nCurrentTab">
				<option value="1">默认显示该选项卡</option>
				<option <c:if test="${not empty tab && tab.nCurrentTab == 0}">selectd</c:if> value="0">默认不显示该选项卡</option>
			</select>
		</dd>
	</dl>
</form>