<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	.FloorIconTable {width:100%;}
	.FloorIconTable th {border:1px solid #A9A9A9;text-align:center;background:#eee;line-height:36px;height:36px;}
	.FloorIconTable tr td {height:50px;border:1px solid #eee;border:1px solid #eee;line-height:50px;}
	.FloorIconTable tr td img {}
</style>
<form method="post" action="floor/icon/post" id="TplFloorIconForm">
	<input type="hidden" id="icon_nTplFloorID" name="nTplFloorID" value="${floor.nTplFloorID}"/>
	<table class="FloorIconTable">
		<tr>
			<th>
				<span class="chk-bg"></span>
			</th>
			<th>编号</th>
			<th>名称</th>
			<th>路径</th>
			<th>预览</th>
		</tr>
		<c:forEach items="${icons}" var="icon">
			<tr>
				<td align="center">
					<label class="checked-wrap">
						<input name="sTplIconUrl" value="${icon.sTplIconUrl}" type="checkbox" class="chk FloorIconCheckBox" /><span class="chk-bg"></span>
					</label>
				</td>
				<td align="center">${icon.nTplIconID}</td>
				<td>${icon.sTplIconName}</td>
				<td>${icon.sTplIconUrl}</td>
				<td align="center"><img src="http://img.egolm.com/${icon.sTplIconUrl}"/></td>
			</tr>
		</c:forEach>
	</table>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		$(".chk").on("click", function() {
			Checked.cancelAll($(".chk"));
			Checked.checked(this);
		});
	});
</script>