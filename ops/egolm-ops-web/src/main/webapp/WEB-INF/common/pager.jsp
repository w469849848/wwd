<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
var pager = function(formId, page, pageSize, force) {
	var currentIdx = $.trim($('.navigation_bar .active').text());
	if(page == currentIdx && !force) return;
	var $form = $('#' + formId);
	$form.append('<input type="hidden" name="index" value="' + page + '">');
	$form.append('<input type="hidden" name="limit" value="' + pageSize + '">');
	$form.submit();
}
</script>
<style>
</style>
<c:set scope="page" var="index"     value="${empty page || empty page.index || page.index == 0 ? 1 : page.index}" />
<c:set scope="page" var="pageTotal" value="${empty page || empty page.pageTotal || page.pageTotal == 0 ? 1 : page.pageTotal}" />
<c:set scope="page" var="limit"     value="${empty page || empty page.limit || page.limit == 0 ? 10 : page.limit}" />
<c:set scope="page" var="start"     value="${index < 7 ? 1 : ((pageTotal-6) < index? (pageTotal -6):(index- 3))}" />
<c:set scope="page" var="end"       value="${start + 6 > pageTotal ? pageTotal : (start + 6)}" />		
<div class="navigation_bar pull-right">
	<ul class="clearfix">
		<li><a href="javascript:pager('${pagerForm}','1',${limit})" class="nav_first ${index == 1 ? 'page-disable' : ''}"></a></li>
		<li><a href="javascript:pager('${pagerForm}',${index - 1 > 0 ? index - 1 : 1},${limit})" class="nav_float ${index == 1 ? 'page-disable' : ''}"></a></li>
		<c:if test="${pageTotal > 7 && (start + 3) > (pageTotal/2)}">
			<li><a href="javascript:void(0)">…</a></li>
		</c:if>
		<c:forEach begin="${start}" end="${end}" var="idx">
			<c:choose>
				<c:when test="${idx == index}">
				<li class="active"><a href="javascript:void(0)">${idx}</a></li>
				</c:when>
			<c:otherwise>
				<li><a href="javascript:pager('${pagerForm}',${idx},${limit})">${idx}</a></li>
			</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${pageTotal > 7 && (start + 3) <= (pageTotal/2)}">
			<li><a href="javascript:void(0)">…</a></li>
		</c:if>
		<li><a href="javascript:pager('${pagerForm}',${index + 1 > pageTotal ? pageTotal : index + 1},${limit})" class="nav_right ${index == pageTotal ? 'page-disable' : ''}"></a></li>
		<li><a href="javascript:pager('${pagerForm}',${pageTotal},${limit})" class="nav_last ${index == pageTotal ? 'page-disable' : ''}"></a></li>
	</ul>
</div>