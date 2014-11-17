<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/header.jsp"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="Keywords" content="게시판 목록" />
<meta name="Description" content="게시판 목록" />
<title>list</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 부트스트랩 -->
<link href="/css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="/css/common.css" rel="stylesheet" media="screen">
<script src="//code.jquery.com/jquery.js"></script>
<script src="/js/bootstrap.min.js"></script>
</head>
<body>


	<!-- Static navbar -->
	<nav class="navbar navbar-default navbar-static-top" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">방명록</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="#about">About</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<c:if test="${!isAuthenticated}">
						<li>
						<li><a href="/user/login">로그인</a></li>
						<li><a href=/user/join>회원가입</a></li>
					</c:if>
					<c:if test="${isAuthenticated}">
						<li class="dropdown"><a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-expanded="false">${authUserName}
								<span class="caret"></span>
						</a>
							<ul class="dropdown-menu" role="menu">
								<li><a href="/j_spring_security_logout">로그아웃</a></li>
							</ul></li>
					</c:if>

				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>

	<div class="container">

		<!-- Main component for a primary marketing message or call to action -->
		<div class="jumbotron">
			<h1>방명록</h1>
			<p>방명록을 남겨주세요.</p>
			<p>
				<a class="btn btn-lg btn-primary" href="/guestbook/write"
					role="button">방명록 글쓰기 &raquo;</a>
			</p>
		</div>

	</div>
	<!-- /container -->

	<div class="container">
		<c:forEach var="guestbook" items="${list }" varStatus="status">
			<div class="panel panel-primary">
				<div class="panel-heading">${guestbook.user.name }</div>
				<div class="panel-body">${guestbook.content }</div>
				<div class="panel-footer">
				${guestbook.createdDate }<br>
					<c:forEach var="image" items="${guestbook.images }"
						varStatus="status2">
						<img src="/guestbook/download/${image.id}" width="350" height="350"><br>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
	</div>

	<div class="container">
		<footer>
			<p>&copy; Company 2014</p>
		</footer>
	</div>

</body>
</html>