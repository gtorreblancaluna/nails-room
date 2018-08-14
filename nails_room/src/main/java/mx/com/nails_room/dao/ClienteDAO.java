package mx.com.nails_room.dao;

import java.util.List;

import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.ClienteDTO;

public interface ClienteDAO {

	public List<ClienteDTO> obtenerPorFiltro(FiltroUsuario filtroUsuario);
	public void agregar(ClienteDTO ClienteDTO);
	public List<ClienteDTO> obtenerPuestos();
	public void editar(ClienteDTO clienteDTO);
	public void eliminar(ClienteDTO clienteDTO);
	public List<ClienteDTO> obtenerClientesPorNombre(String valor);
}
