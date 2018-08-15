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
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.CuentaUsuarioServicio;
import mx.com.nails_room.service.VentasServicio;


@Controller
public class VentasController {
	
	@Autowired
	private CuentaUsuarioServicio cuentaUsuarioServicio;
	@Autowired
	private VentasServicio ventasServicio;
	
	@GetMapping(value = "/ventas.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		model.addAttribute("venta", new VentaDTO());
		this.obtenerValoresModel(model);
		return "ventas";
	}
	
	// busqueda por filtro
	@PostMapping(value = "/ventas.do", params = "filtro")
	public String mostrarPorFiltro(@ModelAttribute FiltroVentas filtroVentas,HttpServletRequest request, Model model) {		
		List<VentaDTO> listaVentas = ventasServicio.obtenerPorFiltro(filtroVentas);
		model.addAttribute("messageView","Se obtuvieron "+listaVentas.size()+ " resultados");
		model.addAttribute("listaVentas",listaVentas);		
		this.obtenerValoresModel(model);
		return "ventas";
	}	
	
	@PostMapping(value = "/ventas.do", params = "agregar")
	public String agregar(@ModelAttribute VentaDTO venta,HttpServletRequest request, Model model) {	
		
		ventasServicio.agregar(venta);
		model.addAttribute("messageView","Se agrego con exito, "+venta.getDetalleVenta().size()+ " articulos");
		this.obtenerValoresModel(model);
		return "ventas";
	}
	
	public Model obtenerValoresModel(Model model) {
	
		model.addAttribute("listaUsuarios",cuentaUsuarioServicio.obtenerTodosUsuarios());
		model.addAttribute("listaEstacion",ventasServicio.obtenerEstacionesTrabajo());
		
		return model;
	}

}
