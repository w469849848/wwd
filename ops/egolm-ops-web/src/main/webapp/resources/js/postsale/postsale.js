$(function(){

	$('#search-advice').on('click', function(){
		$('#advice-search-form').submit();
	});
	
	$('.reply-advice').on('click', function() {
		var $div = $(this).parents('div:first');
		$div.append('<div><div><textarea style="min-width:550px;max-width: 800px;"></textarea></div><div><input type="button" class="submit-apply" value="提交"/><input type="button" class="cancel-apply" value="取消"/></div></div>');
	});
	
	$('body').on('click', '.submit-apply', function() {
		var reply = $.trim($(this).parent('div').parent().find('textarea').eq(0).val());
		if(reply.length < 15) {
			Ego.error('回复不能少于15字');
			return;
		}
		var param = {};
		param.nAdviseID= $.trim($(this).parents('tr:first').attr('data-id'));
		param.sContent=reply;
		HTTP.postEgox(webHost + '/postsale/advice/reply', param, function(data) {
			Ego.success('回复成功', function() {
				window.location.href = '';
			})
		}, function(data) {
			Ego.error(data.ReturnValue);
		});
	});
	
	$('body').on('click', '.cancel-apply', function() {
		$(this).parent('div').parent().remove();
	});
});