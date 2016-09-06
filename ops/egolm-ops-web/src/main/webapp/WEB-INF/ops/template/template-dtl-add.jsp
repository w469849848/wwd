<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	dt{float:left;width:120px;}
	dd input,select {width:300px;}
	#SelectAdposList {width:100%;}
	#SelectAdposList tr th {border:1px solid #A9A9A9;text-align:center;background:#eee;line-height:16px;height:16px;}
	#SelectAdposList tr td {border:1px solid #eee;line-height:16px;height:16px;}
</style>
<div id="AdposEditDiv" style="overflow-y:auto;overflow-x:hidden;padding:5px;margin:-7px;height:99%;width:39%;float:left;border:1px solid #eee;">
	<div style="height:120px;">
		<form action="adpos/post" method="post" id="TplDtlCreateForm">
			<input type="hidden" name="AliYunCdnImagePath" value="${imagePath}"/>
			<input type="hidden" name="cell.nTplCellID" value="${cell.nTplCellID}"/>
			<input type="hidden" name="cell.nTplPageID" value="${tab.nTplPageID}"/>
			<input type="hidden" name="cell.nTplFloorID" value="${tab.nTplFloorID}"/>
			<input type="hidden" name="cell.nTplTabID" value="${tab.nTplTabID}"/>
			<input type="hidden" name="cell.nRowStart" value="${empty cell ? nRowStart : cell.nRowStart}"/>
			<input type="hidden" name="cell.nRowEnd" value="${empty cell ? nRowStart : cell.nRowEnd}"/>
			<input type="hidden" name="cell.nColStart" value="${empty cell ? nColStart : cell.nColStart}"/>
			<input type="hidden" name="cell.nColEnd" value="${empty cell ? nColStart : cell.nColEnd}"/>
			<input id="CellnApID" type="hidden" name="cell.nApID" value="${cell.nApID}"/>
			<dl>
				<dt>
					<label>单元格类型：</label>
				</dt>
				<dd>
					<select id="cell_sCellType" name="cell.sCellType" onchange="DoSearchAdpos();">
						<option <c:if test="${empty cell || cell.sCellType eq 'img'}">selected</c:if> value="scroll">多幅单元格</option>
						<option <c:if test="${not empty cell && cell.sCellType eq 'img'}">selected</c:if> value="img">单幅单元格</option>
					</select>
				</dd>
			</dl>
			<dl>
				<dt>
					<label>页面打开方式：</label>
				</td>
				<dd>
					<select name="cell.sOpenTarget">
						<option <c:if test="${empty cell || cell.sCellType eq '_blank'}">selected</c:if> value="_blank">在新窗口中打开</option>
						<option <c:if test="${not empty cell && cell.sCellType eq '_self'}">selected</c:if> value="_self">在当前页面打开</option>
					</select>
				</dd>
			</dl>
		</form>
	</div>
</div>
<div style="overflow-y:auto;overflow-x:hidden;padding:5px;margin:-7px;height:99%;width:60%;float:right;border:1px solid #eee;">
	<div style="width:100%;height:40px;">
		<input type="text" id="AdposSearchText" style="width:300px;"/>
		<input type="hidden" id="search_nTplPageID" value="${tab.nTplPageID}"/>
		<button id="AdposSearchButton">查询</button>
	</div>
	<table id="SelectAdposList" style="width:100%;">
		<thead>
			<tr style='height:28px;'>
				<th>编号</th>
				<th>广告标题</th>
				<th>高度</th>
				<th>宽度</th>
				<th>渠道</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
			
		</tbody>
	</table>
</div>
<script type="text/javascript">
$(document).ready(function() {
	DoSearchAdpos();
});
$("#AdposSearchButton").click(function() {
	DoSearchAdpos();
});
function DoSearchAdpos() {
	$("#SelectAdposList tbody *").remove();
	var searchText = $("#AdposSearchText").val();
	var sApTypeID = $("#cell_sCellType").val();
	var imagePath = "${imagePath}";
	var nTplPageID = $("#search_nTplPageID").val();
	SearchAdpos(nTplPageID, sApTypeID, searchText, imagePath);
}
</script>