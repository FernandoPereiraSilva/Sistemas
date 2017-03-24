<html>

	<script>

		var meses = [
			'${sessionScope.idioma.getString("view.vetorMeses0")}',
			'${sessionScope.idioma.getString("view.vetorMeses1")}',
			'${sessionScope.idioma.getString("view.vetorMeses2")}',
			'${sessionScope.idioma.getString("view.vetorMeses3")}',
			'${sessionScope.idioma.getString("view.vetorMeses4")}',
			'${sessionScope.idioma.getString("view.vetorMeses5")}',
			'${sessionScope.idioma.getString("view.vetorMeses6")}',
			'${sessionScope.idioma.getString("view.vetorMeses7")}',
			'${sessionScope.idioma.getString("view.vetorMeses8")}',
			'${sessionScope.idioma.getString("view.vetorMeses9")}',
			'${sessionScope.idioma.getString("view.vetorMeses10")}',
			'${sessionScope.idioma.getString("view.vetorMeses11")}'
		];
		
		var diasemana = [
			'${sessionScope.idioma.getString("view.vetorDiasemana0")}',
			'${sessionScope.idioma.getString("view.vetorDiasemana1")}',
			'${sessionScope.idioma.getString("view.vetorDiasemana2")}',
			'${sessionScope.idioma.getString("view.vetorDiasemana3")}',
			'${sessionScope.idioma.getString("view.vetorDiasemana4")}',
			'${sessionScope.idioma.getString("view.vetorDiasemana5")}',
			'${sessionScope.idioma.getString("view.vetorDiasemana6")}'
		];
		
		var intervalo = window.setInterval(preparaRodape, 1000);
		var intervalo = window.setInterval(executaDebito, 600000);

		$( document ).ready(function() {
			preparaRodape();
			executaDebito();
		});

		function executaDebito() {
			$.ajax({
                url : "/Projeto_Integrado/controller.do",
                type : "POST",
                data : {
                	command: "DebitoAutomatico_Efetuar"
                },
                async: false
        	});
		}
		
		function preparaRodape() {
			var agora = new Date();
		    $("#rodape2").html(rodape2(agora));
		    $("#rodape3").html(rodape3(agora));
		    $("#rodape4").html(rodape4(agora));
		}
		
		function rodape2(data){
			if (data.getHours() > 6 && data.getHours() < 12){
				return "${sessionScope.idioma.getString("view.saudacao0")}";
			}else if (data.getHours() > 12 && data.getHours() < 18){     
				return "${sessionScope.idioma.getString("view.saudacao1")}";
			}else{
				return "${sessionScope.idioma.getString("view.saudacao2")}";
			}
		}
		
		function rodape3(data){
			var diaDaSemana = data.getDate()+"";
			if (diaDaSemana.length == 1) "0" + diaDaSemana;
			
			return	diasemana[data.getDay()] + ", " + diaDaSemana + " ${sessionScope.idioma.getString("view.complemento")} " +
					meses[data.getMonth()] + " ${sessionScope.idioma.getString("view.complemento")} " + data.getFullYear();
		}
		
		function rodape4(data){
			var hora = data.getHours()+"";
			var minuto = data.getMinutes()+"";
			var segundo = data.getSeconds()+"";

			if (hora.length == 1) hora = "0" + hora;
			if (minuto.length == 1) minuto = "0" + minuto;
			if (segundo.length == 1) segundo = "0" + segundo;
			
			return hora + ":" + minuto + ":" + segundo;
		}
	
	</script>
	
	<head>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		<link href="css/rodape.css" rel="stylesheet">
	</head>
	<body>
		<footer class="footer">
			<div class="container">
				<table style="width: 100%">
					<tr>
						<td style="width: 36.5%;max-width: 36.5%;">
							<p class="text-muted" id="rodape1">${sessionScope.idioma.getString("view.bemVindo")} ${sessionScope.nome}</p>
						</td>
						<td style="width: 19%;max-width: 19%;">
							<p class="text-muted" id="rodape2"></p>
						</td>
						<td style="width: 36.5%;max-width: 36.5%;">
							<p class="text-muted" id="rodape3"></p>
						</td>
						<td style="width: 8%;max-width: 8%;">
							<p class="text-muted" id="rodape4"></p>
						</td>
					</tr>
				</table>
			</div>
		</footer>
	</body>
</html>
