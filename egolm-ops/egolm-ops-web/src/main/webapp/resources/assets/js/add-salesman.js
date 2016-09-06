jQuery(function($) {

	$('#submit').on('click', function() { //保存编辑
		
		//提交表单
		
		if(true){ //保存成功
			$('#successAlert').modal('show');
		}
		
	});
	
	//区域
	 loadTOrgs("zone-menu","4");
	 var sSalBizZone = $("#sSalBizZone").val(); 
	 if(sSalBizZone !=''){
		 $("#zone-btn").find("span").eq(0).text(sSalBizZone);
	 }
	 $("#zone-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#zone-btn").find("span").eq(0).text(litext);
		 $("#sSalBizZone").val(litext);
		 $("#sSalBizZoneID").val(livalue);
	 });

});