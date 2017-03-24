package Command;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DebitoAutomatico_Efetuar implements Command {

	Model.Cliente cliente2;

	@Override
	public void executa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Date hoje = new Date();
			ArrayList<Model.Debito> lista = new Model.Debito(0, null, 0, 0, 0, 0, 0).consultarEmAberto();
			for (Model.Debito debito: lista) {
				if (getData(hoje).compareTo(getData(debito.getData())) == 0) {
					try{
						debito.pagar();
					}catch (Exception e) {}
				}
			}
		} catch (Exception erro) {}
	}

	private Date getData(Date data) {
		Calendar myCalendar = Calendar.getInstance();
		myCalendar.setTime(data);
		myCalendar.set(Calendar.HOUR_OF_DAY, 0);
		myCalendar.set(Calendar.MINUTE, 0);
		myCalendar.set(Calendar.SECOND, 0);
		myCalendar.set(Calendar.MILLISECOND, 0);
		return myCalendar.getTime();
	}
}