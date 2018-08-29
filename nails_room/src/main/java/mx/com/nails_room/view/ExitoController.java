package mx.com.nails_room.view;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExitoController {

	@GetMapping(value = "/exito.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {
		return "clienteExito";
	}
}
