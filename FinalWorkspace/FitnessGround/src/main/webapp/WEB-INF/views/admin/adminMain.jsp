<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 

<c:import url="common/head.jsp" />

<style type="text/css">
</style>

	
<c:import url="common/headend.jsp" />
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>

    <c:if test="${ sessionScope.user == null }">
		<script type="text/javascript">
			$(function (){
				alert("로그인이 필요합니다.");
				location.href="main.do";
			});
		</script>
	</c:if>

<c:import url="common/nav.jsp" />

<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="adminMain.do">Fitness Ground</a></li>
			<li class="breadcrumb-item active">메인으로 이동</li>
		</ol>
		<!-- Icon Cards-->
		<div class="row">
			<div class="col-xl-3 col-sm-6 mb-3">
				<div class="card text-white bg-success o-hidden h-30">
					<div class="card-body">
						<div class="card-body-icon">
							<i class="fa fa-fw fa-comments"></i>
						</div>
						<div class="mr-5">${message }개의 새로운 문의</div>
					</div>
					<a class="card-footer text-white clearfix small z-1" href="adminQuestionBoard.do">
						<span class="float-left">View Details</span> <span
						class="float-right"> <i class="fa fa-angle-right"></i>
					</span>
					</a>
				</div>
			</div>
			<div class="col-xl-3 col-sm-6 mb-3">
				<div class="card text-white bg-warning o-hidden h-30">
					<div class="card-body">
						<div class="card-body-icon">
							<i class="fa fa-fw fa-list"></i>
						</div>
						<div class="mr-5">${gymrequest }개의 헬스장 등록요청</div>
					</div>
					<a class="card-footer text-white clearfix small z-1" href="adminbusinessRequestlist.do">
						<span class="float-left">View Details</span> <span
						class="float-right"> <i class="fa fa-angle-right"></i>
					</span>
					</a>
				</div>
			</div>
			<div class="col-xl-3 col-sm-6 mb-3">
				<div class="card text-white bg-danger o-hidden h-30">
					<div class="card-body">
						<div class="card-body-icon">
							<i class="fa fa-fw fa-shopping-cart"></i>
						</div>
						<div class="mr-5">일반 회원 관리 바로가기 </div>
					</div>
					<a class="card-footer text-white clearfix small z-1" href="adminuserlist.do">
						<span class="float-left">View Details</span> <span
						class="float-right"> <i class="fa fa-angle-right"></i>
					</span>
					</a>
				</div>
			</div>
			<div class="col-xl-3 col-sm-6 mb-3">
				<div class="card text-white bg-primary o-hidden h-30">
					<div class="card-body">
						<div class="card-body-icon">
							<i class="fa fa-fw fa-support"></i>
						</div>
						<div class="mr-5">사업자 회원관리 바로가기</div>
					</div>
					<a class="card-footer text-white clearfix small z-1" href="adminbusinesslist.do">
						<span class="float-left">View Details</span> <span
						class="float-right"> <i class="fa fa-angle-right"></i>
					</span>
					</a>
				</div>
			</div>
		</div>
		
		
		<%-- <!-- Area Chart Example-->
		<div class="card mb-3">
			<div class="card-header">
				<i class="fa fa-area-chart"></i> Area Chart Example
			</div>
			<div class="card-body">
				<canvas id="myAreaChart" width="100%" height="30"></canvas>
			</div>
			<div class="card-footer small text-muted">Updated yesterday at
				11:59 PM</div>
		</div> --%>
		<div class="row">
			<div class="col-lg-8">
				<%-- <!-- Example Bar Chart Card-->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fa fa-bar-chart"></i> Bar Chart Example
					</div>
					<div class="card-body">
						<div class="row">
							<div class="col-sm-8 my-auto">
								<canvas id="myBarChart" width="100" height="50"></canvas>
							</div>
							<div class="col-sm-4 text-center my-auto">
								<div class="h4 mb-0 text-primary">$34,693</div>
								<div class="small text-muted">YTD Revenue</div>
								<hr>
								<div class="h4 mb-0 text-warning">$18,474</div>
								<div class="small text-muted">YTD Expenses</div>
								<hr>
								<div class="h4 mb-0 text-success">$16,219</div>
								<div class="small text-muted">YTD Margin</div>
							</div>
						</div>
					</div>
					<div class="card-footer small text-muted">Updated yesterday
						at 11:59 PM</div>
				</div> --%>
				<!-- Card Columns Example Social Feed-->
				<!-- <div class="mb-0 mt-4">
					<i class="fa fa-newspaper-o"></i> News Feed
				</div>
				<hr class="mt-2">
				<div class="card-columns">
					Example Social Card
					<div class="card mb-3">
						<a href="#"> <img class="card-img-top img-fluid w-100"
							src="https://unsplash.it/700/450?image=610" alt="">
						</a>
						<div class="card-body">
							<h6 class="card-title mb-1">
								<a href="#">David Miller</a>
							</h6>
							<p class="card-text small">
								These waves are looking pretty good today! <a href="#">#surfsup</a>
							</p>
						</div>
						<hr class="my-0">
						<div class="card-body py-2 small">
							<a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-thumbs-up"></i>Like
							</a> <a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-comment"></i>Comment
							</a> <a class="d-inline-block" href="#"> <i
								class="fa fa-fw fa-share"></i>Share
							</a>
						</div>
						<hr class="my-0">
						<div class="card-body small bg-faded">
							<div class="media">
								<img class="d-flex mr-3" src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<h6 class="mt-0 mb-1">
										<a href="#">John Smith</a>
									</h6>
									Very nice! I wish I was there! That looks amazing!
									<ul class="list-inline mb-0">
										<li class="list-inline-item"><a href="#">Like</a></li>
										<li class="list-inline-item">·</li>
										<li class="list-inline-item"><a href="#">Reply</a></li>
									</ul>
									<div class="media mt-3">
										<a class="d-flex pr-3" href="#"> <img
											src="http://placehold.it/45x45" alt="">
										</a>
										<div class="media-body">
											<h6 class="mt-0 mb-1">
												<a href="#">David Miller</a>
											</h6>
											Next time for sure!
											<ul class="list-inline mb-0">
												<li class="list-inline-item"><a href="#">Like</a></li>
												<li class="list-inline-item">·</li>
												<li class="list-inline-item"><a href="#">Reply</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer small text-muted">Posted 32 mins ago</div>
					</div>
					Example Social Card
					<div class="card mb-3">
						<a href="#"> <img class="card-img-top img-fluid w-100"
							src="https://unsplash.it/700/450?image=180" alt="">
						</a>
						<div class="card-body">
							<h6 class="card-title mb-1">
								<a href="#">John Smith</a>
							</h6>
							<p class="card-text small">
								Another day at the office... <a href="#">#workinghardorhardlyworking</a>
							</p>
						</div>
						<hr class="my-0">
						<div class="card-body py-2 small">
							<a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-thumbs-up"></i>Like
							</a> <a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-comment"></i>Comment
							</a> <a class="d-inline-block" href="#"> <i
								class="fa fa-fw fa-share"></i>Share
							</a>
						</div>
						<hr class="my-0">
						<div class="card-body small bg-faded">
							<div class="media">
								<img class="d-flex mr-3" src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<h6 class="mt-0 mb-1">
										<a href="#">Jessy Lucas</a>
									</h6>
									Where did you get that camera?! I want one!
									<ul class="list-inline mb-0">
										<li class="list-inline-item"><a href="#">Like</a></li>
										<li class="list-inline-item">·</li>
										<li class="list-inline-item"><a href="#">Reply</a></li>
									</ul>
								</div>
							</div>
						</div>
						<div class="card-footer small text-muted">Posted 46 mins ago</div>
					</div>
					Example Social Card
					<div class="card mb-3">
						<a href="#"> <img class="card-img-top img-fluid w-100"
							src="https://unsplash.it/700/450?image=281" alt="">
						</a>
						<div class="card-body">
							<h6 class="card-title mb-1">
								<a href="#">Jeffery Wellings</a>
							</h6>
							<p class="card-text small">
								Nice shot from the skate park! <a href="#">#kickflip</a> <a
									href="#">#holdmybeer</a> <a href="#">#igotthis</a>
							</p>
						</div>
						<hr class="my-0">
						<div class="card-body py-2 small">
							<a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-thumbs-up"></i>Like
							</a> <a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-comment"></i>Comment
							</a> <a class="d-inline-block" href="#"> <i
								class="fa fa-fw fa-share"></i>Share
							</a>
						</div>
						<div class="card-footer small text-muted">Posted 1 hr ago</div>
					</div>
					Example Social Card
					<div class="card mb-3">
						<a href="#"> <img class="card-img-top img-fluid w-100"
							src="https://unsplash.it/700/450?image=185" alt="">
						</a>
						<div class="card-body">
							<h6 class="card-title mb-1">
								<a href="#">David Miller</a>
							</h6>
							<p class="card-text small">
								It's hot, and I might be lost... <a href="#">#desert</a> <a
									href="#">#water</a> <a href="#">#anyonehavesomewater</a> <a
									href="#">#noreally</a> <a href="#">#thirsty</a> <a href="#">#dehydration</a>
							</p>
						</div>
						<hr class="my-0">
						<div class="card-body py-2 small">
							<a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-thumbs-up"></i>Like
							</a> <a class="mr-3 d-inline-block" href="#"> <i
								class="fa fa-fw fa-comment"></i>Comment
							</a> <a class="d-inline-block" href="#"> <i
								class="fa fa-fw fa-share"></i>Share
							</a>
						</div>
						<hr class="my-0">
						<div class="card-body small bg-faded">
							<div class="media">
								<img class="d-flex mr-3" src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<h6 class="mt-0 mb-1">
										<a href="#">John Smith</a>
									</h6>
									The oasis is a mile that way, or is that just a mirage?
									<ul class="list-inline mb-0">
										<li class="list-inline-item"><a href="#">Like</a></li>
										<li class="list-inline-item">·</li>
										<li class="list-inline-item"><a href="#">Reply</a></li>
									</ul>
									<div class="media mt-3">
										<a class="d-flex pr-3" href="#"> <img
											src="http://placehold.it/45x45" alt="">
										</a>
										<div class="media-body">
											<h6 class="mt-0 mb-1">
												<a href="#">David Miller</a>
											</h6>
											<img class="img-fluid w-100 mb-1"
												src="https://unsplash.it/700/450?image=789" alt="">I'm
											saved, I found a cactus. How do I open this thing?
											<ul class="list-inline mb-0">
												<li class="list-inline-item"><a href="#">Like</a></li>
												<li class="list-inline-item">·</li>
												<li class="list-inline-item"><a href="#">Reply</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card-footer small text-muted">Posted yesterday</div>
					</div>
				</div> -->
				<!-- /Card Columns-->
			</div>
			<div class="col-lg-4">
				<%-- <!-- Example Pie Chart Card-->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fa fa-pie-chart"></i> Pie Chart Example
					</div>
					<div class="card-body">
						<canvas id="myPieChart" width="100%" height="100"></canvas>
					</div>
					<div class="card-footer small text-muted">Updated yesterday
						at 11:59 PM</div>
				</div> --%>
				<!-- Example Notifications Card-->
				<!-- <div class="card mb-3">
					<div class="card-header">
						<i class="fa fa-bell-o"></i> Feed Example
					</div>
					<div class="list-group list-group-flush small">
						<a class="list-group-item list-group-item-action" href="#">
							<div class="media">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<strong>David Miller</strong>posted a new article to <strong>David
										Miller Website</strong>.
									<div class="text-muted smaller">Today at 5:43 PM - 5m ago</div>
								</div>
							</div>
						</a> <a class="list-group-item list-group-item-action" href="#">
							<div class="media">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<strong>Samantha King</strong>sent you a new message!
									<div class="text-muted smaller">Today at 4:37 PM - 1hr
										ago</div>
								</div>
							</div>
						</a> <a class="list-group-item list-group-item-action" href="#">
							<div class="media">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<strong>Jeffery Wellings</strong>added a new photo to the album
									<strong>Beach</strong>.
									<div class="text-muted smaller">Today at 4:31 PM - 1hr
										ago</div>
								</div>
							</div>
						</a> <a class="list-group-item list-group-item-action" href="#">
							<div class="media">
								<img class="d-flex mr-3 rounded-circle"
									src="http://placehold.it/45x45" alt="">
								<div class="media-body">
									<i class="fa fa-code-fork"></i> <strong>Monica Dennis</strong>forked
									the <strong>startbootstrap-sb-admin</strong>repository on <strong>GitHub</strong>.
									<div class="text-muted smaller">Today at 3:54 PM - 2hrs
										ago</div>
								</div>
							</div>
						</a> <a class="list-group-item list-group-item-action" href="#">View
							all activity...</a>
					</div>
					<div class="card-footer small text-muted">Updated yesterday
						at 11:59 PM</div>
				</div> -->
			</div>
		</div>
		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">
				<i class="fa fa-table"></i> 고객들 평점이 가장 좋은 헬스장 목록입니다
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr align="center">
								<th>Name</th>
								<th>Location</th>
								<th>Category</th>
								<th>Operator</th>
								<th>Registration Date</th>
								<th>Rating</th>
							</tr>
						</thead>
						
						<tbody>
						<c:set var="i" value="0"/>
						  <c:forEach var="item" items="${ratinglist }" varStatus="status">
						  	<input type="hidden" id="hiderating${ i }" value="${ item.rating }">
						  	<input type="hidden" id="count" value="${fn:length(ratinglist)} ">
							<tr align="center">
								<td>${item.gym_name }</td>
								<td>${item.location }</td>
								<td>${item.category }</td>
								<td>${item.name }</td>
								<td>${item.register_date }</td>
								<td id="td${i }"></td>
							</tr>
							<c:set var="i" value="${ i+1 }"/>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="card-footer small text-muted"></div>
		</div>
	</div>
	<!-- /.container-fluid-->
	<!-- /.content-wrapper-->
	<c:import url="common/footer.jsp" />
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fa fa-angle-up"></i>
	</a>
	

</div>


<script type="text/javascript">
$(document).ready(function(){
	console.log($("#count").val());
	var count = $("#count").val();
	for(var i = 0; i <= count; i++){
		var result = '';
		result = $("#hiderating" + i + "").val();
		var mod = result % 1;
		var star = '';
		var t = 0;
		result =  Math.floor(result);
		for(var j = 0; j < result; j ++){
			star += '<i class="fa fa-star" aria-hidden="true"></i>';
			t++;
		}
		if (mod > 0){
			star += '<i class="fa fa-star-half-o" aria-hidden="true"></i>';
			t++;
		}
		for(var z = t; z < 5; z++){
			star += '<i class="fa fa-star-o" aria-hidden="true"></i>';
		}
		
		result = $("#hiderating" + i + "").val();
		star += "&nbsp;"+result;
		
		$("#td" + i + "").html(star);
	}
});
	
</script>
<c:import url="common/end.jsp" />