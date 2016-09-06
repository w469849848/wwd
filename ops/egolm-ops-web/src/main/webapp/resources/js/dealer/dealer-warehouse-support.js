$(function(){
	var loadFeeCalculate = function() {
		$('#calculate-menu').empty();
		HTTP.postEgox(webHost + '/common/queryByCommonNo', {
			sCommonNo : 'FEECALC'
		}, function(data) {
			var feeCalculate = '';
			for ( var index in data.DataList) {
				feeCalculate += '<li value="' + data.DataList[index].sComID + '">' + data.DataList[index].sComDesc + '</li>';
			}
			$('#calculate-menu').append(feeCalculate);
		}, function(data){
			Ego.error('获取仓库计费类型失败');
		});
	};
	
	var loadWarehouse = function(cityID) {
		$('#warehouse_menu').empty();
		HTTP.postAjx(webHost + '/warehouse/queryByCityIds', {
			cityIds : cityID
		}, function(data) {
			var warehouse = '';
			for ( var index in data.warehouses) {
				warehouse += '<li value="' + data.warehouses[index].swarehouseNO + '">' + data.warehouses[index].swarehouseName + '</li>';
			}
			$('#warehouse_menu').append(warehouse);
		}, function(data){
			Ego.error('获取区域仓库失败');
		});
	};
	
	loadFeeCalculate();
	if(undefined != $('#sOrgNO').val() && $('#sOrgNO').val().length > 0) {
		loadWarehouse($('#sOrgNO').val());
	}
	
	var infoCount = 0;
	$('.content-toggle').on('click', function(){
		infoCount ++;
		if(infoCount % 2 == 0) $('.content-box').slideDown();
		if(infoCount % 2 == 1) $('.content-box').slideUp();	
	});
		
	var accountCount = 0;
	$('.account-toggle').on('click', function(){
		accountCount ++;
		if(accountCount % 2 == 0) $('.account-box').slideDown();
		if(accountCount % 2 == 1) $('.account-box').slideUp();
	});
		
	var warehouseCount = 0;
	$('.warehouse-toggle').on('click', function(){
		warehouseCount ++;
		if(warehouseCount % 2 == 0) $('.warehouse-box').slideDown();
		if(warehouseCount % 2 == 1) $('.warehouse-box').slideUp();
	});
	
	var goodsCount = 0;
	$('.goods-toggle').on('click', function(){
		goodsCount ++;
		if(goodsCount % 2 == 0) $('.goods-box').slideDown();
		if(goodsCount % 2 == 1) $('.goods-box').slideUp();
	});
	
	$('#warehouse-list').on('click', function(){
		if($('#sZoneCode-area-menu li').length < 1 ) {
			Ego.error('请先选择区域');
		}
		else if($('#sOrgNO').val().length < 1 && $('#warehouse_menu li').length < 1) {
			Ego.error('请先选择区域');
		}
		else if($('#sOrgNO').val().length > 0 && $('#warehouse_menu li').length < 1){
			Ego.error('该区域无仓库');
		}
	});

	$('#sZoneCode-area-menu li').on('click', function(){
		loadWarehouse($(this).attr('value'));
	});

	$('#warehouse_menu').on('click', 'li', function(){
		$('#sWarehouseNO-choice').text($.trim($(this).text()));
		$('#sWarehouseNO').val($(this).attr('value'));
		$('#sWarehouseName').val($.trim($(this).text()));
	});
	
	$('#calculate-menu').on('click', 'li', function(){
		$('#calculate-choice').text($.trim($(this).text()));
		$('#sFeeCalcTypeID').val($(this).attr('value'));
		$('#sFeeCalcType').val($.trim($(this).text()));
		$('#sFeeCalcValue').val('');
		var type = $(this).attr('value');
		switch(type) {
		case '5' :
			$('#sFeeCalcValue').next().text('¥');break;
		default :
			$('#sFeeCalcValue').next().text('%');break;
		}
	});
	
	var index = 0;
	$('#add-warehouse').on('click', function(){
		if(undefined != $(this).attr('data-size') && $(this).attr('data-size').length > 0) {
			index = $(this).attr('data-size');
		}
		var warehouseNO = $('#sWarehouseNO').val();
		var warehouseName = $('#sWarehouseName').val();
		var calculateNO = $('#sFeeCalcTypeID').val();
		var calculateName = $('#sFeeCalcType').val();
		var calculateValue = $('#sFeeCalcValue').val();
		if(warehouseNO.length == 0) {
			Ego.error('必须选择仓库');
			return;
		}
		if(calculateNO.length == 0) {
			Ego.error('必须选择计费类型');
			return;
		}
		if(calculateValue.length == 0) {
			Ego.error('必须输入计费方式');
			return;
		}
		if('5' != calculateNO && !/^[0-9]{1,2}(.[0-9]{2})?$/.test(calculateValue)) {
			Ego.error('百分比最多2位整数，两位小数');
			return
		}
		if(!/^[0-9]{1,9}(.[0-9]{2})?$/.test(calculateValue)) {
			Ego.error('固定金额最多9位整数两位小数');
			return
		}
		for(var i = 0; i <=index; i++) {
			if($('input[name="warehouses['+i+'].sWarehouseNO"]').length > 1) {
				Ego.error('该仓库已经被添加');
				return;
			}
		}
		
		var warehouseTpl = $('#warehouse-tpl').html();
		warehouseTpl = warehouseTpl.replace(/warehouseNO/, 'warehouses['+index+'].sWarehouseNO');
		warehouseTpl = warehouseTpl.replace(/warehouseNOValue/, warehouseNO); 
		
		warehouseTpl = warehouseTpl.replace(/warehouseName/, 'warehouses['+index+'].sWarehouseName');
		warehouseTpl = warehouseTpl.replace(/warehouseNameValue/, warehouseName);
		
		warehouseTpl = warehouseTpl.replace(/feeCalculateNO/, 'warehouses['+index+'].sFeeCalcTypeID');
		warehouseTpl = warehouseTpl.replace(/feeCalculateNOValue/, calculateNO);
		
		warehouseTpl = warehouseTpl.replace(/feeCalculateName/, 'warehouses['+index+'].sFeeCalcType');
		warehouseTpl = warehouseTpl.replace(/feeCalculateNameValue/, calculateName);
		
		warehouseTpl = warehouseTpl.replace(/feeCalculateAmount/, 'warehouses['+index+'].sFeeCalcValue');
		warehouseTpl = warehouseTpl.replace(/feeCalculateAmountValue/, calculateValue);
		warehouseTpl = warehouseTpl.replace(/amountUnit/, calculateNO == '5' ? '¥' : '%');
		
		$('.warehouse-box').append(warehouseTpl);
		index ++;
	});
	
	$(document).on('click', '.remove-warehouse', function(){
		if($(this).attr('data-rm') == 'false') {
			Ego.error('该仓库存在未释放库存，不可删除');
			return;
		}
		$(this).parents('.row').remove();
	});
	

	var loadContractGoods = function(params) {
		HTTP.postEgox(webHost + '/dealer/contractGoods', params, function(data) {
			var html = ajaxPager.render(params, function() {
				loadContractGoods($.extend(params, { index : data.index + 1 }));
			});
			var goodsHtml = '';
			if(undefined != data.DataList.datas) {
				for(var index in data.DataList.datas) {
					var goods = data.DataList.datas[index];
					console.log(goods);
					goodsHtml += '<tr>';
					goodsHtml += '<td>'+goods.sMainBarcode+'</td>';
					goodsHtml += '<td>'+goods.sGoodsDesc+'</td>';
					goodsHtml += '<td>'+goods.nLifeCycle+'月</td>';
					goodsHtml += '<td>'+goods.sSpec+'/'+goods.sUnit+'</td>';
					goodsHtml += '<td>'+goods.nRealSalePrice+'</td>';
					goodsHtml += '<td>'+goods.sSpec+'</td>';
					goodsHtml += '<td>'+goods.nStockQty+'</td>';
					goodsHtml += '<td>'+goods.sAgentName+'</td>';
					goodsHtml += '<td>未zhding</td>';
					goodsHtml += '</tr>';
				}
			}
			$('.contract-goods').empty();
			$('.contract-goods').append(goodsHtml);
			$('.goods-pager').empty();
			$('.goods-pager').append(html);
		}, function(data) {
			Ego.error(data.returnValue);
		});
	};
	
	if(undefined != $('#sAgentContractNO').val() && $('#sAgentContractNO').val().length > 0) {
		loadContractGoods($('#sAgentContractNO').val());
	}
	
});