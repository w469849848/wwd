"use strict";

var Checked = (function(c){ //选中一行/全选

	c = {
		checked : function(elem){
			var $checked = $(elem),
				$label = $checked.parents('label:first');
				
			if(!!$checked.attr('checked')){
				$label.removeClass('checked');
				$checked.attr('checked',false);
			}else{
				$label.addClass('checked');
				$checked.attr('checked',true);
			}
		},
		selectAll : function(elem,isAll){
			var $checked = $(elem),
				$label = $checked.parents('label:first');
				
			if(isAll){
				$label.removeClass('checked');
				$checked.attr('checked',false);
				
			}else{
				isAll = true;
				$label.addClass('checked');
				$checked.attr('checked',true);
			}
		}
	}
	
	return c;
})(window.Checked || {});
