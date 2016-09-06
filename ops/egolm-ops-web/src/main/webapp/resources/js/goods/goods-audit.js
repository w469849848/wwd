jQuery(function($) {

	var isAll = false; //是否全选

	$('.goods table').footable({ //响应式表格初始化
		breakpoints: {
			phone: 480,
			tablet: 1200
		}
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
	
	//分类
	loadCategoryTree("category-memu","sCategoryNO");
	
	//加载区域
	 loadTOrgs("zoneCode-menu","4");
	 var sOrgNO_u = $("#sOrgNO").val();
	 if(sOrgNO_u != ''){  //查询返回后  
		  $("#zoneCode-menu").find("li").each(function(){
			  if($(this).attr("value")==sOrgNO_u){
				  $("#zoneCode-id").find("span").eq(0).text($(this).text()); 
			  }
		 }); 
	 }
	 $("#zoneCode-menu li").click(function(){//新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#zoneCode-id").find("span").eq(0).text(litext);
		 $("#sOrgNO").val(livalue); 
 	 });
	 
	 
	
	//审核状态
	var nTag_u  = $("#nTag").val();
	if(nTag_u != ''){
		$("#ntag-memu").find("li").each(function(){ 
			 if($(this).attr("value") ==nTag_u){  
				  $("#ntag-id").find("span").eq(0).text($(this).text());
			 }
		});
	}
	
	$("#ntag-memu li").click(function(){  //新增时
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#ntag-id").find("span").eq(0).text(litext);
		 $("#nTag").val(livalue);  
	 });
	
	$(document).keypress(function(e) {    //回车查询
		if (window.event && window.event.keyCode == 13) {
            window.event.returnValue = false;
        }
	 }); 
	
	 $("#query").on('click',function(){  //查询
		 $("#limitPageForm").submit();
	});
});