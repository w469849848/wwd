<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
td{
	height: 40px;
}
.info-name {
	display: block;
	margin: 15px 0px 15px 0px;
	width: 200px;
	text-align: right;
}
.info-val {
	margin: 15px 0px 15px 0px;
	text-align: left;
}
</style>
<div style="margin: auto auto;">
	<table>
		<thead>
			<tr>
				<th width="200px"></th>
				<th width="300px"></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><span class="info-name">组织名称：</span></td>
				<td><span class="info-val" id="info-name"></span></td>
			</tr>
			<tr>
				<td><span class="info-name">上级组织：</span></td>
				<td><span class="info-val" id="info-prev"></span></td>
			</tr>
			<tr>
				<td><span class="info-name">所在层级：</span></td>
				<td><span class="info-val" id="info-level"></span></td>
			</tr>
			<tr>
				<td><span class="info-name">下属组织数：</span></td>
				<td><span class="info-val" id="info-subs"></span></td>
			</tr>
			<tr>
				<td><span class="info-name">组织描述：</span></td>
				<td><span class="info-val" id="info-desc"></span></td>
			</tr>
		</tbody>
	</table>
	<a class="button" style="float:right;margin-right: 45%;width: 10%" href="#close" onclick="$.pdialog.closeCurrent();"><span>关闭</span></a>
</div>
<script type="text/javascript">
	$(function(){
		$('#info-name').text(member.base_organization.name);
		$('#info-prev').text((member.base_organization.getParentNode() && member.base_organization.getParentNode().name) || '');
		$('#info-level').text(member.base_organization.level);
		$('#info-subs').text(getSubNodeSize([member.base_organization]));
		$('#info-desc').text(member.base_organization.description);
	});
</script>