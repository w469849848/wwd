
function createPaginationHtml(dataResult,type){  
	 var page  = dataResult.page;
	 var index = page.index;
	 var pageTotal = dataResult.pageTotal;
	 var pageIndex = dataResult.pageIndex;
	
	 var floatIndex = index-1;
	 var rightIndex = index+1;
	 //console.log(index+"----"+pageIndex);
	  //console.log("=index="+index+"=pageTotal="+pageTotal+"==pageIndex="+pageIndex+"-floatIndex-"+floatIndex+"==rightIndex="+rightIndex);
	 
	 //设置分页
	 var paginationMsg = "";
	 paginationMsg+="<ul class='clearfix'>";
	 paginationMsg+="	<li>";
	 paginationMsg+="		<a href='#' onclick='limitOnclick("+index+",\""+type+"\")' class='nav_first'></a>";
	 paginationMsg+="	</li>";
	 paginationMsg+="	<li>";
	 paginationMsg+="		<a href='#' onclick='limitOnclick("+floatIndex+",\""+type+"\")' class='nav_float'></a>";
	 paginationMsg+="	</li>";
	     for(var i=1;i<=pageIndex;i++){ 
	 paginationMsg+="		<li class='active'>";
	 paginationMsg+="			<a href='#' onclick='limitOnclick("+i+",\""+type+"\")'>"+i+"</a>";
	 paginationMsg+="		</li>"; 
	     } 
	 paginationMsg+="	<li>";
	 if(pageTotal > index){
		 paginationMsg+="		<a href='#'  onclick='limitOnclick("+rightIndex+",\""+type+"\")'  class='nav_right'></a>"; 
	 }else{
		 paginationMsg+="		<a href='#'    class='nav_right'></a>";
	 }
	
	 paginationMsg+="	</li>";
	 paginationMsg+="	<li>";
	 paginationMsg+="		<a href='#'  onclick='limitOnclick("+pageTotal+",\""+type+"\")'  class='nav_last'></a>";
	 paginationMsg+="	</li>";
	 paginationMsg+="</ul>";
	 return paginationMsg;
}


function  limitOnclick(index,type){
	 
	 
	 if(type == 'loadGoodsMsg'){  //商品导入第二步，选择商品
		loadGoodsMsg(index);
	 }
	 if(type =='loadDtlMsg'){  //商品审核详情列表
		 loadDtlMsg(index);
	 }
	 if(type == 'goodsPuyawayMsg'){ //商品上下架
		 loadAcGoodsMsg(index);
	 }
}

//memuId  为下拉列表对应的ID
//hiddenId 为隐藏值的ID
function loadCategoryTree(memuId,hiddenId){
	$.ajax({
		cache: false,
        type: "POST", 
        url:webHost+'/goods/catgory/categoryJsonTree',  
        async: false, 
        error: function(request) {
        	Ego.error("系统连接异常,请刷新后重试.",null);
        },
        success: function(data) {
        	var dataResult = eval("(" + data + ")"); 
          	var IsValid = dataResult.IsValid;   
          	if(IsValid){
          		var dataList3 = dataResult.DataList;
          		
          		if(dataList3.length>0){ 
          			var categoryTreeMsg = "<li value=''>全部</li>";
          			for(var i =0 ;i<dataList3.length;i++){
          				var data3 = dataList3[i];
           				categoryTreeMsg+="<li value="+data3.scategoryNO+">";
          				categoryTreeMsg+="	<span class='item-name'>"+data3.scategoryName+"</span>";
          				categoryTreeMsg+="	<ul class='lv-second'>";
          				var  dataList2 = data3.child;
          				if(dataList2.length>0){
          					for(var j=0;j<dataList2.length;j++){
          						var data2 = dataList2[j];
          						categoryTreeMsg+="		<li value="+data2.scategoryNO+">";
                  				categoryTreeMsg+="			<span class='item-name'>"+data2.scategoryName+"</span>";
                  				categoryTreeMsg+="			<ul class='lv-third'>";
                  				
                  				var dataList1 = data2.child;
                  				if(dataList1.length>0){ 
                  					 for(var k=0;k<dataList1.length;k++){
                  						var data1 = dataList1[k];
                  						categoryTreeMsg+="	 <li value="+data1.scategoryNO+"><span class='item-name'>"+data1.scategoryName+"</span></li>";
                  					} 
                  				} 
                  				categoryTreeMsg+="			</ul>";
                  				categoryTreeMsg+="		</li>"; 
          					}
          				}
          			
          				categoryTreeMsg+="	</ul>";
          				categoryTreeMsg+="</li>";
          			} 
          			$("#"+memuId).html(categoryTreeMsg);
          			
          		//三级菜单 --- 一级
          			$('.lv-first>li').hover(function(){
          				$('.lv-first').find('.select').removeClass('select');
          				$(this).addClass('select').siblings().removeClass('select');
          			},function(){
          				var lv3_value = $(this).attr('value');
          				var lv3_text = $(this).text();
          				if(lv3_text == '全部'){ //全部
          					$("#"+hiddenId).val(lv3_value); //设置选中值的分类ID
 
              				$(this).parents('ul.lv-first:first').siblings('.dropdown-btn').find('.item-name').text(lv3_text);
          					
          				}
          			});
          			
          			//三级菜单 --- 二级
          			$('.lv-second>li').hover(function(){
          				$('.lv-second').find('.select').removeClass('select');
          				$(this).addClass('select').siblings().removeClass('select');
          			},function(){});
          			
          			$('.lv-third>li').on('click',function(){
          				
          			});
          			
          			//第三级点击,显示选择信息
          			$('.lv-third>li').on('click',function(e){
          				var $this = $(this),
          					lv3 = $this.find('.item-name').text(),
          					lv2 = $this.parents('ul.lv-third:first').siblings('.item-name').text(),
          					lv1 = $this.parents('ul.lv-second:first').siblings('.item-name').text();
          				 
          				$("#"+hiddenId).val($this.attr('value')); //设置选中值的分类ID
          				$this.parents('ul.lv-first:first').siblings('.dropdown-btn').find('.item-name').text(lv1 + ',' + lv2 + ',' + lv3);

          			}); 
          		}
          	}
          	
         	 
        }
    });
}

