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

public class CodigoAcesso_SortearBotoes implements Command {

	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		
		String btn1 = "", btn2 = "", btn3 = "", btn4 = "", btn5 = "";
		String[] textos = {
			rbn.getString("view.telaCodigoAcesso.btnUm"),
			rbn.getString("view.telaCodigoAcesso.btnDois"),
			rbn.getString("view.telaCodigoAcesso.btnTres"),
			rbn.getString("view.telaCodigoAcesso.btnQuatro"),
			rbn.getString("view.telaCodigoAcesso.btnCinco")
		};
			
		for (int i = 0; i < 5;) {
			int numero = (int) (Math.random() * 5);
			if (!textos[numero].equals("")) {
				if (i == 0)			btn1 = textos[numero];
				else if (i == 1)	btn2 = textos[numero];
				else if (i == 2)	btn3 = textos[numero];
				else if (i == 3)	btn4 = textos[numero];
				else if (i == 4)	btn5 = textos[numero];
				i++;
				textos[numero] = "";
			}
		}

		itens.put("btn1", btn1);
		itens.put("btn2", btn2);
		itens.put("btn3", btn3);
		itens.put("btn4", btn4);
		itens.put("btn5", btn5);
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}
