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
			
		},
		
		addItem : function(){
			
		}
	}
	
	return c;
	
})(window.CheckGroup || {});
