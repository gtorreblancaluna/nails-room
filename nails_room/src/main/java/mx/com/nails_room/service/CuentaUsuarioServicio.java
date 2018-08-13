package mx.com.nails_room.service;

import java.util.List;

import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.UsuarioDTO;

public interface CuentaUsuarioServicio {

	public UsuarioDTO validar(UsuarioDTO usuario);
	public List<UsuarioDTO> obtenerUsuariosPorFiltro(FiltroUsuario filtroUsuario);
	public void agregar(UsuarioDTO usuarioDTO);
	public List<UsuarioDTO> obtenerPuestos();
	public void editar(UsuarioDTO usuarioDTO);
	public List<UsuarioDTO> obtenerTodosUsuarios();
	
}
