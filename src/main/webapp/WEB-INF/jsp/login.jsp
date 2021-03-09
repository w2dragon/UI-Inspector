<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html>
<head>
<sec:csrfMetaTags />
<meta charset="UTF-8">
<title>로그인</title>
	<link rel="stylesheet" href="/static/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/static/css/login.css" />
	<script src="/static/js/index.js"></script>
	<script src="/static/jquery-1.12.4.min.js"></script>
	<script src="/static/js/bootstrap.min.js"></script>
	 <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
	
</head>
<body>
	<div class="limiter">
				<div class="row" style='width:50vh; padding: 0; display: flex; align-items: flex-end; position: absolute; top: 8px; right: 16px; font-size: 18px;'>
							<div class="col-md-8" style='display: flex; align-items: flex-end; justify-content: flex-end;'>
								<button type="button" class="btn btn-google m-l-200 m-t-11" style="font-size:15px; height: 31px; margin: 0; margin-top: 5px; margin-bottom: 5px; padding: 5px 10px 5px 10px; width: 145px;" data-toggle="modal" data-target="#checkUser">비밀번호 재설정</button>
							</div>
				</div>
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-160">
				<form id="loginForm" action="/login" method="post" class="login100-form validate-form">
					<div class="login100-form-avatar" style=" width: 100%; text-align: center;" >
						<img src="/static/img/KakaoTalk_20201013_150351940.png" alt="AVATAR"  height="48px">
					</div>
					<span class="login100-form-title p-t-10" style="font-family: NanumGothic; font-size: 19px; font-weight: bold; color: rgb(109,110,113);">
						데이터 표준화 웹 관리 시스템
					</span>
					<sec:csrfInput />
					<div class="p-t-31 p-b-9 m-t-15 c-center">
						<label for="loginForm_username" class="txt1">
							아이디
						</label>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Username is required">
						<input id="loginForm_username" class="input100" type="text" name="username" autocomplete="off" /> 
						<span class="focus-input100" style="margin-left: 20px;border:none;border-bottom: 1px solid rgb(178, 49, 33);width: calc(90% + 2px);"></span>
						<span class="symbol-input100">
							<i class="fa fa-user"></i>
						</span>
					</div>
					<div class="p-t-13 p-b-9 c-center">
						<label for="loginForm_password" class="txt1">
							비밀번호
						</label>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Password is required">
						<input id="loginForm_password" class="input100" type="password" name="password" autocomplete="off" />
						<span class="focus-input100" style="margin-left: 20px;border:none;border-bottom: 1px solid rgb(178, 49, 33);width: calc(90% + 2px);"></span>
						<span class="symbol-input100">
						<i class="fa fa-lock"></i>
						</span>
					</div>
					<div class="container-login100-form-btn m-t-17">
						<button type="submit" form="loginForm" class="fa fa-arrow-circle-o-right" style="color:rgb(178, 49, 33); font-size:46px">
							
						</button>
					</div>					
				</form>
			</div>
			<div class="layoutFooter">
				Copyright ⓒ 2020 – LG CNS
			</div>
		</div>
			
	</div>

	<!-- Modal -->
	<div class="modal fade" id="checkUser" tabindex="-1" role="dialog"  aria-labelledby="checkUserTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	      <div class="row">
	     		 <div class="col-md-8">
	     		 	<h3 id="exampleModalLongTitle" style="font-family:sans-serif; font-size:18px;">비밀번호 재설정</h3>
	     		 </div>
	        	<div class="col-md-4"> <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">X</span>
	        </button> </div>
	      </div>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <input type="text" class="form-control ModelInputWidth" id="adminId" name="userId" placeholder="관리자 아이디" autocomplete="off" />
	          </div>
	          <div class="form-group">
	            <input type="text" class="form-control ModelInputWidth" id="adminName" name="userName" placeholder="성명" autocomplete="off" />
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button onclick="javascript:checkUser()" class="btn btn-secondary" style="background-color: #F0F0F0 ;" >비밀번호 재설정</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div class="modal fade" id="passwordChange" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	       <div class="row">
				<div class="col-md-8">
					<h1  id="exampleModalLongTitle" style="font-family:sans-serif; font-size:30px;">
						비밀번호 재설정
					</h1>
				</div>
	        	<div class="col-md-4">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          			<span aria-hidden="true">X</span>
	        		</button>
	        	</div>
	      </div>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="form-group">
	            <input type="password" class="form-control ModelInputWidth" id="newPass" placeholder="새로운 비밀번호" />
	          </div>
	          <div class="form-group">
	            <input type="password" class="form-control ModelInputWidth m-l-20" id="checkPass" placeholder="새로운 비밀번호 확인" />
	          </div>
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button onclick="javascript:changePwd()" class="btn btn-secondary" style="background-color: #F0F0F0 ;">비밀번호 재설정 완료</button>
	      </div>
	    </div>
	  </div>
	</div>

	<script type="text/javascript">
	let userId = '';
	function checkUser() {
		const sUserId = $("input[name='userId']").val();
		const sFirstname = $("input[name='userName']").val();
		if (sUserId.trim().length === 0) {
			alert('아이디를 입력하세요');
			return;
		}
		if (sFirstname.trim().length === 0) {
			alert('성명을 입력하세요');
			return;
		}
		$.ajax({
			type: "POST",
		    url: "/checkUser",
		    async: false,
			beforeSend: function (xhr) {
				const header = "${_csrf.headerName}", token = "${_csrf.token}";
				xhr.setRequestHeader(header, token);
			},
		    data: {
		        username: sUserId,
		        firstname: sFirstname,
		    },
		    success: function (data) {
		    	if (data === "OK") {
		    		userId = sUserId;
		    		$('#checkUser').modal('hide');
		    		$('#passwordChange').modal('show');
		    	} else {
		    		alert("아이디나 성명이 틀렸습니다.");
		    	}
		    },
		});
	}
	
	function changePwd() {
		if ($('#newPass').val().trim().length === 0) {
			alert('새로운 비밀번호를 입력하세요');
			return;
		}
		if ($('#checkPass').val().trim().length === 0) {
			alert('새로운 비밀번호 확인을 입력하세요');
			return;
		}
		if ($('#newPass').val() !== $('#checkPass').val()) {
			alert('비밀번호가 일치하지 않습니다');
			return;
		}
		$.ajax({
			type: "POST",
		    url: "/changePass",
		    async: false,
		    beforeSend: function (xhr) {
				const header = "${_csrf.headerName}", token = "${_csrf.token}";
				xhr.setRequestHeader(header, token);
			},
		    data: {
		        "password": $("#newPass").val(),
		        "username": userId,
		    },
		    success: function (data) {
		    	if (data === "OK") {
		    		alert("비밀번호가 변경되었습니다.");
		    		$('#passwordChange').modal('hide');
		    	} else {
		    		alert("비밀번호가 일치하지 않습니다.");
		    	}
		    },
		});
	}

	$("#loginForm").submit(function(event) {
		if ($("#loginForm_username").val().trim().length === 0) {
			alert('아이디를 입력하세요');
			return false;
		}
		if ($("#loginForm_password").val().trim().length === 0) {
			alert('비밀번호를 입력하세요');
			return false;
		}
	});
	
	$("#checkUser").on('hide.bs.modal', function(){
		$('#adminId').val('');
		$('#adminName').val('');
	});
	
	$("#passwordChange").on('hide.bs.modal', function(){
		$('#newPass').val('');
		$('#checkPass').val('');
	});
	
	$(document).ready(function() {
		<c:if test="${param.error != null}">
			alert('아이디나 비밀번호가 일치하지 않습니다.');
		</c:if>
	});
	
	</script>
</body>
</html>