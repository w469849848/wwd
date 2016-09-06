$(document).ready(function() {
	$("#TplEditDiv #TplEditTabsList").sortable({
		connectWith : ".connectedSortable",
		axis : "y",
		cancel : ".FloorBody,.FloorTab,.FloorIcon,.FloorTitle,.FloorRemove,.FloorTabAdd,.FloorCellMerge,.FloorRemoveButton,.FloorMoreText",
		update : function(event, ui) {
			var args = "";
			var index = 0;
			$(".FloorListItem").each(function() {
				var $FloorBox = $(this);
				var nTplFloorID = $FloorBox.attr("floorid");
				args += nTplFloorID + "=" + index++ + ","
			});
			$.ajax({
				url: "floor/sort?data=" + args,
				dataType: "json",
				success: function(json) {
					console.log(json);
				}
			});
		}
	}).disableSelection();
});

function AppendFloorToPage(nTplPageID, nTplFloorID) {
	var tit = "添加楼层";
	if(nTplFloorID != ""){
		tit = "修改楼层";
	}
	$.jwindow({
		url: "floor/add",
		title: tit,
		data: {nTplFloorID:nTplFloorID,nTplPageID:nTplPageID},
		confirm: function(win) {
			var nFloorHeight = $("#floor_nFloorHeight").val();
			if(!nFloorHeight || nFloorHeight.length == 0 || parseInt(nFloorHeight) < 80) {
				$.jalert({message:"楼层高度不能小于80"});
				return;
			}
			var sFloorTitle = $("#floor_nFloorTitle").val();
			if(!sFloorTitle || sFloorTitle.length == 0) {
				$.jalert({message:"楼层标题不能为空"});
				return;
			}
			$("#TplFloorCreateForm").ajaxSubmit({
				dataType : "json",
				success : function(json) {
					if(json.IsValid) {
						$.closeJWindow(win);
						$.jalert({message:"操作成功", confirm:function(id) {
							window.location.reload(true);
						}});
					} else {
						$.jalert({message:"操作失败"});
					}
				}, error: function(e) {
					console.log(e);
				}
			});
		}
	});
}

function RemoveFloorByID(nTplFloorID) {
	$.jconfirm({
		message:"确定要删除楼层吗?",
		confirm:function(id) {
			$.ajax({
				url: "floor/delete/" + nTplFloorID,
				dataType:"json",
				async:false,
				success:function(json) {
					if(json.IsValid) {
						$.jalert({message:"操作成功", confirm:function(id) {
							window.location.reload(true);
						}});
					} else {
						$.jalert({message:"操作失败"});
					}
				}
			});
		}
	});
}

function AddNewTabToFloor(nTplFloorID, nTplTabID) {
	$.jwindow({
		url: "tab/add",
		title: "添加选项卡",
		data:{nTplFloorID:nTplFloorID,nTplTabID:nTplTabID},
		confirm: function(win) {
			var sTabName = $("#tab_sTabName").val();
			if(!sTabName || sTabName.length == 0) {
				$.jalert({message:"选项卡名称不能为空"});
				return;
			}
			$("#TplTabCreateForm").ajaxSubmit({
				dataType : "json",
				success : function(json) {
					if(json.IsValid) {
						$.closeJWindow(win);
						$.jalert({message:"操作成功", confirm:function(id) {
							window.location.reload(true);
						}});
						
					} else {
						$.jalert({message:"操作失败"});
					}
				}, error: function(e) {
					console.log(e);
				}
			});
		}
	});
}

$(document).ready(function() {
	$("ul#TplEditTabsList").find("li").each(function() {
		var $CurrentTab;
		$(this).find(".FloorTab").each(function() {
			var $TabTitle = $(this);
			if($TabTitle.hasClass("current")) {
				if(!$CurrentTab) {
					$CurrentTab = $TabTitle;
				} else {
					$TabTitle.removeClass("current");
				}
			}
		});
		if(!$CurrentTab) {
			var $FloorTabList = $(this).find(".FloorTab");
			if($FloorTabList.length > 0) {
				$CurrentTab = $($FloorTabList[0]);
			}
		}
		if($CurrentTab) {
			var FloorID = $CurrentTab.attr("floorid");
			var CurrentTabID = $CurrentTab.attr("tabid");
			ChangeCurrentTab(FloorID, CurrentTabID);
		}
	});
});

