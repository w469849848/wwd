jQuery(function($) {
	// 表单异步提交
	$('#shopForm').ajaxForm(
			function(data) {
				var res = JSON.parse(data);
				if (res.IsValid == true) {
					$.jalert({
						title : "提示",
						message : res.ReturnValue,
						confirmButton : "关闭",
						confirm : function() {
							window.location.href = "shopList?sShopName="
									+ $("#sShopName").val();
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
			$("#shopForm").submit();
		}
	});
	// 加载店铺类型
	loadCommonMsg("shoptype-menu", "ShopType"); // 加载店铺类型
	var sShoptype_u = $("#sShopType").val();
	if (sShoptype_u != '') {
		$("#shoptype").find("span").eq(0).text(sShoptype_u);
	}
	$("#shoptype-menu li").click(function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#shoptype").find("span").eq(0).text(litext);
		$("#sShopTypeID").val(livalue);
		$("#sShopType").val(litext);
	});
	// 加载经销类型
	loadCommonMsg("scopetype-menu", "ScopeType"); // 加载经销类型
	var sScopetype_u = $("#sScopeType").val();
	if (sScopetype_u != '') {
		$("#scopetype").find("span").eq(0).text(sScopetype_u);
	}
	$("#scopetype-menu li").click(function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#scopetype").find("span").eq(0).text(litext);
		$("#sScopeTypeID").val(livalue);
		$("#sScopeType").val(litext);
	});

	// 日期控件
	$('#dFirstSaleDate').datetimepicker({
		format : 'Y-m-d', // 格式化日期
		timepicker : true, // 开启时间选项
		yearStart : 2000, // 设置最小年份
		yearEnd : 2050, // 设置最大年份
		todayButton : false
	// 关闭选择今天按钮
	});

	$('#seletSCustNO').on('click', function() { // 显示选择用户窗口
		seletSCustNO("salectCustList");
	});

	$('#seletSalesmanNO1').on('click', function() { // 显示选择开店业务员窗口
		seletSalesmanNO("salesmanNOList?saleNO=1");
	});

	$('#seletSalesmanNO2').on('click', function() { // 显示选择维护业务员窗口
		seletSalesmanNO("salesmanNOList?saleNO=2");
	});
	
	
	$("#back_btn").on('click', function() {
		window.location.href = 'shopList?sShopName=' + $("#sShopName").val();
	});
	$.datetimepicker.setLocale('ch'); // 日期插件设置为中文

	// 省份选择处理
	var sProvince_u = $("#sProvince").val(); // 编辑时展示
	if (sProvince_u != '') {
		$("#province").find("span").eq(0).text(sProvince_u);
		// 加载市
		loadCity();
	}
	$("#province-menu li").click(function() { // 选择
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		if(livalue != $("#sProvinceID").val()){
			$("#province").find("span").eq(0).text(litext);
			$("#sProvinceID").val(livalue);
			$("#sProvince").val(litext);
			$("#city").find("span").eq(0).text("请选择");
			$("#sCityID").val("");
			$("#sCity").val("");
			$("#district").find("span").eq(0).text("请选择");
			$("#sDistrictID").val("");
			$("#sDistrict").val("");
			// 加载市
			loadCity();
		}
	});
	// 市选择处理
	var sCity_u = $("#sCity").val(); // 编辑时展示
	if (sCity_u != '') {
		$("#city").find("span").eq(0).text(sCity_u);
		// 加载地区
		loadDistrict();
	}
	// 地区选择处理
	var sDistrict_u = $("#sDistrict").val(); // 编辑时展示
	if (sDistrict_u != '') {
		$("#district").find("span").eq(0).text(sDistrict_u);
	}
});

// 获取市区资料
function loadCity() {
	$.get("getCityByProvinceId?sProvinceID=" + $("#sProvinceID").val(),
			function(data) {
				if (data.IsValid) {
					var result = "";
					$.each(data.DataList, function(n, value) {
						result += "<li value='" + value.sRegionNO + "'>"
								+ value.sRegionDesc + "</li> ";
					});
					$("#city-menu").html('');
					$("#city-menu").append(result);
					$("#district-menu").html('');
				}
			}, "json");
	$("#city-menu").on("click", "li", function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		if(livalue != $("#sCityID").val()){
			$("#city").find("span").eq(0).text(litext);
			$("#sCityID").val(livalue);
			$("#sCity").val(litext);
			$("#district").find("span").eq(0).text("请选择");
			$("#sDistrictID").val("");
			$("#sDistrict").val("");
			// 加载地区
			loadDistrict();
		}
	});
}

// 获取地区资料
function loadDistrict() {
	$.get("getAreaByCityId?sCityID=" + $("#sCityID").val(), function(data) {
		if (data.IsValid) {
			var result = "";
			$.each(data.DataList, function(n, value) {
				result += "<li value='" + value.sRegionNO + "'>"
						+ value.sRegionDesc + "</li> ";
			});
			$("#district-menu").html('');
			$("#district-menu").append(result);
		}
	}, "json");
	$("#district-menu").on("click", "li", function() {
		var litext = $(this).text();
		var livalue = $(this).attr("value");
		$("#district").find("span").eq(0).text(litext);
		$("#sDistrictID").val(livalue);
		$("#sDistrict").val(litext);
	});
}

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
	if ($("#sShopTypeID").val() == "") {
		alert("请选择店铺类型。");
		return false;
	}
	if ($("#sScopeTypeID").val() == "") {
		alert("请选择经营类型。");
		$("#sScopeTypeID").focus();
		return false;
	}
	if ($("#sContacts").val() == "") {
		alert("联系人不能为空。");
		$("#sContacts").focus();
		return false;
	}
	if ($("#sTel").val() == "") {
		alert("手机号码不能为空。");
		$("#sTel").focus();
		return false;
	}
	if ($("#sEmail").val()!='') {
		if(!ismail($("#sEmail").val())){
			alert("邮箱地址不合法。");
			$("#sEmail").focus();
			return false;
		}
	}
	if ($("#sProvinceID").val() == "") {
		alert("请选择店铺所在省份。");
		return false;
	}
	if ($("#sCityID").val() == "") {
		alert("请选择店铺所在城市。");
		return false;
	}
	if ($("#sDistrictID").val() == "") {
		alert("请选择店铺所在行政区。");
		return false;
	}
	if ($("#sAddress").val() == "") {
		alert("地址不能为空。");
		$("#sAddress").focus();
		return false;
	}
	if($("#nStoreArea").val()!=''){
		if(!(new RegExp(/^\d+(\.\d+)?$/).test($("#nStoreArea").val()))){
			alert("营业面积不合法。");
			$("#nStoreArea").focus();
			return false;
		}
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

function ismail(mail){
	return(new RegExp(/^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/).test(mail));
}
