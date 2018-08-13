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
	public String agregar(@ModelAttribute ClienteDTO clienteDTO,HttpServletRequest request, Model model) {
		
		clienteServicio.agregar(clienteDTO);
		model.addAttribute("messageView","Se agrego exitosamente el cliente: "+clienteDTO.getNombre()+" "+clienteDTO.getAp_paterno());
		return "clienteExito";
	}	
	@PostMapping(value = "/clientes.do", params = "editar")
	public String editar(@ModelAttribute ClienteDTO clienteDTO,HttpServletRequest request, Model model) {		
		clienteServicio.editar(clienteDTO);
		model.addAttribute("messageView","Se edito exitosamente el cliente: "+clienteDTO.getNombre()+" "+clienteDTO.getAp_paterno());
		return "clienteExito";
	}
	
	@PostMapping(value = "/clientes.do", params = "eliminar")
	public String eliminar(@ModelAttribute ClienteDTO clienteDTO,HttpServletRequest request, Model model) {		
		clienteServicio.eliminar(clienteDTO);
		model.addAttribute("messageView","Se elimino con exito al cliente ");
		return "clienteExito";
	}

}
