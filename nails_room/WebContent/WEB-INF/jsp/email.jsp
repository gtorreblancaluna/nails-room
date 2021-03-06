<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Enviar correo </title>
</head>
<body>
 <div class="container" style="">

		<c:if test="${messageView != null}">
		<div class="alert alert-success">
  			<strong>Success!</strong> 
  			<c:set var = "message" value = "${messageView}"/>
  			<c:forEach var="item" items="${fn:split(message,'|')}">
        		<p>${item}</p>
			</c:forEach>
		</div>

		</c:if>
		<c:if test="${messageError != null}">
		<div class="alert alert-danger">
  			<strong>Error! </strong> ${messageError}
		</div>
		</c:if>	
			<div class="page-header">
		<div class="row">
			<div class="col">
				<h1>Enviar correo</h1>
			</div>
			
		</div>
	</div>

	<form:form  action="email.do" method="post" name="enviar" id="enviar">
	
		<div class="form-group">
			<input type="submit" class="btn btn-dark" name="enviar" value="Enviar" />					
		</div>
	</form:form>
		
			
	</div>
	
	
	
	<script type="text/javascript">

$( document ).ready(function() {		

	
}); // end document ready


</script>
</body>


	


</html>