/**
 * 适配3.0系统的ajax分页
 */
var ajaxPager = {
	page : {},
	callback : function(){},
	render : function(page, callback) {
		var bindListener = function() {
			$(document).off('click', '.pager');
			$(document).on('click', '.pager', function() {
				var $a = $(this).find('a');
				var page = {
					index : $a.attr('data-index'),
					limit : $a.attr('data-limit')
				};
				var currentIdx = $.trim($(this).siblings().filter('.active').text());
				if(currentIdx == page.index) return;
				callback(page);
			});
		};
		page = page;
		callback = callback;
		bindListener();
		return ajaxPager.html(page);
	},
	html : function(page) {
		var index = page.index || 1;
		var total = page.total || 1;
		var limit = page.limit || 10;
		var pageTotal = Math.ceil(total/limit);
		var start = index < 7 ? 1 : ((pageTotal - 6) < index ? (pageTotal - 6) : (index - 3));
		var end = start + 6 > pageTotal ? pageTotal : (start + 6);
		var html = '';
		html += '<div class="navigation_bar pull-right">';
		html += '<ul class="clearfix">';
		html += '<li class="pager"><a href="javascript:void(0);" data-index="1" data-limit="'+limit + '" class="nav_first '+(index == 1 ? "page-disable" : "")+'"></a></li>';
		html += '<li class="pager"><a href="javascript:void(0);" data-index="' + (index - 1 > 0 ? index - 1 : 1) + '" data-limit="' + limit + '" class="nav_float '+(index == 1 ? "page-disable" : "")+'"></a></li>';
		if (pageTotal > 7 && (start+3) > (pageTotal / 2)) {
			html += '<li><a href="javascript:void(0)">…</a></li>';
		}
		for (var idx = start; idx <= end; idx++) {
			if (idx == index) {
				html += '<li class="active"><a href="javascript:void(0)">' + idx + '</a></li>';
			} else {
				html += '<li class="pager"><a href="javascript:void(0)" data-index="' + idx + '" data-limit="' + limit + '">' + idx + '</a></li>';
			}
		}
		if (pageTotal > 7 && (start+3) <= (pageTotal / 2)) {
			html += '<li><a href="javascript:void(0)">…</a></li>';
		}
		html += '<li class="pager"><a href="javascript:void(0);" data-index="' + (index + 1 > pageTotal ? pageTotal : index + 1) + '" data-limit="' + limit + '" class="nav_right '+(index == pageTotal ? "page-disable" : "")+'"></a></li>';
		html += '<li class="pager"><a href="javascript:void(0);" data-index="' + pageTotal + '" data-limit="' + limit + '" class="nav_last '+(index == pageTotal ? "page-disable" : "")+'"></a></li>';
		html += '</ul>';
		html += '</div>';
		return html;
	}
};


var HTTP = {};
HTTP.postAjx = function(url, data, success, error, complete) {
	$.ajax({
		type : 'POST',
		url : url,
		data : data,
		dataType : "json",
		cache : false,
		traditional:true,
		success : function(data) {
			if(data.statusCode != 200) { error && error(data); }
			else { success && success(data); }
		},
		error : function(data){ error && error(data)},
		complete : function(data){ complete && complete(data)},
	});
};

HTTP.postEgox = function(url, data, success, error, complete) {
	$.ajax({
		type : 'POST',
		url : url,
		data : data,
		dataType : "json",
		cache : false,
		traditional:true,
		success : function(data) {
			if(!data.IsValid) { error && error(data); }
			else { success && success(data); }
		},
		error : function(data){ error && error(data)},
		complete : function(data){ complete && complete(data)},
	});
};