package mx.com.nails_room.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.UserSession;
import mx.com.nails_room.model.UsuarioDTO;
import mx.com.nails_room.service.CuentaUsuarioServicio;

import static mx.com.nails_room.commons.ApplicationConstants.PUESTO_ADMINISTRADOR;

@Controller
public class UsuariosController {	
	@Autowired
	private CuentaUsuarioServicio cuentaUsuarioServicio;
	
	@GetMapping(value = "/usuarios.do")
	public String mostrarPrincipalUsuarios(HttpServletRequest request, Model model) {		
		model.addAttribute("usuarioDTO", new UsuarioDTO());
		model.addAttribute("puestos",cuentaUsuarioServicio.obtenerPuestos());
		return "usuario";
	}	
	// busqueda por filtro
	@PostMapping(value = "/usuarios.do", params = "filtro")
	public String mostrarPorFiltro(@ModelAttribute FiltroUsuario filtroUsuario,HttpServletRequest request, Model model) {		
		List<UsuarioDTO> listaUsuarios = cuentaUsuarioServicio.obtenerUsuariosPorFiltro(filtroUsuario);
		model.addAttribute("messageView","Se obtuvieron "+listaUsuarios.size()+ " resultados");
		model.addAttribute("listaUsuarios",listaUsuarios);		
		model.addAttribute("puestos",cuentaUsuarioServicio.obtenerPuestos());
		return "usuario";
	}	
	@PostMapping(value = "/usuarios.do", params = "agregar")
	public String agregar(@ModelAttribute UsuarioDTO usuarioDTO,HttpServletRequest request, Model model) {
		
		cuentaUsuarioServicio.agregar(usuarioDTO);
		model.addAttribute("messageView","Se agrego exitosamente el usuario: "+usuarioDTO.getNombre()+" "+usuarioDTO.getAp_paterno());
		return "usuarioExito";
	}	
	@PostMapping(value = "/usuarios.do", params = "editar")
	public String editar(@ModelAttribute UsuarioDTO usuarioDTO,HttpServletRequest request, Model model) {		
		cuentaUsuarioServicio.editar(usuarioDTO);
		model.addAttribute("messageView","Se edito exitosamente el usuario: "+usuarioDTO.getNombre()+" "+usuarioDTO.getAp_paterno());
		return "usuarioExito";
	}
	
	@PostMapping(value = "/usuarios.do", params = "eliminar")
	public String eliminar(@ModelAttribute UsuarioDTO usuarioDTO,HttpServletRequest request, Model model) {		
		usuarioDTO.setActivo("0");
		cuentaUsuarioServicio.editar(usuarioDTO);
		model.addAttribute("messageView","Se elimino con exito ");
		return "usuarioExito";
	}
	@PostMapping(value = "/usuarios.do", params = "cambiarContrasenia")
	public String cambiarContrasenia(@ModelAttribute UsuarioDTO usuarioDTO,HttpServletRequest request, Model model) {		
		HttpSession httpSession = request.getSession();
		UserSession userSession = (UserSession) httpSession.getAttribute("userSession");
		if(userSession != null && userSession.getUsuario() != null) {
			if(userSession.getUsuario().getPuestoDTO().getPuestoId() == PUESTO_ADMINISTRADOR) {
				cuentaUsuarioServicio.editar(usuarioDTO);
				model.addAttribute("messageView","Se cambio con exito la contrase&ntilde;a ");
				return "usuarioExito";
			}else {
				model.addAttribute("messageError","Para realizar esta accion necesitas permisos de ADMINISTRADOR ");
				return "usuario";
			}
		}else {
			model.addAttribute("messageError","No se encontro usuario logueado, porfavor logeate correctamente ");
			return "usuario";
		}
	}	

}
