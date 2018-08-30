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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.CajaServicio;
import mx.com.nails_room.service.CuentaUsuarioServicio;
import mx.com.nails_room.service.VentasServicio;
import static mx.com.nails_room.commons.ApplicationConstants.VENTA_PREVENTA;


@Controller
public class VentasController {
	
	@Autowired
	private CuentaUsuarioServicio cuentaUsuarioServicio;
	@Autowired
	private VentasServicio ventasServicio;
	@Autowired
	private CajaServicio cajaServicio;
	
	@GetMapping(value = "/ventas.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {
		CajaDTO caja = cajaServicio.obtenerCajaAbierta();
		if(caja == null)
			model.addAttribute("messageError", "Caja esta cerrada, debes abrir caja para poder generar ventas ");
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
	
	// guardar venta
	@PostMapping(value = "/ventas.do", params = "agregar")
	public ModelAndView agregar(@ModelAttribute VentaDTO venta,HttpServletRequest request, Model model,RedirectAttributes redir) {	
		CajaDTO caja = cajaServicio.obtenerCajaAbierta();
		ModelAndView modelAndView = new ModelAndView();
		if(caja == null) {
			model.addAttribute("messageError","Caja cerrada, no se pueden ingresar ventas cuando la caja esta cerrada");
			modelAndView.setViewName("ventas");
			return modelAndView;
		}
		venta.setCaja(new CajaDTO());
		venta.getCaja().setCajaId(caja.getCajaId());
		ventasServicio.agregar(venta);
		redir.addFlashAttribute("messageView","Se agrego con exito, "+venta.getDetalleVenta().size()+ " articulos");
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}
	
	@PostMapping(value = "/ventas.do", params = "actualizar")
	public ModelAndView actualizar(@ModelAttribute VentaDTO venta, HttpServletRequest request,RedirectAttributes redir) {	
		ModelAndView modelAndView = new ModelAndView();
		ventasServicio.actualizar(venta);
		redir.addFlashAttribute("messageView","Se edito con exito, "+venta.getDetalleVenta().size()+ " articulos");
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}
	// actualizar y finalizar
	@PostMapping(value = "/ventas.do", params = "actualizarFinalizar")
	public ModelAndView actualiactualizarFinalizarzar(@ModelAttribute VentaDTO venta, HttpServletRequest request, RedirectAttributes redir) {	
		ModelAndView modelAndView = new ModelAndView();
		ventasServicio.actualizar(venta);
		ventasServicio.finalizar(venta);		
		redir.addFlashAttribute("messageView","Se edito y finalizo con exito, "+venta.getDetalleVenta().size()+ " articulos");
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}
	
	// guardar y finalizar venta
	@PostMapping(value = "/ventas.do", params = "finalizar")
	public ModelAndView finalizar(@ModelAttribute VentaDTO venta,HttpServletRequest request, RedirectAttributes redir) {	
		CajaDTO caja = cajaServicio.obtenerCajaAbierta();
		ModelAndView modelAndView = new ModelAndView();
		if(caja == null) {
			redir.addFlashAttribute("messageError","Caja cerrada, no se pueden ingresar ventas cuando la caja esta cerrada");
			modelAndView.setViewName("ventas");
			return modelAndView;
		}
		venta.setCaja(new CajaDTO());
		venta.getCaja().setCajaId(caja.getCajaId());
		
		ventasServicio.agregar(venta);
		ventasServicio.finalizar(venta);
		
		FiltroVentas filtroVentas = new FiltroVentas();
		LocalDate hoy = LocalDate.now();
		filtroVentas.setFechaInicioFiltro(hoy.toString());
		redir.addFlashAttribute("messageView","Exito al finalizar la venta ");
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}
	
	// finalizar venta desde actualizar
		@PostMapping(value = "/ventas.do", params = "finalizarUp")
		public ModelAndView finalizarUp(@ModelAttribute VentaDTO venta,HttpServletRequest request,  RedirectAttributes redir) {	
			ModelAndView modelAndView = new ModelAndView();
			ventasServicio.finalizar(venta);			
//			FiltroVentas filtroVentas = new FiltroVentas();
//			LocalDate hoy = LocalDate.now();
//			filtroVentas.setFechaInicioFiltro(hoy.toString());
//			model.addAttribute("listaVentas", ventasServicio.obtenerPorFiltro(filtroVentas));
			redir.addFlashAttribute("messageView","Exito al finalizar la venta ");
			modelAndView.setViewName("redirect:/exito.do");
			return modelAndView;
		}
	
	public Model obtenerValoresModel(Model model) {
	
		model.addAttribute("listaUsuarios",cuentaUsuarioServicio.obtenerTodosUsuarios());
		model.addAttribute("listaEstacion",ventasServicio.obtenerEstacionesTrabajo());
		model.addAttribute("listaEstado",ventasServicio.obtenerEstadosVenta());
		
		return model;
	}

}
