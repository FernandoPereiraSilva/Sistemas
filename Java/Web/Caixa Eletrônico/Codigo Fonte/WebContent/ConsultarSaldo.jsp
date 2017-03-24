<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>

	<script language='JavaScript'>
	
		function direcionar(pagina){				
			$("#proximaPagina").val(pagina);
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}

		function voltar(){				
			$("#proximaPagina").val("Principal.jsp");
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
		function imprimir(){
			alert("${requestScope.saldo}");
		}
		
	</script>
	
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>${sessionScope.idioma.getString("view.telaConsultarSaldo.titulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaConsultarSaldo.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="ConsultarSaldo.jsp"/>
			<c:set var="parametros" scope="request" value="<parametro><tipo>double</tipo><tratamento>valor</tratamento><conteudo>${sessionScope.cliente1.getSaldo()}</conteudo><nome>saldo</nome></parametro>"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center">
								<h3>${sessionScope.idioma.getString("view.telaConsultarSaldo.saldo")} ${requestScope.saldo}</h3>
							</td>
						</tr>
					</table>
				</div>
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaConsultarSaldo.voltar')}" onclick="voltar()">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td align="center" style="width: 20%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaConsultarSaldo.imprimir')}" onclick="imprimir()">
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