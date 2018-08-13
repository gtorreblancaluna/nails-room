package mx.com.nails_room.dao;

import java.util.List;

import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.UsuarioDTO;

public interface CuentaUsuarioDAO {

	public UsuarioDTO validar(UsuarioDTO usuario);
	public List<UsuarioDTO> obtenerUsuariosPorFiltro(FiltroUsuario filtroUsuario);
	public void insertar(UsuarioDTO usuarioDTO);
	public List<UsuarioDTO> obtenerPuestos();
	public void editar(UsuarioDTO usuarioDTO);
}
