<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="com.kh.fitnessground.workout.yoga.model.vo.Yoga, java.util.List"%>
<c:import url="../include/common/head.jsp" />

<link rel="stylesheet"
	href="/fitnessground/resources/css/workout/workout.css" />

<!-- headend 대신 넣는 코드(removed jquery.min.js)  -->
	<!-- css 파일 로드-->
	 <link rel="stylesheet" href="/fitnessground/resources/css/bootstrap.css">
	<link rel="stylesheet" href="/fitnessground/resources/css/common/compiled_main.css" />
	<link rel="stylesheet" href="/fitnessground/resources/css/common/main.css" />
	<link rel="stylesheet" href="/fitnessground/resources/css/common/login.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
	</head>
	<body class="homepage">
	
	<!-- java script 파일 로드 -->
	<script type="text/javascript" src="/fitnessground/resources/js/jquery-3.2.1.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/bootstrap.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/common/jquery.scrolly.min.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/common/jquery.dropotron.min.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/common/jquery.onvisible.min.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/common/skel.min.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/common/util.js"></script>
	<script type="text/javascript" src="/fitnessground/resources/js/common/main.js"></script>
	
<script type="text/javascript" src="/fitnessground/resources/js/workout/workout.js"></script>

<!-- Header -->
<div id="mypage_header">
	<!-- Nav -->
	<c:import url="../include/main/nav.jsp" />
	<c:import url="../user/login.jsp"/>
	<c:import url="../user/findidpwd.jsp"/>
	<c:import url="../user/register.jsp"/>
</div> 

<!-- Modal -->
	<c:import url="detailView.jsp" />

<!-- yoga head 부분  -->

<!-- <div id="workout-head">
	<h2 id="workout-title">Yoga</h2>
</div> -->

<!-- yoga body -->
<div class="col-sm-12 col-md-12 col-lg-12 col-xs-12" id="workout-body">


	<!-- tab testing -->
	<div class="container is-bg-a">
		<!-- tab-list -->
		<div class="wrap">
			<div class="tab-wrap">
				<ul class="tab-list tab-b is-col-3">
					<li><a href="healthMain.do"><span>헬스</span></a></li>
					<li><a href="yogaMain.do"><span>요가</span></a></li>
					<li class="in"><a href="#"><span>필라테스</span></a></li>
					<li><a href="#"><span>맨몸운동</span></a></li>
				</ul>
			</div>
		</div>
	</div>
	<!-- // tab-list -->

	<div class="container news-section-tab">
		<!-- news-section-tab -->
		<div class="wrap">
			<div class="tab-wrap" id="press-cate">
				<ul class="tab-list">
					<li id="tab-li"><a href="javascript: category('스트레칭')">스트레칭</a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('복근집중운동')">복근집중운동</a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('전신운동')">전신운동</a></li>
					<li id="vertical-bar"><span>|</span></li>
					<li id="tab-li"><a href="javascript: category('하체운동')">하체운동</a></li>
				</ul>

			</div>
			<div class="sort-area">
				<select name="sort" id="sort">
					<option value="1">All</option>
					<option value="2">최신순</option>
					<option value="3">인기순</option>
				</select>
				<!-- animated 검색바 -->
			
				<div class="srch_wrpr">
					<div class="srch_sb_cnt">
						<input type="text" name="text_bar" id="v-srch" class="sech_txt_inpt"
							placeholder="Type to search...">
						<button class="srch_btn">
							<i class="fa fa-search" aria-hidden="true"></i>
						</button>
					</div>
				</div>
				
				<hr id="video-line">
			</div>
		</div>
	</div>
	<!-- thumbnail & 재생시간 youtube API call -->
					<script type="text/javascript">
					var list = new Array(); 
					var duration; 
					var thumbnail;
					var st;
					<c:forEach items="${list}" var="it" varStatus="status">
					list.push("${it.url}");
					st = ${status.count}-1;
					console.log(list);
					/* $(document).ready(function(){ */
						/* for(var i=0;i<5;i++){ */
							$.get("https://www.googleapis.com/youtube/v3/videos", {
								part : 'contentDetails',
								maxResults : 50,
								id : list[st],
								key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
							}, function(data) {
								
								$.each(data.items, function(i, item) {
									duration = item.contentDetails.duration;
									//API시간 -->HH:MM:SS형태로 변환
									var hourRegex = new RegExp("[0-9]{1,2}H", "gi");
			                        var minRegex = new RegExp("[0-9]{1,2}M", "gi");
			                        var secRegex = new RegExp("[0-9]{1,2}S", "gi");
			    
			                        var hour = hourRegex.exec(duration);
			                        var min = minRegex.exec(duration);
			                        var sec = secRegex.exec(duration);
			                        
			                        if(hour!==null){
			                            hour = hour.toString().split("H")[0] + ":";
			                        }else{
			                            hour = "";
			                        }
			                        if(min !==null){
			                            min = min.toString().split("M")[0];
			                            if(min.length<2){
					                    	   min = "0"+min;
					                    }
			                        }else{
			                            min = "00";
			                        }
			                        if(sec !==null){
			                            sec = sec.toString().split("S")[0];
			                            if(sec.length<2){
					                    	   sec = "0"+sec;
					                    }
			                        }else{
			                            sec = "00";
			                        }
			                        duration = hour+min+":"+sec;
									console.log("time:" + duration);
									$('#v-time${it.v_no}').append(duration);
								});
								
				
							});
						/* } */
						/* for(var i=0;i<5;i++){ */
							$.get("https://www.googleapis.com/youtube/v3/videos", {
								part : 'snippet',
								maxResults : 50,
								id : list[st],
								key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
							}, function(data) {
								
								$.each(data.items, function(i, item) {
									 thumbnail = item.snippet.thumbnails.medium.url;

									$('#video-iframe${it.v_no}').append('<img id=\"v-img\" src=\"'+thumbnail+'\">');
								});
				
							});
						/* } */
						/* }); */
					</c:forEach>
					</script>
	<!-- 동영상 리스트 (a태그덮어씌움~modal) view -->
	<div class="workout-videos">
		<c:if test="${!empty list}">
			<c:forEach items="${list}" var="y" varStatus="st">
					
				<div class="video">
					<div id="video-iframe${y.v_no}">
					</div>
					<div id="video-info">
						<div class="time">
						<span class="video-time" id="v-time${y.v_no}"></span>
						</div>
						<span id="video-text">
						<a href="#workout-modal" data-toggle="modal" data-title="${y.title }" data-url="${y.url }" data-content="${y.content }"
						data-target="#detailView">${y.title}</a>
						</span> 
						<%-- <span id="video-text"><c:url var="detail" value="#detail" /></span> --%>
						
					</div>
				</div>
			
			</c:forEach>
		</c:if>
	</div>