function ChangeCurrentTab(nTplFloorID, nTplTabID) {
	$("#FLOOR_"+nTplFloorID).find(".FloorTab").removeClass("CurrentTab");
	$("#FLOOR_"+nTplFloorID).find("#TAB_TITLE_"+nTplTabID).addClass("CurrentTab");
	$("#FLOOR_"+nTplFloorID).find(".FloorTabBody").hide();
	$("#FLOOR_"+nTplFloorID).find("#TAB_BODY_"+nTplTabID).show();
}

function DoPageCellMerge(nTplTabIDStart, nRowNumStart, nRowNumEnd, nColNumStart, nColNumEnd) {
	nTplTabIDStart = parseInt(nTplTabIDStart);
	nRowNumStart = parseInt(nRowNumStart);
	nRowNumEnd = parseInt(nRowNumEnd);
	nColNumStart = parseInt(nColNumStart);
	nColNumEnd = parseInt(nColNumEnd);
	var startRow = nRowNumEnd <= nRowNumStart ? nRowNumEnd : nRowNumStart;
	var startCol = nColNumEnd <= nColNumStart ? nColNumEnd : nColNumStart;
	var endRow = nRowNumEnd > nRowNumStart ? nRowNumEnd : nRowNumStart;
	var endCol = nColNumEnd > nColNumStart ? nColNumEnd : nColNumStart;
	$FloorBodyTable = $("#TAB_BODY_" + nTplTabIDStart)
	$FloorBodyTableTrStart = $FloorBodyTable.find("tr:eq(" + startRow + ")");
	$FloorBodyTableTrTdStart = $FloorBodyTableTrStart.find("td:eq(" + startCol + ")");
	$FloorBodyTableTrTdStart.attr("merge", "1");
	$FloorBodyTableTrTdStart.attr("rows", (endRow - startRow + 1));
	$FloorBodyTableTrTdStart.attr("cols", (endCol - startCol + 1));
	for(var i = startRow; i <= endRow; i++) {
		var $FloorBodyTableTr = $FloorBodyTable.find("tr:eq(" + (i) + ")");
		for(var j = startCol; j <= endCol; j++) {
			var $FloorBodyTableTrTd = $FloorBodyTableTr.find("td:eq(" + (j) + ")");
			if(i != startRow || j != startCol) {
				$FloorBodyTableTrTd.attr("merged", "1");
			}
		}
	}
	$FloorBodyTable.find("td[merged=1]").hide();
	$FloorBodyTable.find("td[merge=1]").each(function() {
		$(this).attr("rowspan", $(this).attr("rows"));
		$(this).attr("colspan", $(this).attr("cols"));
		$(this).css({"height":parseInt($(this).attr("nHeight"))*parseInt($(this).attr("rows"))});
	});
}

function DoBannerChange(id, index) {
	$("#" + id + " .advert_list a").each(function(i, e) {
		if(i == index) {
			$(this).show();
		} else {
			$(this).hide();
		}
	});
}

$(document).ready(function() {
	$("#CellMergeDetail i").each(function() {
		var $i = $(this);
		DoPageCellMerge($i.attr("nTplTabID"), $i.attr("nRowStart"), $i.attr("nRowEnd"), $i.attr("nColStart"), $i.attr("nColEnd"));
		
		$(".FloorBody tr td").each(function() {
			var id = $(this).attr("id");
			var merge = $(this).attr("merge");
			if(parseInt(merge) == 1 && $(this).find(".banner_tag").length == 0) {
				var html = "";
				html += "<ul class='banner_tag' style='bottom:5px;right:10px;position:absolute;z-index=999;'>";
				var $advertList = $(this).find(".advert_list a");
				$advertList.each(function(i, e) {
					html += "<li index='" + i + "' style='float:left;list-style:none;margin-right:3px;'><a href='javascript:DoBannerChange(\"" + id + "\", " + i + ");'><font size='3' color='#AAA;'>●</fond></a></li>";
				});
				html += "</ul>";
				if($advertList.length > 1) {
					$(this).append(html);
				}
			}
		});
	});
});


