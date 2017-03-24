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
	
		$( document ).ready(function() {
			perdeFoco("txtAgencia", "${sessionScope.idioma.getString('view.telaAcesso.agencia')}", false);
			perdeFoco("txtConta", "${sessionScope.idioma.getString('view.telaAcesso.conta')}", false);
			perdeFoco("txtSenha", "${sessionScope.idioma.getString('view.telaAcesso.senha')}", false);
		});
	
		function acessar(){
			if (($("#txtAgencia").val() != "" && $("#txtAgencia").val() != "${sessionScope.idioma.getString('view.telaAcesso.agencia')}") &&
				($("#txtConta").val() != "" && $("#txtConta").val() != "${sessionScope.idioma.getString('view.telaAcesso.conta')}") &&
				($("#txtSenha").val() != "" && $("#txtSenha").val() != "${sessionScope.idioma.getString('view.telaAcesso.senha')}"))
			{
				var dados = $.parseJSON(
					$.ajax({
		                url : "/Projeto_Integrado/controller.do",
		                type : "POST",
		                data : {
		                	command: "Acessar_Logar",
		                	txtAgencia: $("#txtAgencia").val(),
		                	txtConta: $("#txtConta").val(),
		                	txtSenha: $("#txtSenha").val()
		                },
		                dataType : "json",
		                async: false
		        	}).responseText
	        	);

				alert(dados[0].mensagem);
				
				if(dados[0].acessou == "true"){
					$("#proximaPagina").val(dados[0].proximaPagina);
					$("#commandPrincipal").val("Geral_Direcionar");
					$("#principal").submit();
				}
			}else{
				alert("${sessionScope.idioma.getString('control.acesso.campos')}");
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
	</script>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>${sessionScope.idioma.getString("view.telaAcesso.titulo")}</title>
	</head>
	<body>	
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${idioma.getString('view.telaAcesso.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="Acesso.jsp"/>
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
								<input type="text" id="txtAgencia" name="txtAgencia" style="text-align:center; width: 90%;" maxlength="4" class="form-control"
									onfocus="recebeFoco('txtAgencia', '${sessionScope.idioma.getString('view.telaAcesso.agencia')}', false)"
									onblur="perdeFoco('txtAgencia', '${sessionScope.idioma.getString('view.telaAcesso.agencia')}', false)"
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
									onfocus="recebeFoco('txtConta', '${sessionScope.idioma.getString('view.telaAcesso.conta')}', false)"
									onblur="perdeFoco('txtConta', '${sessionScope.idioma.getString('view.telaAcesso.conta')}', false)"
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
								<input type="text" id="txtSenha" name="txtSenha" style="text-align:center; width: 90%;" maxlength="4" class="form-control"
									onfocus="recebeFoco('txtSenha', '${sessionScope.idioma.getString('view.telaAcesso.senha')}', true)"
									onblur="perdeFoco('txtSenha', '${sessionScope.idioma.getString('view.telaAcesso.senha')}', true)"
								>
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
								<input class="btn btn-primary" type="button" value="${sessionScope.idioma.getString('view.telaAcesso.acessar')}" id="btn1" onclick="acessar()">
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