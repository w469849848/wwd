<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	dt{float:left;width:140px;}
	dd input,select {width:300px;}
</style>
<form action="floor/post" method="post" id="TplFloorCreateForm">
	<input type="hidden" name="floor.nTplPageID" value="${tplpage.nTplPageID}"/>
	<input type="hidden" name="floor.nTplFloorID" value="${floor.nTplFloorID}"/>
	<dl>
		<dt><label>楼层顺序：</label></dt>
		<dd><input type="text" name="floor.nFloorIndex" value="${floor.nFloorIndex}"/></dd>
	</dl>
	<dl>
		<dt><label>楼层名称：</label></dt>
		<dd><input id="floor_nFloorTitle" type="text" name="floor.sFloorTitle" value="${floor.sFloorTitle}"/></dd>
	</dl>
	<dl>
		<dt><label>楼层类型：</label></dt>
		<dd>
			<select name="floor.sFloorType">
				<option <c:if test="${empty floor || floor.sFloorType eq 'TAB'}">selected="selected"</c:if> value="TAB">选项卡</option>
				<option <c:if test="${not empty floor && floor.sFloorType eq 'SCROLL'}">selected="selected"</c:if> value="SCROLL">幻灯片</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>楼层宽度：</label></dt>
		<dd><input type="text" name="floor.nFloorWidth" value="${tplpage.nWidth}" readonly="readonly"/></dd>
	</dl>
	<dl>
		<dt><label>楼层高度：</label></dt>
		<dd><input id="floor_nFloorHeight" type="text" name="floor.nFloorHeight" value="${empty floor.nFloorHeight ? '450' : floor.nFloorHeight}"/></dd>
	</dl>
	<dl>
		<dt><label>楼层外边距-上：</label></dt>
		<dd><input type="text" name="floor.nFloorMarginTop" value="${empty floor.nFloorMarginTop ? '10' : floor.nFloorMarginTop}"/></dd>
	</dl>
	<dl>
		<dt><label>楼层外边距-下：</label></dt>
		<dd><input type="text" name="floor.nFloorMarginBottom" value="${empty floor.nFloorMarginBottom ? '0' : floor.nFloorMarginBottom}"/></dd>
	</dl>
	<dl>
		<dt><label>是否显示楼层：</label></dt>
		<dd>
			<select name="floor.nTag">
				<option value="1">显示该楼层</option>
				<option <c:if test="${not empty floor && floor.nTag == 0}">selected</c:if> value="0">隐藏该楼层</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>显示选项卡：</label></dt>
		<dd>
			<select name="floor.nShowTab">
				<option value="1">显示TAB选项卡</option>
				<option  <c:if test="${not empty floor && floor.nShowTab == 0}">selected</c:if> value="0">不显示TAB选项卡</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>显示楼层标题：</label></dt>
		<dd>
			<select name="floor.nShowTitle">
				<option value="0">不显示楼层标题</option>
				<option  <c:if test="${not empty floor && floor.nShowTitle == 1}">selected</c:if> value="1">显示楼层标题</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>显示楼层图标：</label></dt>
		<dd>
			<select name="floor.nShowIcon">
				<option value="1">显示楼层图标</option>
				<option <c:if test="${not empty floor && floor.nShowIcon == 0}">selected</c:if> value="0">不显示楼层图标</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>显示更多链接：</label></dt>
		<dd>
			<select name="floor.nShowMore">
				<option value="1">显示更多链接</option>
				<option <c:if test="${not empty floor && floor.nShowMore == 0}">selected</c:if> value="0">不显示更多链接</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>显示楼层边框：</label></dt>
		<dd>
			<select name="floor.nShowBorder">
				<option value="1">显示楼层边框</option>
				<option <c:if test="${not empty floor && floor.nShowBorder == 0}">selected</c:if> value="0">不显示楼层边框</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>使用楼层索引：</label></dt>
		<dd>
			<select name="floor.nUseIndex">
				<option value="0">不使用楼层索引</option>
				<option <c:if test="${not empty floor && floor.nUseIndex == 1}">selected</c:if> value="1">使用楼层索引</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>自定义标记：</label></dt>
		<dd>
			<select name="floor.sCustomType">
				<option value="A">选项卡楼层-A</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'B'}">selected</c:if> value="B">广告位楼层-B</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'C'}">selected</c:if> value="C">品牌列表楼层-C</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'D'}">selected</c:if> value="D">首页头占位层-D</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'D'}">selected</c:if> value="E">首页头轮播-E</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'D'}">selected</c:if> value="F">首页头导航-F</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'O'}">selected</c:if> value="O">自定义标记-O</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'P'}">selected</c:if> value="P">自定义标记-P</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'Q'}">selected</c:if> value="Q">自定义标记-Q</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'R'}">selected</c:if> value="R">自定义标记-R</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'S'}">selected</c:if> value="S">自定义标记-S</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'T'}">selected</c:if> value="T">自定义标记-T</option>
				<option <c:if test="${not empty floor && floor.sCustomType eq 'U'}">selected</c:if> value="U">自定义标记-U</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>楼层边框颜色：</label></dt>
		<dd><input type="text" name="floor.sFloorBorderColor" value="#FF6400" value="${floor.sFloorBorderColor}"/></dd>
	</dl>
	<dl>
		<dt><label>选项卡边框颜色：</label></dt>
		<dd><input type="text" name="floor.sTabBorderColor" value="#FF6400" value="${floor.sTabBorderColor }"/></dd>
	</dl>
	<dl>
		<dt><label>楼层图标：</label></dt>
		<dd><input type="text" name="floor.sFloorIcon" value="${floor.sFloorIcon }"/></dd>
	</dl>
	<dl>
		<dt><label>楼层更多链接：</label></dt>
		<dd><input type="text" name="floor.sMoreLink" value="${floor.sMoreLink }"/></dd>
	</dl>
	<dl>
		<dt><label>楼层更多链接：</label></dt>
		<dd><input type="text" name="floor.sMoreLink" value="${floor.sMoreLink }"/></dd>
	</dl>
	<dl>
		<dt><label>更多显示文字：</label></dt>
		<dd><input type="text" name="floor.sMoreText" value="${empty floor.sMoreText ? '更多>>' : floor.sMoreText}"/></dd>
	</dl>
	<dl>
		<dt><label>更多链接打开方式：</label></dt>
		<dd>
			<select name="floor.sMoreOpenTarget">
				<option value="_blank">在新窗口中打开</option>
				<option<c:if test="${not empty floor && floor.sMoreOpenTarget eq '_self'}">selected</c:if> value="_self">在当前页面中打开</option>
			</select>
		</dd>
	</dl>
</form>