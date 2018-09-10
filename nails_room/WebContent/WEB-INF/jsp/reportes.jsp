<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<style type="text/css">

</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: Reportes</title>
<link rel="stylesheet" type="text/css" href="css/data-tables.css">
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
				<h1>Reportes</h1>
			</div>
			
		</div>
	</div>
	
		<!--2018.08.11 Formulario para aplicar busqueda por filtro -->
	<form:form modelAttribute="filtroVentas" action="reportes.do" method="post" name="filtroVentas" id="obtenerPorFiltro" >
		<div class="container-result">	
			<p>Aplicar filtro</p>
			<table class="table tableFilter bgcol">
			<tbody>
				<tr>
					<td>
						<span class="input-group-text">Fecha inicio:<input type="date" name="fechaInicioFiltro" id="fechaInicioFiltro" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Fecha final:<input type="date" name="fechaFinFiltro" id="fechaFinFiltro" class="form-control"> </span>
					</td>
					<td>
						<span class="input-group-text">Descripci&oacute;n:<input type="text" name="descripcionFiltro" id="" class="form-control"> </span>
					</td>								
				</tr>
				<tr>
					<td colspan=1>
					 	<input type="submit" class="btn btn-dark" name="filtroVentas" value="Lo mas vendido" />	
					</td>
					<td colspan=3>
						<input type="submit" class="btn btn-dark" name="filtroClientes" value="Clientes frecuentes" />	
					</td>
					
				</tr>
				
			</tbody>
			</table>	
		</div>
	</form:form>
	
	
		<!-- Mostramos las ventas del filtro consultado -->
		<c:if test="${not empty resultados}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery table-bordered table-sm">
		<thead>
			<tr>				
				<th>Descripci&oacute;n</th>
				<th>Cantidad vendida</th>				
				<th>Total vendido</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultados}" var="resultado">		
		 		<tr>		 			
		 			<td>${resultado.articulo.descripcion}</td>
		 			<td style="text-align:center;"><fmt:formatNumber value="${resultado.cantidadVendida}" type="number" /></td>		 			
		 			<td style="text-align:center;"><fmt:formatNumber value="${resultado.totalVendidoPorArticulo}" type="currency" currencySymbol="$"/></td>		 			
		 		</tr>	 	
	 		</c:forEach>
	 	</tbody>
	 		</table>
	 		</div>
		</c:if>
		
		<c:if test="${not empty resultadoClientes}">
		<div class="containerShowResultQuery container-result">
		<table class="table tableShowResultQuery table-bordered table-sm">
		<thead>
			<tr>				
				<th>Nombre cliente</th>
				<th>Cantidad</th>				
				<th>Total comprado</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${resultadoClientes}" var="res">		
		 		<tr>		 			
		 			<td>${res.nombreCliente}</td>
		 			<td style="text-align:center;"><fmt:formatNumber value="${res.cantidadVendida}" type="number" /></td>		 			
		 			<td style="text-align:center;"><fmt:formatNumber value="${res.totalVendidoPorArticulo}" type="currency" currencySymbol="$"/></td>		 			
		 		</tr>	 	
	 		</c:forEach>
	 	</tbody>
	 		</table>
	 		</div>
		</c:if>
		
  
    
    </div>

<script type="text/javascript" src="js/data-tables.js"></script>
<script type="text/javascript" src="js/admin/reportes.js"></script>

</body>
</html>