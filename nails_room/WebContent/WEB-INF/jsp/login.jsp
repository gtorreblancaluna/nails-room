
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>nails room ::: login</title>

</head>
<body>		
	<div class="container">
		<c:if test="${messageSucess != null}">
		<div class="alert alert-success">
  			<strong>Success!</strong> ${messageSucess}
		</div>
		</c:if>
		<c:if test="${messageError != null}">
		<div class="alert alert-danger">
  			<strong>Error! </strong> ${messageError}
		</div>
		</c:if>
		<form:form modelAttribute="usuarioDTO" action="procesarLogin.do"	method="post" name="loginForm">			
				<div class="form-group">
					<label>Email: </label> <input type="text" id="email" name="email"	placeholder="Email" class="form-control">
				</div>
				<div class="form-group">
					<label>Contrase&ntilde;a: </label> 
					<input type="password"	id="password" name="contrasenia" placeholder="Contrase&ntilde;a" class="form-control">
				</div>			
				<div class="form-group">
					<button type="submit" class="form-control" value="">Entrar</button>
				</div>			
		</form:form>
	</div>	
</body>
</html>