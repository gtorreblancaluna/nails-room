package mx.com.nails_room.view;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.ClienteDTO;
import mx.com.nails_room.service.ClienteServicio;

@Controller
public class ClientesController {	
	
	@Autowired
	@Qualifier("clienteServicio")
	private ClienteServicio clienteServicio;
	
	@GetMapping(value = "/clientes.do")
	public String mostrarInicio(HttpServletRequest request, Model model) {		
		model.addAttribute("clienteDTO", new ClienteDTO());
		return "cliente";
	}	
	// busqueda por filtro
	@PostMapping(value = "/clientes.do", params = "filtro")
	public String mostrarPorFiltro(@ModelAttribute FiltroUsuario filtroUsuario,HttpServletRequest request, Model model) {		
		List<ClienteDTO> listaClientes = clienteServicio.obtenerPorFiltro(filtroUsuario);
		model.addAttribute("messageView","Se obtuvieron "+listaClientes.size()+ " resultados");
		model.addAttribute("listaClientes",listaClientes);		
		model.addAttribute("puestos",clienteServicio.obtenerPuestos());
		return "cliente";		
	}	
	@PostMapping(value = "/clientes.do", params = "agregar")
	public ModelAndView agregar(@ModelAttribute ClienteDTO clienteDTO,HttpServletRequest request,RedirectAttributes redir) {
		ModelAndView modelAndView = new ModelAndView();
		clienteServicio.agregar(clienteDTO);
		redir.addFlashAttribute("messageView","Se agrego exitosamente el cliente: "+clienteDTO.getNombre()+" "+clienteDTO.getAp_paterno());
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}	
	@PostMapping(value = "/clientes.do", params = "editar")
	public ModelAndView editar(@ModelAttribute ClienteDTO clienteDTO,HttpServletRequest request, RedirectAttributes redir) {		
		clienteServicio.editar(clienteDTO);
		ModelAndView modelAndView = new ModelAndView();
		redir.addFlashAttribute("messageView","Se edito exitosamente el cliente: "+clienteDTO.getNombre()+" "+clienteDTO.getAp_paterno());
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}
	
	@PostMapping(value = "/clientes.do", params = "eliminar")
	public ModelAndView eliminar(@ModelAttribute ClienteDTO clienteDTO,HttpServletRequest request, Model model,RedirectAttributes redir) {	
		ModelAndView modelAndView = new ModelAndView();
		clienteServicio.eliminar(clienteDTO);
		redir.addFlashAttribute("messageView","Se elimino con exito al cliente ");
		modelAndView.setViewName("redirect:/exito.do");
		return modelAndView;
	}

}
