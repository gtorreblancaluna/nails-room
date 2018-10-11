package mx.com.nails_room.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import mx.com.nails_room.model.ConfiguracionDTO;
import mx.com.nails_room.service.SystemService;

@Controller
public class ConfiguracionController {
	
	@Autowired
	private SystemService systemService;

	@GetMapping(value = "/configuracion.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		model.addAttribute("configuracion", systemService.obtenerConfiguracion());		
		return "configuracion";
	}
	
	@PostMapping(value = "/configuracion.do" , params = "guardar")
	public String guardar(@ModelAttribute ConfiguracionDTO configuracion, HttpServletRequest request, Model model) {
		
		systemService.guardar(configuracion);
		model.addAttribute("configuracion", systemService.obtenerConfiguracion());		
		model.addAttribute("messageView","Se guardo con exito!");		
		return "configuracion";
	}
}
