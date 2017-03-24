<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<c:set var="cliente1" scope="session" value=""/>
	<c:set var="cliente2" scope="session" value=""/>
	<c:set var="nome" scope="session" value=""/>

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<script>
	
		var codigoAcesso = "";
	
		$( document ).ready(function() {
			sortearBotoes();
		});
		
		function concatenaCodigoAcesso(campo){
			codigoAcesso += $("#" + campo).val().substring(0, 1) + "";
			if (codigoAcesso.length == 3){
				acessar();
			}
		}

		function acessar(){
			var dados = $.parseJSON(
				$.ajax({
	                url : "/Projeto_Integrado/controller.do",
	                type : "POST",
	                data : {
	                	command: "CodigoAcesso_Logar",
	                	codigoAcesso: codigoAcesso
	                },
	                dataType : "json",
	                async: false
	        	}).responseText
        	);

			alert(dados[0].mensagem);
			
			if(dados[0].proximaPagina != ""){
				$("#proximaPagina").val(dados[0].proximaPagina);
				$("#commandPrincipal").val("Geral_Direcionar");
				$("#principal").submit();
			}else{
				sortearBotoes();
				codigoAcesso = "";
			}
		}
	
		function sortearBotoes(){
			var dados = $.parseJSON(
				$.ajax({
	                url : "/Projeto_Integrado/controller.do",
	                type : "POST",
	                data : {
	                	command: "CodigoAcesso_SortearBotoes"
	                },
	                dataType : "json",
	                async: false
	        	}).responseText
        	);

			$("#btn1").val(dados[0].btn1);
			$("#btn2").val(dados[0].btn2);
			$("#btn3").val(dados[0].btn3);
			$("#btn4").val(dados[0].btn4);
			$("#btn5").val(dados[0].btn5);
		}

		function voltar(){				
			$("#proximaPagina").val("Acesso.jsp");
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
	</script>
	
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>${sessionScope.idioma.getString("view.telaCodigoAcesso.setTitulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaCodigoAcesso.setTitulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="CodigoAcesso.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<input type="hidden" name="codigoAcesso" id="codigoAcesso" value="">
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="" id="btn1" onclick="concatenaCodigoAcesso('btn1')">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="" id="btn2" onclick="concatenaCodigoAcesso('btn2')">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="" id="btn3" onclick="concatenaCodigoAcesso('btn3')">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="" id="btn4" onclick="concatenaCodigoAcesso('btn4')">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaAcesso.voltar')}" onclick="voltar()">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="" id="btn5" onclick="concatenaCodigoAcesso('btn5')">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
		<c:import url="Rodape.jsp"/>
	</body>
</html>