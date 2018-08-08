package mx.com.nails_room.view;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import mx.com.nails_room.model.UserSession;
import mx.com.nails_room.model.UsuarioDTO;
import mx.com.nails_room.service.CuentaUsuarioServicio;

@Controller
public class LoginController {	
	@Autowired
	private CuentaUsuarioServicio cuentaUsuarioServicio;	

	@GetMapping(value = "/login.do")
	public ModelAndView login( HttpServletRequest request,HttpServletResponse response) {
		ModelAndView modelAndView = new ModelAndView("login");	
		HttpSession httpSession = request.getSession();
		UserSession userSession = (UserSession) httpSession.getAttribute("userSession");	
		modelAndView.addObject("usuarioDTO", new UsuarioDTO());
		
		if (request.getParameter("JSESSIONID") != null) {
	    Cookie userCookie = new Cookie("JSESSIONID", request.getParameter("JSESSIONID"));
	    response.addCookie(userCookie);
		} else {
		    String sessionId = httpSession.getId();
		    Cookie userCookie = new Cookie("JSESSIONID", sessionId);
		    response.addCookie(userCookie);
		}
		
		
		httpSession.setAttribute("userSession", userSession);
		
		if(userSession != null && userSession.getUsuario() != null)
			 modelAndView.setViewName("bienvenida");
		
		return modelAndView;
	}
	
	@PostMapping(value = "/procesarLogin.do")
	public ModelAndView loginProcess(HttpServletRequest request, HttpServletResponse response, 
			@ModelAttribute UsuarioDTO usuarioDTO){
		
		HttpSession httpSession = request.getSession();
		UserSession userSession = (UserSession) httpSession.getAttribute("userSession");
		
		ModelAndView modelAndView = new ModelAndView("bienvenida");	
		
		usuarioDTO = cuentaUsuarioServicio.validar(usuarioDTO);				
		if(userSession==null)
			userSession = new UserSession(null);
		
		if(usuarioDTO == null) {
			modelAndView.addObject("message","Usuario o contrase\u00F1a no coinciden");
			modelAndView.setViewName("login");
			return modelAndView;
		}else{			
			userSession.setUsuario(usuarioDTO);
			httpSession.setAttribute("userSession", userSession);
			return modelAndView;
		}
//		return null;
	}
	
	

}
