package Command;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

public class EfetuarTransferencia_Confirmar implements Command {
	
	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model.Cliente cliente1 = (Model.Cliente) request.getSession().getAttribute("cliente1");
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		
		String agenciaDestino = request.getParameter("txtAgencia");
		String contaDestino = request.getParameter("txtConta");

		try{
			Model.Cliente cliente2 = Model.Cliente.consultarCliente(Integer.parseInt(agenciaDestino + contaDestino));
			double valor = Double.parseDouble(Unit.Unit.pegaValor(request.getParameter("valorBruto")+"", rbn)); 
			new Model.Transferencia(0, 0, null, 0, 0, 0, "", "").cadastrarTransferencia(cliente1, cliente2, valor);
			itens.put("transferiu", "true");
			itens.put("mensagem", rbn.getString("control.efetuarTransferencia.Ok"));
		}catch (Exception erro) {
			itens.put("valido", "false");
			itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
		}
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}
