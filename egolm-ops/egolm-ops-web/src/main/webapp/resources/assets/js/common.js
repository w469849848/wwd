(function ($) {
	$.extend({
		limitTo : function(index) {
			if(index >=1) {
				$("#limitPageForm").find("input").each(function() {
					if(this.name === "page.index") {
						$(this).val(index);
					}
				});
				$("#limitPageForm").submit();
			}
		},
		jalert : function(options) {
			var defaults = {
				id : "DefaultAlertWin",
				title : "弹出框提示",
				message : "弹出框提示",
				confirmButton : "确定",
				confirm : function() {}
			};
			var o = $.extend(defaults, options);
			var footable = null, $row = null;
			var jalertHtml =
				"<div class='JAssembly fade delete-box' id='JAlert_" + o.id + "' tabindex='-1' role='dialog' aria-labelledby='deleteAlertLabel'>"
					+ "<div class='modal-dialog' role='document'>"
						+ "<div class='modal-content border-radius'>"
							+ "<div class='modal-header'>"
								+ "<h4 class='modal-title' id='deleteAlertLabel'>" + o.title + "</h4>"
							+ "</div>"
							+ "<div class='modal-body'>"
								+ "<p>" + o.message + "</p>"
								+ "<p class='btn-box clearfix'>"
									+ "<input class='bg-color border-radius border' type='button' id='JAlert_" + o.id + "_AlertButton' value='" + o.confirmButton + "' />"
								+ "</p>"
							+ "</div>"
						+ "</div>"
					+ "</div>"
				+ "</div>";
			if($("#JAlert_" + o.id).length == 0) {
				$(".page-content").append(jalertHtml);
				$("#JAlert_" + o.id).modal("show");
				$("#JAlert_" + o.id + "_AlertButton").click(function() {
					$("#JAlert_" + o.id).remove();
					$($(".modal-backdrop")[0]).remove();
					o.confirm(o.id);
				});
			}
		},
		jconfirm : function(options) {
			if(!options.confirm) {
				$.jalert({message:"确认提示框，确认回调函数不能为空", title:"错误提示", confirmButton:"关闭"});
			} else {
				var defaults = {
					id : "DefaultConfitmWin",
					title : "弹出框提示",
					message : "弹出框确认提示",
					confirmButton : "确定",
					cancelButton : "取消",
					cancel : function() {}
				};
				var o = $.extend(defaults, options);
				var footable = null, $row = null;
				var jalertHtml =
					"<div class='JAssembly fade delete-box' id='JConfirm_" + o.id + "' tabindex='-1' role='dialog' aria-labelledby='deleteAlertLabel'>"
						+ "<div class='modal-dialog' role='document'>"
							+ "<div class='modal-content border-radius'>"
								+ "<div class='modal-header'>"
									+ "<h4 class='modal-title' id='deleteAlertLabel'>" + o.title + "</h4>"
								+ "</div>"
								+ "<div class='modal-body'>"
									+ "<p style='padding:15px;margin-top:-10px;'>" + o.message + "</p>"
									+ "<p class='btn-box clearfix'>"
										+ "<input class='bg-color border-radius border' type='button' id='JConfirm_" + o.id + "_ConfirmButton' value='" + o.confirmButton + "' />"
										+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
										+ "<input class='bg-color border-radius border' type='button' id='JConfirm_" + o.id + "_CancelButton' value='" + o.cancelButton + "' />"
									+ "</p>"
								+ "</div>"
							+ "</div>"
						+ "</div>"
					+ "</div>";
				if($("#JConfirm_" + o.id).length == 0) {
					$(".page-content").append(jalertHtml);
					$("#JConfirm_" + o.id).modal("show");
					$("#JConfirm_" + o.id + "_CancelButton").click(function() {
						$("#JConfirm_" + o.id).remove();
						$($(".modal-backdrop")[0]).remove();
						o.cancel(o.id);
					});
					$("#JConfirm_" + o.id + "_ConfirmButton").click(function() {
						$("#JConfirm_" + o.id).remove();
						$($(".modal-backdrop")[0]).remove();
						o.confirm(o.id);
					});
				}
			}
		},
		jwindow : function(options) {
			var jwindowHtml;
			var defaults = {
				width : 800,
				height : 500,
				id : "DefaultJWindow",
				title : "弹出窗口",
				showButton : true,
				confirmButton : "确定",
				cancelButton : "取消",
				data : {},
				confirm : function() {},
				cancel : function() {}
			};
			var o = $.extend(defaults, options);
			var footable = null, $row = null;
			if($("#JWindow_" + o.id).length == 0) {
				var templateHtml = 
								"<div class='JAssembly fade edit-box JWindowBody' id='JWindow_" + o.id + "' tabindex='-1' role='dialog' aria-labelledby='editDealerLabel' style='position:absolute;'>"
									+ "<div class='modal-dialog' role='document' style='margin-top:0px;margin-left:0px;'>"
										+"<p style='font-size:16px;font-weight:bold;color:#FF6600;text-indent:10px;line-height:45px;height:45px;margin:-1px 1px;width:" + (o.width-2) + "px;background:#FFFFFF;'>"
											+ "<font>" + o.title + "</font>"
											+ "<a style='line-height:45px;height:45px;color:#FF6600;margin:-1px 1px;float:right;margin-right:10px;' class='jwindow_close' href=\"javascript:$.closeJWindow('" + o.id + "')\">关闭</a>"
										+ "</p>"
										+ "<div style='overflow-y:auto;width:" + o.width + "px;height:" + o.height + "px;padding:0px;' class='modal-content'>"
											+ "<div class='modal-body' style='padding:10px;position:relative;'>"
												+ "###HTML###"
											+ "</div>"
										+ "</div>"
										+ (o.showButton ? (
										"<p style='pargin-left:1px;margin:-1px 1px;height:48px;width:" + (o.width-2) + "px;background:#FFFFFF;padding-top:5px;padding-right:10px;'>"
											+ "<label style='width:120px;float:right;'><input style='color:#FFFFFF;background:#ff6400!important;width:100%;' type='button' id='JWindow_" + o.id + "_CancelButton' value='" + o.cancelButton + "' /></label>"
											+ "<label style='width:120px;float:right;'><input style='color:#FFFFFF;background:#ff6400!important;width:100%;' type='button' id='JWindow_" + o.id + "_ConfirmButton' value='" + o.confirmButton + "' /></label>"
										+ "</p>") : (""))
									+ "</div>"
								+ "</div>";
				if(o.url && o.url.length > 0) {
					$.ajax({
						url : o.url,
						type : "post",
						async : false,
						data: o.data,
						success : function(html) {
							jwindowHtml = templateHtml.replace("###HTML###", html);
						}, error : function (request, status, error) {
							$.jalert({message:"Ajax请求失败", title:"错误提示", confirmButton:"关闭"});
						}
					});
				} else if(o.html && o.html.length > 0) {
					jwindowHtml = templateHtml.replace("###HTML###", o.html);
				} else if(o.target && o.target.length > 0) {
					
				} else {
					$.jalert({message:"URL或HTML参数不能为空", title:"错误提示", confirmButton:"关闭"});
					return false;
				}
				if((o.url && o.url.length > 0) || (o.html && o.html.length > 0) || (o.target && o.target.length > 0)) {
					$(".page-content").append(jwindowHtml);
					var clientWidth = document.body.clientWidth;
					var clientHeight = document.body.clientHeight;
					var jwindowWidth = o.width;
					var jwindowHeight = o.height + 90;
					var jwindowLeft = parseInt(clientWidth/2) - (parseInt(jwindowWidth/2));
					var jwindowTop = parseInt(clientHeight/2) - (parseInt(jwindowHeight/2));
					$(".modal-dialog").css({"top":jwindowTop, "left":jwindowLeft});
					$("#JWindow_" + o.id).modal("show");
					$("#JWindow_" + o.id + "_CancelButton").click(function() {
						$.closeJWindow(o.id);
						o.cancel(o.id);
					});
					$("#JWindow_" + o.id + "_ConfirmButton").click(function() {
						o.confirm(o.id);
					});
				}
				return true;
			} else {
				return false;
			}
		},
		closeJWindow : function(id) {
			if(id) {
				$("#JWindow_" + id).remove();
			} else {
				$(".JWindowBody").remove();
			}		
			$($(".modal-backdrop")[0]).remove();
		}, 
		clearJassembly : function() {
			$(".JAssembly").fadeOut(0, function() {
				$(".JAssembly").remove();
			});
			$(".modal-backdrop").fadeOut(0, function() {
				$(".modal-backdrop").remove();
			});
		}
	});
})(jQuery);



(function ($) {
	$.fn.extend({
		jalert : function(options) {
			this.click(function() {
				$.jalert(options);
			});
		},
		jconfirm : function(options) {
			this.click(function() {
				$.jconfirm(options);
			});
		},
		jwindow : function(options) {
			this.click(function() {
				$.jwindow(options);
			});
		}
    });
})(jQuery);