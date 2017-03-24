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

public class EfetuarTransferencia_Verificar implements Command {

	Model.Cliente cliente2;
	
	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model.Cliente cliente1 = (Model.Cliente) request.getSession().getAttribute("cliente1");
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		List<Map<String, Object>> retorno = new ArrayList<Map<String, Object>>();
		Map<String, Object> itens = new LinkedHashMap<String, Object>();
		
		String agenciaDestino = request.getParameter("txtAgencia");
		String contaDestino = request.getParameter("txtConta");
		String valorDestino = request.getParameter("txtValor");
		String erroVerificar = verificar(cliente1, agenciaDestino, contaDestino, valorDestino, rbn);
			
		if (("").equals(erroVerificar)){
			itens.put("valido", "true");
			itens.put("mensagem", "");
			itens.put("agencia", agenciaDestino);
			itens.put("conta", contaDestino);
			itens.put("nome", cliente2.getNome());
			itens.put("valor", Unit.Unit.formatarSaldo(valorDestino, rbn));
			itens.put("valorBruto", valorDestino);
		}else{
			itens.put("valido", "false");
			itens.put("mensagem", erroVerificar);
		}
		
		retorno.add(itens);
		String json=new Gson().toJson(retorno);
        response.getWriter().write(json);
	}

	public String verificar(Model.Cliente cliente1, String agenciaDestino, String contaDestino, String valorDestino, ResourceBundle rbn){
		try {
			if (cliente1.getSaldo() >= Double.parseDouble(Unit.Unit.pegaValor(valorDestino, rbn))) {
				int codigo = Integer.parseInt(agenciaDestino + contaDestino);
				if (cliente1.getCodigo() != codigo) {
					cliente2 = Model.Cliente.consultarCliente(codigo);
					if (cliente2 != null) {
						if (cliente1.getBanco().equals(cliente2.getBanco())) {
							return "";
						} else return rbn.getString("control.efetuarTransferencia.bancoDiferente");
					} else return rbn.getString("control.efetuarTransferencia.contaInexistente");
				} else return rbn.getString("control.efetuarTransferencia.contaIgual");
			}else return rbn.getString("control.efetuarTransferencia.saldoInferior");
		} catch (Exception erro) {
			return rbn.getString("control.erroTry") + "\n\n" + erro.getMessage();
		}
	}
}
