jQuery(function(){ 
	var queryName = $("#queryName").val(); 
	var url = '/data/generalReport/idcTitleByName?queryName='+queryName;
	
	loadQueryMsg(url);  //加载标题 
	//查询结果
	$(".report-alert .r-box").on('click',function(){
		if(check()){
			loadDataMsg(1,'child');	
		}
	});
});