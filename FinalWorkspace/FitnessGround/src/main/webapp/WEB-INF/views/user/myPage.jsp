<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<c:import url="../include/common/head.jsp" />
	
	<link rel="stylesheet" href="/fitnessground/resources/css/user/mypage.css" />
	
    <c:import url="../include/common/headend.jsp" />
    
    <c:if test="${ sessionScope.user == null }">
		<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
	</c:if>
    <c:if test="${ sessionScope.user != null }">
	<div id="page-wrapper">
		<!-- Header -->
		<div id="mypage_header">
            <!-- Nav -->
			<c:import url="../include/main/nav.jsp" />			
			<c:import url="login.jsp"/>
			<c:import url="findidpwd.jsp"/>
			<c:import url="register.jsp"/>
		</div>
    </div>
	<div id="myPageBar">
		<div class="col-md-8 col-md-offset-2 hidden-xs hidden-sm hidden-md visible-lg"><nav>
			<ul>
				<li><h1><a href="#">My Page</a></h1></li>
				<li id="myPageBarText"><a href="udetail.do">회원정보</a></li>
				<li id="myPageBarText"><a href="#">비밀번호변경</a></li>
				<li id="myPageBarText"><a href="#">게시글관리</a></li>
				<li id="myPageBarText"><a href="#">운동스케줄</a></li>
				<li id="myPageBarText"><a href="#">회원탈퇴</a></li>
			</ul>
		</nav></div>
		<div class="col-sm-12 visible-xs visible-sm visible-md hidden-lg">
			<ul class="nav nav-tabs">
			  <li role="presentation" class="dropdown">
			    <a class="dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-expanded="false" id="sm_title">
			      My Page <span class="caret"></span>
			    </a>
			    <ul class="dropdown-menu" role="menu">
				<li><a href="udetail.do">회원정보</a></li>
				<li><a href="#">비밀번호변경</a></li>
				<li><a href="#">게시글관리</a></li>
				<li><a href="#">운동스케줄</a></li>
				<li><a href="#">회원탈퇴</a></li>
			    </ul>
			  </li>
			</ul>
		</div>
	</div>
	<div class="mypage_info col-md-3 col-md-offset-2 col-sm-12">
		<div class="mypage_info_title" align="center">
			<img alt="user sample image" src="/fitnessground/resources/images/myimages/nullimage.png">
			<p align="center">${sessionScope.user.name} 님</p>
		</div>
		<div class="mypage_info_content">
			<p>
				<span class="btn-lg glyphicon glyphicon-user" aria-hidden="true"> 닉네임</span>
				${sessionScope.user.nickname}
			</p>
			<p>
				<span class="btn-lg glyphicon glyphicon-envelope" aria-hidden="true"> E-mail</span>
				${sessionScope.user.email}
			</p>
			<p>
				<span class="btn-lg glyphicon glyphicon-phone" aria-hidden="true"> Phone</span>
				${sessionScope.user.phone}
			</p>
			<div id="mypage_btn">
				<table>
					<tr align="center">
						<td><button class="btn btn-default"  onclick="location.href='udetail.do'">회원정보수정</button></td>
						<td><button class="btn btn-default">비밀번호변경</button></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
	<div class="mypage_schedule col-md-4 col-sm-12 col-md-offset-1">
		<div id="yesterdaySchedule">
			<table>
				<thead><tr>
					<th>어제의 운동</th>
					<td align="right">${yesterDate}</td>
				</tr></thead>
				<tbody>
				<c:choose>
					<c:when test="${!empty yesterday}">
						<c:forEach items="${yesterday}" var="s" varStatus="st">
							<c:url var="detail" value="">
								<c:param name="sno" value="${s.s_no}"/>
							</c:url>
							<tr>
								<td colspan="2"><a href="${detail}">${s.content}</a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr><td colspan="2">운동내역이 없습니다.</td></tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<div id="todaySchedule">
			<table>
				<thead><tr align="center">
					<th>오늘의 운동</th>
					<td align="right">${currentDate}</td>
				</tr></thead>
				<tbody>
				<c:choose>
					<c:when test="${!empty today}">
						<c:forEach items="${today}" var="s" varStatus="st">
							<c:url var="detail" value="">
								<c:param name="sno" value="${s.s_no}"/>
							</c:url>
							<tr>
								<td colspan="2"><a href="${detail}">${s.content}</a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr><td colspan="2">운동내역이 없습니다.</td></tr>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		</div>
		<div id="moreS" align="right"><button class="btn btn-default">MORE</button></div>
	</div>
	</c:if>
    <c:import url="../include/main/footer.jsp" />

    <c:import url="../include/common/end.jsp" />