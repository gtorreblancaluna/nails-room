package mx.com.nails_room.view;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import mx.com.nails_room.model.UserSession;
import mx.com.nails_room.model.UsuarioDTO;

@Controller
public class LogoutController {	
	
	@RequestMapping(value = "/logout.do")
	public String showLogin( HttpServletRequest request, Model model,HttpServletResponse response) {	
		
		HttpSession httpSession = request.getSession();
		UserSession userSession = (UserSession) httpSession.getAttribute("userSession");
		
		if (request.getParameter("JSESSIONID") != null) {
	    Cookie userCookie = new Cookie("JSESSIONID", request.getParameter("JSESSIONID"));
	    response.addCookie(userCookie);
		} else {
		    String sessionId = httpSession.getId();
		    Cookie userCookie = new Cookie("JSESSIONID", sessionId);
		    response.addCookie(userCookie);
		}
	
		if(userSession!=null) {
			httpSession.setAttribute( "userSession", null );
//		    request.getSession().invalidate();
			model.addAttribute("usuarioDTO", new UsuarioDTO());
		}
		httpSession.setAttribute("userSession", new UserSession(null));
		return "login";		
	}

}
