'use strict'

var CheckGroup = (function(c){
	c = {
		showChecked : function(obj){
			var checkData = [];
			$(obj).parents('div.item-group-wrap:first').find('div.item-group').each(function(){
				var $this = $(this),
					isCheck = false,
					secondType = $this.find('h1').text(),
					checkVal = [];
				$(this).find('input[type=checkbox]').each(function(){
					if( $(this).attr('checked') == 'checked' ){
						if( !isCheck ){
							isCheck = true;
							checkVal.push(secondType);
						}
						checkVal.push( $(this).parents('div.sort-checkbox:first').find('span.item-name').text() );
					}
				});
				if( checkVal.length > 0 ){
					checkData.push(checkVal);
				}
			});
			return checkData;
		},showCheckedLevel : function(obj){
			var checkDataLevel = [];
			$(obj).parents('div.item-group-wrap:first').find('div.item-group').each(function(){
				var $this = $(this),
				isCheck = false,
				category_level_id = $this.find('h1').attr('id'),
				checkVal = [];
				$(this).find('input[type=checkbox]').each(function(){
					if( $(this).attr('checked') == 'checked' ){
						if( !isCheck ){
							isCheck = true;
							checkVal.push(category_level_id);
						}
						checkVal.push($(this).parents('div.sort-checkbox:first').find('span.item-name').attr('id'));
					}
				});
				if( checkVal.length > 0 ){
					checkDataLevel.push(checkVal);
				}
			});
			return checkDataLevel;
		},
		addItem : function(){
		}
	}
	return c;
})(window.CheckGroup || {});

jQuery(function($){
	/**
	 * 三级菜单多选
	 * 
	 */
	//停止冒泡
	var goodsData = [];
	var goodsDataIds = [];
	$('.item-group').on('click',function(e){ e.stopPropagation(); });
	//选中效果 -- 二级分类
	$('.sec-level-wrap .item-group-wrap .chk').on('click',function(){
		var data = [],str='',i = 0,j=1;
		Checked.checked(this);
		data = CheckGroup.showChecked(this);
		for(;i < data.length;i++){
			for(;j < data[i].length;j++){
				if(j == 1){
					str = str + data[i][j];
				}else{
					str = str + ',' + data[i][j];
				}
			}
		}
//		var level_2_value = $(this).parents('.item-group').find('h1').attr('id');
		$(this).parents('div.dropdown-wrap:first').find('span.check-content').text(str);
//		$(this).parents('div.dropdown-wrap:first').find('span.check-content').attr("id",level_2_value);
	});
	
	//选中效果 -- 三级分类
	$('.three-lv-wrap .item-group-wrap .chk').on('click',function(){
		var str='';
		Checked.checked(this);
		goodsData = CheckGroup.showChecked(this);
		goodsDataIds = CheckGroup.showCheckedLevel(this);
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
		var level_2_value = $(this).parents('.item-group').find('h1').attr('id');
		$(this).parents('div.dropdown-wrap:first').find('span.check-content').attr("id",level_2_value);
	});
	
	//添加分类
	$('.good-sort .btn-add').on('click',function(){
		var categoryID = $('.first-level-wrap .check-content').attr('id'),
			  fSort = $('.first-level-wrap .check-content').text(),
			  html = '<li class="sort-item active" ><input type="hidden" id="level_1_categoryId" value="'+categoryID+'"/><div><a  onclick="$(this).parent().remove();" href="javascript:void(0)"><img src="../../../resources/assets/images/btn-delete.png"></a><h2>'+ fSort +'</h2>';
		for(var i = 0;i < goodsData.length;i++){
			var pHtml = '';
			for(var j = 0;j < goodsData[i].length;j++){
				if( j == 0 ){
					pHtml = '<p><input type="hidden" id="level_2_categoryId" value="'+goodsDataIds[i][j]+'"/><span>'+ goodsData[i][j] +'：</span>'
				}else{
					pHtml += '<i><input type="hidden" id="level_3_categoryId" value="'+goodsDataIds[i][j]+'" name="'+goodsData[i][j]+'"/>' + goodsData[i][j] +'</i>';
				}
			}
			pHtml += '</p>';
			html += pHtml;
		}
		html += '</div></li>';
		$('form > .scroll-wrap > ul').append(html);
	});
	
});