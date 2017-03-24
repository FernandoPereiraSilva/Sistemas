<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	
	<script src="js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="js/jquery-ui/jquery-ui.css">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui/jquery-ui.js"></script>
	<script src="js/jquery-mask/jquery.mask.js"></script>
	
	<script>
	
		$( document ).ready(function() {	
			
			if ("${sessionScope.idioma.getString('idioma')}" == "portugues"){
				$("#txtValor").mask('000.000.000.000.000,00', {reverse: true});
			}else{
				$("#txtValor").mask('000.000.000.000.000.00', {reverse: true});
			}
			
			$("#txtDataDebito").mask('00/00/0000');
			
			var data = new Date();
			data.setDate(data.getDate() +1)
			
		   $('#txtDataDebito').removeClass('hasDatepicker');
		   $('#txtDataDebito').datepicker({
		       	onSelect: function(dateText, inst) {
		       		$("#txtDataDebito").css({color: "#000000"});
		       	},
				dateFormat: 'dd/mm/yy',
				dayNames: ['Domingo','Segunda','Terça','Quarta','Quinta','Sexta','Sábado','Domingo'],
				dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
				dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','Sáb','Dom'],
				monthNames: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
				monthNamesShort: ['Janeiro','Fevereiro','Março','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
				changeMonth: true,
			    changeYear: true,
			    minDate: data
		   });
			
			perdeFoco("txtOperadora", "${sessionScope.idioma.getString('view.telaCadastrarDebito.codOperadora')}", false);
			perdeFoco("txtDataDebito", "${sessionScope.idioma.getString('view.telaCadastrarDebito.dataDebito')}", false);
			perdeFoco("txtConsumidor", "${sessionScope.idioma.getString('view.telaCadastrarDebito.codConsumidor')}", false);
			perdeFoco("txtValor", "${sessionScope.idioma.getString('view.telaCadastrarDebito.valor')}", false);
		});
		
		function voltar(){				
			$("#proximaPagina").val("Principal.jsp");
			$("#commandPrincipal").val("Geral_Direcionar");
			$("#principal").submit();
		}
		
		function cadastrar(){
			if (($("#txtOperadora").val() != "" && $("#txtOperadora").val() != "${sessionScope.idioma.getString('view.telaCadastrarDebito.codOperadora')}") &&
				($("#txtDataDebito").val() != "" && $("#txtDataDebito").val() != "${sessionScope.idioma.getString('view.telaCadastrarDebito.dataDebito')}") &&
				($("#txtConsumidor").val() != "" && $("#txtConsumidor").val() != "${sessionScope.idioma.getString('view.telaCadastrarDebito.codConsumidor')}") &&
				($("#txtValor").val() != "" && $("#txtValor").val().replace(",", ".") > 0 && $("#txtValor").val() != "${sessionScope.idioma.getString('view.telaCadastrarDebito.valor')}"))
			{
				var hoje = new Date();
				dados = $.parseJSON(
					$.ajax({
		                url : "/Projeto_Integrado/controller.do",
		                type : "POST",
		                data : {
		                	command: "DebitoAutomatico_Cadastrar",
		                	txtOperadora: $("#txtOperadora").val(),
		                	txtDataDebito: $("#txtDataDebito").val(),
		                	txtConsumidor: $("#txtConsumidor").val(),
		                	txtValor: $("#txtValor").val().replace(",", ".")
		                },
		                dataType : "json",
		                async: false
		        	}).responseText
	        	);
				
				alert(dados[0].mensagem);
				
				if (dados[0].cadastrou == "true"){
					voltar();
				}
			}else{
				alert("${sessionScope.idioma.getString('control.cadastrarDebito.naoDigitouOValor')}");
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
		<title>${sessionScope.idioma.getString("view.telaCadastrarDebito.titulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaCadastrarDebito.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="DebitoAutomatico.jsp"/>
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
								<input type="text" id="txtOperadora" name="txtOperadora" style="text-align:center; width: 100%;" class="form-control"
									onfocus="recebeFoco('txtOperadora', '${sessionScope.idioma.getString('view.telaCadastrarDebito.codOperadora')}', false)"
									onblur="perdeFoco('txtOperadora', '${sessionScope.idioma.getString('view.telaCadastrarDebito.codOperadora')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
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
								<input type="text" id="txtDataDebito" name="txtDataDebito" style="text-align:center; width: 100%;" class="form-control"
									onfocus="recebeFoco('txtDataDebito', '${sessionScope.idioma.getString('view.telaCadastrarDebito.dataDebito')}', false)"
									onblur="perdeFoco('txtDataDebito', '${sessionScope.idioma.getString('view.telaCadastrarDebito.dataDebito')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
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
								<input type="text" id="txtConsumidor" name="txtConsumidor" style="text-align:center; width: 100%;" class="form-control"
									onfocus="recebeFoco('txtConsumidor', '${sessionScope.idioma.getString('view.telaCadastrarDebito.codConsumidor')}', false)"
									onblur="perdeFoco('txtConsumidor', '${sessionScope.idioma.getString('view.telaCadastrarDebito.codConsumidor')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
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
								<input type="text" id="txtValor" name="txtValor" style="text-align:center; width: 100%;" class="form-control"
									onfocus="recebeFoco('txtValor', '${sessionScope.idioma.getString('view.telaCadastrarDebito.valor')}', false)"
									onblur="perdeFoco('txtValor', '${sessionScope.idioma.getString('view.telaCadastrarDebito.valor')}', false)"
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
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaCadastrarDebito.cadastrar')}" onclick="cadastrar()">
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