

(function($) {
	var option = {
		print : null,
		url : null,
		async: false,
		param :null,
	};
	$.print = function (o) {
		$.extend(option, o);
		if(null == option.url) {
			alert('url can not be null');
			return;
		}
		if(null == option.param) {
			alert('param can not be null');
			return;
		}
		open(option.print, $.extend(option, resolveParam(option.param, false)));
	}
	$.fn.renderTable = function($form) {
		var $this = this;
		var param = resolveParam($form, false);
		post(param.url, param, function(data) {
			table.render($this, data.data);
		}, function(data) {
			error(data.errors);
		});
	};
	var error = function(msg) {
		alert(msg);
	};
	var post = function(url, data, success, error, complete) {
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			dataType : "json",
			cache : false,
			traditional:true,
			async: option.async,
			success : function(data) {
				if(data.isValid != true) { error && error(data); }
				else { success && success(data); }
			},
			error : function(data){ error && error(data)},
			complete : function(data){ complete && complete(data)},
		});
	};
	var resolveParam = function(param, query) {
		if (param.jquery) {
			if (query) {
				var query = '?';
				var a = param.serializeArray();
				$.each(a, function() {
					query += this.name + '=' + this.value + '&';
				});
				return query;
			} else {
				var query = {};
				var a = param.serializeArray();
				$.each(a, function() {
					query[this.name] = this.value;
				});
				return query;
			}
		}
		if ($(param).length > 0) {
			return resolveParam($(param), query);
		}
		return param;
	};
	var open = function(url, param) {
		var form = '<form class="hidden" action="' + url + '" target="_blank" method="post">';
		$.each(param, function(key, value) {
			form += '<input type="hidden" name="' + key + '" value="' + value + '"/>';
		});
		form += '</form>';
		$(form).submit();
	};
	var table = {};
	table.render = function($self, data) {
		var title = table.resolveTitle(data);
		var body = table.resolveBody(data.dataList);
		$self.empty();
		$self.html('<table cellpadding="0" cellspacing="0" border="0" class="display" id="table" style="width: 1080px;"></table>');
		$self.find('table').eq(0).dataTable({
			"info": false,
			"ordering": false,
			"paging": false,
			"processing": true,
			"searching": false,
			"data" : body,
			"columns" : title,
		});
	};
	table.resolveTitle = function(data) {
		var title = [];
		var dic = data.dictionary;
		var list = data.dataList[0];
		var titleSort = [];
		for ( var l in list) {
			titleSort.push(l);
		}
		for ( var index in titleSort) {
			var column = {};
			column['title'] = dic[titleSort[index]];
			column['class'] = 'center';
			title.push(column);
		}
		return title;
	};
	table.resolveBody = function(data) {
		var body = [];
		for(var i in data) {
			var row = [];
			$.each(data[i], function(key, value) {
				row.push(value);
			});
			body.push(row);
		}
		return body;
	};
})(jQuery);