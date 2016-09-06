jQuery(function($) {
	$("#submitForm").on('click', function() {
		var arrElem = $('#commCustForm').serialize();
		if (validatorForm()) {
			$.ajax({
				cache : false,
				type : "POST",
				url : 'editOrAddCust',
				data : arrElem,
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
		}
	});

	$('#seletSalesmanNO1').on('click', function() { // 显示选择开店业务员窗口
		seletSalesmanNO("salesmanNOList?saleNO=1");
	});

	$('#seletSalesmanNO2').on('click', function() { // 显示选择维护业务员窗口
		seletSalesmanNO("salesmanNOList?saleNO=2");
	});
	
	$("#back_btn").on('click', function() {
		window.location.href='customerList?sCustName='+$("#sCustName").val();
	});
});

// 表单验证
function validatorForm() {
	if ($("#sCustName").val() == "") {
		alert("会员姓名不能为空。");
		return false;
	}
	if ($("#sCustLeveTypeID").val() == "") {
		alert("请选择会员等级。");
		return false;
	}
	if ($("#sMobile").val() == "") {
		alert("手机号码不能为空。");
		return false;
	}
	return true;
}