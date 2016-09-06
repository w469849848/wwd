<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="panelBar" >
	<div class="pages">
		<span>显示</span>
		<select class="combox" name="page.limit" onchange="navTabPageBreak({numPerPage:this.value});">
			<option value="50" <c:if test="${page.limit == 50}">selected</c:if>>50</option>
			<option value="100" <c:if test="${page.limit == 100}">selected</c:if>>100</option>
			<option value="200" <c:if test="${page.limit == 200}">selected</c:if>>200</option>
			<option value="500" <c:if test="${page.limit == 500}">selected</c:if>>500</option>
		</select>
		<span>条，共${page.total}条</span>
	</div>
	<div class="pagination" targetType="navTab" totalCount="${page.total}" numPerPage="${page.limit}" pageNumShown="10" currentPage="${page.index}"></div>
</div>