jQuery(function(){

	//判断已选分类
	$('input[type="checkbox"]').each(function(){
		var $this = $(this);
		if($items.indexOf("["+$(this).attr('scategoryNO')+"]") > -1){
			$this.prop('checked', true);
		}
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