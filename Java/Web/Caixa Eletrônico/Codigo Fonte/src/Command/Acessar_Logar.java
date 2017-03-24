package Command;

import java.io.IOException;
import java.text.ParseException;
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

import Model.Acesso;
import Unit.Unit;

public class Acessar_Logar implements Command {

	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		try {
			ArrayList<Acesso> acessos = Model.Acesso.carregaAcessos();
			Unit.setAcessos(acessos);
			consultarDia();
	
			String agencia = request.getParameter("txtAgencia");
			String conta = request.getParameter("txtConta");
			String senha = request.getParameter("txtSenha");
				
			if (("99999999").equals(conta) && ("9999").equals(agencia) && ("9999").equals(senha)) {
				itens.put("acessou", "true");
				itens.put("mensagem", rbn.getString("control.acesso.administradora"));
				itens.put("proximaPagina", "Administrador.jsp");
			} else {
				Model.Acesso acesso = new Model.Acesso(agencia, conta, senha);
				int indiceAcesso = acesso.efetuarLogin(acessos);
				if (indiceAcesso == -2) {
					itens.put("acessou", "false");
					itens.put("mensagem", rbn.getString("control.acesso.bloqueada"));
					itens.put("proximaPagina", "Acesso.jsp");
				} else if (indiceAcesso == -1) {
					itens.put("acessou", "false");
					itens.put("mensagem", rbn.getString("control.acesso.dadosErrados"));
					itens.put("proximaPagina", "Acesso.jsp");
				} else {
					itens.put("acessou", "true");
					if (acessos.get(indiceAcesso).getAcesso().equals("sem")){
						itens.put("mensagem", rbn.getString("control.acesso.submitSemCodigo"));
					}else{
						itens.put("mensagem", rbn.getString("control.acesso.submitTemCodigo"));
						
					}
					itens.put("proximaPagina", "CodigoAcesso.jsp");
					Unit.setIndiceAcesso(indiceAcesso);
				}
			}
		} catch (Exception erro) {
			itens.put("acessou", "false");
			itens.put("mensagem", rbn.getString("control.erroTry") + "\n\n" + erro.getMessage());
			itens.put("proximaPagina", "Acesso.jsp");
		}
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}
	
	private static void consultarDia() throws ParseException, ClassNotFoundException, IOException {
		SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");
		Date agoraDate = formato.parse(formato.format(new Date()));
		for (int i = 0; i < Unit.getAcessos().size(); i++) {
			Unit.getAcessos().get(i).desbloquearConta(formato, agoraDate);
			Unit.getAcessos().get(i).atualizaDataTentativa(formato, agoraDate);
		}
		new Model.Acesso().gravarAcessos(Unit.getAcessos());
	}
}
