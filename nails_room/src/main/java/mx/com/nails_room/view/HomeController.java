package mx.com.nails_room.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import mx.com.nails_room.model.UserSession;
@Controller
public class HomeController {

	@GetMapping(value = "/index.do")
	public String mostrarHome(HttpServletRequest request, Model model) {
		HttpSession httpSession = request.getSession();
		UserSession userSession = (UserSession) httpSession.getAttribute("userSession");	
		if(userSession != null && userSession.getUsuario() != null)
			return "bienvenida";
		else
			return "login";
	}	
}
