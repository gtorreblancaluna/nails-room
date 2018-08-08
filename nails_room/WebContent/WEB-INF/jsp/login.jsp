
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
		<c:if test="${message != null}">
			<div class="message"><c:out value="${message}"></c:out></div>
			</c:if>
			<form:form modelAttribute="usuarioDTO" action="procesarLogin.do" method="post" name="loginForm">
			<div class="row">	
						<br>
						<div class="col-12">
							
						</div>
					<div class="col-6" >
						<label>Email: </label>
						<input type="text" id="email" name="email" placeholder="Email" class="form-control">
					
				
					</div>
					<div class="col-6">
						<label>Contrase&ntilde;a: </label>
						<input type="password" id="password" name="contrasenia" placeholder="Contrase&ntilde;a" class="form-control">

					</div>
					
					<div class="col-12">
					<br><br>

						
					</div>
					
			</div>
<%-- 			</form> --%>
			<button type="submit" class="form-control" value="">Entrar</button>
			</form:form>
			
			
		</div>
		
	
	
</body>

</html>