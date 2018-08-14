package mx.com.nails_room.service;

import java.util.List;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.ClienteDTO;

public interface ClienteServicio {

	public List<ClienteDTO> obtenerPorFiltro(FiltroUsuario filtroUsuario);
	public void agregar(ClienteDTO clienteDTO);
	public List<ClienteDTO> obtenerPuestos();
	public void editar(ClienteDTO clienteDTO);
	public void eliminar(ClienteDTO clienteDTO);
	public List<ClienteDTO> obtenerClientesPorNombre(String valor);
	
}
