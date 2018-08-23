package mx.com.nails_room.view;

import java.time.LocalDate;
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
import static mx.com.nails_room.commons.ApplicationConstants.VENTA_PREVENTA;


@Controller
public class VentasController {
	
	@Autowired
	private CuentaUsuarioServicio cuentaUsuarioServicio;
	@Autowired
	private VentasServicio ventasServicio;
	
	@GetMapping(value = "/ventas.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		model.addAttribute("venta", new VentaDTO());
		FiltroVentas filtroVentas = new FiltroVentas();
		LocalDate hoy = LocalDate.now();
		filtroVentas.setFechaInicioFiltro(hoy.toString());
		filtroVentas.setEstadoVentaFiltro(VENTA_PREVENTA+"");
		model.addAttribute("listaVentas", ventasServicio.obtenerPorFiltro(filtroVentas));
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
		model.addAttribute("venta", new VentaDTO());
		this.obtenerValoresModel(model);
		return "ventas";
	}
	
	@PostMapping(value = "/ventas.do", params = "actualizar")
	public String actualizar(@ModelAttribute VentaDTO venta,HttpServletRequest request, Model model) {	
		
		ventasServicio.actualizar(venta);
		model.addAttribute("messageView","Se edito con exito, "+venta.getDetalleVenta().size()+ " articulos");
		model.addAttribute("venta", new VentaDTO());
		this.obtenerValoresModel(model);
		return "ventas";
	}
	
	// finalizar venta
	@PostMapping(value = "/ventas.do", params = "finalizar")
	public String finalizar(@ModelAttribute VentaDTO venta,HttpServletRequest request, Model model) {	
		
		ventasServicio.agregar(venta);
		ventasServicio.finalizar(venta);
		
		FiltroVentas filtroVentas = new FiltroVentas();
		LocalDate hoy = LocalDate.now();
		filtroVentas.setFechaInicioFiltro(hoy.toString());
		model.addAttribute("listaVentas", ventasServicio.obtenerPorFiltro(filtroVentas));
		model.addAttribute("messageView","Exito al finalizar la venta ");
		this.obtenerValoresModel(model);
		return "ventas";
	}
	
	public Model obtenerValoresModel(Model model) {
	
		model.addAttribute("listaUsuarios",cuentaUsuarioServicio.obtenerTodosUsuarios());
		model.addAttribute("listaEstacion",ventasServicio.obtenerEstacionesTrabajo());
		model.addAttribute("listaEstado",ventasServicio.obtenerEstadosVenta());
		
		return model;
	}

}
