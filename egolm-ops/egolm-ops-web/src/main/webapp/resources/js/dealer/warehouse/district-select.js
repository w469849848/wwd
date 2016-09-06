var isAll = false;
$(document).ready(function(){
	var footable = null, $row = null,
	// true为全选，false为未选中
	deleteType = true,
	// true为删除一行,false为批量删除
	$table = $('.table-box table'),
	// 获取表格元素
	$bgRow = null; 
	$('.cust table').footable(
			{ // 响应式表格初始化
				debug : true,
				breakpoints : {
					phone : 600,
					tablet : 980
				},
				log : function(message, type) {
					$bgRow = $table.find('tbody tr').not(
							'.footable-row-detail');
					if (message = 'footable_initialized') {
						$bgRow.each(function(index) {
							if (index % 2 == 1) {
								$(this).css({
									'background' : '#fbfbfb'
								});
							}
						});
					}
					if (message == 'footable_row_expanded'
							|| message == 'footable_row_collapsed') {
						$bgRow.each(function(index) {
							if (index % 2 == 1) {
								$(this).css({
									'background' : '#fbfbfb'
								});
							}
						});
					}
				}
			});
	
		loadDistrictList();
	 
		$('.chk').on('click', function() { //选中/取消选中
			Checked.checked(this);
			if($('.district-check').filter('[checked=checked]').length == $('.district-check').length) {
				$('.check-all').attr('checked',true);
				$('.check-all').parents('label:first').addClass('checked');
				isAll = true;
			}else {
				$('.check-all').attr('checked',false);
				$('.check-all').parents('label:first').removeClass('checked');
				isAll = false;
			}
		});

		$('.batch .chk').on('click', function() { //全选/取消全选
			Checked.selectAll(this, isAll);
			$('.checked-wrap input').each(function(index) {
				Checked.selectAll(this, isAll);
			});
			isAll = !isAll;
		});
		
	$("#query").on('click',function(){
		loadDistrictList();
	});
});

 

function bindClicked(){  
	var selectValue = "";
	var selectName = "";
	$(".district-check").each(function(){
		if($(this).attr("checked")){
			selectValue+=$(this).attr("data-id")+",";
			selectName+=$(this).attr("name")+",";
		}
	});
	parent.getDistrict(selectValue,selectName);
	var index = parent.layer.getFrameIndex(window.name); // 先得到当前iframe层的索引
	parent.layer.close(index); // 再执行关闭
} 

//加载经销商商品类据
function loadDistrictList(){
	 var cityID  = $("#sCityID").val();
	 var districtIDs = $("#districtIDs").val();
	 var sRegionDesc  = $("#sRegionDesc").val();
	$.ajax({
      cache: false,
      type: "POST",
      url:webHost+'/agent/warehouse/districtSelectList', 
      data:'cityID='+cityID+'&sRegionDesc='+sRegionDesc, 
      async: false,
      error: function(request) {
      	Ego.error("系统连接异常,请刷新后重试.",null);
      },
      success: function(data) { 
    	  var dataResult = eval("(" + data + ")");
      	 var isValid = dataResult.IsValid;
      	 if(isValid){
       		var dataList = dataResult.DataList ; 
        		if(dataList.length>0){
					 var shopMsg="";
					 for(var i = 0;i<dataList.length;i++){
						 var data = dataList[i]; 
						 var regionNo = data.sRegionNO;
						 var chk = "";
						 var labelCss = "";
						 if(districtIDs.indexOf(regionNo) != -1){
							 chk = "checked='checked'";
							 labelCss = "checked";
						 }
						 shopMsg += "<tr style='cursor:pointer;' title='"+data.sRegionNO+"' shopNO='"+data.sRegionNO+"' shopName='"+data.sRegionDesc+"'> "
							 + "							<td>"
							 + "					<label class='checked-wrap "+labelCss+"'>"
							 + "						<input type='checkbox' class='chk district-check' name='"+data.sRegionDesc+"'"+chk+"  data-id='"+data.sRegionNO+"'/>"
							 + "						<span class='chk-bg'></span>"
							 + "					</label>"
							 + "				</td>"
							 + "							<td>"+data.sRegionNO+"</td> "
							 + "							<td>"+data.sRegionDesc+"</td> "
							 + "							<td>"+data.sRegionType+"</td> "
							 + "							<td> ";
							 if(data.nTag == 0){
								 shopMsg += "									<span class='state'><img "
									 + "										src='"+webHost+"/resources/egolm/assets/images/circle.png' /> "
									 + "									</span>未禁用 ";
							 }else if(data.nTag == 1){
								 shopMsg+= "									<span class='state'><img "
									 + "										src='"+webHost+"/resources/egolm/assets/images/close.png' /> "
									 + "									</span>已禁用 ";
							 }
							 shopMsg+= "							</td> "
							 + "						</tr>";
						 $("#select_msg_id").html(shopMsg);
					 }
					 var chks = districtIDs.split(",");
					 console.log(districtIDs+"     "+chks.length+"   "+dataList.length)
					 if((chks.length-1) == dataList.length){
						 $(".check-all").attr("checked","checked");
						 $(".check-all").parent("label").addClass("checked");
						 isAll = true;
					 }
					 console.log(isAll);
				 }else{
					 $("#select_msg_id").html("<tr> <td colspan='4' style='text-align: center;'>暂无对应地区</td> </tr>");
				 }
       	}else{
       		var returnValue = dataResult.ReturnValue ;
       		Ego.error(returnValue,null);
       	}
      }
  }); 
} 