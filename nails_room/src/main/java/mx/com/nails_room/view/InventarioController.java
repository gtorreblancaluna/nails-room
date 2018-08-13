package mx.com.nails_room.view;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import mx.com.nails_room.forms.FiltroArticulo;
import mx.com.nails_room.model.ArticuloDTO;
import mx.com.nails_room.service.InventarioServicio;

@Controller
public class InventarioController {	
	
	@Autowired	
	private InventarioServicio inventarioServicio;
	
	@GetMapping(value = "/inventario.do")
	public String mostrarPorFiltro(HttpServletRequest request, Model model) {		
		model.addAttribute("articulo", new ArticuloDTO());
		return "inventario";
	}	
	// busqueda por filtro
	@PostMapping(value = "/inventario.do", params = "filtro")
	public String mostrarPorFiltro(@ModelAttribute FiltroArticulo filtroArticulo,HttpServletRequest request, Model model) {		
		List<ArticuloDTO> listaArticulos = inventarioServicio.obtenerPorFiltro(filtroArticulo);
		model.addAttribute("messageView","Se obtuvieron "+listaArticulos.size()+ " resultados");
		model.addAttribute("listaArticulos",listaArticulos);		
		return "inventario";
	}	
	@PostMapping(value = "/inventario.do", params = "agregarProducto")
	public String agregarProducto(@ModelAttribute ArticuloDTO articuloDTO,HttpServletRequest request, Model model) {
		articuloDTO.setEsProducto("1");
		inventarioServicio.agregar(articuloDTO);
		model.addAttribute("messageView","Se agrego exitosamente el articulo: "+articuloDTO.getDescripcion());
		return "inventarioExito";
	}	
	
	@PostMapping(value = "/inventario.do", params = "agregarServicio")
	public String agregarServicio(@ModelAttribute ArticuloDTO articuloDTO,HttpServletRequest request, Model model) {
		articuloDTO.setEsProducto("0");
		inventarioServicio.agregar(articuloDTO);
		model.addAttribute("messageView","Se agrego exitosamente el servicio: "+articuloDTO.getDescripcion());
		return "inventarioExito";
	}	
	@PostMapping(value = "/inventario.do", params = "editar")
	public String editarArticulo(@ModelAttribute ArticuloDTO articuloDTO,HttpServletRequest request, Model model) {		
		inventarioServicio.editar(articuloDTO);
		model.addAttribute("messageView","Se edito exitosamente el articulo: "+articuloDTO.getDescripcion());
		return "inventarioExito";
	}	
	
	
	@PostMapping(value = "/inventario.do", params = "eliminar")
	public String eliminar(@ModelAttribute ArticuloDTO articuloDTO,HttpServletRequest request, Model model) {		
		inventarioServicio.eliminar(articuloDTO);
		model.addAttribute("messageView","Se elimino con exito ");
		return "inventarioExito";
	}

}
