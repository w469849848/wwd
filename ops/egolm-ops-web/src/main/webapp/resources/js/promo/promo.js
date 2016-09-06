function AjaxDeletePromoByID(sPromoPaperNO) {
	$.jconfirm({
		message : "确定要删除活动单吗？",
		confirm : function() {
			$.ajax({
				url : "del?promo.sPromoPaperNO=" + sPromoPaperNO,
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({
							message: "操作成功",
							confirm: function() {
								window.location.reload(true);
							}
						});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function ToEditPromoMain(sPromoPaperNO) {
	$.jwindow({
		url : "add",
		width: 1000,
		height:700,
		data: {"promo.sPromoPaperNO":sPromoPaperNO},
		title : "新增促销单",
		confirm : function(WinID) {
			$("#PromoCreateForm").validate({
		    	errorPlacement:function(error, element) {  
		    		element.parent("dd").find("font.error").remove();
		    		$("<font class='error' style='padding-left:10px;color:red;'>" + $(error[0]).html() + "</font>").appendTo(element.parent("dd"));
				}, success : function(element) {
					element.parent("dd").find("font.error").remove();
				}, submitHandler:function(form) { 
					$(form).ajaxSubmit({
						dataType: "json",
						success: function(json) {
							if(json.IsValid) {
								$.closeJWindow(WinID);
								$.jalert({
									message: "操作成功",
									confirm: function() {
										window.location.reload(true);
									}
								});
							} else {
								$.jalert({message: "操作失败"});
							}
						}, error : function(e) {
							$.jalert({message: "操作失败"});
						}
					});
				}
		    });
			$("#PromoCreateForm").submit();
		}
	});
}

function PromoAddGoods(sPromoPaperNO, sAgentContractNO, nGoodsID, sBrandID, sCategoryNO) {
	$.jwindow({
		url: "addDtl",
		data: {"promoDtl.sPromoPaperNO":sPromoPaperNO, "promoDtl.sAgentContractNO":sAgentContractNO, "promoDtl.nGoodsID":nGoodsID, "promoDtl.sCategoryNO":sCategoryNO, "promoDtl.sBrandID":sBrandID},
		title: "添加促销商品",
		confirm : function(WinID) {
			$("#BatchPromoDtlSaveForm").validate({
		    	errorPlacement:function(error, element) {  
		    		element.parent("dd").find("font.error").remove();
		    		$("<font class='error' style='padding-left:10px;color:red;'>" + $(error[0]).html() + "</font>").appendTo(element.parent("dd"));
				}, success : function(element) {
					element.parent("dd").find("font.error").remove();
				}, submitHandler:function(form) { 
					$(form).ajaxSubmit({
						dataType: "json",
						success: function(json) {
							if(json.IsValid) {
								$.closeJWindow(WinID);
								$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
							} else {
								$.jalert({message: "操作失败"});
							}
						}, error : function(e) {
							$.jalert({message: "操作失败"});
						}
					});
				}
		    });
			$("#BatchPromoDtlSaveForm").submit();
		}
	});
}

function PromoDelGoods(nTag, sPromoPaperNO, sAgentContractNO, nGoodsID, sBrandID, sCategoryNO, sGroupNO, nRuleID) {
	$.jconfirm({
		message : "确定要删除促销商品吗？",
		confirm : function() {
			$.ajax({
				url : "delDtl?promoDtl.nTag=" + nTag + "&promoDtl.sPromoPaperNO=" + sPromoPaperNO + "&promoDtl.sAgentContractNO=" + sAgentContractNO + "&promoDtl.nGoodsID=" + nGoodsID + "&promoDtl.sCategoryNO=" + sCategoryNO + "&promoDtl.sBrandID=" + sBrandID + "&promoDtl.sGroupNO=" + sGroupNO + "&promoDtl.nRuleID=" + nRuleID,
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function AjaxToAddBWList(sPromoPaperNO, sShopNO) {
	$.jconfirm({
		message : "确定要添加到黑白名单吗？",
		confirm : function() {
			$.ajax({
				url : "bwSave",
				data : {"bw.sPromoPaperNO":sPromoPaperNO, "bw.sShopNO":sShopNO},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功"});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function AjaxToDelBWList(sPromoPaperNO, sShopNO) {
	$.jconfirm({
		message : "确定要从名单中删除吗？",
		confirm : function() {
			$.ajax({
				url : "bwDel",
				data : {"bw.sPromoPaperNO":sPromoPaperNO, "bw.sShopNO":sShopNO},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function PromoAddExGoods(sPromoPaperNO, sAgentContractNO, nGoodsID) {
	$.jconfirm({
		message : "确定要添加到排除商品吗？",
		confirm : function() {
			$.ajax({
				url : "exSave",
				data : {"ex.sPromoPaperNO":sPromoPaperNO, "ex.sAgentContractNO":sAgentContractNO, "ex.nGoodsID":nGoodsID},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function PromoAddGiftGoods(sPromoPaperNO, sAgentContractNO, nGoodsID, nPrice, nPoint, nLimitQty, nMaxLimitQty) {
	$.jwindow({
		title : "添加换购商品",
		url : "giftAdd",
		type : "post",
		data : {"promoDtl.sPromoPaperNO":sPromoPaperNO, "promoDtl.sAgentContractNO":sAgentContractNO, "promoDtl.nGoodsID":nGoodsID},
		confirm : function(WinID) {
			$("#PromoGiftSaveForm").validate({
		    	errorPlacement:function(error, element) {  
		    		element.parent("dd").find("font.error").remove();
		    		$("<font class='error' style='padding-left:10px;color:red;'>" + $(error[0]).html() + "</font>").appendTo(element.parent("dd"));
				}, success : function(element) {
					element.parent("dd").find("font.error").remove();
				}, submitHandler:function(form) { 
					$(form).ajaxSubmit({
						dataType: "json",
						success: function(json) {
							if(json.IsValid) {
								$.closeJWindow(WinID);
								$.jalert({message: "操作成功"});
							} else {
								$.jalert({message: "操作失败"});
							}
						}, error : function(e) {
							$.jalert({message: "操作失败"});
						}
					});
				}
		    });
			$("#PromoGiftSaveForm").submit();
		}
	});
}

function PromoDelGift(sPromoPaperNO, sAgentContractNO, nGoodsID, nRuleID, nMeetAmount, nPrice, nPoint, nLimitQty, nMaxLimitQty) {
	$.jconfirm({
		message : "确定要删除换购商品吗？",
		confirm : function() {
			$.ajax({
				url : "delGift",
				type : "post",
				data : {"promoDtl.sPromoPaperNO":sPromoPaperNO, "promoDtl.sAgentContractNO":sAgentContractNO, "promoDtl.nGoodsID":nGoodsID, "promoDtl.nRuleID":nRuleID, "promoDtl.nMeetAmount":nMeetAmount, "promoDtl.nPrice":nPrice, "promoDtl.nPoint":nPoint, "promoDtl.nLimitQty":nLimitQty, "promoDtl.nMaxLimitQty":nMaxLimitQty},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function PromoSaveGift(sPromoPaperNO, sAgentContractNO, nGoodsID, sBrandID, sCategoryNO, nRuleID) {
	$.jconfirm({
		message : "确定要参加换购活动吗？",
		confirm : function() {
			$.ajax({
				url : "saveDtl",
				type : "post",
				data : {"promoDtl.sPromoPaperNO":sPromoPaperNO, "promoDtl.sAgentContractNO":sAgentContractNO, "promoDtl.nGoodsID":nGoodsID, "promoDtl.sBrandID":sBrandID, "promoDtl.sCategoryNO":sCategoryNO, "promoDtl.nRuleID":nRuleID},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}

function AjaxFlushPromo(sPromoPaperNO, sPromoName) {
	$.jconfirm({
		message : "确定要将《" + sPromoName + "》数据更新到ERP系统吗？",
		confirm : function() {
			$.ajax({
				url : "flush",
				type : "post",
				data : {"sPromoPaperNO":sPromoPaperNO},
				dataType: "json",
				success : function(json) {
					if(json.IsValid) {
						$.jalert({message: "操作成功", confirm:function() {window.location.reload(true);}});
					} else {
						$.jalert({message: "操作失败"});
					}
				}
			});
		}
	});
}


