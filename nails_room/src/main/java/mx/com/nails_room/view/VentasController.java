package mx.com.nails_room.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.VentasDTO;
import mx.com.nails_room.service.CuentaUsuarioServicio;
import mx.com.nails_room.service.VentasServicio;


@Controller
public class VentasController {
	
	@Autowired
	private CuentaUsuarioServicio cuentaUsuarioServicio;
	@Autowired
	private VentasServicio notasServicio;
	
	@GetMapping(value = "/ventas.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		model.addAttribute("ventasDTO", new VentasDTO());
		model.addAttribute("listaUsuarios",cuentaUsuarioServicio.obtenerTodosUsuarios());
		return "ventas";
	}
	
	// busqueda por filtro
		@PostMapping(value = "/ventas.do", params = "filtro")
		public String mostrarPorFiltro(@ModelAttribute FiltroVentas filtroVentas,HttpServletRequest request, Model model) {		
			
			List<VentasDTO> listaVentas = notasServicio.obtenerPorFiltro(filtroVentas);
			model.addAttribute("messageView","Se obtuvieron "+listaVentas.size()+ " resultados");
			model.addAttribute("listaVentas",listaVentas);		
			model.addAttribute("listaUsuarios",cuentaUsuarioServicio.obtenerTodosUsuarios());
			return "ventas";
		}	

}
