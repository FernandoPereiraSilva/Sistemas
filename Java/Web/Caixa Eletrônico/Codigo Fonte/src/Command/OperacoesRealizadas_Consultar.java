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

public class OperacoesRealizadas_Consultar implements Command {
	
	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();

		try{
			retorno = Model.Operacao.consultarOperacoesDiarias();
		}catch (Exception erro) {
			itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
			retorno.add(itens);
		}
		
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}
