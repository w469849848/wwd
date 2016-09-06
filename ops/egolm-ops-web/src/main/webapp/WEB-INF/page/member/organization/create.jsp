<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="auOrgDiv" class="hide">
	<form id="add-org-form" method="POST" onsubmit="return false;" style="margin: auto auto;">
		<table border="0">
			<tbody>
				<tr>
					<td><font color="red">*</font>组织名称：</td>
					<td> 
						<input style="width: 200px;" type="text" maxlength="25" id="add-org-name" name="name">
						<input type="hidden" name="parentId" id="add-org-parent-id">
					</td>
				</tr>
				<tr>
					<td>上级组织：</td>
					<td>
						<div style="display: block; margin: 10px auto;overflow: auto; width: 450px; height: 340px; border: solid 1px #CCC; line-height: 21px; background: #FFF;">
							<div id='preOrgContent' class="menuContent ztreeMC"
								style="display: block; position: relative;">
								<ul id=add-org-tree class="ztree add-org-tree"></ul>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>组织描述：</td>
					<td>
						<textarea id="add-org-description" style="width: 450px;" rows="2" cols="10" maxlength="100" name="description" multiline="true"></textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<a class="button submit-add-org" href="javascript:void(0)" style="float: left; margin: 5px auto 0px auto;" ><span>确定</span></a> 
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
	loadCurrentOrganizationTree('add-org-tree');
	
	$('.submit-add-org').on('click',function(){
		$('#add-org-parent-id').val(member.current_organization.id);
		Net.post('organization/create',$('#add-org-form').serialize() ,function(data){
			$.pdialog.closeCurrent();
			loadBaseOrganizationTree();
		},function(data){
			alertMsg.error('创建组织机构失败！');
		});
	});
});
</script>