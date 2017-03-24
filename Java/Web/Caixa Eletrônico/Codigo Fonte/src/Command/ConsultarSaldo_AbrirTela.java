package Command;

import java.io.IOException;
import java.util.Date;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ConsultarSaldo_AbrirTela implements Command {

	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResourceBundle rbn = (ResourceBundle) request.getSession().getAttribute("idioma");
		RequestDispatcher view = request.getRequestDispatcher("ConsultarSaldo.jsp");
		
		Model.Cliente cliente1 = (Model.Cliente) request.getSession().getAttribute("cliente1");
		String erroCadastrarOperacao = cadastrarOperacao(cliente1, rbn);
		String saldo = Unit.Unit.preparaValor(cliente1.getSaldo()+"", rbn);
		request.setAttribute("saldo", Unit.Unit.formatarSaldo(saldo + "", rbn));
		if (!erroCadastrarOperacao.equals("")){
			request.setAttribute("mensagem", erroCadastrarOperacao);
		}

		view.forward(request, response);
	}
	
	public String cadastrarOperacao(Model.Cliente cliente, ResourceBundle rbn) {
		try {
			new Model.Operacao(
				0,
				cliente.getCodigo(),
				new Date(),
				0.0,
				1
			).cadastrar();
			return "";
		} catch (Exception erro) {
			return rbn.getString("control.erroTry") + "\n\n" + erro.getMessage();
		}
	}
}
