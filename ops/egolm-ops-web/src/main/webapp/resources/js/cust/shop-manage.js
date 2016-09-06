jQuery(function($) {
	var footable = null, $row = null, isAll = false,
	// true为全选，false为未选中
	deleteType = true,
	// true为删除一行,false为批量删除
	$table = $('.table-box table'),
	// 获取表格元素
	$bgRow = null;

	$('.shop table').footable(
			{ // 响应式表格初始化
				debug : true,
				breakpoints : {
					phone : 600,
					tablet : 980
				},
				log : function(message, type) {
					$bgRow = $table.find('tbody tr')
							.not('.footable-row-detail');
					if (message = 'footable_initialized') {
						$bgRow.each(function(index) {
							if (index % 2 == 1) {
								$(this).css({
									'background' : '#fbfbfb'
								});
							}
						});
					}
					if (message == 'footable_row_expanded'
							|| message == 'footable_row_collapsed') {
						$bgRow.each(function(index) {
							if (index % 2 == 1) {
								$(this).css({
									'background' : '#fbfbfb'
								});
							}
						});
					}
				}
			});

	$('td a.edit').on('click', function(e) { // 编辑
		$("#nShopID").val(this.title);
		$("#toEditPageForm").submit();
	});

	$(document).on('click', '#submit', function(e) { // 保存编辑
		$('#editShop').modal('hide');
		$('#successAlert').modal('show');
	});

	$('td a.delete').on('click', function(e) { // 删除弹窗
		e.stopPropagation();
		deleteType = true;
		footable = $(this).parents('table:first').data('footable');
		$row = $(this).parents('tr:first');
		$('#deleteAlert').modal('show');
	});

	$('#btn-confirm').on('click', function() { // 确认删除
		if (deleteType) {
			$.ajax({
				cache : false,
				type : "POST",
				url : "delete",
				data : {
					sCustNO : $row.attr("title")
				},
				async : false,
				error : function(request) {
					alert("错误提示：" + request);
				},
				success : function(data) {
					var res = JSON.parse(data);
					if (res.IsValid == true) {
						$('#deleteAlert').modal('hide');
						footable.removeRow($row);
						footable = null;
						$row = null;
					} else {
						
					}
					$.jalert({
						title : "提示",
						message : res.ReturnValue,
						confirmButton : "关闭",
						confirm : function() {
						}
					});
				}
			});

		} else { // 批量删除
		}
	});

	$('.shop-check').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.shop-check').filter('[checked=checked]').length == $('.shop-check').length) {
			$('.check-all').attr('checked',true);
			$('.check-all').parents('label:first').addClass('checked');
			isAll = true;
		}else {
			$('.check-all').attr('checked',false);
			$('.check-all').parents('label:first').removeClass('checked');
			isAll = false;
		}
	});

	$('.check-all').on('click', function() { //全选/取消全选
		Checked.selectAll(this, isAll);
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	$('#batch-change-city').on('click', function(){
		var currentCity = validateSameCity();
		if(null == currentCity) return;
		var $checkCusts = $('.shop-check').filter('[checked=checked]');
		var shopNOs = [];
		$checkCusts.each(function() {
			shopNOs.push($(this).attr('data-no'));
		});
		generateDistricts(shopNOs, currentCity);
	});
	
	function validateSameCity() {
		var $checkShops = $('.shop-check').filter('[checked=checked]');
		if($checkShops.length < 1) {
			Ego.error('请选择需要操作的店铺!');
			return null;
		}
		var currentCity = null;
		var pass = true;
		$checkShops.each(function(){
			if(null == currentCity) {
				currentCity = $(this).attr('data-city');
			}
			if(currentCity != $(this).attr('data-city')) {
				pass = false;
			}
		});
		
		if(!pass) {
			Ego.error('不能同时操作不同城市的店铺');
			return null;
		}
		return currentCity;
	};
	
	$('#batch-update-shop').on('click', function() {
		var currentTag = validateSameState();
		if(null == currentTag) return;
		var $checkShops = $('.shop-check').filter('[checked=checked]');
		var shopNOs = [];
		$checkShops.each(function(){
			shopNOs.push($(this).attr('data-no'));
		});
		var notice = '确定要批量禁用这些店铺';
		var tag = 1;
		if(1 == currentTag) {
			notice = '确定要批量启用这些店铺';
			tag = 0;
		}
		Ego.alert(notice, function(){
			updateTag(shopNOs, tag);
		});
	});
	
	$("#district-memu li").click(function(){
		var litext = $(this).text();
		var livalue =  $(this).attr("value");  
		if(livalue == "-1"){
			$("#district-span").text(litext);
			$("#sDistrictID").val("");
			$("#sDistrict").val("");
		}else{
			$("#district-span").text(litext);
			$("#sDistrictID").val(livalue);
			$("#sDistrict").val(litext);
		}
	});
	
	function validateSameState() {
		var $checkShops = $('.shop-check').filter('[checked=checked]');
		if($checkShops.length < 1) {
			Ego.error('请选择需要操作的店铺!');
			return null;
		}
		var currentTag = null;
		var pass = true;
		$checkShops.each(function(){
			if(null == currentTag) {
				currentTag = $(this).attr('data-tag');
			}
			if(currentTag != $(this).attr('data-tag')) {
				pass = false;
			}
		});
		
		if(!pass) {
			Ego.error('不能同时操作不同市的店铺');
			return null;
		}
		return currentTag;
	};
});

