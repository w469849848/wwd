jQuery(function($) {
	var 	$table = $('.table-box table'); //获取表格元素 
	$('.goods-import table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 980
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail');
			if (message = 'footable_initialized') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
		}
	});
	
	//单选组
	$(document).on('click','.chk-radio',function(){
		$('.table-step1 .chk-radio').attr('checked',false);
		$(this).attr('checked',true);
	});
	
	$(document).on('click','.chk',function(){
		Checked.checked(this);
	});
	
	$('.next-step').on('click',function(){ //下一步 
		step = $(this).attr("step");
		if(step == 1){
			var first_sAgentContractNO_value = "";
			$('input[name="sAgentContractNO_first"]').filter('[checked="checked"]').each(function(){ 
				first_sAgentContractNO_value= $(this).val();
			});
			if(first_sAgentContractNO_value == ''){ 
				Ego.error("请选择一个合同",null);
				return false;
			}
			
			 window.location.href=webHost+"/goods/tGoodsDealer/importSecond?sAgentContractNO="+first_sAgentContractNO_value; 
 		}
	});

});