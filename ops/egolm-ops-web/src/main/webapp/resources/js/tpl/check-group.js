'use strict'
var CheckGroup = (function(c){
	c = {
		showChecked : function(obj){
			var checkData = [];
			$(obj).parents('div.item-group-wrap:first').find('div.item-group').each(function(){
				var $this = $(this),
					isCheck = false,
					secondType = $this.find('h1:last').text(),
					checkVal = [];
				$(this).find('input[type=checkbox]').each(function(){
					if( $(this).attr('checked') == 'checked' ){
						if( !isCheck ){
							isCheck = true;
							checkVal.push(secondType);
						}
						checkVal.push($(this).parents('div.sort-checkbox:first').find('span.item-name').text() );
					}
				});
				if( checkVal.length > 0 ){
					checkData.push(checkVal);
				}
			});
			return checkData;
		},
		addItem : function(){
		}
	}
	return c;
})(window.CheckGroup || {});

jQuery(function($){
		//停止冒泡
		var goodsData = [];
		
		$('.item-group').on('click',function(e){ e.stopPropagation(); });
		//选中效果 -- 三级分类
		$('.three-lv-wrap .item-group-wrap .chk').on('click',function(){
			var str='';
			Checked.checked(this);
			goodsData = CheckGroup.showChecked(this);
			for(var i = 0;i < goodsData.length;i++){
				for(var j = 1;j < goodsData[i].length;j++){
					if( j == 1 && i == 0 ){
						str = str + goodsData[i][j];
					}else{
						str = str + ',' + goodsData[i][j];
					}
				}
			}
			$(this).parents('div.dropdown-wrap:first').find('span.check-content').text(str);
		});
		
		//添加分类
		$('.good-sort .btn-add').on('click',function(){
			var isChose = false;
			var repeatName =[];
			$('div.item-group').find('input[type=checkbox]').each(function(){
				if($(this).attr('checked') == 'checked' ){
					var id = $(this).val();
					$('div .scroll-wrap').find('input[id=goodsIs]').each(function(){
						if(id == $(this).val()){
							isChose = true ;
							repeatName.push($(this).parent().parent().text());
						}
					});
				}
			});
			if(isChose){
				alert('请勿重复选择【'+repeatName.join(',')+'】商品分类！');
			}else{
					$('div.item-group').find('input[type=checkbox]').each(function(){
						if($(this).attr('checked') == 'checked' ){
							var html = "<li class='sort-item active'><div><a onClick='removeLi(this);' href='javascript:void(0)'><img src='../../../resources/assets/images/btn-delete.png'></a><h2></h2>";
							html +="<p>"+$(this).parents('div.sort-checkbox:first').find('span.item-name').text()+"<i><input type='hidden' value='"+$(this).val()+"'  id='goodsIs' attr='"+$(this).attr('attr')+"'/></i></p></div></li>"
							$('form > .scroll-wrap > ul').append(html);
						}
					});
			}
		});
		
		//初始化商品分类
		var checkContent = $('.check-content').text();
		if("未选择"==checkContent){
			var checkContentResult = "";
			var categoryJson = parent.getCategoryJson();
			if(categoryJson!=""&&categoryJson!= undefined){
				var categoryResult = eval(categoryJson); 
				if(categoryResult.length>0){
					var html = '';
					for(var i=0;i<categoryResult.length;i++){
							 html += '<li class="sort-item active">'+
							 '<div><a onclick="removeLi(this);" href="javascript:void(0)">'+
								'<img src="../../../resources/assets/images/btn-delete.png"></a><h2></h2>'+
								'<p>'+categoryResult[i].categoryName+'<i><input type="hidden" value="'+categoryResult[i].categoryID+'" id="goodsIs" attr="'+categoryResult[i].categoryName+'"></i></p>'+
							'</div></li>';
							 checkContentResult+=categoryResult[i].categoryName+",";
						}
					}
					$('form > .scroll-wrap > ul').append(html);
				}
			$('.check-content').text(checkContentResult);
		}
});
