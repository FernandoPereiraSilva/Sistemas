<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<script>
	
		$( document ).ready(function() {
			$("#commandPrincipal").val("Idioma_Alterar");
			$("#telaAtual").val("Acesso.jsp");
			$("#principal").submit();
		});
		
	</script>
	
	<head>
	</head>
	<body>	
		<form action="controller.do" method="post" id="principal">
			<input type="hidden" id="commandPrincipal" name="command" value="">
			<input type="hidden" id="telaAtual" name="telaAtual" value="">
		</form>
	</body>
</html>