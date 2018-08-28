package mx.com.nails_room.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import mx.com.nails_room.forms.FiltroVentas;
import mx.com.nails_room.model.CajaDTO;
import mx.com.nails_room.model.DetalleCajaDTO;
import mx.com.nails_room.model.UserSession;
import mx.com.nails_room.model.UsuarioDTO;
import mx.com.nails_room.model.VentaDTO;
import mx.com.nails_room.service.CajaServicio;
import mx.com.nails_room.service.VentasServicio;
import static mx.com.nails_room.commons.ApplicationConstants.VENTA_FINALIZADO;

import java.util.List;

@Controller
public class CajaController {
	@Autowired
	private CajaServicio cajaServicio;
	@Autowired
	private VentasServicio ventasServicio;
	
	@GetMapping(value = "/caja.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		this.obtenerDatos(model);
		return "caja";
	}
	
	@PostMapping(value = "/caja.do", params = "abrir")
	public String abrirCaja(@ModelAttribute CajaDTO caja,HttpServletRequest request, Model model) {	
		HttpSession session = request.getSession();
		UserSession userSession = (UserSession) session.getAttribute("userSession");
		if(userSession != null && userSession.getUsuario() != null) {	
			caja.setUsuario(new UsuarioDTO());
			caja.getUsuario().setUsuarioId(userSession.getUsuario().getUsuarioId());			
			cajaServicio.abrirCaja(caja);
			model.addAttribute("caja",cajaServicio.obtenerCajaAbierta());
			model.addAttribute("messageView","Apertura de caja con exito! ");
			return "caja";
		}else {			
			model.addAttribute("messageError", "ERROR. No se encontro session, porfavor recarga la pagina y logueate correctamente ");
			return "caja";		
		}
	}
	
	@PostMapping(value = "/caja.do", params = "registrarMovimiento")
	public String registrarMovimiento(@ModelAttribute DetalleCajaDTO detalleCaja,HttpServletRequest request, Model model) {	
		
		cajaServicio.ingresarDetalleCaja(detalleCaja);			
		this.obtenerDatos(model);
		model.addAttribute("messageView","Se ingreso con exito el movimiento en la caja ");		
		return "caja";
	}
	
	@PostMapping(value = "/caja.do", params = "cerrarCaja")
	public String cerrarCaja(@ModelAttribute CajaDTO caja,HttpServletRequest request, Model model) {	
		
		cajaServicio.cerrarCaja(caja);			
		this.obtenerDatos(model);
		model.addAttribute("messageView","Se ha cerrado con exito ");		
		return "caja";
	}
	
	public Model obtenerDatos(Model model) {
		CajaDTO caja = cajaServicio.obtenerCajaAbierta();
		if(caja!=null) {
			// traemos las ventas por caja y que esten finalizadas
			float ingresos = 0f;
			float egresos = 0f;
			float totalVentas = 0f;
			FiltroVentas filtroVentas = new FiltroVentas();
			filtroVentas.setEstadoVentaFiltro(VENTA_FINALIZADO+"");
			filtroVentas.setCajaId(caja.getCajaId());
			List<VentaDTO> ventas = ventasServicio.obtenerPorFiltro(filtroVentas);
			ventas.stream().forEach(t -> t.setTotalVenta(ventasServicio.obtenerTotalVenta(t.getVentaId())));
			for (DetalleCajaDTO detalleCaja : caja.getDetalleCaja()) {
				if(detalleCaja.getEsIngreso().equals("1"))
					ingresos += detalleCaja.getMonto();
				else
					egresos += detalleCaja.getMonto();
			}
			for(VentaDTO venta : ventas) {
				totalVentas += venta.getTotalVenta();
			}
			model.addAttribute("totalCaja",((totalVentas + ingresos)-egresos));
			model.addAttribute("ingresos",ingresos);
			model.addAttribute("egresos",egresos);
			model.addAttribute("totalVentas",totalVentas);
			model.addAttribute("ventas",ventas);
			model.addAttribute("numeroVentas",ventas.size());
			model.addAttribute("messageView","Se obtuvieron "+ventas.size()+" ventas con estado FINALIZADO ");
		}
		model.addAttribute("caja",caja);
		return model;
	}

}
