jQuery(function($) {
	// 表单异步提交
	$('#certifForm').ajaxForm(
			function(data) {
				var res = JSON.parse(data);
				if (res.IsValid == true) {
					$.jalert({
						title : "提示",
						message : res.ReturnValue,
						confirmButton : "关闭",
						confirm : function() {
							window.location.href = "certifList?sCertifNO="
									+ $("#sCertifNO").val();
						}
					});
				} else {
					$.jalert({
						title : "提示",
						message : res.ReturnValue,
						confirmButton : "关闭",
						confirm : function() {
						}
					});
				}
			});

	$("#submitForm").on('click', function() {
		if (validatorForm()) {
			$("#certifForm").submit();
		}
	});
	// 加载证照类型
	loadCommonMsg("certiftype-menu", "CertifType"); // 加载证照类型
	var sCertiftype_u = $("#sCertifType").val();
	if (sCertiftype_u != '') {
		$("#certiftype").find("span").eq(0).text(sCertiftype_u);
	}
	$("#certiftype-menu li").click(function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#certiftype").find("span").eq(0).text(litext);
		$("#sCertifTypeID").val(livalue);
		$("#sCertifType").val(litext);
	});

	// 生效日期
	$('#dValidDate').datetimepicker({
		format : 'Y-m-d', // 格式化日期
		timepicker : true, // 开启时间选项
		yearStart : 2000, // 设置最小年份
		yearEnd : 2050, // 设置最大年份
		todayButton : false
	// 关闭选择今天按钮
	});

	// 到期日期
	$('#dExpiryDate').datetimepicker({
		format : 'Y-m-d', // 格式化日期
		timepicker : true, // 开启时间选项
		yearStart : 2000, // 设置最小年份
		yearEnd : 2050, // 设置最大年份
		todayButton : false
	// 关闭选择今天按钮
	});

	$('#seletSShopNO').on('click', function() { // 显示选择用户窗口
		seletSShopNO("salectShopList");
	});

	$("#back_btn").on('click', function() {
		window.location.href = 'certifList?sCertifNO=' + $("#sCertifNO").val();
	});
	$.datetimepicker.setLocale('ch'); // 日期插件设置为中文
	
});


// 设置图片
function preview(file) {
	if (file.files && file.files[0]) {
		var reader = new FileReader();
		if (typeof FileReader === 'undefined') {
			console.log("浏览器不支持FileReader");
		} else {
			console.log("浏览器支持FileReader");
		}
		reader.readAsDataURL(file.files[0]);

		reader.onload = function(evt) {
			console.log("读 取完成");
			$("#pic-src-id").attr("src", evt.target.result);
		}, reader.onerror = function(evt) {
			console.log("读 取出错");
		}, reader.onabort = function(evt) {
			console.log("读 取中断");
		}, reader.onloadstart = function(evt) {
			console.log("读 取开始");
		}
	} else {
	}
}

// 表单验证
function validatorForm() {
	if ($("#sShopName").val() == "") {
		alert("店铺名称不能为空。");
		return false;
	}
	if ($("#sCustNO").val() == "") {
		alert("请选择所属会员。");
		$("#sCustNO").focus();
		return false;
	}
	if ($("#sCertifTypeID").val() == "") {
		alert("请选择证照类型。");
		return false;
	}
	if ($("#dValidDate").val() == "") {
		alert("请选择生效日期。");
		return false;
	}
	if(!checkDate($("#dValidDate").val())){
		alert("生效日期不合法。");
		$("#dValidDate").focus();
		return false;
	}
	
	if ($("#dExpiryDate").val() == "") {
		alert("请选择到期日期。");
		return false;
	}

	if(!checkDate($("#dExpiryDate").val())){
		alert("到期日期不合法。");
		$("#dExpiryDate").focus();
		return false;
	}
	
	if ($("#sURL").val()!='') {
		if($("#sPicDesc").val()==''){
			alert("图片描述不能为空。");
			$("#sPicDesc").focus();
			return false;
		}
	}
	return true;
}

function checkDate(dateValue){
	
	return(new RegExp(/^[0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3}/).test(dateValue));
}
