<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	
	<script src="js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="js/jquery-ui/jquery-ui.css">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui/jquery-ui.js"></script>
	
	<script>
	
		$( document ).ready(function() {
			var dias = [ "10", "20", "50", "100", "200", "500" ];
			$("#txtValor").autocomplete({
				source : dias,
				selectFirst : true,
				minLength : 0
			});
			
			dados = $.parseJSON(
				$.ajax({
	                url : "/Projeto_Integrado/controller.do",
	                type : "POST",
	                data : {
	                	command: "EfetuarSaque_NotasDisponiveis"
	                },
	                dataType : "json",
	                async: false
	        	}).responseText
        	);
			
			if (dados[0].consultou == true){
				$("#notasDisponiveis").html(dados[0].notas);
			}else{
				alert(dados[0].mensagem);
			}
			
			perdeFoco("txtValor", "${sessionScope.idioma.getString('view.telaEfetuarSaque.valor')}", false);
		});
		
		function voltar(){				
			$("#proximaPagina").val("Principal.jsp");
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
		function sacar(){
			if (($("#txtValor").val() != "") && ($("#txtValor").val() != "0") && ($("#txtValor").val() != "${sessionScope.idioma.getString('view.telaEfetuarSaque.valor')}")){
				dados = $.parseJSON(
					$.ajax({
		                url : "/Projeto_Integrado/controller.do",
		                type : "POST",
		                data : {
		                	command: "EfetuarSaque_Sacar",
		                	txtValor: $("#txtValor").val()
		                },
		                dataType : "json",
		                async: false
		        	}).responseText
	        	);
				
				alert(dados[0].mensagem);
				
				if (dados[0].sacou == true){
					voltar();
				}
			}else{
				alert("${sessionScope.idioma.getString('control.efetuarSaque.naoDigitouOValor')}");
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
		<title>${sessionScope.idioma.getString("view.telaEfetuarSaque.titulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaEfetuarSaque.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="EfetuarSaque.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<div class="well">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center">
								<h3 id="notasDisponiveis"></h3>
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
							<td align="center" style="width: 60%;" colspan="3">
								<input type="text" id="txtValor" name="txtValor" style="text-align:center; width: 100%;" class="form-control"
									onfocus="recebeFoco('txtValor', '${sessionScope.idioma.getString('view.telaEfetuarSaque.valor')}', false);javascript:$(this).autocomplete('search','');"
									onblur="perdeFoco('txtValor', '${sessionScope.idioma.getString('view.telaEfetuarSaque.valor')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
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
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaEfetuarSaque.sacar')}" onclick="sacar()">
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