package mx.com.nails_room.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import mx.com.nails_room.dao.ClienteDAO;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.ClienteDTO;
import mx.com.nails_room.service.ClienteServicio;

@Service("clienteServicio")
public class ClienteServicioImpl implements ClienteServicio{

	@Autowired
	private ClienteDAO clienteDao;
	
	@Override
	public List<ClienteDTO> obtenerPorFiltro(FiltroUsuario filtroUsuario) {
		// TODO Auto-generated method stub
		return clienteDao.obtenerPorFiltro(filtroUsuario);
	}

	@Override
	public void agregar(ClienteDTO clienteDTO) {
		clienteDao.agregar(clienteDTO);
		
	}

	@Override
	public List<ClienteDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void editar(ClienteDTO clienteDTO) {
		clienteDao.editar(clienteDTO);
		
	}

	@Override
	public void eliminar(ClienteDTO clienteDTO) {
		clienteDao.eliminar(clienteDTO);
		
	}

	
}
