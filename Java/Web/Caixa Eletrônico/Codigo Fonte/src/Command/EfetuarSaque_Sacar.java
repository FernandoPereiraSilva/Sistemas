package Command;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class EfetuarSaque_Sacar implements Command {

	Model.Cliente cliente2;
	
	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model.Cliente cliente1 = (Model.Cliente) request.getSession().getAttribute("cliente1");
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		
		int valor = Integer.parseInt(request.getParameter("txtValor")+"");
		if (cliente1.getSaldo() >= valor){
			Model.Saque saque = new Model.Saque(0, cliente1.getCodigo(), new Date(), -Double.parseDouble((Unit.Unit.pegaValor(valor+"", rbn))), 4);
			try {
				if (saque.validarValor(valor)){
					int notasV[] = saque.gerarCombinacao(valor);
					String notas = "";
					if (notasV[0] > 0) notas += "50: " + notasV[0];
					if (notasV[1] > 0) notas += "\n20: " + notasV[1];
					if (notasV[2] > 0) notas += "\n10: " + notasV[2];
					saque.cadastrar();
					cliente1.alterarSaldo(Double.parseDouble((Unit.Unit.pegaValor(valor+"", rbn))), "-");
					itens.put("sacou", true);
					itens.put("mensagem", rbn.getString("control.efetuarSaque.saqueEfetuado") + "\n\n" + notas);
				}else{
					itens.put("sacou", false);
					itens.put("mensagem", rbn.getString("control.efetuarSaque.notasIndisponiveis"));
				}
			} catch (Exception erro) {
				itens.put("sacou", false);
				itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
			}
		}else{
			itens.put("sacou", false);
			itens.put("mensagem", rbn.getString("control.efetuarSaque.saldoInferior"));
		}
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}
