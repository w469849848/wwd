<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<div class="pageContent">
<form method="post" action="${pageContext.request.contextPath}/api/notice/update" class="pageForm required-validate" onsubmit="return validateCallback(this, navTabAjaxDone);">
		<div class="pageFormContent" layoutH="56">
		<table>
		<tr><td>
			<p>
				<label>公告标题：</label>
				<input name="notice_title" type="text" size="30" value="${dataMap.notice_title}"/>
			</p>
		</td>
		</tr>
		<tr>
		<td>
			<div>
				<label>公告内容：</label>
				<textarea class="editor" name="notice_content" rows="15" cols="80">${dataMap.notice_content}</textarea>
			</div>
		</td>
		</tr>
		<tr>
		<td>
			<p>
				<label>发布日期：</label>
				<input type="text" name="pub_date" readonly="true" datefmt="yyyy-MM-dd HH:mm:ss" class="date textInput readonly valid" name="date10" value="${dataMap.pubdate}">
				<a class="inputDateButton" href="javascript:;">选择</a>
			</p>
			<p>
				<label>下线日期：</label>
				<input type="text" name="out_date" readonly="true" datefmt="yyyy-MM-dd HH:mm:ss" class="date textInput readonly valid" name="date10" value="${dataMap.outdate}">
				<a class="inputDateButton" href="javascript:;">选择</a>
			</p>
		</td>
		</tr>
		<tr>
		<td>
			<p>
				<label>地域：</label>
				<input name="area" type="text" size="30" value="${dataMap.area}"/>
			</p>
			<p>
				<input name="account_id" type="hidden" value="admin" readonly="readonly"/>
				<input name="notice_id" type="hidden" value="${dataMap.notice_id}" readonly="readonly"/>
			</p>
		</td>
		</tr>
		</table>
		</div>
		<div class="formBar">
			<ul>
				<li>
					<div class="buttonActive"><div class="buttonContent"><button type="submit">保存</button></div></div>
				</li>
				<li>
					<div class="button"><div class="buttonContent"><button type="button" class="close">取消</button></div></div>
				</li>
			</ul>
		</div>
</form>
</div>
