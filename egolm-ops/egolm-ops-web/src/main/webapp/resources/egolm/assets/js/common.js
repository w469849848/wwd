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
			$.clearJassembly();
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
				"<div class='JAssembly modal fade delete-box' id='JAlert_" + o.id + "' tabindex='-1' role='dialog' aria-labelledby='deleteAlertLabel'>"
					+ "<div class='modal-dialog' role='document'>"
						+ "<div class='modal-content border-radius'>"
							+ "<div class='modal-header'>"
								+ "<h4 class='modal-title' id='deleteAlertLabel'>" + o.title + "</h4>"
							+ "</div>"
							+ "<div class='modal-body'>"
								+ "<p>" + o.message + "</p>"
								+ "<p class='btn-box clearfix'>"
									+ "<input class='bg-color border-radius border' type='button' id='JAlert_" + o.id + "_ConfirmButton' value='" + o.confirmButton + "' />"
								+ "</p>"
							+ "</div>"
						+ "</div>"
					+ "</div>"
				+ "</div>";
			$(".page-content").append(jalertHtml);
			$("#JAlert_" + o.id).modal("show");
			$("#JAlert_" + o.id + "_ConfirmButton").click(function() {
				o.confirm();
				$("#JAlert_" + o.id).fadeOut(500, function() {
					$("#JAlert_" + o.id).remove();
				});
				$(".modal-backdrop").fadeOut(500, function() {
					$(".modal-backdrop").remove();
				});
			});
		},
		jconfirm : function(options) {
			$.clearJassembly();
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
					"<div class='JAssembly modal fade delete-box' id='JConfirm_" + o.id + "' tabindex='-1' role='dialog' aria-labelledby='deleteAlertLabel'>"
						+ "<div class='modal-dialog' role='document'>"
							+ "<div class='modal-content border-radius'>"
								+ "<div class='modal-header'>"
									+ "<h4 class='modal-title' id='deleteAlertLabel'>" + o.title + "</h4>"
								+ "</div>"
								+ "<div class='modal-body'>"
									+ "<p>" + o.message + "</p>"
									+ "<p class='btn-box clearfix'>"
										+ "<input class='bg-color border-radius border' type='button' id='JConfirm_" + o.id + "_CancelButton' value='" + o.cancelButton + "' />"
										+ "<input class='bg-color border-radius border' type='button' id='JConfirm_" + o.id + "_ConfirmButton' value='" + o.confirmButton + "' />"
									+ "</p>"
								+ "</div>"
							+ "</div>"
						+ "</div>"
					+ "</div>";

				$(".page-content").append(jalertHtml);
				$("#JConfirm_" + o.id).modal("show");
				$("#JConfirm_" + o.id + "_CancelButton").click(function() {
					o.cancel();
					$("#JConfirm_" + o.id).fadeOut(500, function() {
						$("#JConfirm_" + o.id).remove();
					});
					$(".modal-backdrop").fadeOut(500, function() {
						$(".modal-backdrop").remove();
					});
				});
				$("#JConfirm_" + o.id + "_ConfirmButton").click(function() {
					o.confirm();
					$("#JConfirm_" + o.id).fadeOut(500, function() {
						$("#JConfirm_" + o.id).remove();
					});
					$(".modal-backdrop").fadeOut(500, function() {
						$(".modal-backdrop").remove();
					});
				});
			}
		},
		jwindow : function(options) {
			$.clearJassembly();
			var defaults = {
				width : 600,
				height : 500,
				id : "DefaultJWindow",
				title : "弹出窗口",
				showButton : true,
				confirmButton : "确定",
				cancelButton : "取消",
				confirm : function() {},
				cancel : function() {}
			};
			var o = $.extend(defaults, options);
			var footable = null, $row = null;
			var templateHtml = 
							"<div class='JAssembly modal fade edit-box JWindowBody' id='JWindow_" + o.id + "' tabindex='-1' role='dialog' aria-labelledby='editDealerLabel'>"
								+ "<div class='modal-dialog' role='document'>"
									+ "<div style='width:" + o.width + "px;height:" + o.height + "px' class='modal-content'>"
										+ "<div class='modal-body'>"
											+ "###HTML###"
										+ "</div>"
										
										+ (o.showButton ? (
											"<p>"
												+ "<label><input type='button' id='JWindow_" + o.id + "_ConfirmButton' value='" + o.confirmButton + "' /></label>"
												+ "<label><input type='button' id='JWindow_" + o.id + "_CancelButton' value='" + o.cancelButton + "' /></label>"
											+ "</p>") : (""))
									+ "</div>"
								+ "</div>"
							+ "</div>";
			if(o.url && o.url.length > 0) {
				$.ajax({
					url : o.url,
					type : "post",
					async : false,
					success : function(html) {
						var jwindowHtml = templateHtml.replace("###HTML###", html);
						$(".page-content").append(jwindowHtml);
						$("#JWindow_" + o.id).modal("show");
						$("#JWindow_" + o.id + "_CancelButton").click(function() {
							o.cancel();
							$("#JWindow_" + o.id).fadeOut(500, function() {
								$("#JWindow_" + o.id).remove();
							});
							$(".modal-backdrop").fadeOut(500, function() {
								$(".modal-backdrop").remove();
							});
						});
						$("#JWindow_" + o.id + "_ConfirmButton").click(function() {
							o.confirm();
						});
					}, error : function (request, status, error) {
						$.jalert({message:"Ajax请求失败", title:"错误提示", confirmButton:"关闭"});
					}
				});
			} else if(o.html && o.html.length > 0) {
				var jwindowHtml = templateHtml.replace("###HTML###", o.html);
				$(".page-content").append(jwindowHtml);
				$("#JWindow_" + o.id).modal("show");
				$("#JWindow_" + o.id + "_CancelButton").click(function() {
					o.cancel();
					$("#JWindow_" + o.id).fadeOut(500, function() {
						$("#JWindow_" + o.id).remove();
					});
					$(".modal-backdrop").fadeOut(500, function() {
						$(".modal-backdrop").remove();
					});
				});
				$("#JWindow_" + o.id + "_ConfirmButton").click(function() {
					o.confirm();
				});
			} else {
				$.jalert({message:"URL或HTML参数不能为空", title:"错误提示", confirmButton:"关闭"});
			}
		},
		closeJWindow : function(id) {
			if(id) {
				$("#JWindow_" + id).fadeOut(500, function() {
					$("#JWindow_" + id).remove();
				});
			} else {
				$(".JWindowBody").fadeOut(500, function() {
					$(".JWindowBody").remove();
				});
			}		
			$(".modal-backdrop").fadeOut(500, function() {
				$(".modal-backdrop").remove();
			});
		}, 
		clearJassembly : function() {
			$(".JAssembly").fadeOut(500, function() {
				$(".JAssembly").remove();
			});
			$(".modal-backdrop").fadeOut(500, function() {
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