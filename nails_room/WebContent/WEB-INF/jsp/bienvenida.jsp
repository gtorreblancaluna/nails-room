<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>punto venta :: bienvenido</title>
<!-- <link rel="stylesheet" href="../css/bootstrap.min.css"> -->
<style type="text/css">


.container-salesWeek{max-height: 700px;overflow: auto;}
.container-salesMonth{max-height: 700px;overflow: auto;}
.container-salesToday{max-height: 700px;overflow: auto;}
/* body{background-image:url("http://www.thomaslhomme.com/wp-content/uploads/2014/03/Cool-Website-Backgrounds.jpg"); } */


</style>
</head>
<body>
<div class="container " >
<div class="page ">
		<div class="row centered row-color">
			<div class="col-sm-12 ">
				<h1 >Bienvenido <c:out value="${userSession.account.email}"></c:out></h1>
			</div>
			
		</div>
	</div>
	
	<div class="row centered row-color" >
	<div class="col-sm-12 ">
	   		<h3>Pedidos del dia</h3>
	   		<div class="container-salesToday bgcol">
	   		<c:if test="${not empty salesToday}">
	   			<table class="table">
	   				<thead>
		   				<tr>
		   					<th>Id</th>
		   					<th>Fecha registro</th>
		   					<th>Fecha entrega</th>
		   					<th>Descripci&oacute;n</th>
		   					<th>Cliente</th>
		   					<th>Sucursal</th>
		   					<th>Atendi&oacute;</th>
		   				</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach items="${salesToday}" var="sale">
		   					<tr>
		   						<td>${sale.saleId}</td>
		   						<td>${sale.saleDate}</td>
		   						<td>${sale.dateDelivery }</td>
		   						<td>${sale.description}</td>
		   						<td>${sale.nameCustomer}</td>
		   						<td>${sale.nameOffice}</td>
		   						<td>${sale.nameUser}</td>
		   					</tr>  	
	   					</c:forEach>			
	   				</tbody>
	   			</table>
	   		</c:if>
	   		<c:if test="${empty salesToday}">
	   			<p>No encontr&eacute; pedidos para hoy</p>
	   		</c:if>
	   		</div>
	   	</div>
	
	
	   <div class="col-sm-12 " >
			<h3>Venta semanal</h3>	
			<div class="container-salesWeek bgcol">
	   		<c:if test="${not empty salesByWeek}">
	   			<table class="table">
	   				<thead>
		   				<tr>
		   					<th>Id</th>
		   					<th>Fecha registro</th>
		   					<th>Fecha entrega</th>
		   					<th>Descripci&oacute;n</th>
		   					<th>Cliente</th>
		   					<th>Sucursal</th>
		   					<th>Atendi&oacute;</th>
		   				</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach items="${salesByWeek}" var="sale">
		   					<tr>
		   						<td>${sale.saleId}</td>
		   						<td>${sale.saleDate}</td>
		   						<td>${sale.dateDelivery }</td>
		   						<td>${sale.description}</td>
		   						<td>${sale.nameCustomer}</td>
		   						<td>${sale.nameOffice}</td>
		   						<td>${sale.nameUser}</td>
		   					</tr>  	
	   					</c:forEach>			
	   				</tbody>
	   			</table>
	   		</c:if>
	   		<c:if test="${empty salesByWeek}">
	   			<p>No encontr&eacute; ventas de la semana </p>
	   		</c:if>
	   		</div>
	   </div>
	   <div class="col-sm-12 ">
	   	 <h3>Venta mensual</h3>
	   	 <div class="container-salesMonth bgcol">
	   		<c:if test="${not empty salesByMonth}">
	   			<table class="table">
	   				<thead>
		   				<tr>
		   					<th>Id</th>
		   					<th>Fecha registro</th>
		   					<th>Fecha entrega</th>
		   					<th>Descripci&oacute;n</th>
		   					<th>Cliente</th>
		   					<th>Sucursal</th>
		   					<th>Atendi&oacute;</th>
		   				</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach items="${salesByMonth}" var="sale">
		   					<tr>
		   						<td>${sale.saleId}</td>
		   						<td>${sale.saleDate}</td>
		   						<td>${sale.dateDelivery }</td>
		   						<td>${sale.description}</td>
		   						<td>${sale.nameCustomer}</td>
		   						<td>${sale.nameOffice}</td>
		   						<td>${sale.nameUser}</td>
		   					</tr>  	
	   					</c:forEach>			
	   				</tbody>
	   			</table>
	   		</c:if>
	   		<c:if test="${empty salesByMonth}">
	   			<p>No encontr&eacute; ventas del mes </p>
	   		</c:if>
	   		</div>	   	 
	   	</div>
	   	
	   	  <div class="col-sm-12 centered" >
			<h3>Productos del dia </h3>	
			<div class="container-itemsByDay bgcol">
	   		<c:if test="${not empty itemsByDay}">
	   			<table class="table">
	   				<thead>
		   				<tr>
		   					<th>Id</th>
		   					<th>Total</th>
		   					<th>Descripci&oacute;n</th>		   					
		   				</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach items="${itemsByDay}" var="item">
		   					<tr>
		   						<td>${item.itemId}</td>
		   						<td>${item.total}</td>
		   						<td>${item.description }</td>		   					
		   					</tr>  	
	   					</c:forEach>			
	   				</tbody>
	   			</table>
	   		</c:if>
	   		<c:if test="${empty itemsByDay}">
	   			<p>No encontr&eacute; articulos vendidos el dia de hoy </p>
	   		</c:if>
	   		</div>
	   </div>
	   
	   <div class="col-sm-12 centered" >
			<h3>Productos de esta semana </h3>	
			<div class="container-itemsByDay bgcol">
	   		<c:if test="${not empty itemsByWeek}">
	   			<table class="table">
	   				<thead>
		   				<tr>
		   					<th>Id</th>
		   					<th>Total</th>
		   					<th>Descripci&oacute;n</th>		   					
		   				</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach items="${itemsByWeek}" var="item">
		   					<tr>
		   						<td>${item.itemId}</td>
		   						<td>${item.total}</td>
		   						<td>${item.description }</td>		   					
		   					</tr>  	
	   					</c:forEach>			
	   				</tbody>
	   			</table>
	   		</c:if>
	   		<c:if test="${empty itemsByWeek}">
	   			<p>No encontr&eacute; articulos vendidos en esta semana </p>
	   		</c:if>
	   		</div>
	   </div>
	   
	   <div class="col-sm-12 " >
			<h3>Productos de este mes </h3>	
			<div class="container-itemsByDay bgcol">
	   		<c:if test="${not empty itemsByMonth}">
	   			<table class="table">
	   				<thead>
		   				<tr>
		   					<th>Id</th>
		   					<th>Total</th>
		   					<th>Descripci&oacute;n</th>		   					
		   				</tr>
	   				</thead>
	   				<tbody>
	   					<c:forEach items="${itemsByMonth}" var="item">
		   					<tr>
		   						<td>${item.itemId}</td>
		   						<td>${item.total}</td>
		   						<td>${item.description }</td>		   					
		   					</tr>  	
	   					</c:forEach>			
	   				</tbody>
	   			</table>
	   		</c:if>
	   		<c:if test="${empty itemsByMonth}">
	   			<p>No encontr&eacute; articulos vendidos en este mes </p>
	   		</c:if>
	   		</div>
	   </div>
	   	
	</div>
</div>



</body>
</html>