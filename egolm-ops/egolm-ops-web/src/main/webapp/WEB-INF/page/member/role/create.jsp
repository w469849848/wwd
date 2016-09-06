<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
</style>
<div id="create-role-div" class="hide">
	<form id="create-role-form" method="POST" onsubmit="return false;" style="height:300px; padding-left: 25%;">
		<table border="0">
			<tbody>
				<tr style="display: none">
					<td colspan="2">
					<input type="hidden" name="id">
					</td>
				</tr>
				<tr height="30"><td></td><td></td></tr>
				<tr>
					<td><font color="red">*</font>角色名称：</td>
					<td> 
						<input style="width: 200px;" type="text" maxlength="25" name="name">
					</td>
				</tr>
				<tr height="10"><td></td><td></td></tr>
				<tr>
					<td><font color="white">*</font>所属组织：</td>
					<td id="create-role-orgs">
						<select class="combox" name="organizationId" style="width:200px;" size="1">
							<option value="">选择组织架构归属</option>
						</select>
					</td>
				</tr>
				<tr height="10"><td></td><td></td></tr>
				<tr>
					<td>组织描述：</td>
					<td>
						<textarea style="width: 200px;" rows="2" cols="10" maxlength="100" name="description" multiline="true"></textarea>
					</td>
				</tr>
				<tr height="10"><td></td><td></td></tr>
				<tr>
					<td></td>
					<td>
						<a class="button submit-create-role" href="javascript:void(0)" style="float: left; margin: 5px auto 0px auto;" ><span>确定</span></a> 
						<a class="button" href="#close" style="float: right;margin: 5px auto 0px auto;" onclick="$.pdialog.closeCurrent();"><span>取消</span></a>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<br />
	<br />
	<br />
	<br />
</div>
<script type="text/javascript">
$(function(){
	Net.post('organization/queryAll', {}, function(data) {
		var $orgs = $('#create-role-orgs');
		var option = '<select class="combox" name="organizationId" style="width:200px;" size="1"><option value="">选择组织架构归属</option>';
		$orgs.empty();
		for(var index in data.orgs) {
			'<a value="" name="orgId" class="" href="javascript:">选择组织架构归属</a>';
			option += '<option value="'+data.orgs[index].id+'">'+data.orgs[index].name+'</option>';
		}
		option += '</select>';
		$orgs.append(option);
		$('#create-role-orgs').combox();
	},function(data){
		alertMsg.error('获取组织机构信息失败！');
	});
	
	$('.submit-create-role').on('click',function(){
		Net.post('role/create', $('#create-role-form').serialize(), function(data) {
			$.pdialog.closeCurrent();
			alertMsg.correct('角色创建成功！');
		},function(){
			alertMsg.error('角色创建失败！');
		});
	});
});
</script>