jQuery(function($) {

	var footable = null,
		$row = null,
		isAll = false, //true为全选，false为未选中
		$table = $('.table-box table'), //获取表格元素
		$bgRow = null;

	$('.advertisement table').footable({ //响应式表格初始化
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

  

	$('td a.delete').on('click', function(e) { //删除弹窗 
		var adConId = $(this).attr("pid");
		Ego.alert("删除广告合同,将会同步删除对应的广告,是否确认删除？",function(){  
			deleteMediaContract(adConId);
		});
	});
 

	$('.chk').on('click', function() { //选中/取消选中
		Checked.checked(this);
	});

	$('.batch .chk').on('click', function() { //全选/取消全选
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	$("#query").on('click',function(){ //查询
		$("#page_index").val("1");
		$("#limitPageForm").submit();
	})
	
	 $(document).keypress(function(e) {    //回车查询
		    // 回车键事件  
	       if(e.which == 13) {  
	    	   e.preventDefault();  //禁掉回车
	       }  
	 }); 
	 
});


//删除广告位合同
function deleteMediaContract(conid){
	 
	$.ajax({
        cache: false,
        type: "POST",
        url:'delete',
        data:'id='+conid,
        async: false,
        error: function(request) {
        	Ego.error("系统异常,请刷新后重试.",null);
        },
        success: function(data) {
        	  var dataResult = eval("(" + data + ")"); 
         	   var  isValid = dataResult.IsValid;  
         	  var returnValue = dataResult.ReturnValue;
         	  if(isValid){
      			Ego.success(returnValue,function(){
         			window.location.href = webHost + '/media/mediaContract/list';
         		}); 
	      	  }else{
	      		 Ego.error(returnValue,null);
	      	  } 
        }
    });  
}