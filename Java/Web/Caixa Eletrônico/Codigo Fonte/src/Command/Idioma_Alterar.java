package Command;

import java.io.IOException;
import java.util.Locale;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Idioma_Alterar implements Command {

	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ResourceBundle rbn;	
		RequestDispatcher view;
		
		if (("ingles").equals("" + request.getParameter("opcaoIdioma"))){
			rbn = ResourceBundle.getBundle("idioma", new Locale("en", "US"));
			view = request.getRequestDispatcher("" + request.getParameter("telaAtual"));
		}else if (("espanhol").equals("" + request.getParameter("opcaoIdioma"))){
			rbn = ResourceBundle.getBundle("idioma", new Locale("es", "ES"));
			view = request.getRequestDispatcher("" + request.getParameter("telaAtual"));
		}else{
			if(("" + request.getParameter("telaAtual")).equals("")){
				view = request.getRequestDispatcher("Acesso.jsp");
			}else{
				view = request.getRequestDispatcher("" + request.getParameter("telaAtual"));
			}
			rbn = ResourceBundle.getBundle("idioma", new Locale("pt", "BR"));
		}
		
		String parametros = request.getParameter("parametros")+"";
		if (!("").equals(parametros) && !("null").equals(parametros)){
			preparaRequest(request, parametros, rbn);
		}
		
		request.getSession().removeAttribute("idioma");
		request.getSession().setAttribute("idioma", rbn);
		
		view.forward(request, response);
	}
	
	public void preparaRequest(HttpServletRequest request, String parametros,  ResourceBundle rbn){
		while (!("").equals(parametros)){
			String aux = parametros.substring(0, parametros.indexOf("</parametro>", 12)+12);
			if (("double").equals(aux.substring(aux.indexOf("<tipo>")+6, aux.indexOf("</tipo>")))){
				if (("valor").equals(aux.substring(aux.indexOf("<tratamento>")+12, aux.indexOf("</tratamento>")))){
					request.setAttribute(aux.substring(aux.indexOf("<nome>")+6, aux.indexOf("</nome>")), Unit.Unit.formatarSaldo(Unit.Unit.preparaValor(aux.substring(aux.indexOf("<conteudo>")+10, aux.indexOf("</conteudo>")), rbn), rbn));
				}else{
					request.setAttribute(aux.substring(aux.indexOf("<nome>")+6, aux.indexOf("</nome>")), aux.substring(aux.indexOf("<conteudo>")+10, aux.indexOf("</conteudo>")));
				}
			}else{
				request.setAttribute(aux.substring(aux.indexOf("<nome>")+6, aux.indexOf("</nome>")), aux.substring(aux.indexOf("<conteudo>")+10, aux.indexOf("</conteudo>")));
			}
			parametros = parametros.replace(aux, "");
		}
	}
}
