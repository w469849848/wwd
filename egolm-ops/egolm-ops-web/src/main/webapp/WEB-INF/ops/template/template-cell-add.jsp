<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
</style>
<form action="cell/post" method="post" id="TplCellCreateForm">
	<input type="hidden" name="cell.nTplFloorID" value="${tab.nTplFloorID}"/>
	<input type="hidden" name="cell.nTplPageID" value="${tab.nTplPageID}"/>
	<input type="hidden" name="cell.nTplTabID" value="${tab.nTplTabID}"/>
	<dl>
		<dt><label>起始行：</label></dt>
		<dd><input id="cell_nRowStart" type="text" name="cell.nRowStart" readonly="readonly"/></dd>
	</dl>
	<dl>
		<dt><label>结束行：</label></dt>
		<dd><input id="cell_nRowEnd" type="text" name="cell.nRowEnd" readonly="readonly"/></dd>
	</dl>
	<dl>
		<dt><label>起始列：</label></dt>
		<dd><input id="cell_nColStart" type="text" name="cell.nColStart" readonly="readonly"/></dd>
	</dl>
	<dl>
		<dt><label>结束列：</label></dt>
		<dd><input id="cell_nColEnd" type="text" name="cell.nColEnd" readonly="readonly"/></dd>
	</dl>
	<dl>
		<dt><label>单元格类型：</label></dt>
		<dd>
			<select name="cell.sCellType">
				<option selected="selected" value="scroll">多幅单元格</option>
				<option value="img">单幅单元格</option>
			</select>
		</dd>
	</dl>
	<dl>
		<dt><label>打开方式：</label></dt>
		<dd>
			<select name="cell.sCellType">
				<option selected="selected" value="_blank">在新窗口中打开</option>
				<option  value="_self">在当前页面打开</option>
			</select>
		</dd>
	</dl>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		$("#TplCellCreateForm").find("#cell_nRowStart").val(nRowNumEnd <= nRowNumStart ? nRowNumEnd : nRowNumStart);
		$("#TplCellCreateForm").find("#cell_nRowEnd").val(nRowNumEnd > nRowNumStart ? nRowNumEnd : nRowNumStart);
		$("#TplCellCreateForm").find("#cell_nColStart").val(nColNumEnd <= nColNumStart ? nColNumEnd : nColNumStart);
		$("#TplCellCreateForm").find("#cell_nColEnd").val(nColNumEnd > nColNumStart ? nColNumEnd : nColNumStart);
	});
</script>