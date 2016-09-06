<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="panelBar" >
	<div class="pages">
		<span>显示</span>
		<select class="combox" name="page.limit" onchange="dialogPageBreak({numPerPage:this.value})">
			<option value="10" <c:if test="${page.limit == 10}">selected</c:if>>10</option>
			<option value="20" <c:if test="${page.limit == 20}">selected</c:if>>20</option>
			<option value="50" <c:if test="${page.limit == 50}">selected</c:if>>50</option>
		</select>
		<span>条，共${page.total}条</span>
	</div>
	<div class="pagination" targetType="dialog" totalCount="${page.total}" numPerPage="${page.limit}" pageNumShown="10" currentPage="${page.index}"></div>
</div>