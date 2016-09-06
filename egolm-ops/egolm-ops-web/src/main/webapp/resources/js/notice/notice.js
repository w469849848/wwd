$(function(){
	var footable = null,
	$row = null,
	isAll = false, //true为全选，false为未选中
	$table = $('.table-box table'), //获取表格元素
	$bgRow = null;
	
	var post = function(url, data, success, error, complete) {
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
	

	$('.notice table').footable({ //响应式表格初始化
		debug: true,
		breakpoints: {
			phone: 600,
			tablet: 980
		},
		log: function(message, type) {
			$bgRow = $table.find('tbody tr').not('.footable-row-detail');
			if (message = 'footable_initialized') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
			if (message == 'footable_row_expanded' || message == 'footable_row_collapsed') {
				$bgRow.each(function(index) {
					if (index % 2 == 1) {
						$(this).css({
							'background': '#fbfbfb'
						});
					}
				});
			}
		}
	});
	
	if($('#topOrgMenu').length != 0) {
		loadTOrgs('topOrgMenu', 3);
	}
	
	$('#search-notice').on('click', function(){
		$('#notice-search-form').submit();
	});
	
	$('#modify-notice').on('click', function(){
		var $single = validateNoticeSingle();
		if($single == '')return;
		var $tds = $single.parents('td').siblings();
		window.location.href = webHost + '/api/notice/update?sNoticeId=' + $single.attr('data-id');
	});
	
	var modifyLock = false;
	$('#submit-modify-notice').on('click', function(){
		if(!validator()) return;
		if(modifyLock) return;
		modifyLock = true;
		post(webHost + '/api/notice/update', $('#modify-notice-form').serialize(), function(data){
			Ego.success('更新公告成功！', function() {
				window.location.href = webHost + '/api/notice/index';
			});
		}, function(data){
			Ego.error('更新公告失败！');
		}, function(data) {
			modifyLock = false;
		});
	});
	
	$('#cancel-create-notice').on('click', function(){
		window.location.href = webHost + '/api/notice/query';
	});
	
	var createLock = false;
	$('#submit-create-notice').on('click', function(){
		if(!validator()) return;
		if(createLock) return;
		createLock = true;
		post(webHost + '/api/notice/add', $('#create-notice-form').serialize(), function(data){
			Ego.success('新建公告成功！', function() {
				window.location.href = webHost + '/api/notice/index';
			});
		}, function(data){
			Ego.error('新建公告失败！');
		}, function(data) {createLock = false;});
	});
	
	var validator = function() {
		if($.trim($('input[name=sNoticeTitle]').val()).length < 1) {
			Ego.error('公告标题不能为空！');
		}
		else if($.trim($('input[name=sNoticeTitle]').val()).length > 40) {
			Ego.error('公告标题不能大于40位！');
		}
		else if($.trim($('input[name=sOrgNO]').val()).length < 1) {
			Ego.error('必须选择发布地点！');
		}
		else if($.trim($('input[name=dPubDate]').val()).length < 1) {
			Ego.error('发布时间不能为空！');
		}
		else if($.trim($('input[name=dOutDate]').val()).length < 1) {
			Ego.error('下架时间不能为空！');
		}
		else if(new Date($.trim($('input[name=dPubDate]').val())) >= new Date($.trim($('input[name=dOutDate]').val()))) {
			Ego.error('公告下架时间不能早于公告发布时间！');
		}
		else if(new Date() > new Date($.trim($('input[name=dPubDate]').val()))) {
			Ego.error('发布时间不能早于当前时间！');
		}
		else if($.trim($('textarea[name=sNoticeContent]').val()).length < 1) {
			Ego.error('公告内容不能为空！');
		} 
		else {
			return true;
		}
		return false;
	}
	
	$('.add-box').on('click', '.org-item', function(){
		$('#current-org').text($(this).text());
		$('#sOrgNO').val($(this).attr('value'));
	});
	
	$('#batch-delete-notice').on('click', function(e){
		var $notices = $('.notice-check').filter('[checked=checked]');
		if($notices.length < 1) {
			Ego.error('请选择需要删除的公告！');
			return;
		}
		Ego.alert('确定要批量删除公告！', function(index) {
			var $notices = $('.notice-check').filter('[checked=checked]');
			if($notices.length < 1) return;
			var noticeIds = [];
			$notices.each(function(){
				noticeIds.push($(this).attr('data-id'));
			});
			post(webHost + '/api/notice/delete', {noticeIds : noticeIds}, function(data){
				window.location.href = '';
			},function(data){
				Ego.error('删除失败！');
			},function(data){
			});
		});
	});
	
	$('#submit-batch-delete').on('click', function(){
		
	});
	
	$('.notice-check').on('click', function() { //选中/取消选中
		Checked.checked(this);
		if($('.notice-check').filter('[checked=checked]').length == $('.notice-check').length) {
			$('.check-all').attr('checked',true);
			$('.check-all').parents('label:first').addClass('checked');
			isAll = true;
		}else {
			$('.check-all').attr('checked',false);
			$('.check-all').parents('label:first').removeClass('checked');
			isAll = false;
		}
	});

	$('.check-all').on('click', function() { //全选/取消全选
		Checked.selectAll(this, isAll);
		$('.checked-wrap input').each(function(index) {
			Checked.selectAll(this, isAll);
		});
		isAll = !isAll;
	});
	
	//日期控件
	$('#out-date-picker').datetimepicker({
      	format:'Y-m-d H:m:s',      //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$('#pub-date-picker').datetimepicker({
      	format:'Y-m-d H:m:s',     //格式化日期
      	timepicker:true,    //开启时间选项
      	yearStart:2000,     //设置最小年份
     	yearEnd:2050,        //设置最大年份
      	todayButton:false    //关闭选择今天按钮
	});
	
	$.datetimepicker.setLocale('ch'); //日期插件设置为中文
	
	function validateNoticeSingle() {
		var $checkNotices = $('.notice-check').filter('[checked=checked]');
		if($checkNotices.length < 1) {
			Ego.error('请选择需要更新的公告!');
			return '';
		}
		if($checkNotices.length > 1) {
			Ego.error('不能同时更新多个公告!');
			return '';
		}
		return $checkNotices;
	}
	
	$('.content-tip').on('mouseenter', function() {
		layer.tips('<span>'+$(this).find('input').val()+'</span>', this, {
			area : 'auto',
			maxWidth : '420px', 
			tips : [3, '#78BA32'],
			time : 5000
		});
	});
	
	$('.content-tip span').on('mouseleave', function() {
		layer.closeAll();
	});
	
	$('.cpa').find('span').resizeText(120);
});
(function($) {
	$.fn.resizeText = function(l) {
		var length = l || 100;
		$(this).each(function() {
			length = $(this).attr("length") || length;
			var text = $(this).text();
			if (!text)
				return "";
			var result = "";
			var count = 0;
			for (var i = 0; i < length; i++) {
				var _char = text.charAt(i);
				if (count >= length)
					break;
				if (/[^x00-xff]/.test(_char))
					count++; // 双字节字符，//[u4e00-u9fa5]中文
				result += _char;
				count++;
			}
			if (result.length < text.length) {
				result += "...";
			}
			$(this).text(result);
		})
	};
})(jQuery);