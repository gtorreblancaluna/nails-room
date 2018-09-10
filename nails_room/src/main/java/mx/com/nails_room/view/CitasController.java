package mx.com.nails_room.view;

import static mx.com.nails_room.commons.ApplicationConstants.CITA_APARTADO;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import mx.com.nails_room.forms.FiltroCitas;
import mx.com.nails_room.model.CitasDTO;
import mx.com.nails_room.service.CitasServicio;

@Controller
public class CitasController {
	
	@Autowired
	private CitasServicio citasServicio;
	
	@GetMapping(value = "/citas.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {
		LocalDate hoy = LocalDate.now();
		FiltroCitas filtro = new FiltroCitas();
		filtro.setFechaInicio(hoy+"");
		filtro.setFechaFin(hoy+"");
		filtro.setEstadoCitaId(CITA_APARTADO);
		List<CitasDTO> citas = citasServicio.obtenerCitasPorFiltro(filtro);
		model.addAttribute("citas", citas);
		model.addAttribute("estados" , citasServicio.obtenerEstadosCitas());
		model.addAttribute("messageView","Se obtuvieron "+citas.size()+ " resultados");
		return "cita";
	}
	
	@PostMapping(value = "citas.do", params="agregar" )
	public String agregarCita(@ModelAttribute CitasDTO cita, HttpServletRequest request, Model model) {
		citasServicio.agregar(cita);		
		LocalDate hoy = LocalDate.now();
		FiltroCitas filtro = new FiltroCitas();
		filtro.setFechaInicio(hoy+"");
		filtro.setFechaFin(hoy+"");
		filtro.setEstadoCitaId(CITA_APARTADO);
		List<CitasDTO> citas = citasServicio.obtenerCitasPorFiltro(filtro);
		model.addAttribute("citas", citas);
		model.addAttribute("estados" , citasServicio.obtenerEstadosCitas());
		model.addAttribute("messageView","Se obtuvieron "+citas.size()+ " resultados |");
		model.addAttribute("messageView","Se ingreso con exito la cita |");		
		return "cita";
	}
	
	@PostMapping(value = "citas.do", params="filtro")
	public String filtro(@ModelAttribute FiltroCitas filtro, HttpServletRequest request, Model model) {
		List<CitasDTO> citas = citasServicio.obtenerCitasPorFiltro(filtro);
		model.addAttribute("citas", citas);
		model.addAttribute("estados" , citasServicio.obtenerEstadosCitas());
		model.addAttribute("messageView","Se obtuvieron "+citas.size()+ " resultados");		
		return "cita";
	}
	
	@PostMapping(value = "citas.do", params="actualizarEstado" )
	public String actualizarEstado(@ModelAttribute CitasDTO cita, HttpServletRequest request, Model model) {
		citasServicio.actualizarEstado(cita);		
		LocalDate hoy = LocalDate.now();
		FiltroCitas filtro = new FiltroCitas();
		filtro.setFechaInicio(hoy+"");
		filtro.setFechaFin(hoy+"");
		filtro.setEstadoCitaId(CITA_APARTADO);
		model.addAttribute("citas", citasServicio.obtenerCitasPorFiltro(filtro));
		model.addAttribute("estados" , citasServicio.obtenerEstadosCitas());
		model.addAttribute("messageView","Se actualizo con exito ");		
		return "cita";
	}
	
}
