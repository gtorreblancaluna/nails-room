package mx.com.nails_room.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mx.com.nails_room.dao.CuentaUsuarioDAO;
import mx.com.nails_room.forms.FiltroUsuario;
import mx.com.nails_room.model.UsuarioDTO;
import mx.com.nails_room.service.CuentaUsuarioServicio;

@Service ("cuentaUsuarioServicio")
public class CuentaUsuarioServicioImpl implements CuentaUsuarioServicio{

	@Autowired
	private CuentaUsuarioDAO cuentaUsuarioDao;
	
	@Override
	public UsuarioDTO validar(UsuarioDTO usuario) {
		// TODO Auto-generated method stub
		return cuentaUsuarioDao.validar(usuario);
	}

	@Override
	public List<UsuarioDTO> obtenerUsuariosPorFiltro(FiltroUsuario filtroUsuario) {
		// TODO Auto-generated method stub
		return cuentaUsuarioDao.obtenerUsuariosPorFiltro(filtroUsuario);
	}

	@Override
	public void agregar(UsuarioDTO usuarioDTO) {
		cuentaUsuarioDao.insertar(usuarioDTO);
		
	}

	@Override
	public List<UsuarioDTO> obtenerPuestos() {
		// TODO Auto-generated method stub
		return cuentaUsuarioDao.obtenerPuestos();
	}

	@Override
	public void editar(UsuarioDTO usuarioDTO) {
		cuentaUsuarioDao.editar(usuarioDTO);
		
	}

	@Override
	public List<UsuarioDTO> obtenerTodosUsuarios() {
		// TODO Auto-generated method stub
		return cuentaUsuarioDao.obtenerTodosUsuarios();
	}

}
