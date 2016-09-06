<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="jstl.jsp"%>
<div class="navbar navbar-default" id="navbar">

	<div class="navbar-container" id="navbar-container">
		<div class="navbar-header pull-left">
			<a href="#" class="navbar-brand">
				<small> <i class="logo"></i> 万店易购运营管理平台
				</small>
			</a>
			<!-- /.brand -->
		</div>
		<!-- /.navbar-header -->

		<div class="user-operate">
			<ul>
				<li>
					<a class="admin" href="javascript:void(0)">
						<span></span>Admin
					</a>
				</li>
				<li>
					<img src="assets/images/border.png" />
				</li>
				<li class="dropdown-wrap">
					<a id="dropdown-btn" class="dropdown-btn dropdown-toggle" href="#" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="true">
						<span>万店总部</span> <span class="dr"></span>
					</a>
					<ul id="dropdown-menu" class="dropdown-menu" aria-labelledby="dropdown-btn">
						<li>万店总部</li>
						<li>万店分部</li>
					</ul>
				</li>
				<li>
					<a href="javascript:void(0)">
						消息 <span class="badge badge-assertive">8</span>
					</a>
				</li>
				<li>
					<a href="javascript:void(0)">注销</a>
				</li>
			</ul>
		</div>

	</div>
	<!-- /.container -->

</div>