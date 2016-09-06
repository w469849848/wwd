$(function(){
	
	//日期控件
	$('#dCreateTime').datetimepicker({
		format : 'Y-m-d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	
	//日期控件
	$('#dAuditTime').datetimepicker({
		format : 'Y-m-d H:i', //格式化日期
		timepicker : true, //开启时间选项
		yearStart : 2000, //设置最小年份
		yearEnd : 2050, //设置最大年份
		todayButton : false
	//关闭选择今天按钮
	});
	
	$("#submit").click(function(){
		var sLineName = $("#sLineName").val();
		var dActiveTime = $("#dActiveTime").val();
		var dCreator = $("#dCreator").val();
		var dCreateTime = $("#dCreateTime").val();
		var sAuditor = $("#sAuditor").val();
		var dAuditTime = $("#dAuditTime").val();
		var sRemark = $("#sRemark").val();
		var sTemplateId = $("#nSalTypeId").val();
		var sTemplateName = $("#sSalType").text();
		
		$.ajax({
			url:'toAddLine',
			type:'POST',
			dataType:'json',
			data:{
				sLineName:sLineName,
				dActiveTime:new Date(),
				dCreator:dCreator,
				dCreateTime:new Date(dCreateTime),
				sAuditor:sAuditor,
				dAuditTime:new Date(dAuditTime),
				sRemark:sRemark,
				sTemplateId:sTemplateId,
				sTemplateName:sTemplateName
			},
			success:function(data){
				if(data){
					window.location.href = "lineList";
				}else{
					
				}
			}
		});
	});
	
	
	 var sSalType = $("#sSalType").val();
	 if(sSalType !=''){
		 $("#template-btn").find("span").eq(0).text(sSalType);
	 }
	 $("#template-menu li").click(function(){
		 var litext = $(this).text();
		 var livalue =  $(this).attr("value"); 
		 $("#template-btn").find("span").eq(0).text(litext);
		 $("#nSalTypeId").val(livalue);
		 $("#sSalType").val(litext);
	 });
	 
	 $('#task-tel-options');
	
	 $('#select-shop').on('click', function(){
		 layer.open({
				type : 2,
				title : '选择业务员',
				shadeClose : true,
				shade : 0.6,
				area : [ '70%', '80%' ],
				content : webHost + '/shop/list/dialog',
		});
	 });
	 
	 $(document).on('click', '.shop-index', function(){
		 globalShops.splice($(this).attr('data-i'), 1);
		 renderShopTable();
	 });
	 
	 
	 $('#submit-line-create').on('click', function(){
		 if($.trim($('#sLineName').val()) == '') {
			 Ego.error('线路名称不能为空');
			 return;
		 }
		 var $nos = $('select[name=sTemplateIds]');
		 if(undefined == $nos || $nos.length < 1) {
			 Ego.error('必须选择线路上的店铺');
			 return;
		 }
		 var pass = true;
		 $nos.each(function(){
			 if(undefined == $(this).val() || $(this).val().length < 1) {
				 pass = false
			 }
		 });
		 if(!pass) {
			 Ego.error('请选择线路任务模板');
			 return;
		 }
		 HTTP.postAjx(webHost + '/salesman/line/create', $('#salesFrom').serialize(), function(){
			 Ego.success('新建线路成功', function(){
				 window.location.href = webHost + '/salesman/taskList';
			 })
		 }, function(){
			 Ego.error('新建线路失败');
		 });
	 });
});

function submit(){
	
}

var globalShops = [];
function selectShops(shops) {
	for(var i in globalShops) {
		for(var j in shops) {
			if(globalShops[i].sShopNO == shops[j].sShopNO) {
				Ego.error('店铺：'+shops[j].sShopName+'已被添加进当前线路');
				return;
			}
		}
	}
	for(var i in shops) {
		globalShops.push(shops[i]);
	}
	renderShopTable();
	layer.closeAll();
}


var renderShopTable = function() {
	var html = '';
	for(var i in globalShops) {
	html += '<tr>';
	html += '<td><input type="hidden" name="sShopNOs" value="'+globalShops[i].sShopNO+'"/>'+globalShops[i].sShopNO+'</td>';
	html += '<td><input type="hidden" name="sShopNames" value="'+globalShops[i].sShopName+'"/>'+globalShops[i].sShopName+'</td>';
	html += '<td><input type="hidden" name="sAddresses" value="'+globalShops[i].sAddress+'"/>'+globalShops[i].sAddress+'</td>';
	html += '<td>'
	html += '<select name="sTemplateIds" class="selectpicker task-select" data-width="140px" title="任务模板">';
	html +=	'<option></option>';
	html +=	'</select>';
	html += '</td>';
	html += '<td>';
	html +=	'<span class="shop-index" data-i="'+i+'"><img src="'+resourceHost+'/images/close.png" /></span>';
	html += '<input type="hidden" name="nIndexs" value="'+i+'"/>';
	html += '</td>';
	html += '</tr>';
	}
	$('.shop-info').empty();
	$('.shop-info').append(html);
	$('.task-select').empty();
	$('.task-select').append($('#task-tel-options').html())
	$('.task-select').selectpicker('refresh');
}