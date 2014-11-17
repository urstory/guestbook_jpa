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
<script>
$(document).ready(function(){

	// 삭제 버튼을 클릭할 경우.
	 $(".deleteGuestbook").click(function(){
		 // 현재 눌려진 버튼의 seq속성값 구함.
		 var seq = $(this).attr("seq");
		 
	       $.ajax({
               type : 'POST',                                    // post 타입 전송
               url: "delete/" + seq,                               // 전송 url
               // data: { name: "John", age: 50 }   // 전송 파라미터
               cache : false,                                  // ajax로 페이지를 요청해서 보여줄 경우
                                                               // cache가 있으면 새로운 내용이 업데이트 되지 않는다.
               async : true,                                    // 비동기 통신,  false : 동기 통신
               success : function(msg){                         // 콜백 성공 응답시 실행
            	   console.log(msg);
               		if(msg){ // 삭제를 성공하였을 경우.
               			$("#guestbook_" + seq).remove();
               		}
                },
               error : function(){                              // Ajax 전송 에러 발생시 실행
                },
               complete : function(){                       //  success, error 실행 후 최종적으로 실행
               }
           });		 
	 });
});
</script>
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
			<div class="panel panel-primary" id="guestbook_${guestbook.id}">
				<div class="panel-heading">
					<div class="row">
						<div class="col-sm-11 col-sx-12">
							${guestbook.user.name }
						</div>
						<div class="col-sm-1 col-sx-6" >
							<c:if test="${isAuthenticated}">
								<c:if test="${authUserId == guestbook.user.id }">
									<button class="btn btn-default btn-xs deleteGuestbook" seq="${guestbook.id }">삭제</button>
								</c:if>
							</c:if>
						</div>
					</div>				
				</div>
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