var nTplFloorIDStart;
var nTplTabIDStart;
var nRowNumStart;
var nColNumStart;
var nRowNumEnd;
var nColNumEnd;

function DoCellMerge() {
	$.jwindow({
		url: "cell/add/" + nTplTabIDStart,
		title: "合并单元格",
		confirm: function(win) {
			$("#TplCellCreateForm").ajaxSubmit({
				async:false,
				dataType : "json",
				success : function(json) {
					if(json.IsValid) {
						$.closeJWindow(win);
						DoPageCellMerge(nTplTabIDStart, nRowNumStart, nRowNumEnd, nColNumStart, nColNumEnd);
					} else {
						$.jalert({message:"合并单元格失败"});
					}
				}
			});
		}
	});
}

$(document).ready(function() {
	var MouseDown;
	$("body").mouseup(function() {
			if(nRowNumStart != nRowNumEnd || nColNumStart != nColNumEnd) {
				if((nRowNumEnd || nRowNumEnd == 0) && (nColNumEnd || nColNumEnd == 0)) {
					if($(".FloorBar").find(".FloorCellMerge").length == 0) {
						$($("#FLOOR_" + nTplFloorIDStart).find(".FloorBar").find("tr")[0]).append("<td class='FloorCellMerge'><a href='javascript:DoCellMerge();'><span style='padding:0 20px;border:1px solid;border-bottom:0px;'>合</span></a></td>");
					}
				}
			}
		MouseDown = false;
	});
	$(".FloorBody table tr td").mousedown(function() {
		MouseDown = null;
		nTplFloorIDStart = null;
		nTplTabIDStart = null;
		nRowNumStart = null;
		nColNumStart = null;
		nRowNumEnd = null;
		nColNumEnd = null;
		$(".FloorBar").find(".FloorCellMerge").remove();
		$(".FloorBody table tr td").css({"background":""});
		var nMerged = $(this).attr("merged");
		var nMerge = $(this).attr("merge");
		if(nMerged == 1 || nMerge == 1) {
			MouseDown = false;
		} else {
			MouseDown = true;
			var $FloorTabBody = $("#TAB_BODY_" + $(this).attr("tabid"));
			nTplFloorIDStart = $FloorTabBody.attr("floorid");
			nTplTabIDStart = $FloorTabBody.attr("tabid");
			nRowNumStart = this.parentElement.rowIndex;
			nColNumStart = this.cellIndex;
		}
	});
	$(".FloorBody table tr td").mouseover(function() {
		if(MouseDown) {
			var nRowNumCurrent = this.parentElement.rowIndex;
			var nColNumCurrent = this.cellIndex;
			var $FloorBodyTable = $(this).closest("table");
			var startRow = nRowNumCurrent <= nRowNumStart ? nRowNumCurrent : nRowNumStart;
			var startCol = nColNumCurrent <= nColNumStart ? nColNumCurrent : nColNumStart;
			var endRow = nRowNumCurrent > nRowNumStart ? nRowNumCurrent : nRowNumStart;
			var endCol = nColNumCurrent > nColNumStart ? nColNumCurrent : nColNumStart;
			for(var i = startRow; i <= endRow; i++) {
				var $FloorBodyTableTr = $FloorBodyTable.find("tr:eq(" + i + ")");
				for(var j = startCol; j <= endCol; j++) {
					var $FloorBodyTableTrTd = $FloorBodyTableTr.find("td:eq(" + j + ")");
					var nMerged = $FloorBodyTableTrTd.attr("merged");
					var nMerge = $FloorBodyTableTrTd.attr("merge");
					if(nMerged == 1 || nMerge == 1) {
						MouseDown = false;
						return;
					}
				}
			}
			var $FloorTabBodyCurrent = $(this).closest(".FloorTabBody");
			var nTplFloorIDCurrent = $FloorTabBodyCurrent.attr("floorid");
			var nTplTabIDCurrent = $FloorTabBodyCurrent.attr("tabid");
			if(nTplFloorIDCurrent == nTplFloorIDStart && nTplTabIDCurrent == nTplTabIDStart) {
				nRowNumEnd = nRowNumCurrent;
				nColNumEnd = nColNumCurrent;
				$FloorTabBodyCurrent.find("td").css({"background":""});
				for(var i = startRow; i <= endRow; i++) {
					var $FloorBodyTableTr = $FloorBodyTable.find("tr:eq(" + i + ")");
					for(var j = startCol; j <= endCol; j++) {
						var $FloorBodyTableTrTd = $FloorBodyTableTr.find("td:eq(" + j + ")");
						$FloorBodyTableTrTd.css({"background":"#4682B4"});
					}
				}
			}
		}
	}); 
});

