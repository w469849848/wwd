jQuery(function($) {

	$('#reset_psw_btn').on('click', function() { // 保存编辑
		// 简历提交
		$.ajax({
			cache : false,
			type : "POST",
			url : 'resetPswForm',
			data : {
				password : $("#password").val(),
				ids : $("#sCustNOIds").val()
			},
			async : false,
			error : function(request) {
				alert("Connection error");
			},
			success : function(data) {
				var res = JSON.parse(data);
				$('#msg_p').html(res.ReturnValue);
				$('#successAlert').modal('show');
			}
		});
	});
});