jQuery(function(){
	//区域选择弹窗
	$('.area .filter-select input').on('focus',function(){
		$('#areaAlert').modal('show');
		addressInit('addProvince', 'addCity', 'addArea', '广东', '广州市', '越秀区');
	});
	
	//确定选择区域
	$('#areaAlert .btn-submit').on('click',function(){
		var prov = $('#addProvince option:selected').text(),
			city = $('#addCity option:selected').text(),
			area = $('#addArea option:selected').text(),
			areaValue = $('#addArea option:selected').val();
		
		$('.add-box .area input').val(prov + ','+ city + ',' + area);
		$('input[name="sOrgNO"]').val(areaValue);
		$('input[name="sOrgName"]').val(area);
		$('#areaAlert').modal('hide');
		
		return;
	});
	
	$('.f-sort input').on('change',function(){
		var $this = $(this),
			val = $this.prop('checked');
		$this.parents('.item-wrap:first').find('.sec-sort .checked-wrap input').prop('checked',val);
	});
	
	$('.sec-tit input').on('change',function(){
		var $this = $(this),
			val = $this.prop('checked');
		//加
		if(val){
			$this.parents('.item-wrap:first').find('.f-sort .checked-wrap input:first').prop('checked',val);
		}
		
		$this.parents('li:first').find('.th-sort .checked-wrap input').prop('checked',val);
	});
	
	//三级点击事件
	$('.th-sort .checked-wrap input').on('click',function(){
		var $this = $(this),
			val = $this.prop('checked');
		if(val){
			$this.parents('.item-wrap:first').find('.f-sort .checked-wrap input:first').prop('checked',val);
			$this.parent().parent().parent().parent().siblings('div.sec-tit:first').find('.checked-wrap input:first').prop('checked',val);
		}
	});
	
	//店铺类型选择
	$('#scope-ul').on('click','li',function(){
		
		$('input[name="sScopeTypeID"]').val($(this).attr('val'));
		$('input[name="sScopeType"]').val($(this).text());
		$('#scope-name').text($(this).text());
		
	});
	
	//表单异步提交
	$('#categoryForm').ajaxForm(function(data) { 
		//关闭
		layer.close($index);   
		
	  	var res = JSON.parse(data);
      	if(res.IsValid==true){
      		layer.alert(res.ReturnValue, {icon: 1}, function(index){
    			layer.close(index);
    			window.location.href="list"; 
    		});
      	}else{
      		layer.alert(res.ReturnValue, {icon: 2}, function(index){
    			layer.close(index);
    		});
      	}
   });
	
});

//处理表单
function commitForm(){
	if(validatorForm()){
		$("#categoryForm").submit();
		$index = layer.load(0, {shade: [0.2, '#393D49']}); 
	}
}

//表单验证
function validatorForm(){
	if(!!!$('input[name="sOrgNO"]').val()){
		layer.alert("请选择所属区域", {icon: 3}, function(index){
			layer.close(index);
		});
		return false;
	}
	
	if(!!!$('input[name="sScopeTypeID"]').val()){
		layer.alert("请选择店铺类型", {icon: 3}, function(index){
			layer.close(index);
		});
		return false;
	}
	
	var $this = $('.chk:checked');
	if($this.length == 0){
		layer.alert("请选择商品分类", {icon: 3}, function(index){
			layer.close(index);
		});
		return false;
	}else{
		var category = [];
		$this.each(function(){
			//console.log("分类编号:"+$(this).attr("scategoryNO")+",分类名称:"+$(this).attr("scategoryName")+",分类等级:"+$(this).attr("level")+",上级编号:"+$(this).attr("supCategoryNO"));
			var cg = $(this).attr("scategoryNO")+","+$(this).attr("scategoryName")+","+$(this).attr("level")+","+$(this).attr("supCategoryNO");
			category.push(cg);
		});
		$('input[name="cateItems"]').val(category.join('-'));
	}
	
	return true;
}