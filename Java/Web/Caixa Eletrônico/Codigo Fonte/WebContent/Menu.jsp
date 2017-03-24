<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script type="text/javascript">
	
		function mudarIdioma(idioma){
			document.getElementById("opcaoIdioma").value = idioma;
			document.getElementById("idioma").submit();
		}

	</script>
	
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
	</head>
	<body>
		<nav class="navbar navbar-inverse navbar-fixed-top" >
			<div class="container">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">${requestScope.titulo}</a>
				</div>
				<ul class="nav navbar-nav navbar-right">				
					<li><a class="navbar-brand" href="#"><img src="imagens/Brazil.ico" height="25" width="30" onclick="mudarIdioma('portugues')"></a></li>
					<li><a class="navbar-brand" href="#"><img src="imagens/Baker Island.ico" height="25" width="30" onclick="mudarIdioma('ingles')"></a></li>
					<li><a class="navbar-brand" href="#"><img src="imagens/Spain.ico" height="25" width="30" onclick="mudarIdioma('espanhol')"></a></li>
				</ul>				
				<div id="navbar" class="navbar-collapse collapse in" aria-expanded="true" style="">
			</div>
		</nav>
		<form action="controller.do" method="post" id="idioma">
			<input type="hidden" id="commandIdioma" name="command" value="Idioma_Alterar">
			<input type="hidden" id="opcaoIdioma" name="opcaoIdioma">
			<input type="hidden" id="telaAtual" name="telaAtual" value="${linkPaginaOrigem}">
			<input type="hidden" id="parametros" name="parametros" value="${parametros}">
		</form>
	</body>
</html>