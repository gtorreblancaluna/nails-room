<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html>
<head>
<style type="text/css">
.panelOpciones{}
.panelOpciones a {		
	  font: bold 17px Arial;
	  text-decoration: none;
	  background-color: #FFF;
	  color: #333333;
	  float: left;
	  width:150px;
	  height:150px;
	  margin: 4%;
	  border-radius: 3px;
  }
  
  .panelOpciones a label{		
	 padding-top: 45%;
  }
.panelBorder{
	border-style: solid;
    background-color: #00000059;
    border-color: black;
    border-radius: 2px;
    -webkit-box-shadow: 10px 10px 5px -5px rgba(186,186,186,1);
    -moz-box-shadow: 10px 10px 5px -5px rgba(186,186,186,1);
    box-shadow: 5px 4px 5px -5px rgb(0, 0, 0);
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Nails Room :: bienvenido</title>
</head>
<body>

<div class="container">

<div class="container-header">
	<h1>I N I C I O</h1>
</div>
	<div class=" ">
		<div class="row">
			<div class="col-sm-12 panelBorder">
				<div class="panelOpciones text-center">
					<a href="caja.do"><label>C A J A</label></a>
					<a href="ventas.do"><label>V E N T A S</label></a>
					<a href="javascript:void(0);"><label>R E P O R T E S</label></a>					
				</div>
			</div>			
		</div>
		
		
	</div>	
	
</div>

</body>
</html>