function ToEditCell(nTplTabID, nRowStart, nColStart) {
	$.jwindow({
		url : "adpos/add",
		width : 1200,
		height : 600,
		title : "关联广告位",
		confirmButton: "保存",
		data : {nTplTabID:nTplTabID, nRowStart:nRowStart, nColStart:nColStart},
		confirm: function(win) {
			$("#TplDtlCreateForm").ajaxSubmit({
				dataType : "json",
				success : function(json) {
					if(json.IsValid) {
						window.location.reload(true);
					} else {
						$.jalert({title:"友情提示", message:"关联广告位失败"});
					}
				}
			});
		}
	});
}

$(document).ready(function() {
	$(".TplCellEditButton").click(function() {
		var $cell = $(this).parent();
		var nTplTabID = $cell.attr("tabid");
		var nColStart = $cell[0].cellIndex;
		var nRowStart = $cell[0].parentElement.rowIndex;
		ToEditCell(nTplTabID, nColStart, nRowStart);
	});
});

function SearchAdpos(nTplPageID, sApTypeID, searchText, imagePath) {
	$("#PreviewDiv").remove();
	$.ajax({
		url : "adpos/search",
		type : "post",
		data : {nTplPageID:nTplPageID, searchText:searchText, sApTypeID:sApTypeID},
		dataType : "json",
		success : function(json) {
			if(json.IsValid) {
				$(json.DataList).each(function() {
					var AdposTrHtml = 
						"<tr style='height:28px;'>" + 
							"<td style='height:28px;line-height:28px;'>" + this.nApID + "</td>" + 
							"<td>" + this.sApTitle + "</td>" + 
							"<td>" + this.nApHeight + "</td>" + 
							"<td>" + this.nApWidth + "</td>" + 
							"<td>" + this.sScopeType + "</td>" + 
							"<td><a href='javascript:SelectAdpos(" + this.nApID + ", " + this.nApWidth + ", " + this.nApHeight + ", \"" + imagePath + "\")'>添加</a></td>" + 
						"</tr>";
					$("#SelectAdposList tbody").append(AdposTrHtml);
				});
			}
		}
	});
}

function ChangeAdpos(li) {
	var AdvertIndex = $(li).index();
	var PreviewDivList = $("#PreviewDiv_list").find("a");
	for(var i = 0; i < PreviewDivList.length; i++) {
		if(i == AdvertIndex) {
			$(PreviewDivList[i]).show();
		} else {
			$(PreviewDivList[i]).hide();
		}
	}
}

