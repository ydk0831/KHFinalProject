<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:import url="../common/head.jsp" />

<style type="text/css">
.buttons {
	display: table-cell;
	padding: 1em;
	text-align: center;
	vertical-align: left;
	width: 5%;
	height: 5%;
}

[class*="btn-"] {
	position: relative;
	display: inline-block;
	width: 10%;
	color: #fff;
	font-size: 16px;
	line-height: 45px;
	margin-right: 3em;
	max-width: 100px;
	text-decoration: none;
	text-transform: uppercase;
	vertical-align: middle;
}

.btn-1,
.btn-2,
.btn-3 {
	color: black;
	background: white;
	border: 1px solid gray;
	box-shadow: 0 2px 0 black, 2px 4px 6px gray;
	font-weight: bold;
	letter-spacing: 1px;
	-webkit-transition: all .15s linear;
	transition: all .15s linear;
}

.btn-1:hover,
.btn-2:hover,
.btn-3:hover {
	background: gray;
	border: 1px solid rgba(0, 0, 0, 0.05);
	box-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
	color: gray;
	text-shadow: -1px -1px 0 black;
}
</style>

<link
	href="/fitnessground/resources/admin/vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">


<c:import url="../common/headend.jsp" />

<script
	src="/fitnessground/resources/admin/vendor/datatables/jquery.dataTables.js"></script>
<script
	src="/fitnessground/resources/admin/vendor/datatables/dataTables.bootstrap4.js"></script>
<script
	src="/fitnessground/resources/admin/js/sb-admin-datatables.min.js"></script>

<script type="text/javascript">
	function userlistPage(){
		location.href="adminuserlist.do"
	}
	function businesslistPage(){
		location.href="adminbusinesslist.do"
	}
	function businessRequestlistPage(){
		location.href="adminbusinessRequestlist.do"
	}
	
	$(document).ready(function() {
		$("#selectCheckBox").click(function() {
			var isChecked = $(this).prop("checked");
			$(".deleteCheckBox").prop("checked", isChecked);

		});
		
		$("#selectDeleteBtn").click(function() {

			var isChecked = false;

			/* 각각의 클래스를 다 보면서 선택이 됬는지 안됬는지 체크한다. */
			$(".deleteCheckBox").each(function(index, data) {
				if (data.checked) {
					isChecked = data.checked;
				}
			});

			if (!isChecked) {
				alert("삭제할 대상을 선택하세요.");
				return;
			}

			/* 사용자에게 한번 더 컨펌 */
			if (confirm("정말 삭제하시겠습니까?")) {
				alert("삭제되었습니다");

				var form = $("#selectDeleteBtn");
				form.attr("method", "post");
				form.attr("action", "<c:url value="businessDelete.do" />");
				form.submit();
			}
		});
	});
	
	
</script>
<c:import url="../common/nav.jsp" />
<div class="content-wrapper">
	<div class="container-fluid">
		<!-- Breadcrumbs-->
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="adminMain.do">FitnessGround
					관리자</a></li>
			<li class="breadcrumb-item active">메인으로이동</li>
		</ol>
		<!-- Example DataTables Card-->
		<div class="card mb-3">
			<div class="card-header">

				<div class="buttons">

					<button class="btn-1" onclick="userlistPage();">일반회원</button>
					<button class="btn-2" onclick="businesslistPage();">사업자회원</button>
					<button class="btn-3" onclick="businessRequestlistPage();">등록요청</button>

				
				</div>


				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th><input type="checkbox" id="selectCheckBox" /></th>
									<th>Index</th>
									<th>Email</th>
									<th>Name</th>
									<th>NickName</th>
									<th>Phone</th>
									<th>Level</th>
									<th>관리</th>
								</tr>
							</thead>
							<!-- <tfoot>
                <tr>
                  <th>Name</th>
                  <th>Position</th>
                  <th>Office</th>
                  <th>Age</th>
                  <th>Start date</th>
                  <th>Salary</th>
                </tr>
              </tfoot> -->
							<tbody>
							<form id="massiveDeleteForm">
								<c:forEach var="item" items="${list }" varStatus="status">
									<tr>
										<td><input type="checkbox" class="deleteCheckBox"
											name="deleteCheckBox" value="${item.user_no} " /></td>
										<td>${status.count }</td>
										<td>${item.email }</td>
										<td>${item.name }</td>
										<td>${item.nickname }</td>
										<td>${item.phone }</td>
										<td>${item.user_level }</td>
										<td><button class="delete_btn" onclick="">삭제</button></td>
									</tr>
								</c:forEach>
								</form>
							</tbody>
						</table>
						<button id="selectDeleteBtn" class="btn-1">선택 삭제</button>
						
					</div>
				</div>
				<div class="card-footer small text-muted">Updated yesterday at
					11:59 PM</div>
			</div>
		</div>
		<!-- /.container-fluid-->
		<!-- /.content-wrapper-->
		<c:import url="../common/footer.jsp" />
		<!-- Scroll to Top Button-->
		<a class="scroll-to-top rounded" href="#page-top"> <i
			class="fa fa-angle-up"></i>
		</a>
		<!-- Logout Modal-->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Ready to
							Leave?</h5>
						<button class="close" type="button" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body">Select "Logout" below if you are
						ready to end your current session.</div>
					<div class="modal-footer">
						<button class="btn btn-secondary" type="button"
							data-dismiss="modal">Cancel</button>
						<a class="btn btn-primary" href="adminlogout.do">Logout</a>
					</div>
				</div>
			</div>
		</div>
		<!-- Bootstrap core JavaScript-->
		<script
			src="/fitnessground/resources/admin/vendor/jquery/jquery.min.js"></script>
		<script
			src="/fitnessground/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
		<!-- Core plugin JavaScript-->
		<script
			src="/fitnessground/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>
		<!-- Page level plugin JavaScript-->
		<script
			src="/fitnessground/resources/admin/vendor/datatables/jquery.dataTables.js"></script>
		<script
			src="/fitnessground/resources/admin/vendor/datatables/dataTables.bootstrap4.js"></script>
		<!-- Custom scripts for all pages-->
		<script src="/fitnessground/resources/admin/js/sb-admin.min.js"></script>
		<!-- Custom scripts for this page-->
		<script
			src="/fitnessground/resources/admin/js/sb-admin-datatables.min.js"></script>
	</div>
	<c:import url="../common/end.jsp" />