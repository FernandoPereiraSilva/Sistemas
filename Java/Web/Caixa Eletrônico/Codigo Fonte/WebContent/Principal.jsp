<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	
	<script>

		function consultarSaldo(){
			$("#commandPrincipal").val("ConsultarSaldo_AbrirTela");
			$("#principal").submit();
		}
		
		function direcionar(pagina){				
			$("#proximaPagina").val(pagina);
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
	</script>
	
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>${sessionScope.idioma.getString("view.telaPrincipal.titulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaPrincipal.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="Principal.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaPrincipal.cadastrarDebito')}" onclick="direcionar('DebitoAutomatico.jsp')">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaPrincipal.consultarSaldo')}" onclick="consultarSaldo()">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaPrincipal.efetuarTranferencia')}" onclick="direcionar('EfetuarTransferencia.jsp')">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaPrincipal.consultarExtrato')}" onclick="direcionar('ConsultarExtrato.jsp')">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaPrincipal.efetuarSaque')}" onclick="direcionar('EfetuarSaque.jsp')">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaPrincipal.sair')}" onclick="direcionar('Acesso.jsp')">
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${not empty sessionScope.listaOperacoes}">
					<c:remove var="listaOperacoes" scope="session"/>
					<c:remove var="indice" scope="session"/>
					<c:remove var="dias" scope="session"/>
					<c:remove var="mensagemImprimir" scope="session"/>
				</c:if>
			</form>
		</div>
		<c:import url="Rodape.jsp"/>
	</body>
</html>