</div>
		
<script type="text/javascript">
//modal 띄우기(title,url, content 값을 모달로)
$('#detailView').on('show.bs.modal', function (event) {
	  var tag = $(event.relatedTarget); // sth that triggered the modal
	  var title = tag.data('title'); // Extract info from data-* attributes
	  var vid = tag.data('url');
	  var content = tag.data('content');
	  
	  var modal = $(this);
	  modal.find('.modal-title').text(title);
	  modal.find('.modal-play').html("<iframe id='video-play' src='https://www.youtube.com/embed/"+vid+"' frameborder='0'"+
				"gesture='media' allow='encrypted-media' allowfullscreen></iframe>");
	  modal.find('#span-content').text(content);
	})

//category별 ajax로 동영상 가져오기 
function category(category2){
	var category = category2;
	console.log(category);
	var queryString = { "category2": category };
	$.ajax({
		url: 'yclist.do',
		data : queryString,
		type : "post",
		dataType: "json",
		async: false,
       success : function(result){
          console.log("전송성공:");
          var title;
          var url;
          var content;
  
          for(var i=0;i<result.clist.length;i++){
        	  (function(title, vid, content){
	          var no = result.clist[i].v_no;
	          title = result.clist[i].title;
	          vid = result.clist[i].url;
	          content = result.clist[i].content;
	          var value ="<div class='video'><div id='video-iframe"+no+"'></div><div id='video-info'><div class='time'><span class='video-time' id='v-time"+no+"'></span>"+
					"</div><span id='video-text'><a href='#' data-toggle='modal' data-target='#detailView' "+
					"data-title='"+title+"' data-url='"+vid+"' data-content='"+content+"'>"+title+"</a></span></div></div>";
		
				if(i==0){
					$('.workout-videos').html(value);
				}else{
				  $('.workout-videos').append(value);
	          	}
	
				var duration; 
				var thumbnail;
				var timeid = '#v-time'+no;
				console.log("timeid outside"+timeid);
				
				//이번에도 순서문제. $.get이하가 for문을 다 돌고나서 실행되어버림....api호출이늦어서인가,, 
					$.get("https://www.googleapis.com/youtube/v3/videos", {
						part : 'contentDetails',
						maxResults : 50,
						id : vid,
						key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
					}, function(data) {
						
						$.each(data.items, function(i, item) {
							duration = item.contentDetails.duration;
							//API시간 -->HH:MM:SS형태로 변환
							var hourRegex = new RegExp("[0-9]{1,2}H", "gi");
	                        var minRegex = new RegExp("[0-9]{1,2}M", "gi");
	                        var secRegex = new RegExp("[0-9]{1,2}S", "gi");
	    
	                        var hour = hourRegex.exec(duration);
	                        var min = minRegex.exec(duration);
	                        var sec = secRegex.exec(duration);
	                        
	                        if(hour!==null){
	                            hour = hour.toString().split("H")[0] + ":";
	                        }else{
	                            hour = "";
	                        }
	                        if(min !==null){
	                            min = min.toString().split("M")[0];
	                            if(min.length<2){
			                    	   min = "0"+min;
			                    }
	                        }else{
	                            min = "00";
	                        }
	                        if(sec !==null){
	                            sec = sec.toString().split("S")[0];
	                            if(sec.length<2){
			                    	   sec = "0"+sec;
			                    }
	                        }else{
	                            sec = "00";
	                        }
	                        duration = hour+min+":"+sec;
							console.log("time:" + duration);
							
							console.log("t:"+timeid);
							$(timeid).append(duration);
						});
						
		
					});
				
					$.get("https://www.googleapis.com/youtube/v3/videos", {
						part : 'snippet',
						maxResults : 50,
						id : vid,
						key : 'AIzaSyACiHNLQp0NoZLhAx6u2JbtMGjCp3STK3A'
					}, function(data) {
						
						$.each(data.items, function(i, item) {
							 thumbnail = item.snippet.thumbnails.medium.url;

							$('#video-iframe'+no).append('<img id=\"v-img\" src=\"'+thumbnail+'\">');
						});
					}
					);
					
				}(i));//api codes exit
          };//for문종료 

          
       },
       error : function(request, status, errorData){
          alert("error code : " + request.status + "\n"
                + "message : " + request.responseText
                + "\n" + "error : " + errorData);
       }
	});
}
</script>


<c:import url="../include/main/footer.jsp" />
<c:import url="../include/common/end.jsp" />