function generateDistricts(shopNOs, cityID) {
	$.ajax({
		cache : false,
		traditional:true,
		type : "POST",
		url : webHost + '/base/region/allCountyInCity',
		data : {
			cityNO : cityID
		},
		async : false,
		error : function(request) {
			Ego.error("错误提示：" + request);
		},
		success : function(data) {
			if (data.statusCode == 200) {
				var content = '市区：<select class="alert-dis">';
				for(var index in data.counties) {
					content += '<option value='+data.counties[index].sRegionNO+'>'+data.counties[index].sRegionDesc+'</option>';
				}
				content += '</select>';
				var index = layer.open({
					type:0,
					title:'请选择市区',
					content: content,
					area: ['300px', '200px'],
					closeBtn:1,
					cancel: function(){
						layer.close(index);
					},
					yes : function() {
						var disID = $('.alert-dis').val();
						changeDistrict(shopNOs, disID);
						layer.close(index);
					}
				});
			} else {
				Ego.error(data.ReturnValue);
			}
		}
	});
}

function changeDistrict(sShopNOs, sDistrictID) {
	Ego.alert('确定要修改店铺的市区', function(){
		$.ajax({
			cache : false,
			traditional:true,
			type : "POST",
			url : "changeDistrict",
			data : {
				sShopNOs : sShopNOs,
				sDistrictID : sDistrictID
			},
			async : false,
			error : function(request) {
				Ego.error("错误提示：" + request);
			},
			success : function(data) {
				var res = JSON.parse(data);
				if (res.IsValid == true) {
					Ego.success(res.ReturnValue, function(){
						$('#limitPageForm').submit();
					});
				} else {
					Ego.error(res.ReturnValue);
				}
			}
		});
	});
}

function updateTag(sShopNO, nTag) {
	$.ajax({
		cache : false,
		traditional:true,
		type : "POST",
		url : "updateTag",
		data : {
			sShopNOs : sShopNO,
			nTag : nTag
		},
		async : false,
		error : function(request) {
			Ego.error("错误提示：" + request);
		},
		success : function(data) {
			var res = JSON.parse(data);
			if (res.IsValid == true) {
				Ego.success(res.ReturnValue, function(){
					window.location.href = "shopList";
				});
			} else {
				Ego.error(res.ReturnValue);
			}
		}
	});
}

//定位店铺地址
function toLocation(nShopID,sShopNO,detailAddress,sCity){
	
	//获取经纬度
	var myGeo = new BMap.Geocoder();
	// 将地址解析结果显示在地图上,并调整地图视野
	myGeo.getPoint(detailAddress, function(point){
		if (point) {
			//设置在隐藏域中
            var params = "?sShopNO="+sShopNO+"&lng="+point.lng+"&lat="+point.lat+"&nShopID="+nShopID;
            window.location.href = "showMap"+params;
		}else{
			console.log("您选择地址没有解析到结果!");
			var params = "?sShopNO="+sShopNO+"&lng=&lat=&nShopID="+nShopID;
            window.location.href = "showMap"+params;
		}
	}, sCity);
}
