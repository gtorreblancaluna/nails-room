package mx.com.nails_room.dao.impl;

import java.util.List;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import mx.com.nails_room.dao.ClienteDAO;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.ClienteDTO;

public class SqlMapCliente extends SqlSessionDaoSupport implements ClienteDAO {

	@Override
	public List<ClienteDTO> obtenerPorFiltro(FiltroUsuario filtroUsuario) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerClientesPorFiltro",filtroUsuario);
	}

	@Override
	public void agregar(ClienteDTO clienteDTO) {
		getSqlSession().insert("agregarCliente",clienteDTO);
	}

	@Override
	public List<ClienteDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void editar(ClienteDTO clienteDTO) {
		// TODO Auto-generated method stub
		getSqlSession().update("editarCliente",clienteDTO);
	}

	@Override
	public void eliminar(ClienteDTO clienteDTO) {
		getSqlSession().update("eliminarCliente",clienteDTO);
		
	}

	@Override
	public List<ClienteDTO> obtenerClientesPorNombre(String valor) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("obtenerClientesPorNombre",valor);
	}

}
