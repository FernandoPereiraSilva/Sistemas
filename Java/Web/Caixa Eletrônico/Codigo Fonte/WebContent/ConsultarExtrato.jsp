<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<script src="js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="js/jquery-ui/jquery-ui.css">
	<script src="js/jquery.js"></script>
	<script src="js/jquery-ui/jquery-ui.js"></script>
	
	<script>
	
		var dados = "";
		var indice = 0;
	
		$( document ).ready(function() {

			var dias = [ "7", "15" ];
			$("#txtDias").autocomplete({
				source : dias,
				selectFirst : true,
				minLength : 0
			});
			
			if ("${requestScope.pesquisado}" == "true"){
				$("#txtDias").val("${requestScope.dias}");
				indice = "${requestScope.indice}";
				pesquisar();
			}else{
				perdeFoco("txtDias", "${sessionScope.idioma.getString('view.telaConsultarExtrato.lancamento')}", false);
			}
		});
	
		function pesquisar(){
			if (($("#txtDias").val() != "" && $("#txtDias").val() != "${sessionScope.idioma.getString('view.telaConsultarExtrato.lancamento')}")){
				dados = $.parseJSON(
					$.ajax({
		                url : "/Projeto_Integrado/controller.do",
		                type : "POST",
		                data : {
		                	command: "ConsultarExtrato_Pesquisar",
		                	txtDias: $("#txtDias").val()
		                },
		                dataType : "json",
		                async: false
		        	}).responseText
		    	);
				
				if (dados[0].temItens == "true"){
					$("#parametros").val("<parametro><tipo>boolean</tipo><tratamento></tratamento><conteudo>true</conteudo><nome>pesquisado</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + indice + "</conteudo><nome>indice</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtDias").val() + "</conteudo><nome>dias</nome></parametro>");

					if (dados[0].lista.length > 1 && indice < dados[0].lista.length-1){
						$("#btnProximo").attr("disabled", false);
					}
					
					if (indice > 0){
						$("#btnAnterior").attr("disabled", false);
					}
					
					$("#camposPesquisar").hide("slow");
					$("#botoesPesquisar").hide("slow");
					$("#camposTabela").show("slow");
					$("#botoesTabela").show("slow");
					preencheCampos();
				}else{
					alert(dados[0].mensagem);
				}
			}else{
				alert("${sessionScope.idioma.getString('control.consultarExtrato.periodoVazio')}");
			}
		}
		
		function imprimir(){
			for (var i = 0; i < dados[0].lista.length; i++){
				for (var i2 = 0; i2 < dados[0].lista[i].length; i2++){
					alert(
					    "${sessionScope.idioma.getString('view.telaConsultarExtrato.numDocumento')}: " + dados[0].lista[i][i2].numeroDocumento + "\n" +
						"${sessionScope.idioma.getString('view.telaConsultarExtrato.data')}: " + dados[0].lista[i][i2].data + "\n" +
						"${sessionScope.idioma.getString('view.telaConsultarExtrato.tipo')}: " + dados[0].lista[i][i2].tipo + "\n" +
				        "${sessionScope.idioma.getString('view.telaConsultarExtrato.debitoCredito')}: " + dados[0].lista[i][i2].debitoCredito + "\n" +
				        "${sessionScope.idioma.getString('view.telaConsultarExtrato.valor')}: " + dados[0].lista[i][i2].valor + "\n" +
				        "${sessionScope.idioma.getString('view.telaConsultarExtrato.saldoFinal')}: " + dados[0].lista[i][i2].saldoFinal + "\n"
					);
				}
			}
		}
		
		function proximo(){
			indice++;
			preencheCampos();

			if (indice == dados[0].lista.length-1){
				$("#btnProximo").attr("disabled", true);
			}
			
			$("#btnAnterior").attr("disabled", false);
			$("#parametros").val("<parametro><tipo>boolean</tipo><tratamento></tratamento><conteudo>true</conteudo><nome>pesquisado</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + indice + "</conteudo><nome>indice</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtDias").val() + "</conteudo><nome>dias</nome></parametro>");
		}
		
		function anterior(){
			indice--;
			preencheCampos();

			if (indice == 0){
				$("#btnAnterior").attr("disabled", true);
			}
			
			$("#btnProximo").attr("disabled", false);
			$("#parametros").val("<parametro><tipo>boolean</tipo><tratamento></tratamento><conteudo>true</conteudo><nome>pesquisado</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + indice + "</conteudo><nome>indice</nome></parametro><parametro><tipo>String</tipo><tratamento></tratamento><conteudo>" + $("#txtDias").val() + "</conteudo><nome>dias</nome></parametro>");
		}
		
		function preencheCampos(){
			var maximo = 10;
			if(dados[0].lista[indice].length < 10){
				maximo = dados[0].lista[indice].length;
				for (var i = maximo; i < 10; i++){
					$("#linha" + (i+1)).attr('class', "");
					for (var i2 = 0; i2 < 6; i2++){
						$("#" + (i+1) + "x" + (i2+1)).html("&nbsp;");
					}
				}
			}
			
			for (var i = 0; i < maximo; i++){
				if(dados[0].lista[indice][i].debitoCredito == "${sessionScope.idioma.getString('view.telaConsultarExtrato.credito')}"){
					$("#linha" + (i+1)).attr('class', "success");
				}else if(dados[0].lista[indice][i].debitoCredito == "${sessionScope.idioma.getString('view.telaConsultarExtrato.debito')}"){
					$("#linha" + (i+1)).attr('class', "danger");
				}else{
					$("#linha" + (i+1)).attr('class', "");
				}
				$("#" + (i+1) + "x1").html(dados[0].lista[indice][i].numeroDocumento);
				$("#" + (i+1) + "x2").html(dados[0].lista[indice][i].data);
				$("#" + (i+1) + "x3").html(dados[0].lista[indice][i].tipo);
				$("#" + (i+1) + "x4").html(dados[0].lista[indice][i].debitoCredito);
				$("#" + (i+1) + "x5").html(dados[0].lista[indice][i].valor);
				$("#" + (i+1) + "x6").html(dados[0].lista[indice][i].saldoFinal);
			}
		}
		
		function alterar(){
			indice = 0;
			$("#parametros").val("");
			$("#camposPesquisar").toggle("slow");
			$("#botoesPesquisar").toggle("slow");
			$("#camposTabela").toggle("slow");
			$("#botoesTabela").toggle("slow");
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
		<title>${sessionScope.idioma.getString("view.telaConsultarExtrato.titulo")}</title>
	</head>
	<body>
	    <div id="main" class="container">
			<c:set var="titulo" scope="request" value="${sessionScope.idioma.getString('view.telaConsultarExtrato.titulo')}"/>
			<c:set var="linkPaginaOrigem" scope="request" value="ConsultarExtrato.jsp"/>
			<c:import url="Menu.jsp"/>
			<form action="controller.do" method="post" id="principal">
				<input type="hidden" id="commandPrincipal" name="command" value="">
				<input type="hidden" id="proximaPagina" name="proximaPagina" value="">
				<c:if test="${requestScope.pesquisado == 'true'}">
					<div class="well" id="camposPesquisar" style="display:none;">
				</c:if>
				<c:if test="${empty requestScope.pesquisado}">
					<div class="well" id="camposPesquisar" >
				</c:if>
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
							<td style="width: 60%;">
								<input type="text" id="txtDias" name="txtDias" style="text-align:center; width: 100%;" class="form-control"
									onfocus="recebeFoco('txtDias', '${sessionScope.idioma.getString('view.telaConsultarExtrato.lancamento')}', false);javascript:$(this).autocomplete('search','');"
									onblur="perdeFoco('txtDias', '${sessionScope.idioma.getString('view.telaConsultarExtrato.lancamento')}', false)"
									onkeypress="return validaConteudoDigitado(String.fromCharCode(event.keyCode), '[0-9]')"
								>
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${requestScope.pesquisado == 'true'}">
					<div class="well" id="botoesPesquisar" style="display:none;">
				</c:if>
				<c:if test="${empty requestScope.pesquisado}">
					<div class="well" id="botoesPesquisar" >
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
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaConsultarExtrato.ok')}" onclick="pesquisar()">
							</td>
							<td align="center" style="width: 20%;">
								&nbsp;
							</td>
						</tr>
					</table>
				</div>
				<c:if test="${requestScope.pesquisado == 'true'}">
					<div class="well" id="camposTabela" >
				</c:if>
				<c:if test="${empty requestScope.pesquisado}">
					<div class="well" id="camposTabela" style="display:none;">
				</c:if>
					<table class="table">
						<thead>
					    	<tr>
					           	<th style="width: 20%; text-align: center;">${sessionScope.idioma.getString("view.telaConsultarExtrato.numDocumento")}</th>
					        	<th style="width: 16%; text-align: center;">${sessionScope.idioma.getString("view.telaConsultarExtrato.data")}</th>
					        	<th style="width: 16%; text-align: center;">${sessionScope.idioma.getString("view.telaConsultarExtrato.tipo")}</th>
					          	<th style="width: 16%; text-align: center;">${sessionScope.idioma.getString("view.telaConsultarExtrato.debitoCredito")}</th>
					           	<th style="width: 16%; text-align: center;">${sessionScope.idioma.getString("view.telaConsultarExtrato.valor")}</th>
					           	<th style="width: 16%; text-align: center;">${sessionScope.idioma.getString("view.telaConsultarExtrato.saldoFinal")}</th>
					      	</tr>
					    </thead>
					    <tbody>
						    <c:forEach var="i" begin="1" end="10">
						    	<tr id="linha${i}">
								    <c:forEach var="i2" begin="1" end="6">
										<td style="text-align: center;" id="${i}x${i2}">&nbsp;</td>
									</c:forEach>
						      	</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<c:if test="${requestScope.pesquisado == 'true'}">
					<div class="well" id="botoesTabela" >
				</c:if>
				<c:if test="${empty requestScope.pesquisado}">
					<div class="well" id="botoesTabela" style="display:none;">
				</c:if>
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td align="center" style="width: 12%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaAcesso.voltar')}" onclick="voltar()">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td align="center" style="width: 12%;">
								<input class="btn btn-primary btn-block" id="btnAnterior" type="button" value="${sessionScope.idioma.getString('view.telaConsultarExtrato.anterior')}" onclick="anterior()" disabled="true">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td align="center" style="width: 12%;">
								<input class="btn btn-primary btn-block" id="btnProximo" type="button" value="${sessionScope.idioma.getString('view.telaConsultarExtrato.proximo')}" onclick="proximo()" disabled="true">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td align="center" style="width: 12%;">
								<input class="btn btn-primary btn-block" type="button" value="${sessionScope.idioma.getString('view.telaConsultarExtrato.imprimir')}" onclick="imprimir()">
							</td>
							<td align="center" style="width: 5%;">
								&nbsp;
							</td>
							<td align="center" style="width: 12%;">
								<input class="btn btn-warning btn-block" type="button" value="${sessionScope.idioma.getString('view.telaConsultarExtrato.alterarPesquisa')}" onclick="alterar()">
							</td>
							<td align="center" style="width: 5%;">
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