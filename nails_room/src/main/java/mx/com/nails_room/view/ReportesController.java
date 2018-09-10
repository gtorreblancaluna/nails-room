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
import mx.com.nails_room.model.DetalleVentaDTO;
import mx.com.nails_room.service.VentasServicio;

@Controller
public class ReportesController {
	
	@Autowired
	private VentasServicio ventasServicio;
	
	@GetMapping(value = "/reportes.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {

	return "reportes";
	}
	
	// busqueda por filtro
	@PostMapping(value = "/reportes.do", params = "filtroVentas")
	public String mostrarPorFiltro(@ModelAttribute FiltroVentas filtroVentas,HttpServletRequest request, Model model) {		
		List<DetalleVentaDTO> resultados = ventasServicio.obtenerReporteVentas(filtroVentas);
		model.addAttribute("messageView","Se obtuvieron "+resultados.size()+ " resultados");
		model.addAttribute("resultados",resultados);
		return "reportes";
	}	
	
	@PostMapping(value = "/reportes.do", params = "filtroClientes")
	public String clientesMayorConsumo(@ModelAttribute FiltroVentas filtroVentas,HttpServletRequest request, Model model) {		
		List<DetalleVentaDTO> resultadoClientes = ventasServicio.obtenerReporteClientesMayorConsumo(filtroVentas);
		model.addAttribute("messageView","Se obtuvieron "+resultadoClientes.size()+ " resultados");
		model.addAttribute("resultadoClientes",resultadoClientes);
		return "reportes";
	}	
		
}
