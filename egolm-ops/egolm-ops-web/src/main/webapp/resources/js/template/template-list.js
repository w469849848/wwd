$(document).ready(function() {
	$("#TplPageCreateButton").click(function() {
		ToCreateTplPage();
	});
	$("#TplPageFlushButton").click(function() {
		ToFlushTplPage();
	});
});

function ToFlushTplPage() {
	$.jwindow({
		url: "clear",
		title: "刷新缓存",
		confirm: function(win) {
			$("#TplFlushForm").ajaxSubmit({
				dataType: "json",
				async: false,
				success: function(json) {
					if(json.IsValid) {
						$.closeJWindow(win);
						$.jalert({
							title : "友情提示",
							message : "操作成功",
							confirmButton : "关闭"
						});
					} else {
						$.jalert({
							title : "友情提示",
							message : "操作失败",
							confirmButton : "关闭"
						});
					}
				}
			});
		}
	});
}

function ToCreateTplPage(nTplPageID) {
	var tit = "新增模板";
	if(nTplPageID != ""){
		tit = "修改模板";
	}
	$.jwindow({
		url : "add",
		title : tit,
		data: {nTplPageID:nTplPageID},
		confirm : function(windowid) {
			var tplName = $("#tplpage_sPageName").val();
			if(!tplName || tplName.length == 0) {
				alert("模板名称不能为空");
				return;
			}
			$("#TplCreateForm").ajaxSubmit({
				dataType : "json",
				async : false,
				success : function(json) {
					if(json.IsValid) {
						$.closeJWindow(windowid);
						$.jalert({
							title : "友情提示",
							message : "操作成功",
							confirmButton : "关闭",
							confirm : function() {
								window.location.reload(true);
							}
						});
					} else {
						$.jalert({
							title : "友情提示",
							message : "操作失败",
							confirmButton : "关闭",
							confirm : function() {
								window.location.reload(true);
							}
						});
					}
				}, error: function(e) {
					console.log(e)
				}
			});
		}
	});
}

function AjaxDeleteTplPageByID(nTplPageID) {
	$.jconfirm({
		message:"确定要删除页面模板吗？",
		confirm:function() {
			$.ajax({
				url: "delete/" + nTplPageID,
				dataType: "json",
				success: function(json) {
					if(json.IsValid) {
						$.jalert({message:"删除页面模板成功", title:"删除操作提示", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message:"删除页面模板失败", title:"删除操作提示"});
					}
				}, error: function(e) {
					console.log(e);
				}
			});
		}
	});
}
