<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.egolm.com/jsp/jstl/security" prefix="e"%>
<style>
	.JWindowBody {left:50%;margin-left:-250px;top:50%;margin-top:-190px;}
</style>
<e:resource title="模板管理-微信" currentTopMenu="模板管理-微信" js="js/common.js,js/jquery-ui-1.10.4.min.js" css="css/jquery-ui-1.10.4.min.css" localCss="template/template-edit.css" localJs="template/template-edit.js" />
<e:point id="content" parentPath="/WEB-INF/common/htmlBase.jsp" currentPath="/WEB-INF/ops/template/template-edit.jsp">
	<div class="main-content" style="background:#FFFFFF;padding:0px;">
		<div class="page-content" style="background:#FFFFFF;margin-left:5px;margin-right:5px;">
			<div class="wh_titer">
				<span class="wh_titer_f"> 
					您的位置： <a href="${webHost}/index">首页</a> &gt; <a href="${webHost}/tpl/get">模板管理-微信</a> &gt; <a href="javascript:void(0);">模板编辑(${tplpage.sPageName})</a> &nbsp;<a class="active" href="javascript:AppendFloorToPage(${tplpage.nTplPageID});">添加楼层</a></span>
			</div>
			<div id="TplEditDiv" style="width:100%;">
				<div id="MessageBox"></div>
				<div id="CellMergeDetail" style="display:none;">
					<c:forEach items="${cells}" var="cell">
						<i nTplCellID="${cell.nTplCellID}" nTplTabID="${cell.nTplTabID}" nTplFloorID="${cell.nTplFloorID}" nTplPageID="${cell.nTplPageID}" nRowStart="${cell.nRowStart}" nRowEnd="${cell.nRowEnd}" nColStart="${cell.nColStart}" nColEnd="${cell.nColEnd}" sOpenTarget="${cell.sOpenTarget}" sCellType="${cell.sCellType}"></i>
					</c:forEach>
				</div>
				<ul id="TplEditTabsList" class="connectedSortable" style="width:${tplpage.nWidth}px;margin:0px auto;padding-bottom:100px;">
					<c:forEach items="${floors}" var="floor">
						<li id="FLOOR_${floor.nTplFloorID}" floorid="${floor.nTplFloorID}" class="ui-state-default FloorListItem" style="margin-top:20px;width:${floor.nFloorWidth}px;height:${floor.nFloorHeight+44}px;">
							<div class="FloorBar" style="background:${floor.nShowTab == 1 ? 'orange' : '#EEE'}">
								<span class="FloorIcon"><a ondblclick="ToSelectIcon(${floor.nTplFloorID});" href="javascript:void(0);"><img id="FloorIconImage_${floor.nTplFloorID}" alt="图标" src="http://img.egolm.com/${floor.sFloorIcon}"></a></span>
								<table>
									<tr>
										<td class="FloorTitle"><a ondblclick="AppendFloorToPage(${tplpage.nTplPageID}, ${floor.nTplFloorID});" href="javascript:void(0);">${floor.sFloorTitle}</a></td>
										<c:forEach items="${tabs}" var="tab">
											<c:if test="${tab.nTplFloorID eq floor.nTplFloorID}">
												<td class="FloorTab${tab.nCurrentTab eq 1 ? ' CurrentTab' : ''}" floorid="${tab.nTplFloorID}" tabid="${tab.nTplTabID}" id="TAB_TITLE_${tab.nTplTabID}"><a class="TabTag" ondblclick="AddNewTabToFloor(${floor.nTplFloorID}, ${tab.nTplTabID});" href="javascript:ChangeCurrentTab(${tab.nTplFloorID}, ${tab.nTplTabID})"><span>${tab.sTabName}</span></a><a class="TabClose" href="javascript:DeleteTplTabByID(${tab.nTplTabID});"><span>X</span></a></td>
											</c:if>
										</c:forEach>
										<td class="FloorTabAdd"><a href="javascript:AddNewTabToFloor(${floor.nTplFloorID});"><span>+</span></a></td>
									</tr>
								</table>
								<span class="FloorMoreText"><a href="javascript:void(0);">${empty floor.sMoreText ? 'More>>' : floor.sMoreText}</a></span>
								<span class="FloorRemoveButton"><a href="javascript:RemoveFloorByID(${floor.nTplFloorID});">x</a></span>
							</div>
							<div class="FloorBody" floorid="${floor.nTplFloorID}" id="FloorBody_${floor.nTplFloorID}">
								<c:forEach items="${tabs}" var="tab">
									<c:if test="${tab.nTplFloorID == floor.nTplFloorID}">
										<table class="FloorTabBody" tabid="${tab.nTplTabID}" floorid="${tab.nTplFloorID}" id="TAB_BODY_${tab.nTplTabID}" style="table-layout:fixed;border-collapse:collapse;display:none;height:${floor.nFloorHeight}px;width:100%;">
											<c:forEach begin="0" end="${tab.nRowCount-1}" varStatus="rvs">
												<tr>
													<c:forEach begin="0" end="${tab.nColCount-1}" varStatus="cvs">
														<td id="Cell_${tplpage.nTplPageID}_${floor.nTplFloorID}_${tab.nTplTabID}_${rvs.index}_${cvs.index}" tabid="${tab.nTplTabID}" style="height:${floor.nFloorHeight/tab.nRowCount}px;" nHeight="${floor.nFloorHeight/tab.nRowCount}" nRowNum="${rvs.index}" nColNum="${cvs.index}" ondblclick="ToEditCell(${tab.nTplTabID},${rvs.index},${cvs.index});">
															<div class="advert_list">
																<c:forEach items="${cells}" var="cell">
																	<c:if test="${not empty cell.nApID}">
																		<c:forEach items="${adverts}" var="advert">
																			<c:if test="${not empty advert.sAdPathUrl && cell.nTplTabID eq tab.nTplTabID && cell.nRowStart eq rvs.index && cell.nColStart eq cvs.index && advert.nApID eq cell.nApID}">
																				<a href="javascript:void(0);"><img style="position:absolute;margin-left:-1px;margin-top:-1px;width:100%;height:100%;" src="${imagePath}${advert.sAdPathUrl}" /></a>
																			</c:if>
																		</c:forEach>
																	</c:if>
																</c:forEach>
															</div>
														</td>
													</c:forEach>
												</tr>
											</c:forEach>
										</table>
									</c:if>
								</c:forEach>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</e:point>