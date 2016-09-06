<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<div>
	<div style="margin: 10% 0%; font-size: 14px; text-align: center;"><span>您确认删除该组织架构吗！</span></div>
	<div style="width: 70%;margin-left: 15%;">
		<a class="button submit-delete-org" href="javascript:void(0)" style="float: left; margin: 5px auto 0px auto;">
			<span>确定</span>
		</a>
		<a class="button" href="#close" style="float: right; margin: 5px auto 0px auto;" onclick="$.pdialog.closeCurrent();">
			<span>取消</span>
		</a>
	</div>
</div>
<script type="text/javascript">
	$('.submit-delete-org').on('click', function(){
		Net.post('organization/delete',{'orgId' : member.base_organization.id},function(data){
			$.pdialog.closeCurrent();
			loadBaseOrganizationTree();
		},function(data){
			alertMsg.error('删除组织机构失败！');
		});
	});
</script>