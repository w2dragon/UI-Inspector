<!DOCTYPE html>
<%@tag description="Page template" pageEncoding="UTF-8"%>
<%@attribute name="title" fragment="true" %>
<%@attribute name="dependencyInHead" fragment="true" %>
<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<%@attribute name="sidebar" fragment="true" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
	<sec:csrfMetaTags />
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<title><jsp:invoke fragment="title"/></title>
	
	<link rel="stylesheet" href="/static/css/bootstrap.min.css" />
	<link rel="stylesheet" href="/static/css/index.css" />
	
	<script src="/static/js/index.js"></script>
	<script src="/static/jquery-1.12.4.min.js"></script>
	<script src="/static/js/bootstrap.min.js"></script>
	
	<jsp:invoke fragment="dependencyInHead"/>
	
</head>
<body>

<div class="layoutWrapper container">
	<jsp:invoke fragment="header"/>
	<div class="layoutContent">
		<jsp:invoke fragment="sidebar"/>
		<div class="layoutMainscreen">
			<jsp:doBody/>
		</div>
	</div>
	<jsp:invoke fragment="footer"/>
</div>


</body>
</html>