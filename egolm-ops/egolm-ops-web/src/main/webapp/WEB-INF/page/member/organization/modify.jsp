<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div id="auOrgDiv" class="hide">
	<form id="modify-org-form" method="POST" onsubmit="return false;" style="margin: auto auto;">
		<table border="0">
			<tbody>
				<tr style="display: none">
					<td colspan="2">
						<input type="hidden" id="modify-current-id" name="id">
					</td>
				</tr>
				<tr>
					<td><font color="red">*</font>组织名称：</td>
					<td> 
						<input style="width: 200px;" type="text" maxlength="25" id="modify-org-name" name="name">
					</td>
				</tr>
				<tr>
					<td>上级组织：</td>
					<td>
						<div style="display: block; margin: 10px auto;overflow: auto; width: 450px; height: 340px; border: solid 1px #CCC; line-height: 21px; background: #FFF;">
							<div id='preOrgContent' class="menuContent ztreeMC"
								style="display: block; position: relative;">
								<ul id=modify-org-tree class="ztree modify-org-tree"></ul>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>组织描述：</td>
					<td>
						<textarea id="modify-org-description" style="width: 450px;" rows="2" cols="10" maxlength="100" name="description" multiline="true"></textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
						<a class="button submit-modify-org" href="javascript:void(0)" style="float: left; margin: 5px auto 0px auto;" ><span>确定</span></a> 
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
	$(function() {
		loadCurrentOrganizationTree('modify-org-tree');
		$('#modify-org-name').val(member.base_organization.name);
		$('#modify-org-description').val(member.base_organization.description);

		$('.submit-modify-org').on('click', function() {
			var node = getSelectNode('modify-org-tree');
			if(null == node) return;
			if(isSubNode(member.base_organization,node)) {
				alertMsg.error('上级组织不能降为子级的子组织!');
				return;
			}
			if(member.base_organization.name == $.trim($('#modify-org-name').val()) &&
			   member.base_organization.description ==$.trim($('#modify-org-description').val()) &&
			   member.base_organization.parentId == node.parentId){
				$.pdialog.closeCurrent();
				return;
			}  
			Net.post('organization/modify',{
				name:$.trim($('#modify-org-name').val()),
				description:$.trim($('#modify-org-description').val()),
				parentId:node.parentId,
				id:member.base_organization.id,
			},function(){
				$.pdialog.closeCurrent();
				loadBaseOrganizationTree();
			},function(){alertMsg.error('编辑组织机构信息失败!');});
		});
	});
</script>