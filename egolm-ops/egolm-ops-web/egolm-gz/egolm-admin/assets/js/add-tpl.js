jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交表单
		
		if(true){ //保存成功
			$('#successAlert').modal('show');
		}
		
	});
	
	//调价模块弹窗样式调整
	$('.add-tpl .tpl-nav ul li').css({'width': (100/$('.add-tpl .tpl-nav ul li').length) + '%'});
	
	//添加模块
	$('#btn-add-tpl').on('click',function(){
		
		$('#addTplAlert').modal('show');
		
	});
	
	//添加模板--切换分类
	$('.tpl-nav ul li').on('click',function(){
		var $this = $(this),
			idx = $this.index(),
			$showItem = $this.parents('.tpl-wrap:first').find('.tpl-list-wrap .tpl-list');
			
		$this.addClass('active').siblings().removeClass('active');
		
		$showItem.addClass('hide').eq(idx).removeClass('hide');
		
	});

});