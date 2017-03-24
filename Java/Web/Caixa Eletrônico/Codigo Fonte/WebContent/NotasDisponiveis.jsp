<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<script>
	
		$( document ).ready(function() {
			var dados = $.parseJSON(
				$.ajax({
	                url : "/Projeto_Integrado/controller.do",
	                type : "POST",
	                data : {
	                	command: "NotasDisponiveis_Consultar"
	                },
	                dataType : "json",
	                async: false
	        	}).responseText
        	);

			$("#10").attr("aria-valuenow", dados[0].porcentagemNota10);
			$("#10").css({"width": (($("#tamanho").width() * dados[0].porcentagemNota10) / 100.0)});
			$("#10").html(dados[0].valorFormatadoNota10 + " (" + dados[0].quantidadeNota10 + "/" + dados[0].limiteNota10 + ")");
			if (dados[0].porcentagemNota10 <= 50 && dados[0].porcentagemNota10 >= 25){
				$("#10").attr("class", "progress-bar progress-bar-warning");
			}else if (dados[0].porcentagemNota10 < 25){
				$("#10").attr("class", "progress-bar progress-bar-danger");
			}

			$("#20").attr("aria-valuenow", dados[1].porcentagemNota20);
			$("#20").css({"width": (($("#tamanho").width() * dados[1].porcentagemNota20) / 100.0)});
			$("#20").html(dados[1].valorFormatadoNota20 + " (" + dados[1].quantidadeNota20 + "/" + dados[1].limiteNota20 + ")");
			if (dados[1].porcentagemNota20 <= 50 && dados[1].porcentagemNota20 >= 25){
				$("#20").attr("class", "progress-bar progress-bar-warning");
			}else if (dados[1].porcentagemNota20 < 25){
				$("#20").attr("class", "progress-bar progress-bar-danger");
			}

			$("#50").attr("aria-valuenow", dados[2].porcentagemNota50);
			$("#50").css({"width": (($("#tamanho").width() * dados[2].porcentagemNota50) / 100.0)});
			$("#50").html(dados[2].valorFormatadoNota50 + " (" + dados[2].quantidadeNota50 + "/" + dados[2].limiteNota50 + ")");
			if (dados[2].porcentagemNota50 <= 50 && dados[2].porcentagemNota50 >= 25){
				$("#50").attr("class", "progress-bar progress-bar-warning");
			}else if (dados[2].porcentagemNota50 < 25){
				$("#50").attr("class", "progress-bar progress-bar-danger");
			}
		});

		function voltar(){				
			$("#proximaPagina").val("Administrador.jsp");
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
	</script>
	
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>${sessionScope.idioma.getString("view.telaOperacoes.titulo")}</title>
	</head>
	<body>	
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${idioma.getString('view.telaOperacoes.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="NotasDisponiveis.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 60%;">
								<div class="progress">
						    		<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%" id="50"></div>
						    	</div>
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 60%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 60%;" id="tamanho">
								<div class="progress">
						    		<div class="progress-bar progress-bar-success" role="progressbar2" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%" id="20"></div>
						    	</div>
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 60%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 60%;">
								<div class="progress">
						    		<div class="progress-bar progress-bar-success" role="progressbar3" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%" id="10"></div>
						    	</div>
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaConsultarSaldo.voltar')}" onclick="voltar()">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
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