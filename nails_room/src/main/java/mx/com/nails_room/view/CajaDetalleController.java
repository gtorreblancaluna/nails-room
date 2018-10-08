package mx.com.nails_room.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import mx.com.nails_room.forms.FiltroCaja;
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
public class CajaDetalleController {
	@Autowired
	private CajaServicio cajaServicio;	
	
	@GetMapping(value = "/caja_detalle.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		model.addAttribute("filtroCaja" , new FiltroCaja());
		return "cajaDetalle";
	}
	
	@PostMapping(value = "/caja_detalle.do", params = "filtro")
	public String filtro(@ModelAttribute FiltroCaja filtroCaja, HttpServletRequest request, Model model) {
		List<CajaDTO> cajas = cajaServicio.obtenerCajaPorFechas(filtroCaja.getFechaInicioFiltro(), filtroCaja.getFechaFinFiltro());
		model.addAttribute("messageView","Se obtuvieron "+cajas.size()+" resultados");
		model.addAttribute("cajas",cajas);
		return "cajaDetalle";
	}

}
