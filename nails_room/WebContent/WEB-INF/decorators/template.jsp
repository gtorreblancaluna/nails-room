<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<decorator:usePage id="myPage" />
<html lang="en-US"	class="html_stretched responsive fixed_header js_active avia_desktop avia_transform csstransforms csstransforms3d csstransitions">
<!-- <html> -->
<head>
<!-- scripts & stylesheets for all site -->
<%@include file="/WEB-INF/jsp/template/imports.jsp"%>

<!-- page title, displayed in your browser bar -->
<title><decorator:title default="Nails Room" /></title>
<decorator:head />
</head>
<body id="top" onload="<decorator:getProperty property="body.onload" />"
	class="page page-id-2992 page-template stretched maven_pro">
	<div id="wrap_all">
		<!-- HEADER -->
		<div id="header" class="">
			<c:import url="/WEB-INF/jsp/template/header.jsp" />
		</div>
		<!-- END HEADER -->
		<!-- MAIN -->
		<div id="main" class="main">
			<!-- BODY -->
			<decorator:body />
			<!-- END BODY -->
			<!-- FOOTER -->
			<c:import url="/WEB-INF/jsp/template/footer.jsp" />
			<!-- END FOOTER -->
		</div>
		<!-- END MAIN -->
	</div>
</body>
</html>