function SelectAdpos(nApID, nApWidth, nApHeight, imagePath) {
	$.ajax({
		url : "adpos/get",
		type : "post",
		data : {nApID:nApID},
		dataType : "json",
		success : function(json) {
			if(json.IsValid) {
				var nBase = 400;
				var nWidth;
				var nHeight;
				if(nApWidth > nApHeight) {
					nWidth = nBase;
					nHeight = parseInt(nBase * nApHeight / nApWidth);
				} else {
					nHeight = nBase;
					nWidth = parseInt(nBase * nApWidth / nApHeight);
				}
				$("#PreviewDiv").remove();
				$("#CellnApID").val(nApID);
				var divHtml = "<div id='PreviewDiv' style='position:relative;border:1px solid;width:" + nWidth + "px;height:" + nHeight + "px;margin-top:20px;margin-left:auto;margin-right:auto;'><ul style='position:absolute;z-index:99;padding:0px;left:0px;top:0px;'>###TITLE###</ul><div class='position:absolute;z-index:98;width:100%;height:100%;height:100%;' id='PreviewDiv_list'>###LIST###</div></div>";
				var listHtml = "";
				var titleHtml = "";
				var BannerIndex = 1;
				$(json.DataList).each(function() {
					var showGoodsMsg = this.nAdShowGoodsMsgID;
					var imageUrl = imagePath + this.sAdPathUrl;
					var jumpUrl = this.sAdJumpUrl;
					listHtml += "<a style='width:100%;height:100%;position:absolute;display:" + (BannerIndex == 1 ? "block" : "none") + ";' href='" + jumpUrl + "' target='_blank'><img style='width:100%;height:100%;' src='" + imageUrl + "'/></a>"
					titleHtml += ("<li style='list-style:none;float:left;margin:5px;width:12px;height:12px;color:red;margin-top:-2px;cursor:pointer;' onclick='ChangeAdpos(this)'><font size='3' color='#AAA;'>●</fond></li>");
				});
				divHtml = divHtml.replace("###LIST###", listHtml);
				divHtml = divHtml.replace("###TITLE###", (json.DataList.length > 1 ? titleHtml : ""));
				$("#AdposEditDiv").append(divHtml);
			}
		}
	});
}

function ToSelectIcon(nTplFloorID) {
	$.jwindow({
		url: "floor/icon",
		title: "选择楼层图标",
		data: {nTplFloorID:nTplFloorID},
		confirm: function(win) {
			var sTplIconUrl;
			$(".FloorIconCheckBox").each(function() {
				var isChecked = $(this).attr("checked");
				if(isChecked) {
					sTplIconUrl = $(this).val();
					return true;
				}
			});
			if(sTplIconUrl && sTplIconUrl.length > 0) {
				var nTplFloorID = $("#icon_nTplFloorID").val();
				$.ajax({
					url : "floor/icon/post",
					type: "post",
					dataType: "json",
					data: {nTplFloorID:nTplFloorID,sTplIconUrl:sTplIconUrl},
					success: function(json) {
						if(json.IsValid) {
							$.closeJWindow(win);
							$("#FloorIconImage_" + nTplFloorID).attr("src", "http://img.egolm.com/" + sTplIconUrl);
						} else {
							$.jalert({message:"保存图标失败"});
						}
					}
				});
			} else {
				$.jalert({message:"请选择一个图标"});
			}
		}
	});
}


$(document).ready(function() {
	$("#TplEditDiv #TplEditTabsList .FloorBody .FloorTabBody .advert_list").each(function() {
		var $cell = $(this);
		var CellImageTags = $cell.find("a");
		for(var i = 0; i < CellImageTags.length; i++) {
			if(i > 0) {
				$(CellImageTags[i]).hide();
			}
		}
	});
});

function DeleteTplTabByID(nTplTabID) {
	$.jconfirm({
		title: "提示",
		message: "确定要删除选项卡吗？",
		confirm: function(id) {
			$.ajax({
				url : "tab/delete",
				data : {nTplTabID:nTplTabID},
				dataType : "json",
				success : function(json) {
					if(json.IsValid) {
						window.location.reload(true);
					} else {
						$.jalert({
							title: "提示",
							message : "操作失败"
						});
					}
				}
			});
		}
	});
}