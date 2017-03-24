package Command;

import java.io.IOException;
import java.text.SimpleDateFormat;
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

import Model.Debito;

public class DebitoAutomatico_Cadastrar implements Command {

	Model.Cliente cliente2;
	
	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model.Cliente cliente1 = (Model.Cliente) request.getSession().getAttribute("cliente1");
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		
		int txtOperadora = Integer.parseInt(request.getParameter("txtOperadora")+"");
		String txtDataDebito = request.getParameter("txtDataDebito");
		int txtConsumidor = Integer.parseInt(request.getParameter("txtConsumidor")+"");
		double txtValor = Double.parseDouble(Unit.Unit.pegaValor(request.getParameter("txtValor")+"", rbn));

		try{
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			sdf.setLenient(false);
			Date data = sdf.parse(txtDataDebito);
			if (!data.before(new Date())){
				Model.Debito debito = new Debito(0, data, txtOperadora, txtConsumidor, txtValor, 0, cliente1.getCodigo());
				debito.cadastrar();
				
				itens.put("cadastrou", "true");
				itens.put("mensagem", rbn.getString("control.cadastrarDebito.cadastroEfetuado"));
			}else{
				itens.put("cadastrou", "false");
				itens.put("mensagem", rbn.getString("control.cadastrarDebito.dataInferior"));
			}
		}catch (Exception erro) {
			itens.put("cadastrou", "false");
			itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
		}
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}