jQuery(function(){
	//区域选择弹窗
	$('.area .filter-select input').on('focus',function(){
		$('#areaAlert').modal('show');
		addressInit('addProvince', 'addCity', 'addArea', '广东', '广州市', '越秀区');
	});
	
	//确定选择区域
	$('#areaAlert .btn-submit').on('click',function(){
		var prov = $('#addProvince').val(),
			city = $('#addCity').val(),
			area = $('#addArea').val();
		
		$('.add-box .area input').val(prov + ','+ city + ',' + area);
		$('#areaAlert').modal('hide');
	});
	
	$('.f-sort input').on('change',function(){
		var $this = $(this),
			val = $this.prop('checked');
		$this.parents('.item-wrap:first').find('.sec-sort .checked-wrap input').prop('checked',val);
	});
	
	$('.sec-tit input').on('change',function(){
		var $this = $(this),
			val = $this.prop('checked');
		$this.parents('li:first').find('.th-sort .checked-wrap input').prop('checked',val);
	});
	
});