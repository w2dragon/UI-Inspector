<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="layoutHeader">
	<div class="layoutHeaderTitle">
		<a class="logolink" href="/">
			<img class="logo" src="/static/img/KakaoTalk_20201015_153403461.png"  height="30px"/>
		</a>
		 데이터 표준화 웹 관리 시스템
	</div>
	<div style="display: flex; justify-content: center; align-items: center; padding-right: 60px;">
		<div style="color: white; font-weight: bold; margin-right: 20px;">
			${currentUser.firstname} (${currentUser.username})
		</div>
		<form action="/logout" method="post">
			<sec:csrfInput />
			<button class="btn btn-default" onclick="this.blur();" style="width: 80px; height:30px; border-radius: 25px; background-color:rgb(200,19,92); padding-top: 4px; color: white;">
				로그아웃
			</button>
		</form>
	</div>
</div>