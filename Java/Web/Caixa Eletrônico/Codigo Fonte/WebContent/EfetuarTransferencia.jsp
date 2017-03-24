<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script src="js/jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery-mask/jquery.mask.js"></script>

	<script type="text/javascript" charset="utf8">

		$( document ).ready(function() {
			if ("${sessionScope.idioma.getString('idioma')}" == "portugues"){
				$("#txtValor").mask('000.000.000.000.000,00', {reverse: true});
			}else{
				$("#txtValor").mask('000.000.000.000.000.00', {reverse: true});
			}
			if ("${requestScope.verificado}" == "true"){
				$("#txtAgencia").val("${requestScope.agencia}");
				$("#txtConta").val("${requestScope.conta}");
				$("#txtValor").val("${requestScope.valor}");
				$("#txtAgenciaDestino").val("${requestScope.agencia}");
				$("#txtContaDestino").val("${requestScope.conta}");
				$("#txtNomeDestino").val("${requestScope.nomeDestino}");

				if ("${requestScope.valorDestino}".startsWith("&#8364;")){
					$("#txtValorDestino").val("€" + "${requestScope.valorDestino}".substring(7));
				}else{
					$("#txtValorDestino").val("${requestScope.valorDestino}");
				}
				
				$("#valorBruto").val("${requestScope.valor}");
				$("#parametros").val("<parametro><tipo>boolean</tipo><tratamento></tratamento><conteudo>true</conteudo><nome>verificado</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtAgencia").val() + "</conteudo><nome>agencia</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtConta").val() + "</conteudo><nome>conta</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtValor").val() + "</conteudo><nome>valor</nome></parametro><parametro><tipo>double</tipo><tratamento>valor</tratamento><conteudo>" + $("#txtValor").val() + "</conteudo><nome>valorDestino</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtNomeDestino").val() + "</conteudo><nome>nomeDestino</nome></parametro>");
			}else{
				perdeFoco("txtAgencia", "${sessionScope.idioma.getString('view.telaEfetuarTransferência.agenciaDestino')}", false);
				perdeFoco("txtValor", "${sessionScope.idioma.getString('view.telaEfetuarTransferência.valorDestino')}", true);
				perdeFoco("txtConta", "${sessionScope.idioma.getString('view.telaEfetuarTransferência.contaDestino')}", false);
			}
		});

		function verificar(){
			if (($("#txtAgencia").val() != "" && $("#txtAgencia").val() != "${sessionScope.idioma.getString('view.telaEfetuarTransferência.agenciaDestino')}") &&
				($("#txtConta").val() != "" && $("#txtConta").val() != "${sessionScope.idioma.getString('view.telaEfetuarTransferência.valorDestino')}") &&
				($("#txtValor").val() != "" && $("#txtValor").val() != "${sessionScope.idioma.getString('view.telaEfetuarTransferência.contaDestino')}"))
			{
				var dados = $.parseJSON(
					$.ajax({
		                url : "/Projeto_Integrado/controller.do",
		                type : "POST",
		                data : {
		                	command: "EfetuarTransferencia_Verificar",
		                	txtAgencia: $("#txtAgencia").val(),
		                	txtConta: $("#txtConta").val(),
		                	txtValor: $("#txtValor").val().replace(",", ".")
		                },
		                dataType : "json",
		                async: false
		        	}).responseText
	        	);
				
				if(dados[0].valido == "true"){

					$("#parametros").val("<parametro><tipo>boolean</tipo><tratamento></tratamento><conteudo>true</conteudo><nome>verificado</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtAgencia").val() + "</conteudo><nome>agencia</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtConta").val() + "</conteudo><nome>conta</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtValor").val() + "</conteudo><nome>valor</nome></parametro><parametro><tipo>double</tipo><tratamento>valor</tratamento><conteudo>" + $("#txtValor").val() + "</conteudo><nome>valorDestino</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + dados[0].nome + "</conteudo><nome>nomeDestino</nome></parametro>");
					
					$("#txtAgenciaDestino").val(dados[0].agencia);
					$("#txtContaDestino").val(dados[0].conta);
					$("#txtNomeDestino").val(dados[0].nome);
					$("#valorBruto").val(dados[0].valorBruto);
					
					if (dados[0].valor.startsWith("&#8364;")){
						$("#txtValorDestino").val("€" + dados[0].valor.substring(7));
					}else{
						$("#txtValorDestino").val(dados[0].valor);
					}
					
					$("#camposVerificar").toggle("slow");
					$("#botoesVerificar").toggle("slow");
					$("#camposConfirmar").toggle("slow");
					$("#botoesConfirmar").toggle("slow");
				}else{
					alert(dados[0].mensagem);
				}
			}else{
				alert("${sessionScope.idioma.getString('control.efetuarTransferencia.campos')}");
			}
		}
		
		function alterar(){
			$("#parametros").val("");
		
			$("#camposVerificar").toggle("slow");
			$("#botoesVerificar").toggle("slow");
			$("#camposConfirmar").toggle("slow");
			$("#botoesConfirmar").toggle("slow");
		}
		
		function confirmar(){
			var dados = $.parseJSON(
				$.ajax({
	                url : "/Projeto_Integrado/controller.do",
	                type : "POST",
	                data : {
	                	command: "EfetuarTransferencia_Confirmar",
	                	txtAgencia: $("#txtAgencia").val(),
	                	txtConta: $("#txtConta").val(),
	                	valorBruto: $("#valorBruto").val()
	                },
	                dataType : "json",
	                async: false
	        	}).responseText
        	);

			alert(dados[0].mensagem);
			
			if(dados[0].transferiu == "true"){
				voltar();
			}
		}
		
		function recebeFoco(campo, conteudoAnterior, password){
			if(password){
				$("#" + campo).attr("type", "password");
			}
			if($("#" + campo).val() == conteudoAnterior){
				$("#" + campo).val("");
				$("#" + campo).css({color: "#000000"});
			}
		}

		function perdeFoco(campo, conteudoPosterior, password){
			if($("#" + campo).val() == ""){
				if(password){
					$("#" + campo).attr("type", "text");
				}
				$("#" + campo).val(conteudoPosterior);
				$("#" + campo).css({color: "#999999"});
			}
		}
	
		function validaConteudoDigitado(letra, expressaoRegular){
			if(letra.match(expressaoRegular))	return true;
			else								return false;
		}

		function voltar(){				
			$("#proximaPagina").val("Principal.jsp");
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
	</script>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>${sessionScope.idioma.getString("view.telaEfetuarTransferência.titulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaEfetuarTransferência.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="EfetuarTransferencia.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<input type="hidden" id="valorBruto" name="valorBruto">
				<c:if test="${requestScope.verificado == 'true'}">
					<div class="well" id="camposVerificar" style="display:none;">
				</c:if>
				<c:if test="${empty requestScope.verificado}">
					<div class="well" id="camposVerificar" >
				</c:if>
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input type="text" id="txtAgencia" name="txtAgencia" style="text-align:center; width: 90%;" maxlength="4" class="form-control"
									onfocus="recebeFoco('txtAgencia', '${sessionScope.idioma.getString('view.telaEfetuarTransferência.agenciaDestino')}', false)"
									onblur="perdeFoco('txtAgencia', '${sessionScope.idioma.getString('view.telaEfetuarTransferência.agenciaDestino')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input type="text" id="txtConta" name="txtConta" style="text-align:center; width: 90%;" maxlength="8" class="form-control"
									onfocus="recebeFoco('txtConta', '${sessionScope.idioma.getString('view.telaEfetuarTransferência.contaDestino')}', false)"
									onblur="perdeFoco('txtConta', '${sessionScope.idioma.getString('view.telaEfetuarTransferência.contaDestino')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
							<td align="center" style="width: 33.3%;">
								<input type="text" id="txtValor" name="txtValor" style="text-align:center; width: 90%;" class="form-control"
									onfocus="recebeFoco('txtValor', '${sessionScope.idioma.getString('view.telaEfetuarTransferência.valorDestino')}', false)"
									onblur="perdeFoco('txtValor', '${sessionScope.idioma.getString('view.telaEfetuarTransferência.valorDestino')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
							</td>
							<td align="center" style="width: 33.3%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${requestScope.verificado == 'true'}">
					<div class="well" id="botoesVerificar" style="display:none;">
				</c:if>
				<c:if test="${empty requestScope.verificado}">
					<div class="well" id="botoesVerificar" >
				</c:if>
					<table style="width: 100%; height: 100%;">
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
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaEfetuarTransferência.verificar')}" onclick="verificar()">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${requestScope.verificado == 'true'}">
					<div class="well" id="camposConfirmar" >
				</c:if>
				<c:if test="${empty requestScope.verificado}">
					<div class="well" id="camposConfirmar" style="display:none;">
				</c:if>
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td style="width: 35%;">
								<h3>${sessionScope.idioma.getString("view.telaEfetuarTransferência.agencia")}</h3>
							</td>
							<td style="width: 55%;">
								<input type="text" id="txtAgenciaDestino" class="form-control" style="width: 100%" readonly="readonly">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td style="width: 35%;">
								<h3>${sessionScope.idioma.getString("view.telaEfetuarTransferência.conta")}</h3>
							</td>
							<td style="width: 55%;">
								<input type="text" id="txtContaDestino" class="form-control" style="width: 100%" readonly="readonly">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td style="width: 35%;">
								<h3>${sessionScope.idioma.getString("view.telaEfetuarTransferência.nome")}</h3>
							</td>
							<td style="width: 55%;">
								<input type="text" id="txtNomeDestino" class="form-control" style="width: 100%" readonly="readonly">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
						</tr>
						<tr>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td style="width: 35%;">
								<h3>${sessionScope.idioma.getString("view.telaEfetuarTransferência.valor")}</h3>
							</td>
							<td style="width: 55%;">
								<input type="text" id="txtValorDestino" class="form-control" style="width: 100%" readonly="readonly">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${requestScope.verificado == 'true'}">
					<div class="well" id="botoesConfirmar" >
				</c:if>
				<c:if test="${empty requestScope.verificado}">
					<div class="well" id="botoesConfirmar" style="display:none;">
				</c:if>
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 14.28%;">
								&nbsp;
							</td>
							<td align="center" style="width: 14.28%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaAcesso.voltar')}" onclick="voltar()">
							</td>
							<td align="center" style="width: 14.28%;">
								&nbsp;
							</td>
							<td align="center" style="width: 14.28%;">
								<input class="btn btn-warning btn-block" type="button" value="${sessionScope.idioma.getString('view.telaEfetuarTransferência.alterar')}" onclick="alterar()">
							</td>
							<td align="center" style="width: 14.28%;">
								&nbsp;
							</td>
							<td align="center" style="width: 14.28%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaEfetuarTransferência.confirmar')}" onclick="confirmar()">
							</td>
							<td align="center" style="width: 14.28%;">
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