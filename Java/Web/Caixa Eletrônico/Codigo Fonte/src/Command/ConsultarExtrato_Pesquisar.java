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

import TO.ListaOperacoesTO;

public class ConsultarExtrato_Pesquisar implements Command {

	Model.Cliente cliente2;
	
	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model.Cliente cliente1 = (Model.Cliente) request.getSession().getAttribute("cliente1");
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		
		try{
			int dias = Integer.parseInt(request.getParameter("txtDias") + "");
			
			ArrayList<ArrayList<ListaOperacoesTO>> lista = Model.Operacao.consultarExtrato(cliente1.getSaldo(), cliente1.getCodigo(), dias, rbn);
			
			if (lista.size() > 0){
				itens.put("temItens", "true");
				itens.put("lista", lista);
				itens.put("mensagem", "");
			}else{
				itens.put("temItens", "false");
				itens.put("lista", null);
				itens.put("mensagem", "vazio");
			}
		}catch (Exception erro) {
			itens.put("temItens", "false");
			itens.put("lista", null);
			itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
		}

		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}
