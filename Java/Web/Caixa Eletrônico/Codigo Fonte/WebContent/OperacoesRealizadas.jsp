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
	                	command: "OperacoesRealizadas_Consultar"
	                },
	                dataType : "json",
	                async: false
	        	}).responseText
        	);

			colorir(dados[0].tabela, 2, dados[0].formatado);
			colorir(dados[1].tabela, 4, dados[1].formatado);
			colorir(dados[3].tabela, 6, dados[3].formatado);
			colorir(dados[4].tabela, 8, dados[4].formatado);
		});
		
		function colorir(limite, coluna, valorFormatado){
			for (var i = 1; i < 101; i++){
				if (i < limite){
					$("#" + i + "x" + coluna).css({"background-color": "#3CB371", "border-left": "solid", "border-right": "solid"});
					$("#" + i + "x" + coluna).attr("title", valorFormatado);
				}
				if (i == limite){
					$("#" + i + "x" + coluna).css({"background-color": "#3CB371", "border-top": "solid", "border-left": "solid", "border-right": "solid"});
					$("#" + i + "x" + coluna).attr("title", valorFormatado);
				}
			}
		}

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
			<c:set var="linkPaginaOrigem" scope="request" value="OperacoesRealizadas.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<div class="well">
					<table style="width: 100%; height: 100%;">
					    <c:forEach var="i" begin="0" end="9">
					    	<c:forEach var="i2" begin="1" end="10">
								<tr style="height: 3px;">
					    			<c:forEach var="i3" begin="1" end="10">
										<c:if test="${i2 == 1 and i3 == 1}">
											<td align="center" style="width: 10%; vertical-align: middle; border-right: solid; border-top: solid;" rowspan="10">${10 - i}0%</td>
										</c:if>
										<td align="center" title="" style="width: 10%;" id="${100 - ((10 * i) + (i2-1))}x${i3}"></td>
									</c:forEach>
								</tr>
							</c:forEach>
						</c:forEach>
						<tr style="height: 3px;">
							<td align="center" style="width: 10%; vertical-align: middle; border-right: solid; border-top: solid;" rowspan="10"></td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10"></td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10">${sessionScope.idioma.getString('view.telaConsultarSaldo.titulo')}</td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10"></td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10">${sessionScope.idioma.getString('view.telaEfetuarTransferência.titulo')}</td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10"></td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10">${sessionScope.idioma.getString('view.telaEfetuarSaque.titulo')}</td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10"></td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10">${sessionScope.idioma.getString('view.telaCadastrarDebito.titulo')}</td>
							<td align="center" style="width: 10%; vertical-align: middle; border-top: solid;" rowspan="10"></td>
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