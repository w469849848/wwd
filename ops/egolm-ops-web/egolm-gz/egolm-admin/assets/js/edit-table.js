"use strict";

var TableEdit = (function(c){
	c.util = {
		getTableHead : function(elem){ //获取 表头 & 要编辑行的内容
			var $parent = $(elem).parents('table:first'),
				$row = $(elem).parents('tr:first'),
				headContent = null,editContent = null,
				headArr = [],editArr = [];
			
			headContent = $parent.find('thead tr th');
			editContent = $row.find('td');
			headContent.each(function(index){
				if(index != 0 && index != (headContent.length - 1)){
					headArr.push($(this).text());
				}
			});
			editContent.each(function(index){
				if(index != 0 && index != (editContent.length - 1)){
					editArr.push($(this).text());
				}
			});
			
			return {head : headArr , edit : editArr};
		},
		createForm : function(elem,id){ //生成表单
			var formElem = '',
				formData = this.getTableHead(elem),
				dataLen = formData.head.length;
			
			for(var i = 0;i < dataLen;i++){
				formElem += '<p><label><span>'+formData.head[i]+'：</span><input type="text" value="'+formData.edit[i]+'" /></label></p>';
			}
			formElem += '<p><label><input id="submit" type="button" value="保存" /></label><label><input type="button" data-dismiss="modal" value="取消" /></label></p>';
			
			$('#'+id+' form').empty().append(formElem);
		}
	}
	return c;
})(window.TableEdit || {});
