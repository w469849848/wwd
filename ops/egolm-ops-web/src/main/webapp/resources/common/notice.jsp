<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	* {font-size:24px;}
	table {width:100%;}
	table, table tr, table tr td {border:1px solid}
	table tr td input {border:0px; width:100%;height:100%;}
	table tr td button {width:100%;}
</style>
<script type="text/javascript">
$.ajax({
	type:'POST',
	url:'${pageContext.request.contextPath}/api/notice/query',
	data:'{pageNum:1,pageSize:2}',
	dataType:"json",
	cache: false,
	success: function(data){
		console.log(data);
	},

});
</script>
</head>
<body>
<div>
<table>
	<tr>
	    <td>photo</td>
	    <td>id</td>
	    <td>name</td>
	    <td>age</td>
	    <td>操作</td>
	</tr>
 
	<c:forEach items="${List}.DataList" var="p">
	<tr>
		<td>${p.notice_id}</td>
	    <td>${p.notice_title}</td>
	    <td>${p.notice_content}</td>
	    <td>${p.create_date}</td>
	    <td>${p.area}</td>
	</tr>
	</c:forEach>
 </table>
 </div>
<br/><br/><br/><br/><br/><br/>

	<a href="${pageContext.request.contextPath}/api/notice/query">${pageContext.request.contextPath}/api/notice/query</a>
	<a href="${pageContext.request.contextPath}/api/notice/queryByTitle">${pageContext.request.contextPath}/api/notice/queryByTitle</a>
	<a href="${pageContext.request.contextPath}/api/notice/add">${pageContext.request.contextPath}/api/hello/add</a>
	<br/><br/><br/>
	
	
	<form action="${pageContext.request.contextPath}/api/notice/query" method="post">
		<table>
			<tr>
				<td>pageNum</td>
				<td><input type="text" name="pageNum" value="1"></td>
				<td>pageSize</td>
				<td><input type="text" name="pageSize" value="10"></td>
			</tr>
			<tr>
				<td colspan="6"><button type="submit">query</button></td>
			</tr>
		</table>
	</form>
	
		<form action="${pageContext.request.contextPath}/api/notice/add" method="post">
		<table>
			<tr>
				<td>title</td>
				<td><input type="text" name="notice_title" value="title"></td>
				<td>=content</td>
				<td><input type="text" name="notice_content" value="content"></td>
				<td>mark_status</td>
				<td><input type="text" name="mark_status" value="1"></td>
			</tr>
			<tr>
				<td>area</td>
				<td><input type="text" name="area" value="西安"></td>
				<td>pubdate</td>
				<td><input type="text" name="pub_date" value="2014-01-17 12:23:33:000"></td>
				<td>out_date</td>
				<td><input type="text" name="ProductId" value="2014-01-17 12:23:33:000"></td>
			</tr>
			<tr>
				<td>account</td>
				<td><input type="text" name="account_id" value="eye"></td>
				<td colspan="6"><button type="submit">add</button></td>
			</tr>
		</table>
	</form>
	
	<br/><br/>
	<form action="${pageContext.request.contextPath}/api/notice/queryByTitle" method="post">
		<table>
			<tr>
				<td>title</td>
				<td><input type="text" name="title" value="title"></td>
				<td>pageNum</td>
				<td><input type="text" name="pageNum" value="1"></td>
				<td>pageSize</td>
				<td><input type="text" name="pageSize" value="10"></td>
			</tr>
			<tr>
				<td colspan="6"><button type="submit">queryByTitle</button></td>
			</tr>
		</table>
	</form>
	
</body>
</html>
