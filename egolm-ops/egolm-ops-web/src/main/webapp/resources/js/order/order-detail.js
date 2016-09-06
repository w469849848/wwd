jQuery(function($) { 
	$("#query").on('click',function(){ //查询 
		console.log('121212');
		$("#page_index").val("1");
		$("#limitPageForm").submit();
	}); 
}); 