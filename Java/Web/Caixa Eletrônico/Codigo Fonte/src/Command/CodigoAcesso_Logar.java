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

import Unit.Unit;

public class CodigoAcesso_Logar implements Command {

	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");

		String codigoAcesso = request.getParameter("codigoAcesso");
		Model.Acesso acesso = Unit.getAcessos().get(Unit.getIndiceAcesso());
		try {
			if (!acesso.getAcesso().equals(codigoAcesso) && !acesso.getAcesso().equals("sem")) {
				acesso.setTentativas(acesso.getTentativas() + 1);
				acesso.setDataTentativa(new SimpleDateFormat("dd/MM/yyyy").format(new Date()));
				itens.put("acessou", "false");
				if (acesso.getTentativas() == 3) {
					itens.put("mensagem", rbn.getString("control.codigoAcesso.codigoErrado") + "\n\n" + rbn.getString("control.codigoAcesso.bloqueado"));
					itens.put("proximaPagina", "Acesso.jsp");
					acesso.setBloqueio();
				}else{
					itens.put("mensagem", rbn.getString("control.codigoAcesso.codigoErrado"));
					itens.put("proximaPagina", "");
				}
			} else {
				itens.put("acessou", "true");
				itens.put("proximaPagina", "Principal.jsp");
				if (acesso.getAcesso().equals("sem")) {
					acesso.setAcesso(codigoAcesso);
					itens.put("mensagem", rbn.getString("control.codigoAcesso.codigoCadastrado"));
				}else{
					itens.put("mensagem", rbn.getString("control.codigoAcesso.logado"));
				}
				acesso.setDesbloqueio();
				Model.Cliente cliente1 = Model.Cliente.consultarCliente(Integer.parseInt(acesso.getAgencia() + acesso.getNumConta()));
				request.getSession().setAttribute("cliente1", cliente1);
				request.getSession().setAttribute("nome", cliente1.getNome());
			}
			
			Unit.getAcessos().set(Unit.getIndiceAcesso(), acesso);
			new Model.Acesso().gravarAcessos(Unit.getAcessos());
			
		} catch (Exception erro) {
			itens.put("acessou", "false");
			itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
			erro.printStackTrace();
			itens.put("proximaPagina", "Acesso.jsp");
		}
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
}
